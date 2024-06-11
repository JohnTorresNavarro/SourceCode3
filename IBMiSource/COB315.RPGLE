0001009908180002 F******************************************************************
0002000902260003 F* cob315     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0004009908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000902260006 F*            DATE - 02/26/09                                     *
0006009908190007 F*                                                                *
0007000902260013 F*  DESCRIPTION - account letters for COBRA department            *
0008009908180004 F*                                                                *
000900131010     F* 10/10/13 sbt - hist file expansion project                     *
0010001711220017  * 11/21/17 dlk - add letterhead ovelay and send back to user as  *    h
0011001712010017  *                pdf, remove duplex and drawer 2 options. Also        h
0012001712010017  *                convert label to seperate mailing sheet.             h
0013002104140017  * 04/14/21 dlk - wording changes to some letters, change to use       h
0014002104140017  *                unique letterhead overlay "cob31lhc" so only cob310  h
0015002104140017  *                and cob315 share this overlay, start printing 2      h
0016002104140017  *                copies of some letters.                              h
0017002104140017  *                                                                     h
0018002104140017  *                                                                     h
0019009908180016 F******************************************************************
0020000902260018 Fcob315d   cf   E             workstn
002100000413JGE01Faacode    IF   e           k DISK
002200020603     FCOBRAAA   IF   E           K DISK
0023009908120034 FACCMST    IF   E           K DISK
0024000902260029 Fcmct14    IF   E           K DISK
002500090226     Fagency    IF   E           K Disk
002600090226     Fsman      IF   E           K Disk
002700090226     Fsmanrlt   IF   E           K Disk
002800090226     Fspragxr2  IF   E           K Disk
0029009908170020 FHIST      O  A E             DISK
0030000902260020 Fcob315p   O    E             PRINTER
0031001712010020 **Fcob315p2  O    E             PRINTER
0032009908160037 D YR              S              9    DIM(12) CTDATA PERRCD(1)
0033009908260037 D dat2wkdt        S               d   datfmt(*usa)
0034000902260037 D relidwk         S                   like(cmrelid)
0035009908260055 D                 DS
0036009908260056 Dsmdy                     1      8  0
0037009908260056 Dsmo                      1      2  0
0038009908260056 Dsda                      3      4  0
0039009908260056 Dsyr                      5      8  0
0040000902260055 D                 DS
0041000902260056 Dstsa                     1     10  0
0042000902260056 Dstrust                   1      3  0
0043000902260056 Dssub                     4      6  0
0044000902260056 Dsacc                     7     10  0
004500080402     d SS#             DS
004600080402     d SFirst3                 1      3
004700080402     d SMiddle2                4      5
004800080402     d SLast4                  6      9
0049009909210054 D* LDA                                                               DB020
0050009908260055 D                UDS
0051001310140056 D  LUSER                 25     32
0052001310140056 D  LUSER10               25     34
0053001711210056 D  llet                 100    100
0054009505080056 D  CONAME               201    240
005500000413     Iaccmsr
005600000413     i              aacode                      a_aacode
005700990819     c     #start        tag
005800090226     c                   eval      stsa  = *zeros
005900990826     c                   eval      smdy  = *zeros
006000990819     c                   eval      slet1 = *blanks
006100990819
006200990819     c     #t0010        tag
006300990819     c                   exfmt     scrn01
006400990819     c                   if        *inkg
006500990819     c                   goto      #end
006600990819     c                   end
006700990819
0068000902260144 C     acckey        CHAIN     accmst                             20
006900990819
007000990819     c                   if        *in20
007100990819     c                   goto      #t0010
007200990819     c                   end
0073009908200060
0074009908250060 C* edit date & letter select
007500990820
007600990820     c                   eval      *in22 = *off
007700090226     C     *USA          test (de)               smdy
007800090226     C                   if        %ERROR
007900090226     c                   eval      *in22 = *on
008000090226     c                   goto      #t0010
008100090226     C                   end
008200990820
008300990820     c                   eval      *in23 = *off
008400090226     c                   if        slet1 = ' '
008500990820     c                   eval      *in23 = *on
008600990820     c                   goto      #t0010
008700990820     c                   end
008800990820
008900030306     c* duplicate screen effect date for use in other screens and letter
009000030306     c                   move      smdy          smdy2             8 0
009100090226     c                   move      stsa          stsa2            10 0
009200990820
009300020603     C*  GET COBRA aa name
009400020603     C*
009500020603     c                   eval      aaname = *blanks
009600090226     c     actrst        Chain     COBRAAA
009700020603     c                   if        %found(COBRAAA)
009800020603     c     CACODE        chain     AACODE
009900020603     c                   if        %found(AACODE)
010000130627     c                   movel     afnam         aaname           30
010100130627     c                   if        afnam <> *blanks
010200130627     c                   cat(p)    alnam:1       aaname
010300130627     c                   else
010400130627     c                   cat(p)    alnam:0       aaname
010500130627     c                   endif
010600020603     c                   endif
010700020603     c                   endif
0108009908190060 C*
010900990812     C                   EXSR      #LTR
011000990819
011100990819     c                   goto      #start
011200990820
011300990819     C     #end          tag
011400990819     c                   eval      *inlr = *on
0115009908190103 C*
011600990816     C*****************************************************
0117000902260073 C* PRINT LETTER AND WRITE HISTORY REC
011800990816     C*****************************************************
0119009908190103 C*
012000990816     C     #LTR          BEGSR
012100090226
012200990826     C* convert effective date from screen to ymd
012300990826     c                   move      smdy          @datin
012400990826     c                   exsr      #datmy
012500990826     c                   move      @datou        symd              8 0
0126000902260103
0127000902260323 C* DL2 - effective date
0128009908200329 C                   MOVE      *BLANKS       DL2              19
0129009908200331 C                   MOVE      smo           M
0130009908260331 C                   MOVE      sda           D
0131009908260331 C                   MOVE      syr           Y
0132009908200332 C                   MOVEL     YR(M)         DL2
013300990820     C                   CAT       D:1           DL2
013400990820     C                   CAT       ',':0         DL2
013500990820     C                   CAT       Y:1           DL2
013600990820     C*
0137000902260103
0138000902260323 C* 3rd DATE LINE - effective date w/.
0139000902260329 C                   clear                   DL3              12
0140000902260331 C                   eval      dl3 = %editc(smdy:'Y')
014100090226     C                   CAT       '.':0         DL3
014200090226
014300990816     C                   EXSR      #NAME
014400990816     C                   EXSR      #ADR
014500210414
014600210414      *******************************************
014700210414      * letter 1 : confirm extended benefits    *
014800210414      *******************************************
014900990820     c                   if        slet1 <> ' '
015000090226     c                   exsr      #getsman
015100090226     c                   select
015200210414      * full service
015300090226     c                   when      acobsrv = 'F'
015400210414      * 2 copies
015500210414     c                   do        2
015600090305     C                   WRITE     LET1FS
015700171121      * letter head overlay
015800171121     c                   write     lethdol
015900090305     C                   WRITE     newpage
016000090305     C                   WRITE     let1fsat
016100210414     c                   enddo
016200210414
016300090226     C                   MOVE      'U53'         TRCODE
016400990820     C                   exsr      #hist
016500090305      * letter only
016600090226     c                   when      acobsrv = 'L'
016700210414      * 2 copies
016800210414     c                   do        2
016900090305     C                   WRITE     LET1LO
017000171121      * letter head overlay
017100171121     c                   write     lethdol
017200090305     C                   WRITE     newpage
017300090305     C                   WRITE     let1loat
017400210414     c                   enddo
017500210414
017600090226     C                   MOVE      'U54'         TRCODE
017700090226     C                   exsr      #hist
017800090305      * billing only
017900090226     c                   when      acobsrv = 'B'
018000210414      * 2 copies
018100210414     c                   do        2
018200090305     C                   WRITE     LET1BO
018300171121      * letter head overlay
018400171121     c                   write     lethdol
018500130627     C                   WRITE     newpage
018600130627     C                   WRITE     let1boat
018700171122      * new page
018800171122     C                   WRITE     newpage
018900130627     C                   WRITE     let1boat2
019000210414     c                   enddo
019100210414
019200090226     C                   MOVE      'U55'         TRCODE
019300090226     C                   exsr      #hist
019400090305      * acct not cobra
019500090305     c                   other
019600090305     c                   leavesr
019700090226     c                   endsl
019800090226
019900090310     c                   exsr      #smanlabel
020000090226     c                   end
020100990820
020200030305
020300990816     C                   ENDSR
020400090226     C****************************************************************
020500090226     C* get sman / agency                                                    *
020600090226     C****************************************************************
020700090226     C*
020800090226     C     #getsman      BEGSR
020900090226     C                   clear                   smagout
021000090310     C                   clear                   smannamo
021100090310     C                   clear                   smanaddro
021200090310     C                   clear                   smancszo
021300090226
0214000902260234 C     SMANCD        CHAIN     SMAN
021500090226
021600090226     c                   if        %found(sman)
021700090226     C     SFNAME        CAT       SLNAME:1      smagout
021800090310      * label info
021900171201     C                   movel     smagout       smannamo         40
022000171201     C                   movel     saddr         smanaddro        40
022100171201     C                   MOVEL     scity         smancszo         40
022200090310     C                   CAT       ',':0         smancszo
022300090310     C                   CAT       sstate:1      smancszo
022400090310     C                   MOVEL     szipcd        ZIP5
022500090310     C                   MOVE      szipcd        ZIP4
022600090310     C                   CAT       ZIP5:1        smancszo
022700090310     C                   if        zip4 <> '0000'
022800090310     C                   CAT       '-':0         smancszo
022900090310     C                   CAT       ZIP4:0        smancszo
023000090310     C                   END
023100090226
023200090226     c                   clear                   relidwk
023300090226     c     acckey        setll     cmct14
023400090226     c                   dou       %eof(cmct14)
023500090226     c     acckey        reade     cmct14
023600090226     c                   if        (not %eof(cmct14)) and (smancd = slsman) and
023700090226     c                             (effdat <= symd) and
023800090226     c                             (cmcan = 0 or cmcan > symd)
023900090226     c                   move      cmrelid       relidwk
024000090226     c                   leave
024100090226     c                   end
024200090226     c                   enddo
024300090226
024400090226     c* get rel/sa to print on letter
024500090226
024600090226     c                   if        relidwk <> *blanks
024700090226     c* get agency/super agency link
024800090226     C     relidwk       Chain     smanrlt
024900090226     C                   If        %Found(smanrlt)
025000090226
025100090226     c* get agency/super agency code
025200090226     C     srasid        Chain     spragxr2
025300090226     C                   If        %Found(spragxr2)
025400090226     c* get agency name
025500090226     C     sxagcy        Chain     AGENCY
025600090226     C                   If        %Found(agency)
025700090226     c                   cat       ',':0         smagout
025800090226     c                   cat       agnam1:1      smagout
025900090226     c                   end
026000090226     c                   end
026100090226
026200090226     c                   end
026300090226     c                   end
026400090226
026500090226     c                   end
026600090226
026700090226     C                   ENDSR
026800090226
026900090226     C****************************************************************
027000090226     C* NAME LINES - N1 = DEAR XXXXXXXXXXX:                                  *
027100090226     C****************************************************************
027200090226     C*
027300090226     C     #NAME         BEGSR
027400090226     C                   clear                   dearline
027500090226     C                   MOVEL     'Dear'        dearline
027600090226     C                   cat       contac:1      dearline
027700090226     C                   CAT       ':':1         dearline
027800090226     C                   ENDSR
027900090226     C*
028000990816     C*
028100990816     C************************************************************
028200090226     C* fill address lines with acct name and address
028300990816     C************************************************************
028400990816     C*
028500990816     C     #ADR          BEGSR
028600090226
028700090226      * al = city, st zip
028800090226     C                   MOVE      *blanks       AL               31
028900090226     C                   MOVEL     acity         AL
029000990817     C                   CAT       ',':0         AL
029100090226     C                   CAT       astate:1      AL
029200090226     C                   MOVEL     azip          ZIP5              5
029300090226     C                   MOVE      azip          ZIP4              4
029400090226     C                   CAT       ZIP5:1        AL
029500990816     C     ZIP4          IFNE      '0000'
029600990816     C                   CAT       '-':0         AL
029700990816     C                   CAT       ZIP4:0        AL
029800990816     C                   END
029900090226
030000090226gsp  C                   clear                   CITYST           32
030100090226gsp  C                   movel     AL            CITYST           32
030200000510
030300090226     c                   exsr      #setaddr
030400000510
030500990816     C                   ENDSR
0306009908170107 C*
030700090226     c*
0308000902260539 C**************************************************************
0309000902260540 C* set address lines - "mail to" account                      *
0310000902260539 C**************************************************************
031100090226     C*
0312000902260542 C     #setaddr      BEGSR
031300090226
031400090226     c                   clear                   aline1
031500090226     c                   clear                   aline2
031600090226     c                   clear                   aline3
031700090226     c                   clear                   aline4
031800090226     c                   clear                   aline5
031900090226     c                   clear                   aline6
032000090226
032100090226     c                   movel     acnam1        aline1
032200090226
032300090226      * no name2, no addr2
032400090226     c                   if        acnam2 = *blanks and aaddr2 = *blanks
032500090226     c                   movel     contac        aline2
032600090226     c                   movel     aaddr1        aline3
032700090226     c                   movel     cityst        aline4
032800090226     c                   end
032900090226
033000090226      * no name2, yes addr2
033100090226     c                   if        acnam2 = *blanks and aaddr2 <> *blanks
033200090226     c                   movel     contac        aline2
033300090226     c                   movel     aaddr1        aline3
033400090226     c                   movel     aaddr2        aline4
033500090226     c                   movel     cityst        aline5
033600090226     c                   end
033700090226
033800090226      * yes name2, no addr2
033900090226     c                   if        acnam2 <> *blanks and aaddr2 = *blanks
034000090226     c                   movel     acnam2        aline2
034100090226     c                   movel     contac        aline3
034200090226     c                   movel     aaddr1        aline4
034300090226     c                   movel     cityst        aline5
034400090226     c                   end
034500090226
034600090226      * yes name2, yes addr2
034700090226     c                   if        acnam2 <> *blanks and aaddr2 <> *blanks
034800090226     c                   movel     acnam2        aline2
034900090226     c                   movel     contac        aline3
035000090226     c                   movel     aaddr1        aline4
035100090226     c                   movel     aaddr2        aline5
035200090226     c                   movel     cityst        aline6
035300090226     c                   end
035400090226
035500090226     C                   ENDSR
035600090226     c*
035700990917     C*
035800990917     C************************************************************
035900171201     C* ROUTINE FOR printing sman label
036000171201     C* 12/01/17 - this is now a seperate page instead of a label so it
036100171201     C*            can be used in a window envelope
036200171201     C************************************************************
036300171201
036400171201        begsr #smanlabel;
036500171201
036600171201        clear cc1;
036700171201        clear cc2;
036800171201        clear cc3;
036900171201        clear cc4;
037000171201        clear cc5;
037100171201        clear cc6;
037200171201
037300171201        eval cc1 = SMANNAMO;
037400171201        eval cc2 = SMANADDRO;
037500171201        eval cc3 = SMANCSZO;
037600171201
037700171201        write cc;
037800990917
037900171201        endsr;
0380009909170107 C*
038100990820     C*
038200990820     C************************************************************
038300990820     C* ROUTINE FOR history record
038400990820     C************************************************************
038500990820     C*
038600990820     C     #hist         BEGSR
0387000902260103
0388009908200103 C* WRITE HIST REC
038900090226     C                   MOVE      stsa          HKEY
039000990820     C                   MOVE      *ZEROS        TRAMT
039100131025     C                   MOVEL     'COB315'      HPRGNM
039200090226     C                   MOVE      acTRST        HSTRST
039300090226     C                   MOVE      acSUB#        HSSUB#
039400090226     C                   MOVE      acACCT        HSACCT
039500131014     C                   MOVEL     LUSER10       HOPER
039600990820     C                   MOVE      'A'           HSDLTD
039700990820     C                   MOVE      UD8YMD        TRDATE
039800990820     C                   MOVE      symd          COVTDT
039900131010     c                   eval      hstrtime = %time
040000990820     C                   WRITE     HISTR
040100171121
040200171121      * fill lda with 'Y' to show that letters were selected so the CL
040300171121      * knows to email them
040400171121
040500171121       llet = 'Y';
0406009908200120 C                   ENDSR
0407009908170103 C***************************************************
0408009908170104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0409009908170105 C***************************************************
0410009908170107 C*
0411009908170107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0412009908170107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0413009908170107 C*
0414009908170106 C     #DATMY        BEGSR
041500990817     C                   MOVEL     @DATIN        @MD               4 0
041600990817     C                   MOVE      @DATIN        @Y                4 0
041700990817     C                   MOVE      @MD           @DATOU            8 0
041800990817     C                   MOVEL     @Y            @DATOU
041900990817     C                   MOVE      *ZEROS        @DATIN            8 0
0420009908170120 C                   ENDSR
042100990817     C*
0422009908190103 C*****************************************************************
042300981112     C     *INZSR        BEGSR
042400990817     C                   MOVE      *DATE         @DATIN
042500990817     C                   EXSR      #DATMY
042600990817     C                   MOVE      @DATOU        UD8YMD            8 0
042700990825     C*
042800990825     C* add 14 days to todays date for letter 7
042900990825     C*
043000090226     C*                  MOVE      *DATE         dat2wkdt
043100090226     c*                  adddur    14:*d         dat2wkdt
043200090226     C*                  MOVE      dat2wkdt      dat2wk
043300990817     C*
0434009908160323 C* FIRST DATE LINE - UDATE
0435009908160328 C*
0436009908160329 C                   MOVE      *BLANKS       DL               19
0437009908160331 C                   MOVE      *MONTH        M                 2 0
0438009908160331 C                   MOVE      *DAY          D                 2
0439009908160331 C                   MOVE      *YEAR         Y                 4
0440009908160332 C                   MOVEL     YR(M)         DL
044100990816     C                   CAT       D:1           DL
044200990816     C                   CAT       ',':0         DL
044300990816     C                   CAT       Y:1           DL
044400000413     C*
044500990812     C     ACCKEY        KLIST
044600090226     C                   KFLD                    strust
044700090226     C                   KFLD                    ssub
044800090226     C                   KFLD                    sacc
044900981112     C                   ENDSR
045000990816**
045100990816January
045200990816February
045300990816March
045400990816April
045500990816May
045600990816June
045700990816July
045800990816August
045900990816September
046000990816October
046100990816November
046200990816December
