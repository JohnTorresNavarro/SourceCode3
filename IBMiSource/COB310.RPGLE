0001009908180002 F******************************************************************
0002009908190003 F* cob310     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0004009908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009908190006 F*            DATE -  8/19/99                                     *
0006009908190007 F*                                                                *
0007009908190013 F*  DESCRIPTION - master letter program for COBRA department      *
0008009908180004 F*                                                                *
0009000004130004 F* 04/13/00 dlk - change cobra administrator name to use "COB"    *
0010000004130004 F*                from aacode file.                               *
0011000005100004 F* 05/10/00 dlk - remove space in address if no 2nd address       *
0012000006160004 F* 06/16/00 dlk - add acc# & name to 45 day, past due, add prem   *
0013000006160004 F*                letter                                          *
0014000103140017 F* 10/13/00 dlk - change label to fit 7 lines                     *
0015000103140017 F* 03/14/01 dlk - add non pay letter and notice of acct can letter*
0016000108200017 F* 08/20/01 dlk - add "Election received too late" letter and     *
0017000108200004 F*                add new check off option to renewl confirmation *
0018000108200004 F*                letter                                          *
001900020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
0020000303050017 F* 03/05/03 dlk - add 3 new letters.                              *
0021000408300017 F* 08/30/04 dlk - add ", spouse" to "and all eligible depentents"*
0022000408300004 F*                also minor wording changes                      *
002300050725      * DLK 07/25/05 - change remittance po box                        *
002400080402     F*  4/04/02 szz - Show alternate ID instead of SS# whenever one is*
002500080402     F*                 available.                                     *
002600090305      * 03/04/09 dlk - change date edit                                *
002700110408      * 04/08/11 dlk - add dep seq# to hist rec for letter 10          *
0028001104150011  * 04/14/11 dlk - add letter history file for sub and dep inelig
0029001104150011  *                letters only.
0030001105160011  * 05/16/11 dlk - many changes to letters and change printer file
0031001105160011  *                from IPDS to AFPDS to print an addendum as a page
0032001105160011  *                segment.
0033001109070011  * 05/16/11 dlk - fix smytext field
0034001111090011  * 11/09/11 dlk - mask ssn when no alt id avail
0035001204180011  * 04/18/12 dlk - stop printing labels for mem & dep inelig letters
0036001207240011  * 07/20/12 dlk - fill in new acct fields in clethst file
0037001208010017  * 08/01/12 dlk - add status field to clethst file                     h
0038001109070011  *
0039001310100011  * 10/10/13 sbt - Hist file expansion project
0040001712010017  * 11/21/17 dlk - add letterhead ovelay and send back to user as pdf.  h
0041001712010017  *                Also convert label to seperate mailing sheet.        h
0042002104140017  * 04/09/21 dlk - wording changes to some letters, change to use       h
0043002104140017  *                unique letterhead overlay "cob31lhc" so only cob310  h
0044002104270017  *                cob315 and cob150 share this overlay, start printing h
0045002104270017  *                2 copies of some letters.                            h
0046002104140017  *                                                                     h
0047002104270011  *
0048002104270011  *   ** NOTE - THE PRINTER FILE COB310P IS ALSO USED IN COB150
0049002104270011  *             TO PRINT THE 1 MONTH AND 6 MONTH LETTERS
0050002104270011  *             SO ANY CHANGES HERE WILL ALSO NEED TO BE DONE AND
0051002104270011  *             RECOMPLIED IN COB150 ALSO. **
0052001711210017  *                                                                     h
0053009908180016 F******************************************************************
0054009908200018 Fcob310d   cf   E             workstn
0055009908200018 FMEMBER    If   E           k DISK
0056009909160018 Fdepndc    If   E           k DISK
005700000413JGE01Faacode    IF   e           k DISK
005800020603     FCOBRAAA   IF   E           K DISK
0059009908120034 FACCMST    IF   E           K DISK
006000080402     FMEMALTL3  IF   E           K Disk
006100110414     Fcodesl1   IF   E           K DISK
006200210409     Ftrsmst    IF   E           K DISK
006300210614     Fsubmem    IF   E           K DISK
0064009908170020 FHIST      O  A E             DISK
006500110414     Fclethst   o  a E           K DISK
0066009908190020 Fcob310p   O    E             PRINTER
0067001712010020 **Fcob310p2  O    E             PRINTER
006800040830     D AND1            C                   CONST(', spouse and all eligible +
006900040830     D                                     dependents')
007000040830     D AND2            C                   CONST(', spouse and all covered +
007100040830     D                                     dependents')
007200110513     D*poboxf           C                   CONST('P.O. Box 64802 Baltimore, MD-
007300110513     D*                                      21264-4802.')
007400110513     D*poboxn           C                   CONST('P.O. Box 17309 Baltimore, MD
007500110513     D*                                     21297-1288. ')
007600110414      * ineligible reasons - maximum 40 characters
007700110414      * THESE MUST MATCH WHAT IS ON THE LETTER / SCREEN !!!
007800110414     D INEL10a         C                   CONST('THREE MONTH COVERAGE UNDER +
007900110414     D                                     GROUP NOT MET')
008000110414     D INEL10b         C                   CONST('INELIGIBLE DUE TO RESIDENCE +
008100110414     D                                     OUTSIDE MD')
008200110414     D INEL10c         C                   CONST('INELIGIBLE DEPENDENTS CANNOT +
008300110414     D                                     EXTEND')
008400110414     D INEL11a         C                   CONST('THREE MONTH COVERAGE UNDER +
008500110414     D                                     GROUP NOT MET')
008600110414     D INEL11b         C                   CONST('INELIGIBLE DUE TO RESIDENCE +
008700110414     D                                     OUTSIDE MD')
008800110414      *
0089009908160037 D YR              S              9    DIM(12) CTDATA PERRCD(1)
0090009908230037 D ldom            S              2  0 DIM(12) CTDATA PERRCD(1)
0091009908260037 D dat2wkdt        S               d   datfmt(*usa)
0092002104090037 D dat45dy         S              8s 0
0093009908260055 D                 DS
0094009908260056 Dsmdy                     1      8  0
0095009908260056 Dsmo                      1      2  0
0096009908260056 Dsda                      3      4  0
0097009908260056 Dsyr                      5      8  0
0098001105160055 D                 DS
0099001105160056 Dsmdy01                   1      8  0
0100001105160056 Dsmdyd01                  3      4  0
0101001105160055 D                 DS
0102001105160056 Dsmdywk12                 1      8  0
0103001105160056 Dsmdywk12d                3      4  0
010400080402     d SS#             DS
010500080402     d SFirst3                 1      3
010600080402     d SMiddle2                4      5
010700080402     d SLast4                  6      9
0108009909210054 D* LDA                                                               DB020
0109009908260055 D                UDS
0110001310140056 D  LUSER                 25     32
0111001310140056 D  LUSER10               25     34
0112001711210056 D  llet                 100    100
0113009505080056 D  CONAME               201    240
0114009909080056 Dlprefix                241    241
011500000413     Iaccmsr
011600000413     i              aacode                      a_aacode
011700990819     c     #start        tag
011800990820     c                   eval      sssn  = *zeros
011900990826     c                   eval      smdy  = *zeros
012000990819     c                   eval      slet1 = *blanks
012100990819     c                   eval      slet2 = *blanks
012200990823     c                   eval      slet3 = *blanks
012300990823     c                   eval      slet4 = *blanks
012400990823     c                   eval      slet5 = *blanks
012500990825     c                   eval      slet6 = *blanks
012600990825     c                   eval      slet7 = *blanks
012700990908     c                   eval      slet8 = *blanks
012800990910     c                   eval      slet9 = *blanks
012900990916     c                   eval      slet10 = *blanks
013000990917     c                   eval      slet11 = *blanks
013100010313     c                   eval      slet12 = *blanks
013200010313     c                   eval      slet13 = *blanks
013300010820     c                   eval      slet14 = *blanks
013400030305     c                   eval      slet15 = *blanks
013500030305     c                   eval      slet16 = *blanks
013600030305     c                   eval      slet17 = *blanks
013700210614     c                   eval      slet18 = *blanks
013800990819
013900990819     c     #t0010        tag
014000990819     c                   exfmt     scrn01
014100990819     c                   if        *inkg
014200990819     c                   goto      #end
014300990819     c                   end
014400990819
0145009908190144 C     sssn          CHAIN     member                             20
014600990819
014700990819     c                   if        *in20
014800990819     c                   goto      #t0010
014900990819     c                   end
015000080402      * Determine whether there is an alternate ID
015100080402
015200080402     C                   Eval      AltType   =   'GBS'
015300080402     C                   Clear                   ALTSS
015400080402     C     AltKey        Chain     MEMALTL3
015500080402     C                   If        %Found(MEMALTL3)
015600080408     C                   Eval      ALTSS = %Trim(MAALTID)
015700080402     C                   Else
015800080402     C                   Move      MBSSNO        SS#
015900111109      * 11/9/11 mask ssn
016000111109     C*                  Eval      ALTSS = %Trim(SFirst3  +
016100111109     C*                                          '-'      +
016200111109     C*                                          SMiddle2 +
016300111109     C*                                          '-'      +
016400111109     C                   Eval      ALTSS = %Trim('XXX-XX-' +
016500080402     C                                           SLast4)
016600080402     C                   End
016700990825
016800990825     c* cobra edit disabled because letters are also mailed to
016900990825     c* non-cobra members
017000990825
017100990825     c*                  eval      *in21 = *off
017200990825     c*                  if        cexpdt = 0
017300990825     c*                  eval      *in21 = *on
017400990825     c*                  goto      #t0010
017500990825     c*                  end
0176009908200060
0177009908250060 C* edit date & letter select
017800990820
017900990820     c                   eval      *in22 = *off
018000090226     C     *USA          test (de)               smdy
018100090226     C                   if        %ERROR
018200090226     c                   eval      *in22 = *on
018300090226     c                   goto      #t0010
018400090226     C                   end
018500990820
018600990820     c                   eval      *in23 = *off
018700990823     c                   if        slet1 = ' ' and slet2 = ' ' and slet3 = ' '
018800990825     c                             and slet4 = ' ' and slet5 = ' ' and slet6 =
018900990908     c                             ' ' and slet7 = ' ' and slet8 = ' '
019000990916     c                             and slet9 = ' ' and slet10 = ' '
019100010313     c                             and slet11 = ' ' and slet12 = ' '
019200010820     c                             and slet13 = ' ' and slet14 = ' '
019300030305     c                             and slet15 = ' ' and slet16 = ' '
019400210614     c                             and slet17 = ' ' and slet18 = ' '
019500990820     c                   eval      *in23 = *on
019600990820     c                   goto      #t0010
019700990820     c                   end
019800990820
019900030306     c* duplicate screen effect date for use in other screens and letter
020000030306     c                   move      smdy          smdy2             8 0
020100110516     c* date as 1st of month for other calcs
020200110516     c                   move      smdy          smdy01            8 0
020300110516     c                   move      01            smdyd01
020400110524     c* duplicate 1st of month for use another time on same letter
020500110524     c                   move      smdy01        smdy01b           8 0
020600030306
020700990820     c* screen 2 needed for renewal confirmation letter
020800990820
020900990820     c                   if        slet2 <> ' '
021000990820     c                   exfmt     scrn02
021100990820     c                   if        *inka
021200990820     c                   goto      #t0010
021300990820     c                   end
021400990820     c                   end
021500990823
021600990824     c* screen 5 needed for welcome to extension letter
021700990824
021800990824     c                   if        slet5 <> ' '
021900990824     c                   exfmt     scrn05
022000990824     c                   if        *inka
022100990824     c                   goto      #t0010
022200990824     c                   end
022300990824     c                   end
022400990825
022500990825     c* screen 6 needed for refund notice
022600990825
022700990825     c                   if        slet6 <> ' '
022800990825     c                   exfmt     scrn06
022900990825     c                   if        *inka
023000990825     c                   goto      #t0010
023100990825     c                   end
023200990825     c                   end
023300990825
023400990825     c* screen 7 needed for past due balance
023500990825
023600990825     c                   if        slet7 <> ' '
023700990825     c                   exfmt     scrn07
023800990825     c                   if        *inka
023900990825     c                   goto      #t0010
024000990825     c                   end
024100990825     c                   end
024200990908
024300990908     c* screen 8 needed for 45 day letter
024400990908
024500990908     c                   if        slet8 <> ' '
024600210409      * default slet8D to 45 days from today
024700210409     c                   eval      *in81 = *off
024800210409     c                   eval      slet8d = dat45dy
024900210409     c     #again8       tag
025000990908     c                   exfmt     scrn08
025100990908     c                   if        *inka
025200990908     c                   goto      #t0010
025300990908     c                   end
025400210409      * edit date
025500210409     c     *usa          test(de)                slet8d
025600210409     c                   if        %error
025700210409     C                   eval      *in81 = *on
025800210409     c                   goto      #again8
025900210409     c                   end
026000990908     c                   end
026100990910
026200990910     c* screen 9 needed for additional premium letter
026300990910
026400990910     c                   if        slet9 <> ' '
026500210411      * default slet9b to 45 days from today
026600210411     c                   eval      *in81 = *off
026700210411     c                   eval      slet9b = dat45dy
026800210411     c     #again9       tag
026900990910     c                   exfmt     scrn09
027000990910     c                   if        *inka
027100990910     c                   goto      #t0010
027200990910     c                   end
027300210411      * edit date
027400210411     c     *usa          test(de)                slet9b
027500210411     c                   if        %error
027600210411     C                   eval      *in81 = *on
027700210411     c                   goto      #again9
027800210411     c                   end
027900210411      * dup date to be used 2nd time on letter.
028000210411     c                   eval      slet9c = slet9b
028100990910     c                   end
028200990916
028300990916     c* screen 10 needed for dependent ineligible letter
028400990916
028500990916     c                   if        slet10 <> ' '
028600990916     c                   eval      *in24 = *off
028700990916     c     #s10          tag
028800990916     c                   exfmt     scrn10
028900990916     c                   if        *inka
029000990916     c                   goto      #t0010
029100990916     c                   end
029200990916     c* validate dep seq#
029300990916     c     depkey        chain     depndc                             24
029400990916     c     *in24         cabeq     *on           #s10
029500990916
029600990916     c                   end
029700990824
029800990917
029900990917     c* screen 11 needed for subscriber ineligible letter
030000990917
030100990917     c                   if        slet11 <> ' '
030200990917     c                   exfmt     scrn11
030300990917     c                   if        *inka
030400990917     c                   goto      #t0010
030500990917     c                   end
030600990917     c                   end
030700010313
030800010313     c* screen 12 needed for non pay / sb350 letter
030900110516     c**                 if        slet12 <> ' '
031000110516     c**                 exfmt     scrn12
031100110516     c**                 if        *inka
031200110516     c**                 goto      #t0010
031300110516     c**                 end
031400110516     c**                 end
031500010314
031600010314     c* screen 13 needed for notice of acct cancel letter
031700010314
031800010314     c                   if        slet13 <> ' '
031900010314     c                   exfmt     scrn13
032000010314     c                   if        *inka
032100010314     c                   goto      #t0010
032200010314     c                   end
032300010314     c                   end
032400010820
032500010820     c* screen 14 needed for election/payment received too late
032600010820
032700010820     c                   if        slet14 <> ' '
032800010820     c                   exfmt     scrn14
032900010820     c                   if        *inka
033000010820     c                   goto      #t0010
033100010820     c                   end
033200010820     c                   end
033300990917
033400030305
033500030305     c* screen 15 needed for end of 45 day
033600030305
033700030305     c                   if        slet15 <> ' '
033800030305     c                   exfmt     scrn15
033900030305     c                   if        *inka
034000030305     c                   goto      #t0010
034100030305     c                   end
034200030305     c                   end
034300030305
034400030305
034500030305     c* screen 17 needed for notice of short payment
034600030305
034700030305     c                   if        slet17 <> ' '
034800030305     c                   exfmt     scrn17
034900030305     c                   if        *inka
035000030305     c                   goto      #t0010
035100030305     c                   end
035200030305     c                   end
035300030305
035400210614     c* screen 18 needed for subsidy confirmation
035500210614     c                   if        slet18 <> ' '
035600210614      * get latest subsidy dates
035700210614     c                   exsr      #getsubsidy
035800210614     c                   exfmt     scrn18
035900210614     c                   if        *inka
036000210614     c                   goto      #t0010
036100210614     c                   end
036200210614     c                   end
036300210614
036400990820
0365009908120144 C     ACCKEY        CHAIN     ACCMST                             87
036600990819     C     *IN87         CABEQ     *ON           #start
036700210615
036800210615      * create account mailing address fields
036900210615     C                   exsr      #actaddr
037000210615
037100020603     C*  GET COBRA aa name
037200020603     C*
037300020603     c                   eval      aaname = *blanks
037400020603     c     mbtrst        Chain     COBRAAA
037500020603     c                   if        %found(COBRAAA)
037600020603     c     CACODE        chain     AACODE
037700020603     c                   if        %found(AACODE)
037800110512     c                   movel     afnam         aaname           30
037900110512     c                   if        afnam <> *blanks
038000110512     c                   cat(p)    alnam:1       aaname
038100110512     c                   else
038200110512     c                   cat(p)    alnam:0       aaname
038300020603     c                   endif
038400110512     c                   endif
038500020603     c                   endif
0386009908190060 C*
038700990812     C                   EXSR      #LTR
038800990819
038900990819     c                   goto      #start
039000990820
039100990819     C     #end          tag
039200990819     c                   eval      *inlr = *on
0393009908190103 C*
039400990816     C*****************************************************
0395009908160073 C* PRINT RENEWAL LETTER AND WRITE HISTORY REC
039600990816     C*****************************************************
0397009908190103 C*
039800990816     C     #LTR          BEGSR
039900990820     C*
040000990826     C* convert effective date from screen to ymd
040100990820     C*
040200990826     c                   move      smdy          @datin
040300990826     c                   exsr      #datmy
040400990826     c                   move      @datou        symd              8 0
040500990820     C*
0406009908190103 C*
0407009908200323 C* 2ND DATE LINE - effective date
0408009908200328 C*
0409009908200329 C                   MOVE      *BLANKS       DL2              19
0410009908200331 C                   MOVE      smo           M
0411009908260331 C                   MOVE      sda           D
0412009908260331 C                   MOVE      syr           Y
0413009908200332 C                   MOVEL     YR(M)         DL2
041400990820     C                   CAT       D:1           DL2
041500990820     C                   CAT       ',':0         DL2
041600990820     C                   CAT       Y:1           DL2
041700990820     C*
041800990820     C                   MOVE      YR(M)         RENMO             9
041900990820     C*
042000990823     C* 1 MONTH PRIOR TO EFFDT
042100990820     C*
0422009908200331 C                   MOVE      smo           WM                2 0
0423009908260331 C                   MOVE      syr           WY                4 0
042400990820     C                   SUB       1             WM
042500990820     C     WM            IFLT      1
042600990820     C                   MOVE      12            WM
042700990823     C                   sub       1             wy
042800990820     C                   END
042900010313
043000110512     C**                 MOVEL     YR(WM)        RENMO2           10
043100990823     C                   MOVEL     YR(WM)        RENMO3            9
043200110512     C**                 CAT       '.':0         RENMO2
043300990823     C*
043400990823     C* last day of 1 MONTH PRIOR TO EFFDT
043500990823     C*
0436001105160331 C                   MOVE      smdy01        dat2wkdt
043700110516     c                   subdur    1:*d          dat2wkdt
043800110516     C                   MOVE      dat2wkdt      date3             8 0
0439001105160331 C                   MOVE      date3         date3b            8 0
044000990823     C*
044100990816     C                   EXSR      #NAME
044200990816     C                   EXSR      #ADR
044300210411
044400210411      * pay to address used in letter 8 and 9
044500210411       clear ptadl1o;
044600210411       clear ptadl2o;
044700210411       clear ptadl3o;
044800210411       clear ptadl4o;
044900210411       chain mbtrst trsmst;
045000210411       if %found(trsmst);
045100210411        ptadl1o = ptadl1;
045200210411        ptadl2o = ptadl2;
045300210411        ptadl3o = ptadl3;
045400210411        ptadl4o = ptadl4;
045500210411       endif;
045600210411
045700210414      ***********************
045800210414      * letter 1 : renewal  *
045900210414      ***********************
046000990820     c                   if        slet1 <> ' '
046100171121     C                   WRITE     LET1
046200171121      * letter head overlay
046300171121     c                   write     lethdol
046400171121
046500990819     C                   MOVE      'U01'         TRCODE
046600990820     C                   exsr      #hist
046700990819     c                   end
046800990820
046900210414      **************************************
047000210414      * letter 2 : renewal confirmation    *
047100210414      **************************************
047200990820     c                   if        slet2 <> ' '
047300171121     C                   WRITE     LET2
047400171121      * letter head overlay
047500171121     c                   write     lethdol
047600171121
047700990820     C                   MOVE      'U02'         TRCODE
047800990820     C                   exsr      #hist
047900990820     c                   end
048000210414
048100210414      **************************
048200210414      * letter 3 : 1 month     *
048300210414      **************************
048400990823     c                   if        slet3 <> ' '
048500171121     C                   WRITE     LET3
048600171121      * letter head overlay
048700171121     c                   write     lethdol
048800171121
048900990823     C                   MOVE      'U03'         TRCODE
049000990823     C                   exsr      #hist
049100990823     c                   end
049200990824
049300210414      ************************
049400210414      * letter 4 : 6 month   *
049500210414      ************************
049600990824     c                   if        slet4 <> ' '
049700171121     C                   WRITE     LET4
049800171121      * letter head overlay
049900171121     c                   write     lethdol
050000171121
050100990824     C                   MOVE      'U04'         TRCODE
050200990824     C                   exsr      #hist
050300990824     c                   end
050400990820
050500210414      ********************************************************************
050600110524     c* letter 5 : welcome to extension - duplex printed with addendum
050700110524     c*            on back
050800110524     c* in order to print the addendum on the back of the letterhead, first
050900110524     c* the addendum must be printed (with the *duplex keyword), then
051000110524     c* the new page blank record, then the letter (front) with the *duplex
051100110524     c* keyword.
051200171121      *
051300171121      * 11/21/17 - change to PDF so duplex is not needed. change pages to
051400171121      *            print letter first
051500210414      **********************************************************************
051600990824
051700990824     c                   if        slet5 <> ' '
051800171121     C                   WRITE     LET5
051900171121      * letter head overlay
052000171121     c                   write     lethdol
052100171121
052200171121     C                   WRITE     newpage
052300110520     C                   WRITE     LET5add
052400990824     C                   MOVE      'U05'         TRCODE
052500990824     C                   exsr      #hist
052600990824     c                   end
052700210414
052800210414      ****************************
052900210414      * letter 6 : refund notice *
053000210414      ****************************
053100990825     c                   if        slet6 <> ' '
053200110513
053300110513      * mailing address override
053400110513     c                   if        slet6mo1 <> *blanks
053500110513     c                   movel     slet6mo1      slet6ma1
053600120806     c                   movel     slet6mo1      slet6ma1b
053700120806     c                   CAT       ':':0         slet6ma1b
053800110513     c                   movel     slet6mo2      slet6ma2
053900110513     c                   movel     slet6mo3      slet6ma3
054000110513     c                   movel     slet6mo4      slet6ma4
054100110513     c                   else
054200110513      * member address
054300110513     c                   movel     n2            slet6ma1
054400120806     c                   movel     n2            slet6ma1b
054500120806     c                   CAT       ':':0         slet6ma1b
054600110513     c                   movel     addr1         slet6ma2
054700110513     c                   movel     a2            slet6ma3
054800110513     c                   movel     a3            slet6ma4
054900110513     c                   end
055000110513
055100210414      * 2 copies
055200210414     c                   do        2
055300990825     C                   WRITE     LET6
055400171121      * letter head overlay
055500171121     c                   write     lethdol
055600210414     c                   enddo
055700171121
055800990825     C                   MOVE      'U06'         TRCODE
055900990825     C                   exsr      #hist
056000990825     c                   end
056100990825
056200210414      ********************************
056300210414      * letter 7 : past due balance  *
056400210414      ********************************
056500990825     c                   if        slet7 <> ' '
056600990825     c                   move      slet7e        slet7e2           6 2
056700210414      * 2 copies
056800210414     c                   do        2
056900990825     C                   WRITE     LET7
057000171121      * letter head overlay
057100171121     c                   write     lethdol
057200210414     c                   enddo
057300171121
057400990825     C                   MOVE      'U07'         TRCODE
057500990825     C                   exsr      #hist
057600990825     c                   end
057700210414
057800210414      ***********************
057900210414      * letter 8 : 45 day   *
058000210414      ***********************
058100990908     c                   if        slet8 <> ' '
058200210414      * 2 copies
058300210414     c                   do        2
058400990908     C                   WRITE     LET8
058500171121      * letter head overlay
058600171121     c                   write     lethdol
058700210414     c                   enddo
058800210414
058900990908     C                   MOVE      'U08'         TRCODE
059000990908     C                   exsr      #hist
059100990908     c                   end
059200990910
059300210414      **********************************
059400210414      * letter 9 : additional premium  *
059500210414      **********************************
059600990910     c                   if        slet9 <> ' '
059700210414      * 2 copies
059800210414     c                   do        2
059900990910     C                   WRITE     LET9
060000171121      * letter head overlay
060100171121     c                   write     lethdol
060200210414     c                   enddo
060300210414
060400990910     C                   MOVE      'U09'         TRCODE
060500990910     C                   exsr      #hist
060600990910     c                   end
060700990916
060800210414      *************************************
060900210414      * letter 10 : dependent ineligible  *
061000210414      *************************************
061100990916     c                   if        slet10 <> ' '
061200990916     c                   move      mbtrst        t                 3 0
061300990916     c                   move      mbsub#        s                 3 0
061400990916     c                   move      mbacct        a                 4 0
061500990916     c                   move      acnam1        acnam1b          40
061600990916
061700990916     c* n4 = depend name (first mi. last)
061800990916     c* n5 = depend name (first mi. last:)
061900990916
062000990916     c                   move      *blanks       n4               35
062100990916     c                   movel     dfname        n4
062200990916     c                   if        dmi <> ' '
062300990916     c                   cat       dmi:1         n4
062400990916     c                   cat       '.':0         n4
062500990916     c                   end
062600990916     c                   movel     dlname        same              4
062700990916     c                   if        same = 'SAME'
062800990916     c                   cat       mlname:1      n4
062900990916     c                   else
063000990916     c                   cat       dlname:1      n4
063100990916     c                   end
063200990916     c                   move      *blanks       n5               36
063300990916     c                   movel     n4            n5
063400990916     c                   cat       ':':0         n5
063500990916
063600990916     c* depend address
063700990916     c                   movel     daddr1        same
063800990916     c                   if        same = 'SAME'
063900990916     c                   move      addr1         dad1
064000000510     c                   movel     a2            dad2
064100000510     c                   movel     a3            dad3
064200990916     c                   else
064300990916     c                   move      daddr1        dad1
064400000510     c                   movel     daddr2        dad2
064500990916     c                   move      *blanks       dad3
064600990916     C                   MOVEL     dcity         dad3
064700990916     C                   CAT       ',':0         dad3
064800990916     C                   CAT       dSTATE:1      dad3
064900990916     C                   MOVEL     dzip          ZIP5
065000990916     C                   MOVE      dzip          ZIP4
065100990916     C                   CAT       ZIP5:1        dad3
065200990916     C     ZIP4          IFNE      '0000'
065300990916     C                   CAT       '-':0         dad3
065400990916     C                   CAT       ZIP4:0        dad3
065500990916     C                   END
065600000510     c                   if        dad2 = *blanks
065700000510     c                   movel     dad3          dad2
065800000510     c                   move      *blanks       dad3
065900000510     c                   end
066000990916     c                   end
066100990916
066200210414      * 2 copies
066300210414     c                   do        2
066400990916     C                   WRITE     LET10
066500171121      * letter head overlay
066600171121     c                   write     lethdol
066700210414     c                   enddo
066800171121
066900990916     C                   MOVE      'U10'         TRCODE
067000990917     c                   movel     slet10d       ck#not
067100110408     c                   movel     slet10d       hdseq#
067200990917     c                   cat       dfname:1      ck#not
067300990916     C                   exsr      #hist
067400110414     C                   exsr      #clethst
067500990917     c                   move      *blanks       ck#not
067600110408     c                   clear                   hdseq#
067700210615
067800210615      * write account mailing sheet
067900210615     C**                 write     cc
068000990916     c                   end
068100990917
068200210414      ***************************************
068300210414      * letter 11 : subscriber ineligible   *
068400210414      ***************************************
068500990917     c                   if        slet11 <> ' '
068600990917     c                   move      mbtrst        t
068700990917     c                   move      mbsub#        s
068800990917     c                   move      mbacct        a
068900990917     c                   move      acnam1        acnam1b
069000171121     C                   WRITE     LET11
069100171121      * letter head overlay
069200171121     c                   write     lethdol
069300171121
069400171121     C                   MOVE      'U11'         TRCODE
069500990917     C                   exsr      #hist
069600210615
069700210615      * write account mailing sheet
069800210615     C**                 write     cc
069900210615
070000110414     C                   exsr      #clethst
070100990917     c                   end
070200990917
070300210414      ************************
070400210414      * letter 12 : non pay  *
070500210414      ************************
070600010313     c                   if        slet12 <> ' '
070700110907     c                   clear                   smytext          14
070800110907     c                   movel     yr(smo)       smytext
070900110516     c                   move      syr           syrchar           4
071000110516     c                   cat       syrchar:1     smytext
071100110516      * smdy12 = last day of cancel month
071200110516     c                   move      smdy          smdywk12
071300110516     c                   move      01            smdywk12d
071400110516     c                   move      smdywk12      dat2wkdt
071500010313     c                   adddur    1:*m          dat2wkdt
071600110516     c                   subdur    1:*d          dat2wkdt
071700010313     C                   MOVE      dat2wkdt      smdy12            8 0
071800010313     C                   WRITE     LET12
071900171121      * letter head overlay
072000171121     c                   write     lethdol
072100171121
072200110516      ** 5/16/11 - code change from U14 to U71 to reflect new non pay
072300110516      *            letter w/o SB350
072400110516     C                   MOVE      'U71'         TRCODE
072500010313     C                   exsr      #hist
072600010313     c                   end
072700010313
072800210414      ***************************************
072900210414      * letter 13 : notice of acct cancel   *
073000210414      ***************************************
073100010314     c                   if        slet13 <> ' '
073200010314     c                   movel     acnam1        acnam1o          41
073300010314     C                   CAT       '.':0         acnam1o
073400210414      * 2 copies
073500210414     c                   do        2
073600010314     C                   WRITE     LET13
073700171121      * letter head overlay
073800171121     c                   write     lethdol
073900110517     C                   WRITE     LET13box
074000210414     C                   enddo
074100210414
074200010314     C                   MOVE      'U15'         TRCODE
074300010314     C                   exsr      #hist
074400210615
074500210615      * write account mailing sheet
074600210615     C                   write     cc
074700010314     c                   end
074800010313
074900210414      *****************************************************
075000210414      * letter 14 : election/payment received too late    *
075100210414      *****************************************************
075200010820     c                   if        slet14 <> ' '
075300010820     C                   WRITE     LET14
075400171121      * letter head overlay
075500171121     c                   write     lethdol
075600171121
075700010820     C                   MOVE      'U24'         TRCODE
075800010820     C                   exsr      #hist
075900010820     c                   end
076000030305
076100210414      ******************************
076200210414      * letter 15 : end of 45 day  *
076300210414      ******************************
076400030305     c                   if        slet15 <> ' '
076500030305     C                   WRITE     LET15
076600171121      * letter head overlay
076700171121     c                   write     lethdol
076800171121
076900030305     C                   MOVE      'U32'         TRCODE
077000030305     C                   exsr      #hist
077100030305     c                   end
077200030305
077300210414      ******************************
077400210414      * letter 16 : end of COBRA   *
077500210414      ******************************
077600030305     c                   if        slet16 <> ' '
077700030305     C                   WRITE     LET16
077800171121      * letter head overlay
077900171121     c                   write     lethdol
078000171121
078100030305     C                   MOVE      'U33'         TRCODE
078200030305     C                   exsr      #hist
078300030305     c                   end
078400030305
078500210414      ***************************************
078600210414      * letter 17 : notice of short pay    *
078700210414      ***************************************
078800030305     c                   if        slet17 <> ' '
078900030305     C                   WRITE     LET17
079000171121      * letter head overlay
079100171121     c                   write     lethdol
079200171121
079300030305     C                   MOVE      'U34'         TRCODE
079400030305     C                   exsr      #hist
079500030305     c                   end
079600030305
079700210614      ***************************************
079800210614      * letter 18 : Subsidy confirmation   *
079900210614      ***************************************
080000210614     c                   if        slet18 <> ' '
080100210615
080200210615      * page 1 with letter head overlay
080300210614     C                   WRITE     LET18
080400210614     c                   write     lethdol
080500210615
080600210615      * page 2 with letter head overlay
080700210614     C                   WRITE     LET18p2
080800210614     c                   write     lethdol
080900210615
081000210615      * page 3 - addendum (w/o letterhead)
081100210615     C                   WRITE     newpage
081200210615     C                   WRITE     LET18p3
081300210615
081400210615      * page 4 - account letter with letter head overlay
081500210615      * create "dear contact:" line
081600210615     C                   clear                   dearline
081700210615     C                   MOVEL     'Dear'        dearline
081800210615     C                   cat       contac:1      dearline
081900210615     C                   CAT       ':':0         dearline
082000210615
082100210615     C                   WRITE     LET18p4
082200210615     c                   write     lethdol
082300210615
082400210615      * write member hist
082500210614     C                   MOVE      'U85'         TRCODE
082600210614     C                   exsr      #hist
082700210615      * write acct hist
082800210615     c                   movel     mbssno        ck#not
082900210615     C                   exsr      #histacc
083000210615     c                   clear                   ck#not
083100210615
083200210614     c                   end
083300210614
083400990816     C                   ENDSR
083500990816     C*
083600990825     C****************************************************************
083700040830     C* NAME LINES - N1 = FIRST MI. LAST, spouse and all eligible dependents *
083800990825     C*              N2 = first mi. last                             *
083900990825     C*              N3 = first mi. last:                            *
084000040830     C*              N6 = FIRST MI. LAST, spouse and all covered dependents  *
084100990825     C****************************************************************
084200990816     C*
084300990816     C     #NAME         BEGSR
084400990816     C*
084500040830     C                   MOVE      *BLANKS       N1               69
084600990825     C                   MOVE      *BLANKS       N2               35
084700990825     C                   MOVE      *BLANKS       N3               36
084800040830     C                   MOVE      *BLANKS       N6               69
084900990817     C                   MOVEL     MFNAME        N1
085000990816     C*
085100990817     C     MMI           IFNE      ' '
085200990817     C                   CAT       MMI:1         N1
085300990816     C                   CAT       '.':0         N1
085400990816     C                   END
085500990816     C*
085600990816     C                   CAT       MLNAME:1      N1
085700990825
085800990825     c                   movel     n1            n2
085900990825     c                   movel     n1            n3
086000010314     c                   movel     n1            n6
086100990825     C                   CAT       ':':0         N3
086200990825
086300040830     C                   CAT       AND1:0        N1
086400040830     C                   CAT       AND2:0        N6
086500990816     C                   ENDSR
086600990816     C*
086700990816     C************************************************************
086800990917     C* ROUTINE FOR city,state zip+4 - MEMBER
086900990816     C************************************************************
087000990816     C*
087100990816     C     #ADR          BEGSR
087200990820     C                   MOVE      *blanks       AL               31
087300990820     C                   MOVEL     CITY          AL
087400990817     C                   CAT       ',':0         AL
087500990817     C                   CAT       STATE:1       AL
087600990816     C                   MOVEL     ZIP           ZIP5              5
087700990816     C                   MOVE      ZIP           ZIP4              4
087800990816     C                   CAT       ZIP5:1        AL
087900990816     C     ZIP4          IFNE      '0000'
088000990816     C                   CAT       '-':0         AL
088100990816     C                   CAT       ZIP4:0        AL
088200990816     C                   END
088300000510
088400000510     c* set address for output
088500000510
088600000510     c                   eval      a2 = *blanks
088700000510     c                   eval      a3 = *blanks
088800000510     c                   if        addr2 <> *blanks
088900000510     c                   movel     addr2         a2
089000000510     c                   movel     al            a3
089100000510     c                   else
089200000510     c                   movel     al            a2
089300000510     c                   end
089400000510
089500990816     C                   ENDSR
0896009908170107 C*
089700990917     C*
089800990917     C************************************************************
089900210615     C* ROUTINE FOR creating account address used for mailing
090000210615     C* 12/01/17 - the label was changed to a seperate page instead of a
090100210615     C*            label so it can be used in a window envelope
090200990917     C************************************************************
090300990917     C*
090400210615     C     #actaddr      BEGSR
090500990917
090600990917     C                   MOVE      *blanks       alacc            31
090700990917     C                   MOVEL     acity         alacc
090800990917     C                   CAT       ',':0         alacc
090900990917     C                   CAT       astate:1      alacc
091000990917     C                   MOVEL     azip          azip5             5
091100990917     C                   MOVE      azip          azip4             4
091200990917     C                   CAT       azip5:1       alacc
091300990917     C     azip4         IFNE      '0000'
091400990917     C                   CAT       '-':0         alacc
091500990917     C                   CAT       azip4:0       alacc
091600990917     C                   END
091700990917
091800171201        clear cc1;
091900171201        clear cc2;
092000171201        clear cc3;
092100171201        clear cc4;
092200171201        clear cc5;
092300171201        clear cc6;
092400171201
092500171201        eval cc1 = contac;
092600171201        eval cc2 = acnam1;
092700171201
092800171201        select;
092900171201        when acnam2 <> *blanks and aaddr2 <> *blanks;
093000171201        eval cc3 = acnam2;
093100171201        eval cc4 = aaddr1;
093200171201        eval cc5 = aaddr2;
093300171201        eval cc6 = alacc;
093400171201
093500171201        when acnam2 <> *blanks and aaddr2 = *blanks;
093600171201        eval cc3 = acnam2;
093700171201        eval cc4 = aaddr1;
093800171201        eval cc5 = alacc;
093900171201
094000171201        when acnam2 = *blanks and aaddr2 <> *blanks;
094100171201        eval cc3 = aaddr1;
094200171201        eval cc4 = aaddr2;
094300171201        eval cc5 = alacc;
094400171201
094500171201        when acnam2 = *blanks and aaddr2 = *blanks;
094600171201        eval cc3 = aaddr1;
094700171201        eval cc4 = alacc;
094800171201
094900171201        endsl;
095000171201
095100990917     C                   ENDSR
0952009909170107 C*
095300990820     C*
095400990820     C************************************************************
095500210615     C* ROUTINE FOR member history record
095600990820     C************************************************************
095700990820     C*
095800990820     C     #hist         BEGSR
0959009908200103 C*
0960009908200103 C* WRITE HIST REC
0961009908200103 C*
096200990820     C                   MOVE      MBSSNO        HKEY
096300990820     C                   MOVE      *ZEROS        TRAMT
096400131025     C                   MOVEL     'COB310'      HPRGNM
096500990820     C                   MOVE      MBTRST        HSTRST
096600990820     C                   MOVE      MBSUB#        HSSUB#
096700990820     C                   MOVE      MBACCT        HSACCT
096800131014     C                   MOVEl     LUSER10       HOPER
096900990820     C                   MOVE      'A'           HSDLTD
097000990820     C                   MOVE      UD8YMD        TRDATE
097100990820     C                   MOVE      symd          COVTDT
097200131010     c                   eval      hstrtime = %time
097300990820     C                   WRITE     HISTR
097400171121
097500171121      * fill lda with 'Y' to show that letters were selected so the CL
097600171121      * knows to email them
097700171121
097800171121       llet = 'Y';
0979009908200120 C                   ENDSR
098000210615     C************************************************************
098100210615     C* ROUTINE FOR account history record
098200210615     C************************************************************
098300210615     C*
098400210615     C     #histacc      BEGSR
0985002106150103
098600210615       hkey = %editc(mbtrst:'X') + %editc(mbsub#:'X') + %editc(mbacct:'X');
098700210615     C                   MOVE      *ZEROS        TRAMT
098800210615     C                   MOVEL     'COB310'      HPRGNM
098900210615     C                   MOVE      MBTRST        HSTRST
099000210615     C                   MOVE      MBSUB#        HSSUB#
099100210615     C                   MOVE      MBACCT        HSACCT
099200210615     C                   MOVEl     LUSER10       HOPER
099300210615     C                   MOVE      'A'           HSDLTD
099400210615     C                   MOVE      UD8YMD        TRDATE
099500210615     C                   MOVE      symd          COVTDT
099600210615     c                   eval      hstrtime = %time
099700210615     C                   WRITE     HISTR
099800210615
099900210615      * fill lda with 'Y' to show that letters were selected so the CL
100000210615      * knows to email them
100100210615
100200210615       llet = 'Y';
1003002106150120 C                   ENDSR
1004009908170103 C***************************************************
1005009908170104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
1006009908170105 C***************************************************
1007009908170107 C*
1008009908170107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
1009009908170107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
1010009908170107 C*
1011009908170106 C     #DATMY        BEGSR
101200990817     C                   MOVEL     @DATIN        @MD               4 0
101300990817     C                   MOVE      @DATIN        @Y                4 0
101400990817     C                   MOVE      @MD           @DATOU            8 0
101500990817     C                   MOVEL     @Y            @DATOU
101600990817     C                   MOVE      *ZEROS        @DATIN            8 0
1017009908170120 C                   ENDSR
101800990817     C*
1019001104140103  ***************************************************
1020001104140104  * write letter history recod                      *
1021001104140105  ***************************************************
1022001104140107
1023001104140106 C     #clethst      BEGSR
102400110414     C                   clear                   clethstr
102500120801     C                   MOVE      'A'           CLSTATUS
102600110414     C                   MOVE      ud8ymd        CLTRDAT
102700110414     C                   time                    CLTRTIM
102800110414     C                   MOVEl     luser         CLTRUSER
102900110414     C                   MOVEl     trcode        CLTRCOD
103000110414     c     trcode        chain     codesl1
103100110414     c                   if        %found(codesl1)
103200110414     C                   MOVEl     ldescr        CLTRDES
103300110414     c                   end
103400110414     C                   MOVEl     ck#not        CLNOTE1
103500110414     C                   clear                   CLNOTE2
103600110414     C                   MOVE      mbssno        CLMSSN
103700110414     C                   MOVEl     mlname        CLMLNAME
103800110414     C                   MOVEl     mfname        CLMFNAME
103900110414     C                   MOVE      mmi           CLMMI
104000110414     C                   MOVEl     addr1         CLMADR1
104100110414     C                   MOVEl     addr2         CLMADR2
104200110414     C                   MOVEl     city          CLMCITY
104300110414     C                   MOVEl     state         CLMST
104400110414     C                   MOVE      zip           CLMZIP
104500110414
104600110414     C                   MOVE      MBTRST        CLTRUST
104700110414     C                   MOVE      MBSUB#        CLSUB
104800110414     C                   MOVE      MBACCT        CLACCT
104900120720     C                   MOVEl     acnam1        CLACNAM1
105000110414     C                   movel     acnam2        CLACNAM2
105100120724     C                   MOVEl     aaname        CLAANAME
105200120724     C                   MOVEl     contac        CLACONTAC
105300120724     C                   MOVEl     aaddr1        CLAADR1
105400120724     C                   MOVEl     aaddr2        CLAADR2
105500120724     C                   MOVEl     acity         CLACITY
105600120724     C                   MOVEl     astate        CLASTATE
105700120724     C                   MOVEl     azip          CLAZIP
105800120724     C                   MOVEl     aarea         CLAPHONE
105900120724     C                   MOVE      aphone        CLAPHONE
106000120724
106100110418     C                   MOVEl     fcstfl        CLFCSTFL
106200110418     C                   MOVEl     acobsrv       CLCOBSRV
106300110414     C                   MOVE      symd          CLTRMDT
106400110414     C                   clear                   CLEENDT
106500110414
106600110414      * letter 10 - Depend ineligible
106700110414     c                   if        trcode = 'U10'
106800110414     C                   move      hdseq#        CLDSEQ
106900110414     C                   move      depss#        CLDSSN
107000110415      * same last name as member
107100110415     c                   if        %subst(dlname:1:5) = 'SAME '
107200110415     C                   movel     mlname        CLDLNAME
107300110415     c                   else
107400110415     C                   movel     DLNAME        CLDLNAME
107500110415     c                   end
107600110414     C                   movel     DFNAME        CLDFNAME
107700110414     C                   movel     DMI           CLDMI
107800110415
107900110415      * same address as member
108000110415     c                   if        %subst(daddr1:1:5) = 'SAME '
108100110415     C                   movel     addr1         CLDADR1
108200110415     C                   movel     addr2         CLDADR2
108300110415     C                   movel     city          CLDCITY
108400110415     C                   movel     state         CLDST
108500110415     C                   move      zip           CLDZIP
108600110415     c                   else
108700110414     C                   movel     DADDR1        CLDADR1
108800110414     C                   movel     DADDR2        CLDADR2
108900110414     C                   movel     DCITY         CLDCITY
109000110414     C                   movel     DSTATE        CLDST
109100110414     C                   move      DZIP          CLDZIP
109200110415     c                   end
109300110414      * set ineligible reason(s)
109400110414      * ** MAKE SURE THESE ALWAYS MATCH WHAT IS PRINTED ON THE LETTER.
109500110414      * ** IF THERE ARE ANY CHANGES THEN THESE MUST BE CHANGED ALSO!!
109600110415      * 4/15/11 - ineligible reason 4 is not used at this time but has been
109700110415      *           included for potential PA reason.
109800110414     c                   if        slet10a <> *blank
109900110414     C                   movel     INEL10a       CLINEL1
110000110414     c                   end
110100110414
110200110414     c                   if        slet10b <> *blank
110300110414     c                   select
110400110414     c                   when      clinel1 = *blanks
110500110414     C                   movel     INEL10b       CLINEL1
110600110414     c                   other
110700110414     C                   movel     INEL10b       CLINEL2
110800110414     c                   endsl
110900110414     c                   end
111000110414
111100110414     c                   if        slet10c <> *blank
111200110414     c                   select
111300110414     c                   when      clinel1 = *blanks
111400110414     C                   movel     INEL10c       CLINEL1
111500110414     c                   when      clinel2 = *blanks
111600110414     C                   movel     INEL10c       CLINEL2
111700110414     c                   other
111800110414     C                   movel     INEL10c       CLINEL3
111900110414     c                   endsl
112000110414     c                   end
112100110414     c                   end
112200110414
112300110414      * letter 11 - Subscriber ineligible
112400110414     c                   if        trcode = 'U11'
112500110414     c
112600110414     c                   if        slet11a <> *blank
112700110414     C                   movel     INEL11a       CLINEL1
112800110414     c                   end
112900110414
113000110414     c                   if        slet11b <> *blank
113100110414     c                   select
113200110414     c                   when      clinel1 = *blanks
113300110414     C                   movel     INEL11b       CLINEL1
113400110414     c                   other
113500110414     C                   movel     INEL11b       CLINEL2
113600110414     c                   endsl
113700110414     c                   end
113800110414     c                   end
113900110414
114000110414     C                   write     clethstr
1141001104140120 C                   ENDSR
114200210614
1143002106140103  ***************************************************
1144002106140104  * get cobra subsidy dates                         *
1145002106140105  ***************************************************
1146002106140107
114700210614     C     #getsubsidy   BEGSR
114800210614     c                   move      99999999      allnines
114900210614     c                   clear                   slet18a
115000210614     c                   clear                   slet18b
115100210614
115200210614     C     subsidkey     setll     submem
115300210614     c                   dou       %eof(submem)
115400210614     c     mbssno        readpe    submem
115500210614     c                   if        not %eof(submem)
115600210614     C                   MOVE      smfrdt        @DATIN
115700210614     C                   EXSR      #DATMY
115800210614     C                   MOVE      @datou        wkfrdt            8 0
115900210614
116000210614     C                   MOVE      smtodt        @DATIN
116100210614     C                   EXSR      #DATMY
116200210614     C                   MOVE      @datou        wktodt            8 0
116300210614
116400210614       slet18a = %trim(%editw(wkfrdt:'0  /  /    '));
116500210614       slet18b = %trim(%editw(wktodt:'0  /  /    '));
116600210614     c                   leave
116700210614     c                   end
116800210614     c                   enddo
116900210614
1170002106140120 C                   ENDSR
117100210614
117200110414
1173009908190103 C*****************************************************************
117400981112     C     *INZSR        BEGSR
117500990817     C                   MOVE      *DATE         @DATIN
117600990817     C                   EXSR      #DATMY
117700990817     C                   MOVE      @DATOU        UD8YMD            8 0
117800990825     C*
117900990825     C* add 14 days to todays date for letter 7
118000990825     C*
118100990825     C                   MOVE      *DATE         dat2wkdt
118200990825     c                   adddur    14:*d         dat2wkdt
118300990825     C                   MOVE      dat2wkdt      dat2wk
118400990908     C*
118500990908     C* add 45 days to todays date for letter 8
118600990908     C*
118700990908     C                   MOVE      *DATE         dat2wkdt
118800990908     c                   adddur    45:*d         dat2wkdt
118900990908     C                   MOVE      dat2wkdt      dat45dy
119000030305     C*
119100030305     C* add 30 days to todays date for letter 17
119200030305     C*
119300030305     C                   MOVE      *DATE         dat2wkdt
119400030305     c                   adddur    30:*d         dat2wkdt
119500030305     C                   MOVE      dat2wkdt      dat30dy
119600030305     C                   MOVE      dat2wkdt      dat30dy2
119700990817     C*
1198009908160323 C* FIRST DATE LINE - UDATE
1199009908160328 C*
1200009908160329 C                   MOVE      *BLANKS       DL               19
1201009908160331 C                   MOVE      *MONTH        M                 2 0
1202009908160331 C                   MOVE      *DAY          D                 2
1203009908160331 C                   MOVE      *YEAR         Y                 4
1204009908160332 C                   MOVEL     YR(M)         DL
120500990816     C                   CAT       D:1           DL
120600990816     C                   CAT       ',':0         DL
120700990816     C                   CAT       Y:1           DL
120800000413     C*
120900990812     C     ACCKEY        KLIST
121000990817     C                   KFLD                    MBTRST
121100990817     C                   KFLD                    MBSUB#
121200990817     C                   KFLD                    MBACCT
121300990916     C     depkey        KLIST
121400990916     C                   KFLD                    sssn
121500990916     C                   KFLD                    slet10d
121600080402    ?C     AltKey        Klist
121700080402    ?C                   Kfld                    MBSSNO
121800080402    ?C                   Kfld                    AltType           4
121900210614    ?C     subsidkey     Klist
122000210614    ?C                   Kfld                    MBSSNO
122100210614    ?C                   Kfld                    allnines          8 0
122200981112     C                   ENDSR
122300990816**
122400990816January
122500990816February
122600990816March
122700990816April
122800990816May
122900990816June
123000990816July
123100990816August
123200990816September
123300990816October
123400990816November
123500990816December
123600990823**
12370099082331
12380099082328
12390099082331
12400099082330
12410099082331
12420099082330
12430099082331
12440099082331
12450099082330
12460099082331
12470099082330
12480099082331
