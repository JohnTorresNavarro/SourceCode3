000100991124     F*-------------------------------------------------------------------------
000200150825     F* ITSTFMNR   GBS SOFTWARE 2015
000300141024     F*            WRITTEN BY - RLJ
000400150825     F*            AATE - 08/2015
000500150825     F*  DESCRIPTION - Issue Tracking Staff File Maintenance
000600141024     F*
000700991124     F*-------------------------------------------------------------------------
000800991209     ** MODIFICATION HISTORY                                              **
000900150825     ** xxx mm/dd/yyyy -
001000141024     **                                                                   **
001100140925     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001200150826     FITSTAFP   UF A E           K DISK
001300150825     F***ITISSL1   IF   E           K DISK    RENAME(ITISSR:ITISSR1)
001400150825     FITSTFMND  CF   E             WORKSTN
001500141024     F                                     SFILE(DETAIL:RRN)
001600140804   X* *
001700140804     D                UDS
001800140804     D  @USER                100    107
001900140804     D  CONAME               201    240
0020001408040056 D  lprefix              241    241
002100140804JGE01D  LD8YMD               248    255  0
002200140804      *
002300131231    *** TIMESTAMP FIELDS DATA STRUCTURE
002400140804      *
002500140911     D @TIMESTAMP      DS
002600140911     D  #TSCYMD                1      8S 0
002700140911     D  #TSTIME                9     14S 0
002800140911     D  @TSJOB                15     24
002900140911     D  @TSUSER               25     34
003000140911     D  #TSNBR                35     40S 0
003100141008    * *
0032001410080048 D                 DS
0033001508260055 D iscur                   1    108
0034001410090055 D  xitfudt                1      8  0
0035001410090055 D  xitvewc                9     11
0036001410090055 D  xittypc               12     14
0037001410090055 D  xitsbjt               15     34
0038001410140055 D  xitrefr               35     37
0039001410090055 D  xitreft               38     97
0040001410090055 D  xitrefd               98    105  0
0041001410090055 D  xitresp              106    108
004200141008    * *
0043001410080048 D                 DS
0044001410090055 D itsav                   1    108
0045001410080055 D   svfudt                1      8  0
0046001410080055 D   svvewc                9     11
0047001410080055 D   svtypc               12     14
0048001410080055 D   svsbjt               15     34
0049001410140055 D   svrefr               35     37
0050001410080055 D   svreft               38     97
0051001410080055 D   svrefd               98    105  0
0052001410080055 D   svresp              106    108
005300140926    * *
005400140123     D                 DS
005500140123     D  GRgroup                      15
005600140123     D  GRP#                          6    OVERLAY(GRgroup)
005700140123    * *
005800130424     D                 DS
0059001408150037 D wktime          S               T   timfmt(*hms:)
0060001408150037 D wkdate          S               D   datfmt(*iso)
0061001408040037 D sysZateymd      S               D   datfmt(*iso)
006200130510     D usadt           S               D   DATFMT(*USA/)
006300140828     D basedate        S               D   INZ(D'1899-12-30')
006400140828     D wkfld           S              5S 0
006500140828     D dayowk          S              1S 0
006600140828     D todate          S              8S 0
006700150210     D #kdat9          S              8S 0 INZ(99999999)
006800140904     D @TS40           S             40A
006900140904     D typflg          S              1
007000141010     D edtcln          S              1
007100141010     D chgind          S              1
007200150514     D itissa          S              6
007300150723     D rfeto           S             20
007400150723     D rfesub          S             60
007500150723     D rfetxt          S            755
007600141014     D getiss          S              1    INZ('N')
007700150826     D husid           S                   LIKE(ISUSID)
007800081111      *
0079001304230053 D                 DS
0080001508270054 D  cusblx         C                   'USER ID CANNOT BE BLANK        '
0081001508270054 D  cmgblx         C                   'MANAGER CANNOT BE BLANK        '
0082001508270054 D  cfnblx         C                   'FIRST NAME CANNOT BE BLANK     '
0083001508270054 D  clnblx         C                   'LAST NAME CANNOT BE BLANK      '
0084001508270054 D  cemblx         C                   'EMAIL ADDRESS CANNOT BE BLANK  '
0085001511040054 D  ceactv         C                   'ACTIVE FLAG MUST BE Y OR N     '
0086001508270054 D  blksjt         C                   'SUBJECT CANNOT BE BLANK        '
0087001410070054 D  blkvew         C                   'VIEWABLE BY CANNOT BE BLANK     '
008800150514    * *
008900150827     C     emlkey        KLIST
009000150827     C                   KFLD                    ememl            30
009100150827     C                   KFLD                    emusi            10
009200140731    * *
009300131231     C                   CLEAR                   @TIMESTAMP
009400131231     C                   MOVE      *BLANKS       @TS40
009500131231     C                   CALL      'TIMESTMP'
009600131231     C                   PARM                    @TS40
009700131231     C                   MOVEL     @TS40         @TIMESTAMP
009800131231     C                   MOVE      #TSCYMD       todate
009900131205    * *
010000131206      *
010100131205     C                   MOVEL     CONAME        TITLE
010200131205     C                   MOVE      '0'           @EXIT             1
010300130426    * *
010400130423      * MAINLINE
010500130607      *
010600130607     C     *IN01         DOWEQ     *OFF
010700130607      *      RELOAD IF CLIENT SEARCH CHANGES
010800130607     C                   EXSR      $CLEAR
010900130607     C                   EXSR      $LOAD
011000130607     C                   EXSR      $DISPLAY
011100130607     C                   setoff                                       88
011200130607      *    PROCESS SELECTION
011300141007     C     *IN01         IFEQ      *OFF
011400130607     C***  *IN07         ANDEQ     *OFF
011500130607     C***  RRN           ANDNE     *ZERO
011600140731     C                   EXSR      $PROCES
011700130607     C*****              ENDIF
011800130607      *
011900141007     C                   endif
012000130607      *
012100141007     C                   enddo
012200141007      *
012300131205     C                   eval      *inlr = '1'
012400131205     C                   return
012500130607      ******************************************************************
012600130607      *       SUBROUTINE - $CLEAR                                      *
012700130607      *                    CLEAR SUBF AND RRN                          *
012800130607      ******************************************************************
012900130607     C     $CLEAR        BEGSR
013000130607     C                   MOVEA     '001'         *IN(31)
013100130607     C                   wRITE     HEADER
013200130607     C                   Z-ADD     *ZERO         RRN               4 0
013300130607     C                   WRITE     HEADER
013400130607     C                   MOVEA     '010'         *IN(31)
013500130607     C                   ENDSR
013600130607      ******************************************************************
013700130607      *       SUBROUTINE - $LOAD                                       *
013800140730      *                    LOAD SUBFILE W/ Issue Info                  *
013900130607      ******************************************************************
014000130607     C     $LOAD         BEGSR
014100140618      *
014200130607     C                   SETOFF                                       3495
014300150826     C     *loval        setll     itstafp                            34
014400130607     C     *IN34         DOUEQ     *ON
014500130607     C     *IN95         OREQ      *ON
014600150826     C                   read      itstafp                                34
014700140730     C                   IF        *In34 <> *ON
014800150210      *
014900140730     C                   exsr      loddtl
015000131231     C                   endif
015100140122      *
015200130607     C                   ENDDO
015300140207      *
015400130607     C                   ENDSR
015500140730      ******************************************************************
015600140730      *       SUBROUTINE - loddtl                                      *
015700140730      *                    LOAD SUBFILE Detail                         *
015800140730      ******************************************************************
015900140730     C     loddtl        BEGSR
016000140730      *
016100150826     C                   eval      ssusid = isusid
016200150826     C                   eval      ssfnam = isfnam
016300150826     C                   eval      sslnam = islnam
016400151104     C                   eval      ssactv = isactv
016500140912      *
016600140731     C                   ADD       1             RRN
016700140731     C                   WRITE     DETAIL
016800140731      *
016900140731     C                   ENDSR
017000130607      ******************************************************************
017100130607      *       SUBROUTINE - $DISPLAY                                    *
017200130607      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
017300130607      ******************************************************************
017400130607     C     $DISPLAY      BEGSR
017500130607     C                   If        RRN <> *Zero
017600130607     C                   MOVE      *ON           *IN31
017700130607     C                   ENDIF
017800130607     C                   WRITE     TRAILER
017900130607     C                   EXFMT     HEADER
018000130607     C                   ENDSR
018100130607      *
018200140731      ******************************************************************
018300140731      *       SUBROUTINE - $PROCES                                     *
018400140731      *                    PROCESS THE SELECTION                       *
018500140731      ******************************************************************
018600140731     C     $PROCES       BEGSR
018700140731     C     *IN96         DOUEQ     *ON
018800150210      *      Add new record
018900150210     C                   IF        *in06 = *ON or rrn = 0
019000150826     C                   exsr      stfadd
019100150210     C                   eval      *in06 = *OFF
019200150210     C                   leavesr
019300150210     C                   endif
019400140731      *
019500140731     C                   READC     DETAIL                                 96
019600140731     C                   IF        *IN96 = *OFF
019700140731      *        Display Action
019800140731     C                   IF        SELECT = '5'
019900150826     C                   exsr      stfdsp
020000140731     C                   iter
020100140731     C                   endif
020200140731      *        Change Action
020300141008     C                   IF        SELECT = '2'
020400150826     C                   exsr      stfchg
020500141008     C                   iter
020600141008     C                   endif
020700140731      *
020800140731     C                   CLEAR                   SELECT
020900140731     C                   UPDATE    DETAIL
021000140731     C                   ENDIF
021100140731     C                   ENDDO
021200140731     C                   ENDSR
021300140731      ******************************************************************
021400150826      *       SUBROUTINE - STFDSP                                      *
021500150826      *                    Dispaly Staff Details                       *
021600140731      ******************************************************************
021700150826     C     stfdsp        BEGSR
021800150826      *
021900150826     C     ssusid        chain     itstafp                            32
022000140805     C                   if        *in32 = '0'
022100150826     C                   eval      dsusid = isusid
022200150826     C                   eval      dsfnam = isfnam
022300150826     C                   eval      dslnam = islnam
022400150826     C                   eval      dsemad = isemad
022500150826     C                   eval      dssupv = issupv
022600150826     C                   eval      dsseml = isseml
022700150826     C                   eval      dsmgr = ismgr
022800150826     C                   eval      dsmeml = ismeml
022900151104     C                   eval      dsactv = isactv
023000140805      *
023100150826     C                   exfmt     dspstf
023200150827      *
023300150827     C                   IF        *IN01 = *ON
023400150827     C                   eval      smsg = *blanks
023500150827     C                   MOVE      *Off          *IN01
023600150827     C                   leavesr
023700150827     C                   endif
023800150827      *
023900140731      *
024000150826     C                   endif
024100140731      *
024200140731     C                   ENDSR
024300141008      ******************************************************************
024400150826      *       SUBROUTINE - STFCHG                                      *
024500150826      *                    Change Staff Details                        *
024600141008      ******************************************************************
024700150826     C     stfchg        BEGSR
024800141009      *
024900150826     C     ssusid        chain     itstafp                            32
025000150826     C                   if        *in32 = '0'
025100150826     C                   eval      csusid = isusid
025200150826     C                   eval      csfnam = isfnam
025300150826     C                   eval      cslnam = islnam
025400150826     C                   eval      csemad = isemad
025500150826     C                   eval      cssupv = issupv
025600150826     C                   eval      csseml = isseml
025700150826     C                   eval      csmgr = ismgr
025800150826     C                   eval      csmeml = ismeml
025900151104     C                   eval      csactv = isactv
026000150827      *
026100150827     C                   eval      *in51 = '0'
026200150827     C                   eval      *in53 = '0'
026300150827     C                   eval      *in54 = '0'
026400150827     C                   eval      *in55 = '0'
026500150827     C                   eval      *in56 = '0'
026600150827     C                   eval      *in57 = '0'
026700151104     C                   eval      *in58 = '0'
026800150827      *
026900150827     C     *IN01         DOWEQ     *OFF
027000150826      *
027100150826     C                   exfmt     chgstf
027200150826      *
027300150826     C                   IF        *IN01 = *ON
027400150826     C                   eval      smsg = *blanks
027500150826     C                   MOVE      *Off          *IN01
027600150826     C                   leavesr
027700150826     C                   endif
027800150826      *     Enter Key - Update
027900150826      *
028000150826     C                   exsr      edtchg
028100150826      *
028200150826     C                   IF        edtcln = 'Y'
028300150826     C                   exsr      chgrec
028400150826     C                   if        chgind = 'Y'
028500150826     C                   leavesr
028600150826     C                   endif
028700150826     C                   endif
028800150827      *
028900150827     C                   ENDDO
029000150826      *
029100150826     C                   endif
029200150826      *
029300150826      *
029400141008     C                   ENDSR
029500150826      ******************************************************************
029600150826      *       SUBROUTINE - EDTCHG                                      *
029700150826      *                    Edit Change data for validity               *
029800150826      ******************************************************************
029900150826     C     edtchg        BEGSR
030000150826      *
030100150826     C                   eval      edtcln = 'N'
030200150826     C                   eval      smsg = *blanks
030300150826      *
030400150827     C                   eval      *in51 = '0'
030500150827     C                   if        csfnam = *blanks
030600150827     C                   eval      smsg = cfnblx
030700150827     C                   eval      *in51 = '1'
030800150827     C                   leavesr
030900150827     C                   endif
031000150827      *
031100150827     C                   eval      *in52 = '0'
031200150827     C                   if        cslnam = *blanks
031300150827     C                   eval      smsg = clnblx
031400150827     C                   eval      *in52 = '1'
031500150827     C                   leavesr
031600150827     C                   endif
031700150827      *
031800150827     C                   eval      *in53 = '0'
031900150827     C                   if        csemad = *blanks
032000150827     C                   eval      smsg = cemblx
032100150827     C                   eval      *in53 = '1'
032200150827     C                   leavesr
032300150827     C                   endif
032400150827      *
032500150827     C                   eval      *in54 = '0'
032600150827     C                   if        cssupv = *blanks
032700150827     C                   eval      smsg = cemblx
032800150827     C                   eval      *in54 = '1'
032900150827     C                   leavesr
033000150827     C                   endif
033100150827      *
033200150827     C                   eval      *in55 = '0'
033300150827     C                   if        csseml = *blanks
033400150827     C                   eval      smsg = cemblx
033500150827     C                   eval      *in55 = '1'
033600150827     C                   leavesr
033700150827     C                   endif
033800150827      *
033900150827     C                   eval      *in56 = '0'
034000150827     C                   if        csmgr = *blanks
034100150827     C                   eval      smsg = cmgblx
034200150827     C                   eval      *in56 = '1'
034300150827     C                   leavesr
034400150827     C                   endif
034500150827      *
034600150827     C                   eval      *in57 = '0'
034700150827     C                   if        csmeml = *blanks
034800150827     C                   eval      smsg = cemblx
034900150827     C                   eval      *in57 = '1'
035000150827     C                   leavesr
035100150827     C                   endif
035200151104      *
035300151104     C                   eval      *in58 = '0'
035400151104     C                   if        csactv <> 'Y' and csactv <> 'N'
035500151104     C                   eval      smsg = ceactv
035600151104     C                   eval      *in58 = '1'
035700151104     C                   leavesr
035800151104     C                   endif
035900150826      *
036000150826     C                   eval      edtcln = 'Y'
036100150826      *
036200150826     C                   ENDSR
036300150826      ******************************************************************
036400150826      *       SUBROUTINE - CHGREC                                      *
036500150826      *                    Change Issue record                         *
036600150826      ******************************************************************
036700150826     C     chgrec        BEGSR
036800150826      *
036900150826     C                   eval      isusid = csusid
037000150826     C                   eval      isfnam = csfnam
037100150826     C                   eval      islnam = cslnam
037200150826     C                   eval      isemad = csemad
037300150826     C                   eval      issupv = cssupv
037400150826     C                   eval      isseml = csseml
037500150826     C                   eval      ismgr = csmgr
037600150826     C                   eval      ismeml = csmeml
037700151104     C                   eval      isactv = csactv
037800150826      *
037900150826      *         If changes were made, update record
038000150826      *
038100150826     C                   update    itstafr
038200150826     C                   eval      chgind = 'Y'
038300150826      *
038400150826     C                   ENDSR
038500140815      ******************************************************************
038600150826      *       SUBROUTINE - STFADD                                      *
038700140815      *                    Add a new Issue Rec                         *
038800140815      ******************************************************************
038900150826     C     stfadd        BEGSR
039000140815      *
039100150827     C                   eval      asusid = *blanks
039200150827     C                   eval      asfnam = *blanks
039300150827     C                   eval      aslnam = *blanks
039400150827     C                   eval      asemad = *blanks
039500150827     C                   eval      assupv = *blanks
039600150827     C                   eval      asseml = *blanks
039700150827     C                   eval      asmgr  = *blanks
039800150827     C                   eval      asmeml = *blanks
039900150827      *
040000150827     C                   eval      *in60 = '0'
040100150827     C                   eval      *in61 = '0'
040200150827     C                   eval      *in63 = '0'
040300150827     C                   eval      *in64 = '0'
040400150827     C                   eval      *in65 = '0'
040500150827     C                   eval      *in66 = '0'
040600150827     C                   eval      *in67 = '0'
040700150827      *
040800150827     C     *IN01         DOWEQ     *OFF
040900150827      *
041000150827     C                   exfmt     addstf
041100150827      *
041200150827     C                   IF        *IN01 = *ON
041300150827     C                   eval      smsg = *blanks
041400150827     C                   MOVE      *Off          *IN01
041500150827     C                   leavesr
041600150827     C                   endif
041700150827      *
041800150827      *          ENTER - Add record
041900150827     C                   exsr      edtinp
042000150827      *
042100150827     C                   IF        edtcln = 'Y'
042200150827     C                   exsr      wrtstf
042300150827      *
042400150827     C                   leavesr
042500150827     C                   endif
042600150827      *
042700150827     C                   ENDDO
042800140815      *
042900140815     C                   ENDSR
043000150827      ******************************************************************
043100150827      *       SUBROUTINE - EDTINP                                      *
043200150827      *                    Edit Input data for validity                *
043300150827      ******************************************************************
043400150827     C     edtinp        BEGSR
043500150827      *
043600150827     C                   eval      edtcln = 'N'
043700150827     C                   eval      smsg = *blanks
043800150827      *
043900150827     C                   eval      *in60 = '0'
044000150827     C                   if        asusid = *blanks
044100150827     C                   eval      smsg = cusblx
044200150827     C                   eval      *in60 = '1'
044300150827     C                   leavesr
044400150827     C                   endif
044500150827      *
044600150827     C                   eval      *in61 = '0'
044700150827     C                   if        asfnam = *blanks
044800150827     C                   eval      smsg = cfnblx
044900150827     C                   eval      *in61 = '1'
045000150827     C                   leavesr
045100150827     C                   endif
045200150827      *
045300150827     C                   eval      *in62 = '0'
045400150827     C                   if        aslnam = *blanks
045500150827     C                   eval      smsg = clnblx
045600150827     C                   eval      *in62 = '1'
045700150827     C                   leavesr
045800150827     C                   endif
045900150827      *
046000150827     C                   eval      *in63 = '0'
046100150827     C                   if        asemad = *blanks
046200150827     C                   eval      smsg = cemblx
046300150827     C                   eval      *in63 = '1'
046400150827     C                   leavesr
046500150827     C                   endif
046600150827      *
046700150827     C                   eval      *in64 = '0'
046800150827     C                   if        assupv = *blanks
046900150827     C                   eval      smsg = cemblx
047000150827     C                   eval      *in64 = '1'
047100150827     C                   leavesr
047200150827     C                   endif
047300150827      *
047400150827     C                   eval      *in65 = '0'
047500150827     C                   if        asseml = *blanks
047600150827     C                   eval      smsg = cemblx
047700150827     C                   eval      *in65 = '1'
047800150827     C                   leavesr
047900150827     C                   endif
048000150827      *
048100150827     C                   eval      *in66 = '0'
048200150827     C                   if        asmgr = *blanks
048300150827     C                   eval      smsg = cmgblx
048400150827     C                   eval      *in66 = '1'
048500150827     C                   leavesr
048600150827     C                   endif
048700150827      *
048800150827     C                   eval      *in67 = '0'
048900150827     C                   if        asmeml = *blanks
049000150827     C                   eval      smsg = cemblx
049100150827     C                   eval      *in67 = '1'
049200150827     C                   leavesr
049300150827     C                   endif
049400150827      *
049500150827     C                   eval      edtcln = 'Y'
049600150827      *
049700150827      *
049800150827     C                   ENDSR
049900150827      ******************************************************************
050000150827      *       SUBROUTINE - WRTSTF                                      *
050100150827      *                    Write new Staff record                      *
050200150827      ******************************************************************
050300150827     C     wrtstf        BEGSR
050400150827      *
050500150827     C                   clear                   itstafr
050600150827      *
050700150827     C                   eval      isusid = asusid
050800150827     C                   eval      isfnam = asfnam
050900150827     C                   eval      islnam = aslnam
051000150827     C                   eval      isemad = asemad
051100150827     C                   eval      issupv = assupv
051200150827     C                   eval      isseml = asseml
051300150827     C                   eval      ismgr = asmgr
051400150827     C                   eval      ismeml = asmeml
051500151104     C                   eval      isactv = 'Y'
051600150827      *
051700150827     C                   write     itstafr
051800150827      *
051900150827     C                   ENDSR
