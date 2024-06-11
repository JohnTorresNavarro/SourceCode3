000100230124          Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200230124                           DftActGrp(*no)
000300230208                           bnddir('GBSBDIR':'GBSBIND')   ;
000400230124
000500190904      //-------------------------------------------------------------------------
000600190904       //
000700230124       //  Description: GBSEFORM Letters - PDF Version
000800230124       //  Programmer.: Jon Allen
000900230124       //  Date.......: 01/24/2023
001000190906       //
001100230124       //  This program reads from a Message File ( PRTOLEMSG ) to receive
001200190906       //  the body of the mesage.
001300190906       //
001400190906       //  We are using an API to retrieve the message from the message file.
001500190906       //   Routine: GetMessage.
001600190906       //
001700230208       //   **** PRODUCTION ****
001800230208       //
001900230901       //   TEXX - Uncomment when going live - Update Printed
002000230208       //
002100230901       //   TEXX - Uncomment when going live - SBM Discrepancy Report
002200230206       //
002300230208       //   TEMP - Undo RPGSPBETA from WEBBOX5OE
002400230206       //
002500230821       //   08.21.2023 - Jallen - Force in_tool = 'Y' when called from the
002600230821       //                J001     transaction history tool.
002700230901       //
002800230901       //   09.01.2023 - Jallen - Turn on web discrepance report call
002900230901       //                J002
003000231007       //
003100231007       //   10.07.2023 - Jallen - Blank create date, time, user
003200231007       //                J003     will be updated during batch print:
003300231007       //                         PRTOLEFRM2.
003400231016       //   10.16.2023 - Jallen - Check for duplicates
003500231016       //                F001
003600231018       //   10.18.2023 - Jallen - If no form gen yet from Tran Hist
003700231018       //                F002     then load color/dattime for form build.
003800240131       //   01.31.2024 - Jallen - Fix plan overlow logic.
003900240131       //                F003     Prevent duplicate plans
004000240206       //   02.06.2024 - Jallen - Correct TRM EMP notes - F004
004100230206       //
004200190904      //-------------------------------------------------------------------------
004300190904
004400190904      //-------------------------------------------------------------------------
004500190904       //
004600190904       // Declare Files
004700190904       //
004800190904      //-------------------------------------------------------------------------
004900190904
005000230124       dcl-f PRTOLEFRMp usage( *output );
005100190904
005200230124       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
005300230124
005400231010       Dcl-f webtranl4  keyed usropn;
005500231018       Dcl-f webtranl6  keyed prefix(OO_) rename(webtranR:webOO)
005600231018         usage( *input ) ;
005700231016       Dcl-f webtranl91 keyed usropn prefix(In_) rename(webtranR:webtranB);
005800230407
005900230407       dcl-f OEFORMP   keyed
006000230407         usage( *input : *output ) ;
006100230407
006200230407       dcl-f OEFORMGENP keyed
006300230407         usage( *input : *output ) ;
006400230407
006500230407       dcl-f OEFORMOTHP keyed
006600230407         usage( *input : *output ) ;
006700230407
006800230407       dcl-f OEFORMPLNP keyed
006900230407         usage( *input : *output ) ;
007000230407
007100230407       dcl-f OEFORMBENP keyed
007200230407         usage( *input : *output ) ;
007300230407
007400230407       dcl-f OEFORMNOTP keyed
007500230407         usage( *input : *output ) ;
007600230419
007700230419       dcl-f OEFORMWAVP keyed
007800230419         usage( *input : *output ) ;
007900230419
008000230419       dcl-f OEFORMCFSP keyed
008100230419         usage( *input : *output ) ;
008200230419
008300230419       dcl-f OEFORMGARP keyed
008400230419         usage( *input : *output ) ;
008500230502
008600230502       dcl-f OEFORMADBP keyed
008700230502         usage( *input : *output ) ;
008800230511
008900230511       dcl-f OEFORMADCP keyed
009000230511         usage( *input : *output ) ;
009100230502
009200230502       dcl-f OEFORMADDP keyed
009300230502         usage( *input : *output ) ;
009400230502
009500230502       dcl-f OEFORMADPP keyed
009600230502         usage( *input : *output ) ;
009700230125
009800230125     Fcodesl1   if   e           k Disk    extfile('F.CODESL1')
009900230125     Fgbscls    if   e           k Disk
010000230125     FWebPayrollIF   E           K DISK
010100230125     FWEBPAYCHP IF   E           K DISK
010200230125     FWEBVIEWD  O  A E           K DISK
010300230228ja01 FSESSNVARL2IF   E           K DISK    USROPN
010400230228ja01 FSESSNVARP IF   E           K DISK    USROPN  RENAME(SESSNVARR:SESSR)
010500230407
010600230407
010700190905
010800230124       /include *LIBL/QMODSRC,#PROTO
010900230208      /Include *LIBL/QMODSRC,#aacolorPr            // Get AA Color
011000190904
011100230124       dcl-ds WEBMBR ExtName('WEBMEMBER') End-DS;
011200230125
011300240131F003 D Titles          s            100a   dim(14) inz
011400240131F003 D tt              s              2s 0 inz
011500240131F003 D tx              s              2s 0 inz
011600230203     D skip_cont       s              1a   inz
011700230125     D b#              s              3s 0 inz
011800230125     D d#              s              3s 0 inz
011900230125     D c#              s              3s 0 inz
012000230125     D e#              s              3s 0 inz
012100230125     D e##             s              3s 0 inz
012200230125     D g#              s              3s 0 inz
012300230125     D n#              s              7s 0 inz
012400230407     D nn#             s              7s 0 inz
012500230407     D no#             s              7s 0 inz
012600230125     D a#              s              3s 0 inz
012700230125     D p#              s              3s 0 inz
012800230125     D t#              s              3s 0 inz
012900230125     D p#cnt           s              3s 0 inz
013000230125     D do#             s              3s 0 inz
013100230125     D bo#             s              3s 0 inz
013200230125     D po#             s              3s 0 inz
013300230125     D co#             s              3s 0 inz
013400230125     D cb#             s              3s 0 inz
013500230125     D zz#             s              3s 0 inz
013600230127     D x               s              3s 0 inz
013700230202     D A_Count         s              3s 0 inz
013800230203     D C_Count         s              3s 0 inz
013900230203     D G_Count         s              3s 0 inz
014000230130     D N_Count         s              3s 0 inz
014100230203     D P_Count         s              3s 0 inz
014200230127     D RunTime         s              6s 0 inz
014300230125     D newhire         s              1s 0 inz
014400230125     D CurrentDep      s              1s 0 inz
014500230125     D contflg         s              1a   inz
014600230125     D In_DATAPRISE    s              1a   inz
014700230125     D In_TOOL         s              1a   inz
014800230125     D In_WebLevel     s              1a   inz
014900230125     D PathVar         s           1000a   inz
015000230125     D WebPages        s           1000a   inz
015100230125     D  Include        s           1000a   inz
015200230125     D WhereamI        s           1000a   inz
015300230125     D pv              s              3s 0 inz
015400230125     D LinesPrinted    s              5s 0 inz
015500230125     D page#           s              3s 0 inz
015600230126     D WXDESC          s            500a   inz
015700230125     D rtvaft          s            100a   inz
015800230125     D multssid        s              1a   inz
015900230125     D multid          s              3s 0 inz
016000230125     D login           s             40a   inz
016100230125     D color           s              7a   inz
016200230125     D cotext          s             20a   inz
016300230125     D wwdiv           s             20a   inz
016400230125     D dep_heading     s              1s 0 inz
016500230125     D wfdesc          s             50a   inz
016600230125     D wpdesc          s             50a   inz
016700230125     D PayInfo         s              1a   inz
016800230125     D svbeforeD       s             20a   inz
016900230125     D svafterD        s             20a   inz
017000230125     D svbefore        s             20a   inz
017100230512     D svafter         s             20a   inz
017200230512     D svgroupvar      s             20a   inz
017300230125     D savamount       s             10s 2 inz
017400230125     D S_Annual        s             10s 2 inz
017500230125     D S_Bonus         s             10s 2 inz
017600230125     D  paychoice      s              1a   inz('Y')
017700230125     D  LuminX         s              1a   inz
017800230125     D  RunDesc        s             50a   inz
017900230125     D  payphone       s              7a   inz
018000230125     D FSAAMT          s             10s 0 inz
018100230125     D FSA_AMT         s             10s 2 inz
018200230125     D FSAANL          s             10s 0 inz
018300230125     D FSA_ANL         s             10s 2 inz
018400230125     D PayFreq         s              2s 0 inz
018500230125     D BenTot          s              3s 0 inz
018600230125     D Benwrk          s              3s 0 inz
018700230125     D dclrsn          s             20a   inz
018800230125     D grptxt1         s             20a   inz
018900230125     D grptxt2         s             20a   inz
019000230125     D grptxt3         s             20a   inz
019100230125     D grptxt4         s             20a   inz
019200230125     D grptxt5         s             20a   inz
019300230125     D grptxt6         s             20a   inz
019400230125     D grptxt7         s             20a   inz
019500230125     D grptxt8         s             20a   inz
019600230125     D grptxt9         s             20a   inz
019700230125     D grptxt0         s             20a   inz
019800230125     D hrswrk          s              5s 2 inz
019900230125     D occupation      s             30a   inz
020000230125     D docname         s             50a   inz
020100230125     D OverFlow        s              1a   inz(' ')
020200230125     D OverDepi        s              1a   inz(' ')
020300230125     D OverBEN         s              1a   inz(' ')
020400230125     D OverPlan        s              1a   inz(' ')
020500230125     D OverCOB         s              1a   inz(' ')
020600230511     D OverAddr        s              1a   inz(' ')
020700230125     D Save_OESSNO     s              9s 0 inz
020800230125     D Save_OEDSEQ     s              2s 0 dim(20) inz
020900230512     D Save_Plan       s             40a   inz
021000230125     D Save_Name       s             40a   inz
021100230125     D SavePCP         s              3a   inz
021200230125     D CarDis          s              3a   dim(20) inz
021300230125     D cd#             s              2s 0 inz
021400230125     D cr#             s              2s 0 inz
021500230125     D hdr             s              1s 0 inz
021600230125     D ifs             s              1a   inz
021700230125     D header          s           1000a   inz
021800230125     D Child           s             12a   dim(5) inz
021900230526     D Lplan           s             50a   dim(9) inz
022000230125     D L#              s              3s 0 inz
022100230125     D Pssid           s             16a   dim(25) inz
022200230125     D v#              s              3s 0 inz
022300230125     D S#              s              3s 0 inz
022400230125     D ps#             s              3s 0 inz
022500230125     D DupNot          s              3s 0 inz
022600230125     D windate         s             10    inz
022700230125     D w80date         s              8s 0 inz
022800230125     D bentrmdt        s              8s 0 inz
022900230208     D  CurDate        s              8s 0 inz
023000230208     D  CurTime        s              6s 0 inz
023100230125     D wToday          s              8s 0 inz
023200230125     D wiso            s               d   datfmt(*iso)
023300230125     D wempdt          s               d   datfmt(*usa)
023400230125     D salchgdt        s               d   datfmt(*usa)
023500230125     D wsaleff         s               d   datfmt(*usa)
023600230125     D wbirth          s               d   datfmt(*usa)
023700230125     D wmardt          s               d   datfmt(*usa)
023800230125     D weffdt          s               d   datfmt(*usa)
023900230125     D wtrmdt          s               d   datfmt(*usa)
024000230125     D wtrmdtb         s               d   datfmt(*usa)
024100230125     D med#usa         s               d   datfmt(*usa)
024200230125     D den#usa         s               d   datfmt(*usa)
024300230125     D vis#usa         s               d   datfmt(*usa)
024400230125     D lif#usa         s               d   datfmt(*usa)
024500230125     D ltd#usa         s               d   datfmt(*usa)
024600230517     D zdate           s               d   datfmt(*usa)
024700230125     D pdate           s               d   datfmt(*usa)
024800230125     D sdate           s               d   datfmt(*usa)
024900230125     D flipdt          s               d   datfmt(*usa)
025000230125     D wtrntyp         s            100a   inz
025100230125     D pcpnbr          s             20    inz
025200230125     D pcpnbrDen       s             20    inz
025300230125     D pcpnbrMed       s             20    inz
025400230125     D pcpnam          s             30    inz
025500230125     D pcpnamDen       s             30    inz
025600230125     D pcpnamMed       s             30    inz
025700230125     D employer        s             30    inz
025800230125     D pcpext          s              1    inz
025900230125     D pcpextDen       s              1    inz
026000230125     D pcpextMed       s              1    inz
026100230125     D pcpspc          s             10    inz
026200230125     D pcpspcDen       s             10    inz
026300230125     D pcpspcMed       s             10    inz
026400230125     D pcpeffDat       s               d   datfmt(*usa)
026500230125     D pcpeffDen       s               d   datfmt(*usa)
026600230125     D pcpeffMed       s               d   datfmt(*usa)
026700230125     D Reason          s             50    inz
026800230125     D AdrChg          s             20    inz
026900230125     D DateText        s             20    inz
027000230125     D TermText        s             20    inz
027100230125     D wssno           s             11    inz
027200230125     D waiver          s              1    inz
027300230125     D plnseq          s             30    inz
027400230125     D wnbr            s             20    inz
027500230125     D NoPrint         s              1    inz
027600230125     D cossid          s             16    inz
027700230125     D AQname          s             35    inz
027800230125     D wmarsts         s             30a   inz
027900230125     D wwben           s             10s 0 inz
028000230125     D wwben9          s              9s 0 inz
028100230125     D wwben8          s              8s 0 inz
028200230125     D len             s              3s 0 inz
028300230125     D extax           s              1a   inz
028400230125     D spsflg          s              1a   inz
028500230125br02 d PriorHist       s              1a   inz
028600230125     D Note            s          50000    inz
028700230125     D NoteA           s            500a   dim(500) inz
028800230125     D NoteB           s            500a   dim(500) inz
028900230125     D PrtTxt          s            100    inz
029000230125     D SgnTxt          s            100    inz
029100230125     D DepAdrChg       s              2s 0 dim(20) inz
029200230125     d cmd             S            200A
029300230125     d length          S             15P 5
029400230125     d #len            S              3P 0
029500230125     d F_COD1          c                   'OVRDBF FILE(CODESL1) '
029600230125     d F_COD2          c                   'TOFILE(F.CODESL1)'
029700230125     D F_ACCMST        s             50    inz
029800230125     D F_ACC1          c                   'OVRDBF FILE(ACCMST) '
029900230125     D F_ACC2          c                   'TOFILE(F.ACCMST)'
030000230125     d                 ds
030100230125     d  out_print              1     14s 0
030200230125     d  out_prtd               1      8s 0 inz
030300230125     d  out_prtt               9     14s 0 inz
030400230125     D                 ds
030500230125     D webview                 1   1600    inz
030600230125     D webgcu                  1   1600    dim(100)
030700230125     D memberno        ds
030800230125     D mem9                    1      9s 0 inz
030900230125     D mem1                    1      3
031000230125     D mem2                    4      5
031100230125     D mem3                    6      9
031200230125     D  OutRange       ds
031300230125     D  OutFrom                1      9s 0 inz
031400230125     D  OutTo                 10     18s 0 inz
031500230125     d  Qbefore        ds
031600230125     d qblast                  1     18a   inz
031700230125     d qbfirst                19     30a   inz
031800230125     d qbmidl                 31     31a   inz
031900230125     d qbadr1                 32     61a   inz
032000230125     d qbadr2                 62     91a   inz
032100230125     d qbzipp                 92    100s 0 inz
032200230125     d  Qafter         ds
032300230125     d qacty                   1     15a   inz
032400230125     d qastat                 16     17a   inz
032500230125     d qarelc                 18     20a   inz
032600230125     d qadob                  21     28s 0 inz
032700230125     d qass#                  29     37s 0 inz
032800230125     d qaseq                  38     39s 0 inz
032900230125     d  WebBen       e ds           530    extname(webbenefit)
033000230125     d  bennam                 1    300a   dim(10) inz
033100230125     d  benrel               301    330a   dim(10) inz
033200230125     d  benper               331    360a   dim(10) inz
033300230125     d  beneff               361    460d   dim(10) inz datfmt(*usa)
033400230125     d  benpln               461    500a   dim(10) inz
033500230125     D  bencat               501    530a   dim(10) inz
033600230125     d  MemCovg      e ds          2000    extname(webmcov)
033700230125     d  plaq                   1    100a   dim(25) inz
033800230125     d  pcaq                 101    175a   dim(25) inz
033900230125     d  desq                 176   1175a   dim(25) inz
034000230125     d  effq                1176   1425d   dim(25) inz datfmt(*usa)
034100230125     d  ctyq                1426   1500    dim(25) inz
034200230125     d  covq                1501   2000a   dim(25) inz
034300230125     d  DepCovg      e ds          1475    extname(webdcov)
034400230125     d  dpln                   1    100a   dim(25) inz
034500230125     d  dcat                 101    175a   dim(25) inz
034600230125     d  ddsc                 176   1175a   dim(25) inz
034700230125     d  deff                1176   1425d   dim(25) inz datfmt(*usa)
034800230125     d  dcsq                1426   1475s 0 dim(25) inz
034900230125     D webparm       e ds                  extname(webtran) prefix(In_) inz
035000230125     D webacc        e ds                  extname(accmst) prefix(In_) inz
035100230125     D webhdr        e ds                  extname(webmember) inz prefix(H)
035200230125     D webdep        e ds                  extname(webdepend) inz
035300230125     D webtrn        e ds                  extname(webtran) inz
035400230125     D webcod        e ds                  extname(webcode) inz
035500230125     D web2          e ds                  extname(webbox2) inz
035600230125     D web3          e ds                  extname(webbox3) inz
035700230125     D web4          e ds                  extname(webbox4DSH) inz
035800230208TEMP D web5          e ds                  extname('RPGSPBETA/WEBBOX5OE') inz
035900230125     D webpln        e ds                  extname(webplan) inz
036000230125     D webplnds      e ds                  extname(webplands) inz
036100230125     D webcobd       e ds                  extname(webcob) inz
036200230125     D webplog       e ds                  extname(webprtlog) inz
036300230125     D webnote       e ds                  extname(webnotp) inz
036400230125     d  WEBPAY       e ds                  extname(webpayroll) inz
036500230125     d  WEBPAYSAV    e ds                  extname(webpayroll) prefix(s_) inz
036600230125     d  webpayd      e ds                  extname(webpayded)
036700230125     d  WEBCFS       e ds                  extname(cfs100p) inz
036800230125     D weblog        e ds                  extname(weblogp) inz
036900230125     D webadepids    e ds                  extname(webadepn) inz   occurs(21)
037000230125     D webabenids    e ds                  extname(webabeni) inz   occurs(999)
037100230125     D webaplnids    e ds                  extname(webaplni) inz   occurs(99)
037200230125     D webacobids    e ds                  extname(webacobi) inz   occurs(99)
037300230125     D EncryptSSN      s             80a   inz
037400230125br01 d In_OESSID_E     s            200a   inz
037500230125
037600230125     D  SALDTA         ds
037700230125     D  salary$                1      9s 0 inz
037800230125     D  salary@               10     17s 0 inz
037900230125
038000230407     D prtNotes      e ds                  extname(OEFORMNOTP) inz
038100230414     D prtNotes_SSID                       like(NOSSID) overlay(prtNotes:1)
038200230414     D prtNotes_NODA                       like(NODATE) overlay(prtNotes:17)
038300230414     D prtNotes_NONA                       like(NONAME) overlay(prtNotes:117)
038400230414     D prtNotes_NOSSN                      like(NOSSN) overlay(prtNotes:217)
038500230414     D prtNotes_NOTSA                      like(NOTSA) overlay(prtNotes:228)
038600230414     D prtNotes_NOACC                      like(NONAME) overlay(prtNotes:240)
038700230414     D prtNotes_Array                      like(NOTE001) overlay(prtNotes:340)
038800230418     D                                     dim(80)
038900230124
039000190904      //-------------------------------------------------------------------------
039100190904       //
039200190904       // Global Variables
039300190904       //
039400190904      //-------------------------------------------------------------------------
039500190904
039600190904       Dcl-S RtnMsg varchar(1000);
039700190906       dcl-s wZip char(9);
039800190906       dcl-s GRPNBRS Char(75);
039900190906       dcl-s grp Char(15) dim(8);
040000190906
040100230124       dcl-s Save_OESSID Char(16);
040200190906       dcl-s GroupNo Char(15);
040300230124       dcl-s wName   char(41);
040400230125       dcl-s wwName  char(100);
040500211203       dcl-s wemla   char(60);
040600190906       dcl-s wdial   Zoned(10);
040700190906       dcl-s wPhone  Char(15);
040800190906       dcl-s #phone  Char(10);
040900190906       dcl-s #Acct   Char(12);
041000190906       dcl-s #SMAN   Char(35);
041100230124       dcl-s wgbstsa# char(12);
041200230130       dcl-s wwssn Char(11);
041300230130       dcl-s wwssn2 Char(11);
041400230125       dcl-s wwdial Char(15);
041500230125       dcl-s wLine Char(125);
041600230126       dcl-s count Zoned(3);
041700190904
041800190906       dcl-s wTrst Zoned(3);
041900190906       dcl-s wSub# Zoned(3);
042000190906       dcl-s wAcct Zoned(4);
042100190906
042200221104       dcl-s d_Space Zoned(3:2) inz(.32);
042300190906       dcl-s s_Space Zoned(3:2) inz(.16);
042400190906
042500230124       dcl-s wline01       char(125);
042600230124       dcl-s in_date       char(32);
042700230124       dcl-s in_format     char(32);
042800230124       dcl-s out_format    char(32);
042900230124       dcl-s out_date      char(32);
043000230124       dcl-s out_error     char(10);
043100230124       dcl-s DOB_date      char(32);
043200230124       dcl-s ENR_date      char(32);
043300230125       dcl-s SAL_date      char(32);
043400230125       dcl-s MAR_date      char(32);
043500190906
043600190904      //-------------------------------------------------------------------------
043700190904       //
043800190904       // Procedures
043900190904       //
044000190904      //-------------------------------------------------------------------------
044100190904
044200190904       Dcl-DS APIErrorCode Qualified;
044300190904         BytesProvided Int(10) INZ(%size(APIErrorCode));
044400190904         BytesAvailable Int(10) INZ(0);
044500190904         ExceptionID Char(7);
044600190904         Reserved Char(1);
044700190904         ExceptionData char(32767);
044800190904       END-DS;
044900190904
045000190904
045100190904
045200190904       Dcl-PR QMHRTVM ExtPgm;
045300190904         MsgInfo char(9999999) options(*varsize);
045400190904         MsgInfoLen Int(10) const;
045500190904         FormatName Char(8) const;
045600190904         MsgID char(7) const;
045700190904         MsgFileName char(20) const;
045800190904         ReplData char(10000) options(*varsize) const;
045900190904         ReplDataLen Int(10) const;
046000190904         ReplSubVal Char(10) const;
046100190904         ReplFormatChar Char(10) const;
046200190904         ErrorCode LikeDS(APIErrorCode);
046300190904
046400190904         // Option Group 1
046500190904         RetrieveOption Char(10) options(*nopass);
046600190904         CCSIdentifier Int(10) options(*nopass);
046700190904         CCSReplData Int(10) options(*nopass);
046800190904       END-PR;
046900190904
047000190904
047100190904
047200190904       // Message format data structures
047300190904       Dcl-DS RTVM0100 Qualified INZ;
047400190904         BytRtn Int(10);
047500190904         BytAvl Int(10);
047600190904         RtnMsgLen Int(10);
047700190904         RtnMsgAvl Int(10);
047800190904         RtnHlpLen Int(10);
047900190904         RtnHlpAvl Int(10);
048000190904         Buffer char(32767);
048100190904       END-DS;
048200190904
048300230124     d fmtDate         pr                  extpgm('FMTDATE')
048400230124     d  in_date                      32    const
048500230124     d  in_format                    32    const
048600230124     d  out_format                   32    const
048700230124     d  out_date                     32    const
048800230124     d  out_error                    10    const
048900190904
049000190904      //-------------------------------------------------------------------------
049100190904       //
049200190904       // *Entry Procedure
049300190904       //
049400190904      //-------------------------------------------------------------------------
049500190904       Dcl-pr Main ExtPgm;
049600230130         *N  Char(1);
049700230206         *N  Char(1);
049800230228         *N  Char(3);
049900230228         *N  Char(16);
050000230208         *N  Char(1);
050100230208         *N  Char(15);
050200230208         *N  Char(10);
050300231009         *N  Char(1);
050400190904       End-Pr;
050500190904
050600190904
050700190904       dcl-pi Main;
050800230130         RunOption Char(1);
050900230206         In_Batch Char(1);
051000230228         In_AA    Char(3);
051100230228         In_SSID  Char(16);
051200230208         Out_Form Char(1);
051300230208         Out_DateTime Char(15);
051400230208         Out_Color Char(10);
051500231009         In_Where Char(1);
051600190904       End-Pi;
051700190904
051800190905
051900230124      //-------------------------------------------------------------------------
052000230124       //
052100230124       // Mainline Program
052200230124       //
052300230124      //-------------------------------------------------------------------------
052400230126     C     KEYCODE       Klist
052500230126     C                   Kfld                    PCTRST
052600230126     C                   Kfld                    PCSUB#
052700230126     C                   Kfld                    PCACCT
052800230126     C                   Kfld                    PCGRPR
052900230126     C                   Kfld                    PCCODE
053000230126     C     WebKeySet     Klist
053100230126     C                   Kfld                    In_OETRST
053200230126     C                   Kfld                    In_OESUB#
053300230126     C                   Kfld                    In_OEACCT
053400230126     C                   Kfld                    In_OESSNO
053500230126     C                   Kfld                    In_OESSID
053600230126     C     WebKeyReade   Klist
053700230126     C                   Kfld                    In_OETRST
053800230126     C                   Kfld                    In_OESUB#
053900230126     C                   Kfld                    In_OEACCT
054000230126     C                   Kfld                    In_OESSNO
054100230126     C                   Kfld                    In_OESSID
054200230322
054300230322         // PriorHist = rpgspin('PriorHist':'session');
054400230322          if PriorHist = 'Y';
054500230322            CmdString = 'OvrDbf File(webtranl4) ToFile(RpgspPayr/webtranl4)';
054600230322            #Command( CmdString : %Len(%trim(CmdString)) );
054700230322            CmdString = 'OvrDbf File(webtranl91) ToFile(RpgspPayr/webtranl91)';
054800230322            #Command( CmdString : %Len(%trim(CmdString)) );
054900230322          endif;
055000230322
055100230322     C                   Open      webtranl4
055200230322     C                   Open      webtranl91
055300230322
055400230126         count = 0;
055500230208         out_form = *blanks;
055600230127
055700230130         If In_BATCH = 'Y';
055800230127         print_fake();
055900190904
056000230124         Setll ( *loval ) webtranl91;
056100230124         dou %Eof( webtranl91 ) ;
056200230124           read  webtranl91 ;
056300230124           if not %Eof( webtranl91 );
056400230124
056500230124                   Select;
056600230127
056700230127                   when  %trim(In_AA) <> %trim(IN_oeaacod) and
056800230127                   %trim(In_AA) <> *blanks;
056900230127
057000230124                   When  RunOption = 'D' and In_OETRST <> 005;
057100230124
057200230124                   If    Save_OESSID <> In_OESSID;
057300230124                    GetActNam();
057400230125                    PopMemberForm();
057500230125                    PopTheForm();
057600230126                    PopDependForm();
057700230126                    PopPlanForm();
057800230215                    CarrierDiscl();
057900230215                    ResetTheForm();
058000230124                    Save_OESSID = In_OESSID;
058100230124                   Endif;
058200230124
058300230127                   When  RunOption = 'B';
058400230127
058500230127                   If    Save_OESSID <> In_OESSID;
058600230127                    GetActNam();
058700230127                    PopMemberForm();
058800230127                    PopTheForm();
058900230127                    PopDependForm();
059000230127                    PopPlanForm();
059100230215                    CarrierDiscl();
059200230127                    ResetTheForm();
059300230127                    Save_OESSID = In_OESSID;
059400230127                    count = count + 1;
059500230127                    if count >= 10;
059600230203       // *inlr = *on;
059700230203       // return;
059800230127                   Endif;
059900230127                   Endif;
060000230127
060100230127                   When  RunOption = '5' and In_OETRST = 005;
060200230127
060300230127                   If    Save_OESSID <> In_OESSID;
060400230127                    GetActNam();
060500230127                    PopMemberForm();
060600230127                    PopTheForm();
060700230127                    PopDependForm();
060800230127                    PopPlanForm();
060900230215                    CarrierDiscl();
061000230127                    ResetTheForm();
061100230127                    Save_OESSID = In_OESSID;
061200230127                    count = count + 1;
061300230127                   Endif;
061400230127
061500230124                   Endsl;
061600230124
061700230124           Read   webtranl91;
061800230124           Endif;
061900230124         Enddo;
062000230130
062100230130         Else;
062200230130         //  Print The Form
062300230130                    PrintTheForm();
062400230130         Endif;
062500230208
062600230208      * Auto-Submit OE Discrepancy Report
062700230901J002 C                   If        In_BATCH = 'Y'
062800230208     C                   Call      'WEBGBSSBM'
062900230208     C                   Parm                    In_BATCH
063000230208     C                   Parm                    RunOption
063100230208     C                   Parm                    IN_AA
063200230208     C                   End
063300231018
063400231018F002 C                   If        In_BATCH <> 'Y'
063500231018F002 C                   if        %trim(In_SSID) <> *blanks
063600231018               In_OETRST = %dec(%subst(In_SSID:1:3):3:0);
063700231018               In_OESUB# = %dec(%subst(In_SSID:4:3):3:0);
063800231018               In_OEACCT = %dec(%subst(In_SSID:7:4):4:0);
063900231018           out_Color = #aacolor(in_oetrst:in_oesub#:In_oeacct);
064000231018              chain(n) (In_SSID) webtranl6;
064100231018              if %found(WEBTRANL6);
064200231023              if OO_OEPRTD > 0;
064300231018              out_DateTime = %char(OO_OEPRTD) + '_' + %char(OO_OEPRTT);
064400231023              else;
064500231023              CurDate = %int(%char(%date : *iso0));
064600231023              CurTime = %Dec(%Time);
064700231023              out_DateTime = %char(CurDate) + '_' + %char(CurTime);
064800231023              endif;
064900231018              endif;
065000231018F002 C                   end
065100231018F002 C                   end
065200230208
065300230322     C                   Close     webtranl4
065400230322     C                   Close     webtranl91
065500230322
065600230322br02       // PriorHist = rpgspin('PriorHist':'session');
065700230322           if PriorHist = 'Y';
065800230322              CmdString = 'DltOvr File(webtranl4)';
065900230322              #Command( CmdString : %Len(%trim(CmdString)) );
066000230322              CmdString = 'DltOvr File(webtranl91)';
066100230322              #Command( CmdString : %Len(%trim(CmdString)) );
066200230322           endif;
066300230322
066400230124       *inlr = *on;
066500230124
066600230124       // ----------------------------------------------------------------
066700230124       dcl-proc GetActNam;
066800230407
066900230407              clear  OE_FORMR;
067000230407              clear  OE_GENR;
067100230407              clear  OE_OTHER;
067200230407              clear  OE_PLANR;
067300230407              clear  OE_BENER;
067400230407              clear  OE_NOTER;
067500230419              clear  OE_WAVR;
067600230419              clear  OE_CFSR;
067700230502              clear  OE_GARR;
067800230502              clear  OE_ADBR;
067900230502              clear  OE_ADDR;
068000230511              clear  OE_ADPR;
068100230511              clear  OE_ADCR;
068200230407
068300230407              FOSSID = IN_OESSID;
068400230407              GOSSID = IN_OESSID;
068500230414              OOSSID = IN_OESSID;
068600230414              NOSSID = IN_OESSID;
068700230407              POSSID = IN_OESSID;
068800230502              BOSSID = IN_OESSID;
068900231007              // J003 FOCRTBY = 'PRTOLEFRMR';
069000231007              // J003 FOCRTDT = %int(%char(%date : *iso0));
069100231007              // J003 FOCRTTM = %Dec(%Time);
069200231018     C     IN_OESSID     chain(n)  webtranl6
069300231018              if %found(WEBTRANL6);
069400231018              if OO_OEPRTD = 0;
069500231010                 FOCRTBY = *blanks;
069600231010                 FOCRTDT = *zeros;
069700231010                 FOCRTTM = *zeros;
069800231010              else;
069900231010                 FOCRTBY = In_Where;
070000231010                 FOCRTDT = *zeros;
070100231010                 FOCRTTM = *zeros;
070200231018              endif;
070300231018              in_oessno = OO_OESSNO;
070400231018              in_oetrst = OO_OETRST;
070500231018              in_oesub# = OO_OESUB#;
070600231018              in_oeacct = OO_OEACCT;
070700231018              in_oeSIGD = OO_OESIGD;
070800231018              in_oeSIGT = OO_OESIGT;
070900231010              endif;
071000230407
071100230223     C                   Eval      waiver = ' '
071200230223
071300230203       g_count = 0;
071400230124       chain ( in_oetrst : in_oeSub# : in_oeAcct ) AccMst;
071500230407
071600230124       // AA Information
071700230124       Exec Sql
071800230124          Select Trim(afnam) || ' ' || alnam, Lower(aemla), addial
071900230124             Into :wname, :wemla, :wdial
072000230124             From aacode
072100230124             Where acode = :aacode;
072200230125
072300230125          if wemla = *blanks;
072400230303             wemla = #getaeml(IN_OETRST:IN_OESUB#:IN_OEACCT);
072500230125          endif;
072600230208
072700230208          if out_DateTime = *blanks;
072800230208           CurDate = %int(%char(%date : *iso0));
072900230208           CurTime = %Dec(%Time);
073000230208           out_DateTime = %char(CurDate) + '_' + %char(CurTime);
073100230208           out_Color = #aacolor(in_oetrst:in_oesub#:In_oeacct);
073200230208          endif;
073300230125
073400230922           len = %len(%trim(%char(wdial)));
073500230922           if len = 10;
073600230125           area = %dec(%subst(%char(wdial):1:3):3:0);
073700230125           phone = %dec(%subst(%char(wdial):4:7):7:0);
073800230125           wwdial = #fmtphn(AREA:PHONE);
073900230922           else;
074000230922           wwdial = *blanks;
074100230922           endif;
074200230922
074300230125       //  wwdial = %editc(wdial : 'X') ;
074400230125       //  wwdial = %subst(wwdial:1:3) +
074500230125       //           '/' +
074600230125       //           %subst(wwdial:4:3) +
074700230125       //           '-' +
074800230125       //           %subst(wwdial:7:4);
074900230124
075000230124           WGBSTSA# = #fmttsa(IN_OETRST:IN_OESUB#:IN_OEACCT);
075100230124
075200230124           wwssn = %editc(IN_OESSNO : 'X') ;
075300230124           wwssn  = %subst(wwssn:1:3) +
075400230124                    '-' +
075500230125                    %subst(wwssn:4:2) +
075600230124                    '-' +
075700230125                    %subst(wwssn:6:4);
075800230407
075900230407           FOACCNM  = %trim(ACNAM1);
076000230407           FOACCNBR = %trim(WGBSTSA#);
076100230321
076200230321           Clear  WEBMBR;
076300230321           WEBMBR = #webdem(IN_OETRST:IN_OESUB#:IN_OEACCT:IN_OESSNO:0:'C');
076400230321           wwname = #fmtnam(MFNAME:MLNAME:MMI);
076500230407
076600230407           FOLNAME = %trim(MLNAME);
076700230407           FOFNAME = %trim(MFNAME);
076800230407           FOMMI   = %trim(MMI);
076900230407
077000230321           webcfs = #cchain(IN_oessno:IN_oedseq);
077100230321           len = %len(%trimr(CFSLST));
077200230321           If  %trim(cfslst) <> *blanks and len > 18;
077300230321               n# = n# + 1;
077400230321               NoteA(n#) = 'Longer Last Name: ' + %trim(CFSLST);
077500230321               wwname = #fmtnam(CFSFST:CFSLST:CFSMID);
077600230407
077700230407           FOLNAME = %trim(CFSLST);
077800230407           FOFNAME = %trim(CFSFST);
077900230407           FOMMI   = %trim(CFSMID);
078000230407
078100230321           Endif;
078200230321           len = %len(%trimr(CFSFST));
078300230321           If    %trim(cfsfst) <> *blanks and len > 12;
078400230321               n# = n# + 1;
078500230321               NoteA(n#) = 'Longer First Name: ' + %trim(CFSFST);
078600230321               wwname = #fmtnam(CFSFST:CFSLST:CFSMID);
078700230407
078800230407           FOLNAME = %trim(CFSLST);
078900230407           FOFNAME = %trim(CFSFST);
079000230407           FOMMI   = %trim(CFSMID);
079100230407
079200230321           Endif;
079300230124
079400230124
079500230124       write HEADER1;
079600230124
079700230210       // write HEADER2;
079800230125
079900230210       // write HEADER3;
080000230124
080100230125       POS_X = 1.95;
080200230125
080300230125       Exec Sql
080400230125          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
080500230125             || Year(Current_Date)
080600230125             Into :wline
080700230125             From sysibm.sysdummy1 ;
080800230125
080900230125       COX001 = 'Date: ' + %trim(wline);
081000230125       COX002 = 'Session Id: ' + %trim(in_OESSID);
081100230125       COX003 = 'Transaction Type: Online Enrollment';
081200230125       write Data3;
081300230208       out_form = 'Y';
081400230130
081500230210           CurDate = %int(%char(%date : *iso0));
081600230210           CurTime = %Dec(%Time);
081700231016
081800231018             If        In_BATCH <> 'Y';
081900231018             if        %trim(In_OESSID) <> *blanks;
082000231018          chain(n) (In_OESSID) webtranl6;
082100231018          if %found(webtranl6);
082200231020          if OO_OEPRTD > 0;
082300231018           CurDate = OO_OEPRTD;
082400231018           CurTime = OO_OEPRTT;
082500231020          endif;
082600231016          pdate = #getusa(CurDate);
082700231016          zdate = #getusa(CurDate);
082800231020          if OO_OESIGD > 0;
082900231018          sdate = #getusa(OO_OESIGD);
083000231018          IN_oesigt = OO_OESIGT;
083100231020          endif;
083200231020        in_date = %editc(CurDate: 'X');
083300231020        fmtDate(in_date:'YYYYMMDD':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
083400231016        wline = %trim(out_date);
083500231018          else;
083600231016          pdate = #getusa(CurDate);
083700231016          zdate = #getusa(CurDate);
083800231016          sdate = #getusa(IN_oesigd);
083900231018          endif;
084000231018          else;
084100231018          pdate = #getusa(CurDate);
084200231018          zdate = #getusa(CurDate);
084300231018          sdate = #getusa(IN_oesigd);
084400231018          endif;
084500231018          pdate = #getusa(CurDate);
084600231018          zdate = #getusa(CurDate);
084700231018          sdate = #getusa(IN_oesigd);
084800231018          endif;
084900231023
085000231023          if      %char(pdate) = '01/01/0001';
085100231023          CurDate = %int(%char(%date : *iso0));
085200231023          pdate = #getusa(CurDate);
085300231023          endif;
085400231023
085500231023          if      %char(sdate) = '01/01/0001';
085600231023          CurDate = %int(%char(%date : *iso0));
085700231023          sdate = #getusa(CurDate);
085800231023          endif;
085900231016
086000230210          COX001 = 'Print Date: ' + %char(pdate)  +
086100230210                    '   Time: ' +  %editw(CurTime:'  :  :  ');
086200230321          COX002 = %trim(wwname);
086300230210          COX003 =  'Signed Date: ' + %char(sdate)  +
086400230210                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
086500230210          write Data3;
086600230210
086700230210          COX001 = *blanks;
086800230210          COX002 = *blanks;
086900230210          COX003 = *blanks;
087000230210          write Data3;
087100230210
087200230407          PRTDATTIM = %char(pdate)  +
087300230407                    '   Time: ' +  %editw(CurTime:'  :  :  ');
087400230407          SIGDATTIM =  %char(sdate)  +
087500230407                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
087600230407          CURDATTIM = %trim(wline);
087700230407          AACOLOR = %trim(Out_Color);
087800230407
087900230407
088000230407
088100230407
088200230407
088300230210
088400230306       BOLD01 = 'EMPLOYER INFORMATION';
088500230130       write BOLD;
088600230203       g_count = g_count + 1;
088700230306       write ULINE;
088800230130
088900230130       PLN001 = *blanks;
089000230130       PLN002 = *blanks;
089100230130       write PLANSR;
089200230203       g_count = g_count + 1;
089300230124
089400230124       // Account Name
089500230125       COL001 = %trim(AcNam1);
089600230125       COL002 = 'Account #: ' + WGBSTSA#;
089700230125       write Data2;
089800230203       g_count = g_count + 1;
089900230124
090000230125       COL001 = *blanks;
090100230125       COL002 = *blanks;
090200230125
090300230124       if acNam2 > '';
090400230125       COL001 = %trim(AcNam2);
090500230125       COL002 = %trim(wname);
090600230125       write Data2;
090700230203       g_count = g_count + 1;
090800230124       EndIf;
090900230124
091000230124       // Exec Contact
091100230125       COL001 = %trim( ecntac );
091200230125       if %trim(COL002) = *blanks;
091300230125       COL002 = %trim(wname);
091400230125       else;
091500230125       COL002 = %trim(wemla);
091600230125       wemla = *blanks;
091700230125       endif;
091800230125       write Data2;
091900230203       g_count = g_count + 1;
092000230124
092100230124       // Address
092200230125       COL001 = aaddr1;
092300230125       if %trim(wemla) = *blanks;
092400230125       COL002 = %trim(wwdial);
092500230125       wdial = *zeros;
092600230125       else;
092700230125       COL002 = %trim(wemla);
092800230125       wemla = *blanks;
092900230125       endif;
093000230125       write Data2;
093100230203       g_count = g_count + 1;
093200230124
093300230124       if aaddr2 > '';
093400230125       COL001 = aaddr2;
093500230125       if %char(wdial) <> *zeros;
093600230125       COL002 = %trim(wwdial);
093700230125       wdial = *zeros;
093800230125       else;
093900230125       COL002 = *blanks;
094000230125       endif;
094100230125       write Data2;
094200230203       g_count = g_count + 1;
094300230124       endif;
094400230124
094500230124       wZip = %Editc(aZip: 'X' );
094600230124       Line01 = %Trim( aCity ) + ', '
094700230124         + %Trim( aState ) + ' '
094800230124         + %Subst( wZip : 1 : 5 ) ;
094900230124
095000230124       if %Subst( wZip : 6 : 4) <>'0000' ;
095100230124         Line01 = %Trim( Line01) + '-' + %Subst( wZip : 6 : 4 ) ;
095200230124       EndIf;
095300230125
095400230125       COL001 = %trim(Line01);
095500230125       if %char(wdial) <> *zeros;
095600230125       COL002 = %trim(wwdial);
095700230125       wdial = *zeros;
095800230125       else;
095900230125       COL002 = *blanks;
096000230125       endif;
096100230125       write Data2;
096200230203       g_count = g_count + 1;
096300230124
096400230125       COL001 = *blanks;
096500230125       COL002 = *blanks;
096600230125       write Data2;
096700230203       g_count = g_count + 1;
096800230124
096900230124       End-Proc;
097000230124
097100230124       // ----------------------------------------------------------------
097200230125       dcl-proc PopMemberForm;
097300230227
097400230306       BOLD01 = 'EMPLOYEE INFORMATION';
097500230227       write BOLD;
097600230307       g_count = g_count + 1;
097700230306       write ULINE;
097800230227
097900230227       PLN001 = *blanks;
098000230227       PLN002 = *blanks;
098100230227       write PLANSR;
098200230124
098300230124           Clear  WEBMBR;
098400230124           WEBMBR = #webdem(IN_OETRST:IN_OESUB#:IN_OEACCT:IN_OESSNO:0:'C');
098500230124           wwname = #fmtnam(MFNAME:MLNAME:MMI);
098600230407
098700230407           FOSSN = %trim(wwssn);
098800230407           FOLNAME = %trim(MLNAME);
098900230407           FOFNAME = %trim(MFNAME);
099000230407           FOMMI   = %trim(MMI);
099100230407
099200230125           webcfs = #cchain(IN_oessno:IN_oedseq);
099300230125           len = %len(%trimr(CFSLST));
099400230125           If  %trim(cfslst) <> *blanks and len > 18;
099500230125               n# = n# + 1;
099600230125               NoteA(n#) = 'Longer Last Name: ' + %trim(CFSLST);
099700230125               wwname = #fmtnam(CFSFST:CFSLST:CFSMID);
099800230407
099900230407           FOLNAME = %trim(CFSLST);
100000230407           FOFNAME = %trim(CFSFST);
100100230407           FOMMI   = %trim(CFSMID);
100200230407
100300230125           Endif;
100400230125           len = %len(%trimr(CFSFST));
100500230125           If    %trim(cfsfst) <> *blanks and len > 12;
100600230125               n# = n# + 1;
100700230125               NoteA(n#) = 'Longer First Name: ' + %trim(CFSFST);
100800230125               wwname = #fmtnam(CFSFST:CFSLST:CFSMID);
100900230407
101000230407           FOLNAME = %trim(CFSLST);
101100230407           FOFNAME = %trim(CFSFST);
101200230407           FOMMI   = %trim(CFSMID);
101300230407
101400230125           Endif;
101500230512
101600230512          If  %subst(in_oessid:16:1) = 'M';
101700230512           If  in_oesigf = 'Y';
101800230512               If  %trim(IN_OEGRPV) = 'DECLINED';
101900230512                 FOSIGNEE = 'DECLINED';
102000230512                 FOSIGNDT = %char(sdate);
102100230517                 FOSIGNER = %trim(ACNAM1);
102200230517                 FOSIGNDTER = %char(sdate);
102300230512               Else;
102400230512                 FOSIGNEE = %trim(wwname);
102500230512                 FOSIGNDT = %char(sdate);
102600230517                 FOSIGNER = %trim(ACNAM1);
102700230517                 FOSIGNDTER = %char(sdate);
102800230512               Endif;
102900230517           Else;
103000230517                 FOSIGNEE = 'Preliminary Election Form Pending Electronic ' +
103100230517                            'Signature';
103200230517                 FOSIGNDT = *blanks;
103300230517                 FOSIGNER = %trim(ACNAM1);
103400230517                 FOSIGNDTER = %char(sdate);
103500230512           Endif;
103600230517          Else;
103700230517          FOSIGNEE = *blanks;
103800230517          FOSIGNDT = *blanks;
103900230517          FOSIGNER = *blanks;
104000230517          FOSIGNDTER = *blanks;
104100230512          Endif;
104200230125
104300230125           PayInfo  = *blanks;
104400230517           Clear  WEBPAYSAV;
104500230210           webpay = #pchain(IN_oetrst:IN_oesub#:IN_oeacct:IN_oessno);
104600230210           webpaysav = #pchain(IN_oetrst:IN_oesub#:IN_oeacct:IN_oessno);
104700230223
104800230223     C                   Select
104900230223     C                   When      %trim(PYPFQ) = 'WKY'
105000230223     C                   Eval      PayFreq = 52
105100230223     C                   When      %trim(PYPFQ) = 'W48'
105200230223     C                   Eval      PayFreq = 48
105300230223     C                   When      %trim(PYPFQ) = 'BW1'
105400230223     C                   Eval      PayFreq = 26
105500230223     C                   When      %trim(PYPFQ) = 'SEM'
105600230223     C                   Eval      PayFreq = 24
105700230223     C                   When      %trim(PYPFQ) = 'MTH'
105800230223     C                   Eval      PayFreq = 12
105900230223     C                   When      %trim(PYPFQ) = 'QTR'
106000230223     C                   Eval      PayFreq = 4
106100230223     C                   Endsl
106200230223     C                   If        In_TOOL  <> *blanks
106300230223     C                   eval      salarydt = empdt
106400230223     C                   Else
106500230223     C                   If        pyans = 0
106600230223     C                   If        pyrat <> 0
106700230223     C                   Eval      pyans = (pyrat * pyhrs) * PayFreq
106800230223     C                   Else
106900230223     C                   Eval      pyans = (pysal * PayFreq)
107000230223     C                   End
107100230223     C                   End
107200230223     C                   Eval      salary = pyans
107300230223     C                   Eval      salarydt = pysaldt
107400230223     C                   End
107500230125
107600230421           if phone > 0;
107700230125           WPHONE = #fmtphn(AREA:PHONE);
107800230407           FOPHONE = WPHONE;
107900230421           else;
108000230421           FOPHONE = *blanks;
108100230421           endif;
108200230124
108300230223        if birth = 0 and pybth <> 0;
108400230223        in_date = %editc(pybth: 'X');
108500230223        fmtDate(in_date:'MMDDYYYY':'MM/DD/YYYY':out_date:out_error)         ;
108600230223        DOB_date = %trim(out_date);
108700230223        else;
108800230223        in_date = %editc(Birth: 'X');
108900230124        fmtDate(in_date:'YYYYMMDD':'MM/DD/YYYY':out_date:out_error)         ;
109000230124        DOB_date = %trim(out_date);
109100230223        endif;
109200230407
109300230407        FOBIRTH = DOB_date;
109400230124
109500230223        if EMPDT = 0 and pyhdt <> 0;
109600230223        in_date = %editc(PYHDT: 'X');
109700230223        fmtDate(in_date:'MMDDYYYY':'MM/DD/YYYY':out_date:out_error)         ;
109800230223        ENR_date = %trim(out_date);
109900230223        else;
110000230223        in_date = %editc(EMPDT: 'X');
110100230124        fmtDate(in_date:'YYYYMMDD':'MM/DD/YYYY':out_date:out_error)         ;
110200230124        ENR_date = %trim(out_date);
110300230223        endif;
110400230407
110500230407        FOEMPDT = ENR_date;
110600230407
110700230124
110800230125             saldta = #getsal(IN_OETRST:IN_OESUB#:IN_OEACCT:IN_OESSNO:0);
110900230125             salary = salary$;
111000230125             salarydt = Salary@;
111100230224
111200230224             if  salarydt = 0;
111300230224             wiso   = #getiso(pysaldt);
111400230224             salchgdt = wiso;
111500230224             salarydt = pysaldt;
111600230224             endif;
111700230125
111800230125        in_date = %editc(salarydt: 'X');
111900230125        fmtDate(in_date:'MMDDYYYY':'MM/DD/YYYY':out_date:out_error)         ;
112000230125        SAL_date = %trim(out_date);
112100230407
112200230407        FOSALARY = '$' + %trim(%editc(salary:'J')) ;
112300230407        FOSALEFF = SAL_date;
112400230223
112500230223        if mardt = 0 and pymar <> 0;
112600230223        in_date = %editc(pymar: 'X');
112700230223        fmtDate(in_date:'MMDDYYYY':'MM/DD/YYYY':out_date:out_error)         ;
112800230223        MAR_date = %trim(out_date);
112900230223        else;
113000230125        in_date = %editc(mardt: 'X');
113100230223        fmtDate(in_date:'YYYYMMDD':'MM/DD/YYYY':out_date:out_error)         ;
113200230125        MAR_date = %trim(out_date);
113300230223        endif;
113400230407
113500230125            PCGRPR = 'MARSTAT';
113600230125            PCCODE = PYMGS;
113700230125            PCTRST = OETRST;
113800230125            PCSUB# = OESUB#;
113900230125            PCACCT = OEACCT;
114000230125
114100230125          Chain (PCTRST:PCSUB#:PCACCT:PCGRPR:PCCODE) WEBPAYCHP;
114200230125          If  not %found(WEBPAYCHP);
114300230125              PCTRST = 0;
114400230125              PCSUB# = 0;
114500230125              PCACCT = 0;
114600230125          Chain (PCTRST:PCSUB#:PCACCT:PCGRPR:PCCODE) WEBPAYCHP;
114700230125          Endif;
114800230125          wmarsts = %trim(PCDESC);
114900230407
115000230407        FOMARDT = MAR_date;
115100230407        FOMARSTS = wmarsts;
115200230125
115300230125          if  %trim(PYOCC) <> *blanks;
115400230125              PCGRPR = 'JOBTITLE';
115500230125              PCCODE = PYOCC;
115600230125              PCTRST = OETRST;
115700230125              PCSUB# = OESUB#;
115800230125              PCACCT = OEACCT;
115900230125          Chain (PCTRST:PCSUB#:PCACCT:PCGRPR:PCCODE) WEBPAYCHP;
116000230125          If  %found(WEBPAYCHP);
116100230125              Occupation = %trim(PCDESC);
116200230125          Else;
116300230125              Occupation = %trim(PYOCC);
116400230125          Endif;
116500230125          Endif;
116600230407
116700230407       FOOCCJOB = %trim(Occupation);
116800230125
116900230124       COL001 = %trim(wwname);
117000230124       COL002 = getmessage('LINE002');
117100230124       COL002 = %ScanRpl( '@B' : %trim(wwssn): COL002);
117200230125       write Data2;
117300230203       g_count = g_count + 1;
117400230124
117500230125       COL001 = %trim(addr1);
117600230125       COL002 = getmessage('LINE003');
117700230125       COL002 = %ScanRpl( '@C' : %trim(DOB_date): COL002);
117800230125       write Data2;
117900230203       g_count = g_count + 1;
118000230125
118100230125       COL001 = *blanks;
118200230125       COL002 = *blanks;
118300230124
118400230124       if addr2 > '';
118500230125       COL001 = %trim(addr2);
118600230125       COL002 = getmessage('LINE004');
118700230125       COL002 = %ScanRpl( '@D' : %trim(ENR_date): COL002);
118800230125         write Data2;
118900230203       g_count = g_count + 1;
119000230124       endif;
119100230124
119200230124       wZip = %Editc(Zip: 'X' );
119300230124       Line01 = %Trim( City ) + ', '
119400230124         + %Trim( State ) + ' '
119500230124         + %Subst( wZip : 1 : 5 ) ;
119600230124
119700230124       if %Subst( wZip : 6 : 4) <>'0000' ;
119800230124         Line01 = %Trim( Line01) + '-' + %Subst( wZip : 6 : 4 ) ;
119900230124       EndIf;
120000230125
120100230125       COL001 = %trim(Line01);
120200230125       if %trim(COL002) = *blanks;
120300230125       COL002 = getmessage('LINE004');
120400230125       COL002 = %ScanRpl( '@D' : %trim(ENR_date): COL002);
120500230125       else;
120600230125       COL002 = *blanks;
120700230125       endif;
120800230125       write Data2;
120900230203       g_count = g_count + 1;
121000230125
121100230125       COL001 = *blanks;
121200230125       COL002 = *blanks;
121300230125       write Data2;
121400230203       g_count = g_count + 1;
121500230125
121600230125       wline = '$' + %trim(%editc(salary:'J')) ;
121700230125       COL001 = getmessage('LINE005');
121800230125       COL001 = %ScanRpl( '@E' : %trim(wline): COL001);
121900230125       COL002 = getmessage('LINE006');
122000230125       COL002 = %ScanRpl( '@F' : %trim(SAL_date): COL002);
122100230125       write Data2;
122200230203       g_count = g_count + 1;
122300230125
122400230125       wline = *blanks;
122500230125       COL001 = getmessage('LINE007');
122600230125       COL001 = %ScanRpl( '@G' : %trim(wmarsts) : COL001);
122700230125       COL002 = getmessage('LINE008');
122800230125       COL002 = %ScanRpl( '@H' : %trim(MAR_date): COL002);
122900230125       write Data2;
123000230203       g_count = g_count + 1;
123100230125
123200230125       COL001 = getmessage('LINE009');
123300230125       COL001 = %ScanRpl( '@I' : %trim(sex): COL001);
123400230125       COL002 = getmessage('LINE012');
123500230125       COL002 = %ScanRpl( '@L' : %trim(occupation) : COL002);
123600230125       write Data2;
123700230203       g_count = g_count + 1;
123800230125
123900230125       COL001 = getmessage('LINE010');
124000230125       COL001 = %ScanRpl( '@J' : %trim(wphone): COL001);
124100230125       COL002 = getmessage('LINE011');
124200230125       COL002 = %ScanRpl( '@K' : %Subst(Fill66:1:65) : COL002);
124300230125       write Data2;
124400230203       g_count = g_count + 1;
124500230407
124600230407       FOADDR1 = %trim(addr1);
124700230407       FOADDR2 = %trim(addr2);
124800230407       FOCITY  = %trim(city);
124900230407       FOSTATE = %trim(state);
125000230413       If pyhrs <> 0;
125100230407       FOHRSWRK = %char(pyhrs);
125200230413       else;
125300230413       FOHRSWRK = *blanks;
125400230413       endif;
125500230407       FOEMAIL = %Subst(Fill66:1:65);
125600230407       select;
125700230407       when     %trim(sex) = 'M';
125800230407       FOGENDER = 'MALE';
125900230407       when     %trim(sex) = 'F';
126000230407       FOGENDER = 'FEMALE';
126100230407       Other;
126200230407       FOGENDER = 'OTHER';
126300230407       endsl;
126400230407
126500230407       wZip = %Editc(Zip: 'X' );
126600230407       FOZIP =  %Subst( wZip : 1 : 5 ) ;
126700230407
126800230407       if %Subst( wZip : 6 : 4) <> '0000';
126900230407       FOZIP = %trim(FOZIP) + '-' + %Subst( wZip : 6 : 4 ) ;
127000230407       EndIf;
127100230124
127200230124       End-Proc;
127300230125       // ----------------------------------------------------------------
127400230125       dcl-proc PopDependForm;
127500230407
127600230407       FOMEDDT = %char(med#usa);
127700230407       FODENDT = %char(den#usa);
127800230407       FOVISDT = %char(vis#usa);
127900230407       FOLIFSTD = %char(lif#usa);
128000230407       FOLTD = %char(ltd#usa);
128100230410
128200230410          FOMEDDT = %ScanRpl( '01/01/0001' : '  ' : FOMEDDT);
128300230410          FODENDT = %ScanRpl( '01/01/0001' : '  ' : FODENDT);
128400230410          FOVISDT = %ScanRpl( '01/01/0001' : '  ' : FOVISDT);
128500230410          FOLIFSTD = %ScanRpl( '01/01/0001' : '  ' : FOLIFSTD);
128600230410          FOLTD = %ScanRpl( '01/01/0001' : '  ' : FOLTD);
128700230410
128800230411       if FOSSID <> *blanks;
128900230530         monitor;
129000230407       write OE_FORMR;
129100230530         on-error;
129200230530         EndMon;
129300230411       endif;
129400230127
129500230127       E_LINE1 = *blanks;
129600230127       write EMPLINE;
129700230203       g_count = g_count + 1;
129800230125
129900230127       E_LINE1 = getmessage('LINE013');
130000230125       If %char(med#usa) = '01/01/0001';
130100230127       E_LINE1 = %ScanRpl( '@M' : '  ' : E_LINE1);
130200230125       else;
130300230127       E_LINE1 = %ScanRpl( '@M' : %char(med#usa) : E_LINE1);
130400230125       endif;
130500230125       If %char(den#usa) = '01/01/0001';
130600230127       E_LINE1 = %ScanRpl( '@N' : '  ' : E_LINE1);
130700230125       else;
130800230127       E_LINE1 = %ScanRpl( '@N' : %char(den#usa) : E_LINE1);
130900230125       endif;
131000230125       If %char(vis#usa) = '01/01/0001';
131100230127       E_LINE1 = %ScanRpl( '@O' : '  ' : E_LINE1);
131200230125       else;
131300230127       E_LINE1 = %ScanRpl( '@O' : %char(vis#usa) : E_LINE1);
131400230125       endif;
131500230125       If %char(lif#usa) = '01/01/0001';
131600230127       E_LINE1 = %ScanRpl( '@P' : '  ' : E_LINE1);
131700230125       else;
131800230127       E_LINE1 = %ScanRpl( '@P' : %char(lif#usa) : E_LINE1);
131900230125       endif;
132000230125       If %char(ltd#usa) = '01/01/0001';
132100230127       E_LINE1 = %ScanRpl( '@Q' : '  ' : E_LINE1);
132200230125       else;
132300230127       E_LINE1 = %ScanRpl( '@Q' : %char(ltd#usa) : E_LINE1);
132400230125       endif;
132500230127       write EMPLINE;
132600230203       g_count = g_count + 1;
132700230125
132800230125       COL001 = *blanks;
132900230125       COL002 = *blanks;
133000230125       write Data2;
133100230203       g_count = g_count + 1;
133200230130
133300230306       BOLD01 = 'GENERAL INFORMATION';
133400230130       write BOLD;
133500230203       g_count = g_count + 1;
133600230306       write ULINE;
133700230223
133800230306                DEP001H = ' ';
133900230306                DEP002H = ' ';
134000230306                DEP003H = ' ';
134100230306                DEP004H = ' ';
134200230306                DEP005H = 'FT';
134300230306                DEP006H = ' ';
134400230306                DEP007H = 'EXT';
134500230306                DEP008H = ' ';
134600230306       write DEPNH1;
134700230203       g_count = g_count + 1;
134800230223
134900230306                DEP001H = 'Name';
135000230306                DEP002H = 'SSN';
135100230306                DEP003H = 'Birth Date';
135200230306                DEP004H = 'GEN';
135300230306                DEP005H = 'STU';
135400230306                DEP006H = 'DIS';
135500230306                DEP007H = 'PAT';
135600230306                DEP008H = 'PCP Info';
135700230223
135800230306       write DEPNH1;
135900230223       g_count = g_count + 1;
136000230125
136100230125       DEP001 = 'EE:' + %trim(b2mlst) + ', ' + %trim(b2mfst) + ' ' +
136200230125                %trim(b2mmmi);
136300230125                DEP002 = %trim(wwssn);
136400230125                DEP003 = %trim(DOB_date);
136500230125                DEP004 = %trim(b2msex);
136600230125                DEP005 = '//';
136700230125                DEP006 = %trim(b2mdis);
136800230203                DEP007 = %trim(b2mext);
136900230203                if       %trim(b2mphy) = *blanks or b2mext = *blanks;
137000230203                DEP007 = '//';
137100230203                endif;
137200230203                DEP008 = %trim(b2mphy);
137300230125       write DEPN1;
137400230203       g_count = g_count + 1;
137500230203
137600230407             GOWHO      = 'SELF';
137700230407             GOLAST     = %trim(b2mlst);
137800230407             GOFIRST    = %trim(b2mfst);
137900230407             GOMID      = %trim(b2mmmi);
138000230407             GOSSN      = %trim(wwssn);
138100230407             GOBIRTH    = %trim(DOB_date);
138200230407             GOGENDER   = %trim(b2msex);
138300230407             GOFTS      = '//';
138400230407             GODISABLED = %trim(b2mdis);
138500230407             GOPHYNAM   = %trim(b2mphy);
138600230407             GOPHYNBR   = %trim(b2mph#);
138700230407             GOEXIST    = %trim(b2mext);
138800230407             GODENT     = %triM(B2MDN#);
138900230407
139000230407           wwssn2 = %editc(b2sssn : 'X') ;
139100230407           wwssn2  = %subst(wwssn2:1:3) +
139200230407                    '-' +
139300230407                    %subst(wwssn2:4:2) +
139400230407                    '-' +
139500230407                    %subst(wwssn2:6:4);
139600230407                if b2sssn = 0;
139700230407                wwssn2 = *blanks;
139800230407                endif;
139900230407
140000230407             GSWHO      = 'SPOUSE';
140100230407             GSLAST     = %trim(b2slst);
140200230407             GSFIRST    = %trim(b2sfst);
140300230407             GSMID      = %trim(b2smmi);
140400230407             GSSSN      = %trim(wwssn2);
140500230407             GSBIRTH    = %char(b2sbth);
140600230410             GSBIRTH = %ScanRpl( '01/01/0001' : '  ' : GSBIRTH);
140700230407             GSGENDER   = %trim(b2ssex);
140800230407             GSFTS      = '//';
140900230407             GSDISABLED = %trim(b2sdis);
141000230407             GSPHYNAM   = %trim(b2sphy);
141100230407             GSPHYNBR   = %trim(b2sph#);
141200230407             GSEXIST    = %trim(b2sext);
141300230407             GSDENT     = %triM(B2sDN#);
141400230407
141500230407           wwssn2 = %editc(b21ssn : 'X') ;
141600230407           wwssn2  = %subst(wwssn2:1:3) +
141700230407                    '-' +
141800230407                    %subst(wwssn2:4:2) +
141900230407                    '-' +
142000230407                    %subst(wwssn2:6:4);
142100230407                if b21ssn = 0;
142200230407                wwssn2 = *blanks;
142300230407                endif;
142400230407
142500230407             G1WHO      = 'CHILD';
142600230407             G1LAST     = %trim(b21lst);
142700230407             G1FIRST    = %trim(b21fst);
142800230407             G1MID      = %trim(b21mmi);
142900230407             G1SSN      = %trim(wwssn2);
143000230407             G1BIRTH    = %char(b21bth);
143100230410             G1BIRTH = %ScanRpl( '01/01/0001' : '  ' : G1BIRTH);
143200230407             G1GENDER   = %trim(b21sex);
143300230425             G1FTS      = %trim(b21FTS);
143400230407             G1DISABLED = %trim(b21dis);
143500230407             G1PHYNAM   = %trim(b21phy);
143600230407             G1PHYNBR   = %trim(b21ph#);
143700230407             G1EXIST    = %trim(b21ext);
143800230407             G1DENT     = %triM(B21DN#);
143900230407
144000230407           wwssn2 = %editc(b22ssn : 'X') ;
144100230407           wwssn2  = %subst(wwssn2:1:3) +
144200230407                    '-' +
144300230407                    %subst(wwssn2:4:2) +
144400230407                    '-' +
144500230407                    %subst(wwssn2:6:4);
144600230407                if b22ssn = 0;
144700230407                wwssn2 = *blanks;
144800230407                endif;
144900230407
145000230407             G2WHO      = 'CHILD';
145100230407             G2LAST     = %trim(b22lst);
145200230407             G2FIRST    = %trim(b22fst);
145300230407             G2MID      = %trim(b22mmi);
145400230407             G2SSN      = %trim(wwssn2);
145500230407             G2BIRTH    = %char(b22bth);
145600230410             G2BIRTH = %ScanRpl( '01/01/0001' : '  ' : G2BIRTH);
145700230407             G2GENDER   = %trim(b22sex);
145800230407             G2FTS      = %trim(b22FTS);
145900230407             G2DISABLED = %trim(b22dis);
146000230407             G2PHYNAM   = %trim(b22phy);
146100230407             G2PHYNBR   = %trim(b22ph#);
146200230407             G2EXIST    = %trim(b22ext);
146300230407             G2DENT     = %triM(B22DN#);
146400230407
146500230407           wwssn2 = %editc(b23ssn : 'X') ;
146600230407           wwssn2  = %subst(wwssn2:1:3) +
146700230407                    '-' +
146800230407                    %subst(wwssn2:4:2) +
146900230407                    '-' +
147000230407                    %subst(wwssn2:6:4);
147100230407                if b23ssn = 0;
147200230407                wwssn2 = *blanks;
147300230407                endif;
147400230407
147500230407             G3WHO      = 'CHILD';
147600230407             G3LAST     = %trim(b23lst);
147700230407             G3FIRST    = %trim(b23fst);
147800230407             G3MID      = %trim(b23mmi);
147900230407             G3SSN      = %trim(wwssn2);
148000230407             G3BIRTH    = %char(b23bth);
148100230410             G3BIRTH = %ScanRpl( '01/01/0001' : '  ' : G3BIRTH);
148200230407             G3GENDER   = %trim(b23sex);
148300230407             G3FTS      = %trim(b23FTS);
148400230407             G3DISABLED = %trim(b23dis);
148500230407             G3PHYNAM   = %trim(b23phy);
148600230407             G3PHYNBR   = %trim(b23ph#);
148700230407             G3EXIST    = %trim(b23ext);
148800230407             G3DENT     = %triM(B23DN#);
148900230407
149000230407           wwssn2 = %editc(b24ssn : 'X') ;
149100230407           wwssn2  = %subst(wwssn2:1:3) +
149200230407                    '-' +
149300230407                    %subst(wwssn2:4:2) +
149400230407                    '-' +
149500230407                    %subst(wwssn2:6:4);
149600230407                if b24ssn = 0;
149700230407                wwssn2 = *blanks;
149800230407                endif;
149900230407
150000230407             G4WHO      = 'CHILD';
150100230407             G4LAST     = %trim(b24lst);
150200230407             G4FIRST    = %trim(b24fst);
150300230407             G4MID      = %trim(b24mmi);
150400230407             G4SSN      = %trim(wwssn2);
150500230407             G4BIRTH    = %char(b24bth);
150600230410             G4BIRTH = %ScanRpl( '01/01/0001' : '  ' : G4BIRTH);
150700230407             G4GENDER   = %trim(b24sex);
150800230407             G4FTS      = %trim(b24FTS);
150900230407             G4DISABLED = %trim(b24dis);
151000230407             G4PHYNAM   = %trim(b24phy);
151100230407             G4PHYNBR   = %trim(b24ph#);
151200230407             G4EXIST    = %trim(b24ext);
151300230407             G4DENT     = %triM(B24DN#);
151400230407
151500230407           wwssn2 = %editc(b25ssn : 'X') ;
151600230407           wwssn2  = %subst(wwssn2:1:3) +
151700230407                    '-' +
151800230407                    %subst(wwssn2:4:2) +
151900230407                    '-' +
152000230407                    %subst(wwssn2:6:4);
152100230407                if b25ssn = 0;
152200230407                wwssn2 = *blanks;
152300230407                endif;
152400230407
152500230407             G5WHO      = 'CHILD';
152600230407             G5LAST     = %trim(b25lst);
152700230407             G5FIRST    = %trim(b25fst);
152800230407             G5MID      = %trim(b25mmi);
152900230407             G5SSN      = %trim(wwssn2);
153000230407             G5BIRTH    = %char(b25bth);
153100230410             G5BIRTH = %ScanRpl( '01/01/0001' : '  ' : G5BIRTH);
153200230407             G5GENDER   = %trim(b25sex);
153300230407             G5FTS      = %trim(b25FTS);
153400230407             G5DISABLED = %trim(b25dis);
153500230407             G5PHYNAM   = %trim(b25phy);
153600230407             G5PHYNBR   = %trim(b25ph#);
153700230407             G5EXIST    = %trim(b25ext);
153800230407             G5DENT     = %triM(B25DN#);
153900230407
154000230411             if GOSSID <> *blanks;
154100231018F001      chain ( GOSSID ) oeformgenp;
154200231018          If  not %found(oeformgenp);
154300230407             write OE_GENR;
154400231018             endif;
154500230411             endif;
154600230203
154700230203           if   %trim(b2mph#) <> *blanks or %trim(b2mdn#) <> *blanks;
154800230223           DEP001 = *blanks;
154900230223           DEP002 = *blanks;
155000230203           DEP003 = *blanks;
155100230203           DEP004 = *blanks;
155200230203           DEP005 = *blanks;
155300230223           DEP006 = *blanks;
155400230223           DEP007 = *blanks;
155500230223           if   %trim(b2mph#) <> *blanks;
155600230223           DEP008 = 'Med#: ' + %trim(b2mph#);
155700230223           endif;
155800230223           if   %trim(b2mdn#) <> *blanks;
155900230223           if   %trim(b2mph#) <> *blanks;
156000230223           DEP008 = %trim(DEP008) + ' Den#: ' + %trim(b2mdn#);
156100230223           else;
156200230223           DEP008 = 'Den#: ' + %trim(b2mdn#);
156300230223           endif;
156400230223           endif;
156500230203       write DEPN1;
156600230203       g_count = g_count + 1;
156700230203           endif;
156800230203
156900230130
157000230130           wwssn2 = %editc(b2sssn : 'X') ;
157100230130           wwssn2  = %subst(wwssn2:1:3) +
157200230130                    '-' +
157300230130                    %subst(wwssn2:4:2) +
157400230130                    '-' +
157500230130                    %subst(wwssn2:6:4);
157600230130                if b2sssn = 0;
157700230130                wwssn2 = *blanks;
157800230130                endif;
157900230125
158000230125       If  %trim(b2slst) <> *blanks;
158100230125       DEP001 = 'SP:' + %trim(b2slst) + ', ' + %trim(b2sfst) + ' ' +
158200230125                %trim(b2smmi);
158300230130                DEP002 = %trim(wwssn2);
158400230125                DEP003 = %char(b2sbth);
158500230125                DEP004 = %trim(b2ssex);
158600230125                DEP005 = '//';
158700230125                DEP006 = %trim(b2sdis);
158800230203                DEP007 = %trim(b2sext);
158900230203                if       %trim(b2sphy) = *blanks or b2sext = *blanks;
159000230203                DEP007 = '//';
159100230203                endif;
159200230203                DEP008 = %trim(b2sphy);
159300230125       write DEPN1;
159400230203       g_count = g_count + 1;
159500230125       endif;
159600230203
159700230223           if   %trim(b2sph#) <> *blanks or %trim(b2sdn#) <> *blanks;
159800230223           DEP001 = *blanks;
159900230223           DEP002 = *blanks;
160000230223           DEP003 = *blanks;
160100230223           DEP004 = *blanks;
160200230223           DEP005 = *blanks;
160300230223           DEP006 = *blanks;
160400230223           DEP007 = *blanks;
160500230223           if   %trim(b2sph#) <> *blanks;
160600230223           DEP008 = 'Med#: ' + %trim(b2sph#);
160700230223           endif;
160800230223           if   %trim(b2sdn#) <> *blanks;
160900230223           if   %trim(b2sph#) <> *blanks;
161000230223           DEP008 = %trim(DEP008) + ' Den#: ' + %trim(b2sdn#);
161100230223           else;
161200230223           DEP008 = 'Den#: ' + %trim(b2sdn#);
161300230223           endif;
161400230223           endif;
161500230203       write DEPN1;
161600230203       g_count = g_count + 1;
161700230203           endif;
161800230130
161900230130           wwssn2 = %editc(b21ssn : 'X') ;
162000230130           wwssn2  = %subst(wwssn2:1:3) +
162100230130                    '-' +
162200230130                    %subst(wwssn2:4:2) +
162300230130                    '-' +
162400230130                    %subst(wwssn2:6:4);
162500230130                if b21ssn = 0;
162600230130                wwssn2 = *blanks;
162700230130                endif;
162800230125
162900230125       If  %trim(b21lst) <> *blanks;
163000230125       DEP001 = 'CH:' + %trim(b21lst) + ', ' + %trim(b21fst) + ' ' +
163100230125                %trim(b21mmi);
163200230130                DEP002 = %trim(wwssn2);
163300230125                DEP003 = %char(b21bth);
163400230125                DEP004 = %trim(b21sex);
163500230125                DEP005 = %trim(b21fts);
163600230125                DEP006 = %trim(b21dis);
163700230203                DEP007 = %trim(b21ext);
163800230203                if       %trim(b21phy) = *blanks or b21ext = *blanks;
163900230203                DEP007 = '//';
164000230203                endif;
164100230203                DEP008 = %trim(b21phy);
164200230125       write DEPN1;
164300230203       g_count = g_count + 1;
164400230125       endif;
164500230203
164600230223           if   %trim(b21ph#) <> *blanks or %trim(b21dn#) <> *blanks;
164700230223           DEP001 = *blanks;
164800230223           DEP002 = *blanks;
164900230223           DEP003 = *blanks;
165000230223           DEP004 = *blanks;
165100230223           DEP005 = *blanks;
165200230223           DEP006 = *blanks;
165300230223           DEP007 = *blanks;
165400230223           if   %trim(b21ph#) <> *blanks;
165500230223           DEP008 = 'Med#: ' + %trim(b21ph#);
165600230223           endif;
165700230223           if   %trim(b21dn#) <> *blanks;
165800230223           if   %trim(b21ph#) <> *blanks;
165900230223           DEP008 = %trim(DEP008) + ' Den#: ' + %trim(b21dn#);
166000230223           else;
166100230223           DEP008 = 'Den#: ' + %trim(b21dn#);
166200230223           endif;
166300230223           endif;
166400230203       write DEPN1;
166500230203       g_count = g_count + 1;
166600230203           endif;
166700230130
166800230130           wwssn2 = %editc(b22ssn : 'X') ;
166900230130           wwssn2  = %subst(wwssn2:1:3) +
167000230130                    '-' +
167100230130                    %subst(wwssn2:4:2) +
167200230130                    '-' +
167300230130                    %subst(wwssn2:6:4);
167400230130                if b22ssn = 0;
167500230130                wwssn2 = *blanks;
167600230130                endif;
167700230125
167800230125       If  %trim(b22lst) <> *blanks;
167900230125       DEP001 = 'CH:' + %trim(b22lst) + ', ' + %trim(b22fst) + ' ' +
168000230125                %trim(b22mmi);
168100230130                DEP002 = %trim(wwssn2);
168200230125                DEP003 = %char(b22bth);
168300230125                DEP004 = %trim(b22sex);
168400230125                DEP005 = %trim(b22fts);
168500230125                DEP006 = %trim(b22dis);
168600230203                DEP007 = %trim(b22ext);
168700230203                if       %trim(b22phy) = *blanks or b22ext = *blanks;
168800230203                DEP007 = '//';
168900230203                endif;
169000230203                DEP008 = %trim(b22phy);
169100230125       write DEPN1;
169200230203       g_count = g_count + 1;
169300230125       endif;
169400230203
169500230223           if   %trim(b22ph#) <> *blanks or %trim(b22dn#) <> *blanks;
169600230223           DEP001 = *blanks;
169700230223           DEP002 = *blanks;
169800230223           DEP003 = *blanks;
169900230223           DEP004 = *blanks;
170000230223           DEP005 = *blanks;
170100230223           DEP006 = *blanks;
170200230223           DEP007 = *blanks;
170300230223           if   %trim(b22ph#) <> *blanks;
170400230223           DEP008 = 'Med#: ' + %trim(b22ph#);
170500230223           endif;
170600230223           if   %trim(b22dn#) <> *blanks;
170700230223           if   %trim(b22ph#) <> *blanks;
170800230223           DEP008 = %trim(DEP008) + ' Den#: ' + %trim(b22dn#);
170900230223           else;
171000230223           DEP008 = 'Den#: ' + %trim(b22dn#);
171100230223           endif;
171200230223           endif;
171300230203       write DEPN1;
171400230203       g_count = g_count + 1;
171500230203           endif;
171600230130
171700230130           wwssn2 = %editc(b23ssn : 'X') ;
171800230130           wwssn2  = %subst(wwssn2:1:3) +
171900230130                    '-' +
172000230130                    %subst(wwssn2:4:2) +
172100230130                    '-' +
172200230130                    %subst(wwssn2:6:4);
172300230130                if b23ssn = 0;
172400230130                wwssn2 = *blanks;
172500230130                endif;
172600230125
172700230125       If  %trim(b23lst) <> *blanks;
172800230125       DEP001 = 'CH:' + %trim(b23lst) + ', ' + %trim(b23fst) + ' ' +
172900230125                %trim(b23mmi);
173000230130                DEP002 = %trim(wwssn2);
173100230125                DEP003 = %char(b23bth);
173200230125                DEP004 = %trim(b23sex);
173300230125                DEP005 = %trim(b23fts);
173400230125                DEP006 = %trim(b23dis);
173500230203                DEP007 = %trim(b23ext);
173600230203                if       %trim(b23phy) = *blanks or b23ext = *blanks;
173700230203                DEP007 = '//';
173800230203                endif;
173900230203                DEP008 = %trim(b23phy);
174000230125       write DEPN1;
174100230203       g_count = g_count + 1;
174200230125       endif;
174300230223
174400230223           if   %trim(b23ph#) <> *blanks or %trim(b23dn#) <> *blanks;
174500230223           DEP001 = *blanks;
174600230223           DEP002 = *blanks;
174700230223           DEP003 = *blanks;
174800230223           DEP004 = *blanks;
174900230223           DEP005 = *blanks;
175000230223           DEP006 = *blanks;
175100230223           DEP007 = *blanks;
175200230223           if   %trim(b23ph#) <> *blanks;
175300230223           DEP008 = 'Med#: ' + %trim(b23ph#);
175400230223           endif;
175500230223           if   %trim(b23dn#) <> *blanks;
175600230223           if   %trim(b23ph#) <> *blanks;
175700230223           DEP008 = %trim(DEP008) + ' Den#: ' + %trim(b23dn#);
175800230223           else;
175900230223           DEP008 = 'Den#: ' + %trim(b23dn#);
176000230223           endif;
176100230223           endif;
176200230203
176300230203       write DEPN1;
176400230203       g_count = g_count + 1;
176500230203           endif;
176600230130
176700230130           wwssn2 = %editc(b24ssn : 'X') ;
176800230130           wwssn2  = %subst(wwssn2:1:3) +
176900230130                    '-' +
177000230130                    %subst(wwssn2:4:2) +
177100230130                    '-' +
177200230130                    %subst(wwssn2:6:4);
177300230130                if b24ssn = 0;
177400230130                wwssn2 = *blanks;
177500230130                endif;
177600230125
177700230125       If  %trim(b24lst) <> *blanks;
177800230125       DEP001 = 'CH:' + %trim(b24lst) + ', ' + %trim(b24fst) + ' ' +
177900230125                %trim(b24mmi);
178000230130                DEP002 = %trim(wwssn2);
178100230125                DEP003 = %char(b24bth);
178200230125                DEP004 = %trim(b24sex);
178300230125                DEP005 = %trim(b24fts);
178400230125                DEP006 = %trim(b24dis);
178500230203                DEP007 = %trim(b24ext);
178600230203                if       %trim(b24phy) = *blanks or b24ext = *blanks;
178700230203                DEP007 = '//';
178800230203                endif;
178900230203                DEP008 = %trim(b24phy);
179000230125       write DEPN1;
179100230203       g_count = g_count + 1;
179200230125       endif;
179300230223
179400230223           if   %trim(b24ph#) <> *blanks or %trim(b24dn#) <> *blanks;
179500230223           DEP001 = *blanks;
179600230223           DEP002 = *blanks;
179700230223           DEP003 = *blanks;
179800230223           DEP004 = *blanks;
179900230223           DEP005 = *blanks;
180000230223           DEP006 = *blanks;
180100230223           DEP007 = *blanks;
180200230223           if   %trim(b24ph#) <> *blanks;
180300230223           DEP008 = 'Med#: ' + %trim(b24ph#);
180400230223           endif;
180500230223           if   %trim(b24dn#) <> *blanks;
180600230223           if   %trim(b24ph#) <> *blanks;
180700230223           DEP008 = %trim(DEP008) + ' Den#: ' + %trim(b24dn#);
180800230223           else;
180900230223           DEP008 = 'Den#: ' + %trim(b24dn#);
181000230223           endif;
181100230223           endif;
181200230203
181300230203       write DEPN1;
181400230203       g_count = g_count + 1;
181500230203           endif;
181600230130
181700230130           wwssn2 = %editc(b25ssn : 'X') ;
181800230130           wwssn2  = %subst(wwssn2:1:3) +
181900230130                    '-' +
182000230130                    %subst(wwssn2:4:2) +
182100230130                    '-' +
182200230130                    %subst(wwssn2:6:4);
182300230130                if b25ssn = 0;
182400230130                wwssn2 = *blanks;
182500230130                endif;
182600230125
182700230125       If  %trim(b25lst) <> *blanks;
182800230125       DEP001 = 'CH:' + %trim(b25lst) + ', ' + %trim(b25fst) + ' ' +
182900230125                %trim(b25mmi);
183000230130                DEP002 = %trim(wwssn2);
183100230125                DEP003 = %char(b25bth);
183200230125                DEP004 = %trim(b25sex);
183300230125                DEP005 = %trim(b25fts);
183400230125                DEP006 = %trim(b25dis);
183500230203                DEP007 = %trim(b25ext);
183600230203                if       %trim(b25phy) = *blanks or b25ext = *blanks;
183700230203                DEP007 = '//';
183800230203                endif;
183900230203                DEP008 = %trim(b25phy);
184000230125       write DEPN1;
184100230203       g_count = g_count + 1;
184200230125       endif;
184300230203
184400230223           if   %trim(b25ph#) <> *blanks or %trim(b25dn#) <> *blanks;
184500230223           DEP001 = *blanks;
184600230223           DEP002 = *blanks;
184700230223           DEP003 = *blanks;
184800230223           DEP004 = *blanks;
184900230223           DEP005 = *blanks;
185000230223           DEP006 = *blanks;
185100230223           DEP007 = *blanks;
185200230223           if   %trim(b25ph#) <> *blanks;
185300230223           DEP008 = 'Med#: ' + %trim(b25ph#);
185400230223           endif;
185500230223           if   %trim(b25dn#) <> *blanks;
185600230223           if   %trim(b25ph#) <> *blanks;
185700230223           DEP008 = %trim(DEP008) + ' Den#: ' + %trim(b25dn#);
185800230223           else;
185900230223           DEP008 = 'Den#: ' + %trim(b25dn#);
186000230223           endif;
186100230223           endif;
186200230203       write DEPN1;
186300230203       g_count = g_count + 1;
186400230203           endif;
186500230126
186600230126       OtherSR();
186700230125
186800230127       // TEST - LINE01 to E_LINE1
186900230127       E_LINE1 = *blanks;
187000230127       write EMPLINE;
187100230203       g_count = g_count + 1;
187200230130
187300230306       BOLD01 = 'OTHER HEALTH/DENTAL INSURANCE INFORMATION';
187400230130       write BOLD;
187500230203       g_count = g_count + 1;
187600230306       write ULINE;
187700230130
187800230130       PLN001 = *blanks;
187900230130       PLN002 = *blanks;
188000230130       write PLANSR;
188100230203       g_count = g_count + 1;
188200230407
188300230407        FOOTHY   =  %trim(b31yes);
188400230407        FOOTHN   =  %trim(b31no);
188500230407        FOOTHEFF =  %char(OTHEREFF);
188600230407        FOOTHEFF = %ScanRpl( '01/01/0001' : '  ' : FOOTHEFF);
188700230407        FOOTHTRM =  %char(OTHERTRM);
188800230407        FOOTHTRM = %ScanRpl( '01/01/0001' : '  ' : FOOTHTRM);
188900230407        FOWHO1   =  %trim(B32SLF);
189000230407        FOWHO2   =  %trim(B32SPS);
189100230407        FOWHO3   =  %trim(B32ALL);
189200230407        FOCARNAM =  %trim(B32PLY);
189300230407        FOPOLY   =  %trim(B32PL#);
189400230407        FOEMPLR  =  %trim(empname);
189500230407        FODEPY   =  %trim(B33YES);
189600230407        FODEPN   =  %trim(B33NO );
189700230407        FODEP1   =  %trim(B33IND);
189800230407        FODEP2   =  %trim(B33SEM);
189900230407        FOMEDY   =  %trim(B34YES);
190000230407        FOMEDN   =  %trim(B34NO );
190100230410        FOMEDA  = %ScanRpl( '01/01/0001' : '  ' : %char(B34EFFA));
190200230410        FOMEDB  = %ScanRpl( '01/01/0001' : '  ' : %char(B34EFFB));
190300230407        FOMEDNBR =  %trim(cobmed#);
190400230407        FODMEDY  =  %trim(B35YES);
190500230407        FODMEDN  =  %trim(B35NO );
190600230410        FODMEDA  = %ScanRpl( '01/01/0001' : '  ' : %char(auzmpA));
190700230410        FODMEDB  = %ScanRpl( '01/01/0001' : '  ' : %char(auzmpB));
190800230407        FODMEDNBR =  %trim(auzmed#);
190900230407
191000230414        if OOSSID <> *blanks;
191100231018F001      chain ( OOSSID ) oeformothp;
191200231018          If  not %found(oeformothp);
191300230407        write   OE_OTHER;
191400231018        endif;
191500230411        endif;
191600230407
191700230126
191800230127       E_LINE1 = getmessage('LINE014');
191900230127       E_LINE1 = %ScanRpl( '@Y' : %trim(b31yes) : E_LINE1);
192000230127       E_LINE1 = %ScanRpl( '@Z' : %trim(b31no) : E_LINE1);
192100230127       write EMPLINE;
192200230203       g_count = g_count + 1;
192300230125
192400230127       E_LINE1 = getmessage('LINE015');
192500230127       E_LINE1 = %ScanRpl( '@W' : %char(OTHEREFF) : E_LINE1);
192600230127       E_LINE1 = %ScanRpl( '@X' : %char(OTHERTRM) : E_LINE1);
192700230130       E_LINE1 = %ScanRpl( '01/01/0001' : '  ' : E_LINE1);
192800230127       write EMPLINE;
192900230203       g_count = g_count + 1;
193000230125
193100230127       E_LINE1 = getmessage('LINE016');
193200230127       E_LINE1 = %ScanRpl( '@1' : %trim(b32slf) : E_LINE1);
193300230127       E_LINE1 = %ScanRpl( '@2' : %trim(b32sps) : E_LINE1);
193400230127       E_LINE1 = %ScanRpl( '@3' : %trim(b32all) : E_LINE1);
193500230127       E_LINE1 = %ScanRpl( '@4' : %trim(b32oth) : E_LINE1);
193600230127       E_LINE1 = %ScanRpl( '@C' : %trim(b32ply) : E_LINE1);
193700230127       E_LINE1 = %ScanRpl( '@5' : %trim(b32pl#) : E_LINE1);
193800230127       E_LINE1 = %ScanRpl( '@6' : %trim(empname) : E_LINE1);
193900230127       write EMPLINE;
194000230203       g_count = g_count + 1;
194100230125
194200230126       // LINE01 = getmessage('LINE017');
194300230126       // LINE01 = %ScanRpl( '@4' : %trim(b32ply) : LINE01);
194400230126       // LINE01 = %ScanRpl( '@5' : %trim(b32pl#) : LINE01);
194500230126       // LINE01 = %ScanRpl( '@6' : %trim(empname) : LINE01);
194600230126       // pos_x = pos_x + s_Space;
194700230126       // write Data;
194800230125
194900230127       E_LINE1 = getmessage('LINE018');
195000230127       E_LINE1 = %ScanRpl( '@7' : %trim(b33yes) : E_LINE1);
195100230127       E_LINE1 = %ScanRpl( '@8' : %trim(b33no) : E_LINE1);
195200230127       write EMPLINE;
195300230203       g_count = g_count + 1;
195400230125
195500230127       E_LINE1 = getmessage('LINE019');
195600230127       E_LINE1 = %ScanRpl( '@9' : %trim(b33ind) : E_LINE1);
195700230127       E_LINE1 = %ScanRpl( '@#' : %trim(b33sem) : E_LINE1);
195800230127       write EMPLINE;
195900230203       g_count = g_count + 1;
196000230125
196100230127       E_LINE1 = getmessage('LINE020');
196200230127       E_LINE1 = %ScanRpl( '%1' : %trim(b34yes) : E_LINE1);
196300230127       E_LINE1 = %ScanRpl( '%2' : %trim(b34no) : E_LINE1);
196400230127       E_LINE1 = %ScanRpl( '%3' : %char(COBPARTA) : E_LINE1);
196500230127       E_LINE1 = %ScanRpl( '%4' : %char(COBPARTB) : E_LINE1);
196600230127       E_LINE1 = %ScanRpl( '%5' : %trim(cobmed#) : E_LINE1);
196700230130       E_LINE1 = %ScanRpl( '01/01/0001' : '  ' : E_LINE1);
196800230127       write EMPLINE;
196900230203       g_count = g_count + 1;
197000230125
197100230127       E_LINE1 = getmessage('LINE021');
197200230127       E_LINE1 = %ScanRpl( '%5' : %trim(b35yes) : E_LINE1);
197300230127       E_LINE1 = %ScanRpl( '%6' : %trim(b35no) : E_LINE1);
197400230127       E_LINE1 = %ScanRpl( '%7' : %char(auzmpa) : E_LINE1);
197500230127       E_LINE1 = %ScanRpl( '%8' : %char(auzmpb) : E_LINE1);
197600230127       E_LINE1 = %ScanRpl( '%9' : %trim(auzmed#) : E_LINE1);
197700230130       E_LINE1 = %ScanRpl( '01/01/0001' : '  ' : E_LINE1);
197800230127       write EMPLINE;
197900230203       g_count = g_count + 1;
198000230126
198100230127       // E_LINE1 = *blanks; stop
198200230127       // pos_x = pos_x + s_Space;
198300230127       // write EMPLINE;
198400230125
198500230125       End-Proc;
198600230126       // ----------------------------------------------------------------
198700230126       dcl-proc PopPlanForm;
198800230127
198900230130       P_Count = 0;
199000230126       write PLANHDR;
199100230203       g_count = g_count + 1;
199200230126
199300230306       BOLD01 = 'BENEFIT ELECTIONS';
199400230127       write BOLD;
199500230203       g_count = g_count + 1;
199600230306       write ULINE;
199700230130
199800230413       If %trim(B41HED) <> *blanks;
199900230407       P1TYPE    =  %trim(B41HED);
200000230407       P1CARNAM  =  %trim(B41CAR);
200100230407       P1PLAN    =  %trim(B41PLN);
200200230407       P1GROUP   =  %trim(B41GRP);
200300230407       P1COVLVL  =  %trim(B41COV) + '  ' + %trim(B41DSC) +
200400230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B41DAT));
200500230413       endif;
200600230407
200700230413       If %trim(B42HED) <> *blanks;
200800230407       P2TYPE    =  %trim(B42HED);
200900230407       P2CARNAM  =  %trim(B42CAR);
201000230407       P2PLAN    =  %trim(B42PLN);
201100230407       P2GROUP   =  %trim(B42GRP);
201200230407       P2COVLVL  =  %trim(B42COV) + '  ' + %trim(B42DSC) +
201300230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B42DAT));
201400230413       endif;
201500230407
201600230413       If %trim(B43HED) <> *blanks;
201700230407       P3TYPE    =  %trim(B43HED);
201800230407       P3CARNAM  =  %trim(B43CAR);
201900230407       P3PLAN    =  %trim(B43PLN);
202000230407       P3GROUP   =  %trim(B43GRP);
202100230407       P3COVLVL  =  %trim(B43COV) + '  ' + %trim(B43DSC) +
202200230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B43DAT));
202300230413       endif;
202400230407
202500230413       If %trim(B44HED) <> *blanks;
202600230407       P4TYPE    =  %trim(B44HED);
202700230407       P4CARNAM  =  %trim(B44CAR);
202800230407       P4PLAN    =  %trim(B44PLN);
202900230407       P4GROUP   =  %trim(B44GRP);
203000230407       P4COVLVL  =  %trim(B44COV) + '  ' + %trim(B44DSC) +
203100230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B44DAT));
203200230413       endif;
203300230407
203400230413       If %trim(B45HED) <> *blanks;
203500230407       P5TYPE    =  %trim(B45HED);
203600230407       P5CARNAM  =  %trim(B45CAR);
203700230407       P5PLAN    =  %trim(B45PLN);
203800230407       P5GROUP   =  %trim(B45GRP);
203900230407       P5COVLVL  =  %trim(B45COV) + '  ' + %trim(B45DSC) +
204000230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B45DAT));
204100230413       endif;
204200230407
204300230413       If %trim(B46HED) <> *blanks;
204400230407       P6TYPE    =  %trim(B46HED);
204500230407       P6CARNAM  =  %trim(B46CAR);
204600230407       P6PLAN    =  %trim(B46PLN);
204700230407       P6GROUP   =  %trim(B46GRP);
204800230407       P6COVLVL  =  %trim(B46COV) + '  ' + %trim(B46DSC) +
204900230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B46DAT));
205000230413       endif;
205100230407
205200230413       If %trim(B47HED) <> *blanks;
205300230407       P7TYPE    =  %trim(B47HED);
205400230407       P7CARNAM  =  %trim(B47CAR);
205500230407       P7PLAN    =  %trim(B47PLN);
205600230407       P7GROUP   =  %trim(B47GRP);
205700230407       P7COVLVL  =  %trim(B47COV) + '  ' + %trim(B47DSC) +
205800230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B47DAT));
205900230413       endif;
206000230407
206100230413       If %trim(B48HED) <> *blanks;
206200230407       P8TYPE    =  %trim(B48HED);
206300230407       P8CARNAM  =  %trim(B48CAR);
206400230407       P8PLAN    =  %trim(B48PLN);
206500230407       P8GROUP   =  %trim(B48GRP);
206600230407       P8COVLVL  =  %trim(B48COV) + '  ' + %trim(B48DSC) +
206700230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B48DAT));
206800230413       endif;
206900230407
207000230413       If %trim(B49HED) <> *blanks;
207100230407       P9TYPE    =  %trim(B49HED);
207200230407       P9CARNAM  =  %trim(B49CAR);
207300230407       P9PLAN    =  %trim(B49PLN);
207400230407       P9GROUP   =  %trim(B49GRP);
207500230407       P9COVLVL  =  %trim(B49COV) + '  ' + %trim(B49DSC) +
207600230410                    '  ' + %ScanRpl( '01/01/0001' : '  ' : %char(B49DAT));
207700230413       endif;
207800230407
207900231013        if POSSID <> *blanks and P1TYPE <> *blanks;
208000231018F001      chain ( POSSID ) oeformplnp;
208100231018          If  not %found(oeformplnp);
208200230411        write OE_PLANR;
208300231018        endif;
208400230411        endif;
208500230407
208600230203       If  %trim(b41hed) <> *blanks or %trim(b42hed) <> *blanks;
208700230130       PLN001 = *blanks;
208800230130       PLN002 = *blanks;
208900230130       write PLANSR;
209000230203       g_count = g_count + 1;
209100230203       else;
209200230203       PLN001 = 'N/A';
209300230203       PLN002 = *blanks;
209400230203       write PLANSR;
209500230203       g_count = g_count + 1;
209600230203       endif;
209700230126
209800230127       If  %trim(b41hed) <> *blanks or %trim(b42hed) <> *blanks;
209900230203       PlanOverFlow();
210000230126       PLN001 = %trim(b41hed);
210100230126       PLN002 = %trim(b42hed);
210200230126       write PLANSR;
210300230130       P_Count = P_Count+1;
210400230203       g_count = g_count + 1;
210500230126
210600230126       If %trim(b41car) <> *blanks or %trim(b42car) <> *blanks;
210700230126       PLN001 = %trim(b41car);
210800230126       PLN002 = %trim(b42car);
210900230126       write PLANSR;
211000230203       g_count = g_count + 1;
211100230126       Endif;
211200230126
211300230126       PLN001 = %trim(b41pln);
211400230126       PLN002 = %trim(b42pln);
211500230126       write PLANSR;
211600230203       g_count = g_count + 1;
211700230126
211800230126       PLN001 = %trim(grptxt1) + ': ' +  %trim(b41grp);
211900230203       PLN002 = %trim(grptxt2) + ': ' +  %trim(b42grp);
212000230203       If       %trim(b42grp) = *blanks;
212100230203       PLN002 = *blanks;
212200230203       endif;
212300230126       write PLANSR;
212400230203       g_count = g_count + 1;
212500230126
212600230203       PLN001 = %trim(b41cov);
212700230203       PLN002 = %trim(b42cov);
212800230126       write PLANSR;
212900230203       g_count = g_count + 1;
213000230203
213100230203       PLN001 = %trim(b41dsc) + ' ' + %char(b41dat);
213200230203       PLN002 = %trim(b42dsc) + ' ' + %char(b42dat);
213300230323       If       %char(b41dat) =  '01/01/0001';
213400230210       PLN001 = *blanks;
213500230210       endif;
213600230203       If       %char(b42dat) =  '01/01/0001';
213700230203       PLN002 = *blanks;
213800230203       endif;
213900230210       if        %trim(PLN001) <> *blanks  or
214000230210                 %trim(PLN002) <> *blanks;
214100230203       write PLANSR;
214200230203       g_count = g_count + 1;
214300230210       endif;
214400230126
214500230126       PLN001 = *blanks;
214600230126       PLN002 = *blanks;
214700230126       write PLANSR;
214800230203       g_count = g_count + 1;
214900230127       Endif;
215000230126
215100230127       If  %trim(b43hed) <> *blanks or %trim(b44hed) <> *blanks;
215200230203       PlanOverFlow();
215300230126       PLN001 = %trim(b43hed);
215400230126       PLN002 = %trim(b44hed);
215500230126       write PLANSR;
215600230130       P_Count = P_Count+1;
215700230203       g_count = g_count + 1;
215800230126
215900230126       If %trim(b43car) <> *blanks or %trim(b44car) <> *blanks;
216000230126       PLN001 = %trim(b43car);
216100230126       PLN002 = %trim(b44car);
216200230126       write PLANSR;
216300230203       g_count = g_count + 1;
216400230126       Endif;
216500230126
216600230126       PLN001 = %trim(b43pln);
216700230126       PLN002 = %trim(b44pln);
216800230126       write PLANSR;
216900230203       g_count = g_count + 1;
217000230126
217100230126       PLN001 = %trim(grptxt3) + ': ' +  %trim(b43grp);
217200230203       PLN002 = %trim(grptxt4) + ': ' +  %trim(b44grp);
217300230203       If       %trim(b44grp) = *blanks;
217400230203       PLN002 = *blanks;
217500230203       endif;
217600230126       write PLANSR;
217700230203       g_count = g_count + 1;
217800230126
217900230203       PLN001 = %trim(b43cov);
218000230203       PLN002 = %trim(b44cov);
218100230126       write PLANSR;
218200230203       g_count = g_count + 1;
218300230203
218400230203       PLN001 = %trim(b43dsc) + ' ' + %char(b43dat);
218500230203       PLN002 = %trim(b44dsc) + ' ' + %char(b44dat);
218600230210       If       %char(b43dat) =  '01/01/0001';
218700230210       PLN001 = *blanks;
218800230203       endif;
218900230210       If       %char(b44dat) =  '01/01/0001';
219000230210       PLN002 = *blanks;
219100230210       endif;
219200230210       if        %trim(PLN001) <> *blanks  or
219300230210                 %trim(PLN002) <> *blanks;
219400230203       write PLANSR;
219500230203       g_count = g_count + 1;
219600230210       endif;
219700230126
219800230126       PLN001 = *blanks;
219900230126       PLN002 = *blanks;
220000230126       write PLANSR;
220100230203       g_count = g_count + 1;
220200230127       Endif;
220300230126
220400230127       If  %trim(b45hed) <> *blanks or %trim(b46hed) <> *blanks;
220500230203       PlanOverFlow();
220600230126       PLN001 = %trim(b45hed);
220700230126       PLN002 = %trim(b46hed);
220800230126       write PLANSR;
220900230130       P_Count = P_Count+1;
221000230203       g_count = g_count + 1;
221100230126
221200230126       If %trim(b45car) <> *blanks or %trim(b46car) <> *blanks;
221300230126       PLN001 = %trim(b45car);
221400230126       PLN002 = %trim(b46car);
221500230126       write PLANSR;
221600230203       g_count = g_count + 1;
221700230126       Endif;
221800230126
221900230126       PLN001 = %trim(b45pln);
222000230126       PLN002 = %trim(b46pln);
222100230126       write PLANSR;
222200230203       g_count = g_count + 1;
222300230126
222400230126       PLN001 = %trim(grptxt5) + ': ' +  %trim(b45grp);
222500230126       PLN002 = %trim(grptxt6) + ': ' +  %trim(b46grp);
222600230203       If       %trim(b46grp) = *blanks;
222700230203       PLN002 = *blanks;
222800230203       endif;
222900230126       write PLANSR;
223000230203       g_count = g_count + 1;
223100230126
223200230203       PLN001 = %trim(b45cov);
223300230203       PLN002 = %trim(b46cov);
223400230126       write PLANSR;
223500230203       g_count = g_count + 1;
223600230203
223700230203       PLN001 = %trim(b45dsc) + ' ' + %char(b45dat);
223800230203       PLN002 = %trim(b46dsc) + ' ' + %char(b46dat);
223900230210       If       %char(b45dat) =  '01/01/0001';
224000230210       PLN001 = *blanks;
224100230203       endif;
224200230210       If       %char(b46dat) =  '01/01/0001';
224300230210       PLN002 = *blanks;
224400230210       endif;
224500230210       if        %trim(PLN001) <> *blanks  or
224600230210                 %trim(PLN002) <> *blanks;
224700230203       write PLANSR;
224800230203       g_count = g_count + 1;
224900230210       endif;
225000230126
225100230126       PLN001 = *blanks;
225200230126       PLN002 = *blanks;
225300230126       write PLANSR;
225400230203       g_count = g_count + 1;
225500230127       Endif;
225600230127
225700230126
225800230127       If  %trim(b47hed) <> *blanks or %trim(b48hed) <> *blanks;
225900230203       PlanOverFlow();
226000230126       PLN001 = %trim(b47hed);
226100230126       PLN002 = %trim(b48hed);
226200230126       write PLANSR;
226300230203       g_count = g_count + 1;
226400230126
226500230126       If %trim(b47car) <> *blanks or %trim(b48car) <> *blanks;
226600230126       PLN001 = %trim(b47car);
226700230126       PLN002 = %trim(b48car);
226800230126       write PLANSR;
226900230203       g_count = g_count + 1;
227000230126       Endif;
227100230126
227200230126       PLN001 = %trim(b47pln);
227300230126       PLN002 = %trim(b48pln);
227400230126       write PLANSR;
227500230203       g_count = g_count + 1;
227600230126
227700230126       PLN001 = %trim(grptxt7) + ': ' +  %trim(b47grp);
227800230126       PLN002 = %trim(grptxt8) + ': ' +  %trim(b48grp);
227900230203       If       %trim(b48grp) = *blanks;
228000230203       PLN002 = *blanks;
228100230203       endif;
228200230126       write PLANSR;
228300230203       g_count = g_count + 1;
228400230126
228500230203       PLN001 = %trim(b47cov);
228600230203       PLN002 = %trim(b48cov);
228700230126       write PLANSR;
228800230203       g_count = g_count + 1;
228900230203
229000230203       PLN001 = %trim(b47dsc) + ' ' + %char(b47dat);
229100230203       PLN002 = %trim(b48dsc) + ' ' + %char(b48dat);
229200230210       If       %char(b47dat) =  '01/01/0001';
229300230210       PLN001 = *blanks;
229400230203       endif;
229500230210       If       %char(b48dat) =  '01/01/0001';
229600230210       PLN002 = *blanks;
229700230210       endif;
229800230210       if        %trim(PLN001) <> *blanks  or
229900230210                 %trim(PLN002) <> *blanks;
230000230203       write PLANSR;
230100230203       g_count = g_count + 1;
230200230210       endif;
230300230126
230400230126       PLN001 = *blanks;
230500230126       PLN002 = *blanks;
230600230126       write PLANSR;
230700230203       g_count = g_count + 1;
230800230127       Endif;
230900230126
231000230131       If  %trim(b49hed) <> *blanks and OverPlan <> 'Y';
231100230203       PlanOverFlow();
231200230126       PLN001 = %trim(b49hed);
231300230126       PLN002 = *blanks;
231400230126       write PLANSR;
231500230203       g_count = g_count + 1;
231600230126
231700230126       If %trim(b49car) <> *blanks;
231800230126       PLN001 = %trim(b49car);
231900230126       PLN002 = *blanks;
232000230126       write PLANSR;
232100230203       g_count = g_count + 1;
232200230126       Endif;
232300230126
232400230126       PLN001 = %trim(b49pln);
232500230126       PLN002 = *blanks;
232600230126       write PLANSR;
232700230203       g_count = g_count + 1;
232800230126
232900230126       PLN001 = %trim(grptxt9) + ': ' +  %trim(b49grp);
233000230126       PLN002 = *blanks;
233100230126       write PLANSR;
233200230203       g_count = g_count + 1;
233300230126
233400230203       PLN001 = %trim(b49cov);
233500230126       PLN002 = *blanks;
233600230126       write PLANSR;
233700230203       g_count = g_count + 1;
233800230203
233900230203       PLN001 = %trim(b49dsc) + ' ' + %char(b49dat);
234000230203       PLN002 = *blanks;
234100230210       If       %char(b49dat) =  '01/01/0001';
234200230210       PLN001 = *blanks;
234300230210       endif;
234400230210       if        %trim(PLN001) <> *blanks  or
234500230210                 %trim(PLN002) <> *blanks;
234600230203       write PLANSR;
234700230203       g_count = g_count + 1;
234800230210       endif;
234900230203
235000230127       PLN001 = *blanks;
235100230127       PLN002 = *blanks;
235200230127       write PLANSR;
235300230203       g_count = g_count + 1;
235400230127       Endif;
235500230131
235600230131       If  OverPlan = 'Y';
235700230502
235800230502              APSSID = IN_OESSID;
235900230502              APDATE = %trim(curdattim);
236000230502              APNAME = %trim(wwname);
236100230502              APSSN  = %trim(wwssn);
236200230502              APTSA  = %trim(wGBSTSA#);
236300230502              APTSANAM = %trim(acnam1);
236400230131
236500230131     C     1             Do        po#           x
236600230131     C                   If        po# > 0 and po# <= 99
236700230131     C     x             occur     webaplnids
236800230131     C                   If        aucpln <> *blanks
236900230131     C                   If        %subst(AUCPLN:1:8) = 'DECLINED'
237000230131     C                   eval      grptxt0 = 'Reason:'
237100230131     C                   else
237200230131     C                   eval      grptxt0 = 'Group#:'
237300230131     C                   End
237400230131
237500230502       If  %trim(aucben) <> *blanks and OverPlan = 'Y';
237600240131
237700240131F003 C                   Eval      tx = %lookup(%trim(AUCBEN):Titles)
237800240131 |   C                   If        tx = 0
237900240131 |   C                   eval      tt = tt + 1
238000240131 |   C                   Eval      Titles(tt) = %trim(AUCBEN)
238100240131 |   C                   else
238200240131 |   C                   iter
238300240131F003 C                   end
238400230502
238500230502            select;
238600230502            when    x = 1;
238700230502            APTTL01 = %trim(aucben);
238800230502            APCAR01 = %trim(auccar);
238900230502            APPLN01 = %trim(aucpln);
239000230502            APGRP01 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
239100230502            APCOV01 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
239200230502                      %char(aucdat);
239300230502            when    x = 2;
239400230502            APTTL02 = %trim(aucben);
239500230502            APCAR02 = %trim(auccar);
239600230502            APPLN02 = %trim(aucpln);
239700230502            APGRP02 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
239800230502            APCOV02 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
239900230502                      %char(aucdat);
240000230502            when    x = 3;
240100230502            APTTL03 = %trim(aucben);
240200230502            APCAR03 = %trim(auccar);
240300230502            APPLN03 = %trim(aucpln);
240400230502            APGRP03 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
240500230502            APCOV03 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
240600230502                      %char(aucdat);
240700230502            when    x = 4;
240800230502            APTTL04 = %trim(aucben);
240900230502            APCAR04 = %trim(auccar);
241000230502            APPLN04 = %trim(aucpln);
241100230502            APGRP04 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
241200230502            APCOV04 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
241300230502                      %char(aucdat);
241400230502            when    x = 5;
241500230502            APTTL05 = %trim(aucben);
241600230502            APCAR05 = %trim(auccar);
241700230502            APPLN05 = %trim(aucpln);
241800230502            APGRP05 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
241900230502            APCOV05 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
242000230502                      %char(aucdat);
242100230502            when    x = 6;
242200230502            APTTL06 = %trim(aucben);
242300230502            APCAR06 = %trim(auccar);
242400230502            APPLN06 = %trim(aucpln);
242500230502            APGRP06 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
242600230502            APCOV06 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
242700230502                      %char(aucdat);
242800230502            when    x = 7;
242900230502            APTTL07 = %trim(aucben);
243000230502            APCAR07 = %trim(auccar);
243100230502            APPLN07 = %trim(aucpln);
243200230502            APGRP07 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
243300230502            APCOV07 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
243400230502                      %char(aucdat);
243500230502            when    x = 8;
243600230502            APTTL08 = %trim(aucben);
243700230502            APCAR08 = %trim(auccar);
243800230502            APPLN08 = %trim(aucpln);
243900230502            APGRP08 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
244000230502            APCOV08 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
244100230502                      %char(aucdat);
244200230502            when    x = 9;
244300230502            APTTL09 = %trim(aucben);
244400230502            APCAR09 = %trim(auccar);
244500230502            APPLN09 = %trim(aucpln);
244600230502            APGRP09 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
244700230502            APCOV09 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
244800230502                      %char(aucdat);
244900230502            when    x = 10;
245000230502            APTTL10 = %trim(aucben);
245100230502            APCAR10 = %trim(auccar);
245200230502            APPLN10 = %trim(aucpln);
245300230502            APGRP10 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
245400230502            APCOV10 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
245500230502                      %char(aucdat);
245600230502            when    x = 11;
245700230502            APTTL11 = %trim(aucben);
245800230502            APCAR11 = %trim(auccar);
245900230502            APPLN11 = %trim(aucpln);
246000230502            APGRP11 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
246100230502            APCOV11 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
246200230502                      %char(aucdat);
246300230502            when    x = 12;
246400230502            APTTL12 = %trim(aucben);
246500230502            APCAR12 = %trim(auccar);
246600230502            APPLN12 = %trim(aucpln);
246700230502            APGRP12 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
246800230502            APCOV12 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
246900230502                      %char(aucdat);
247000230502            when    x = 13;
247100230502            APTTL13 = %trim(aucben);
247200230502            APCAR13 = %trim(auccar);
247300230502            APPLN13 = %trim(aucpln);
247400230502            APGRP13 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
247500230502            APCOV13 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
247600230502                      %char(aucdat);
247700230502            when    x = 14;
247800230502            APTTL14 = %trim(aucben);
247900230502            APCAR14 = %trim(auccar);
248000230502            APPLN14 = %trim(aucpln);
248100230502            APGRP14 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
248200230502            APCOV14 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' +
248300230502                      %char(aucdat);
248400230502            endsl;
248500230502
248600230203       PlanOverFlow();
248700230502       PLN001 = %trim(aucben);
248800230131       PLN002 = %trim(aucben);
248900230131       write PLANSR;
249000230203       g_count = g_count + 1;
249100230131
249200230131       If %trim(b49car) <> *blanks;
249300230131       PLN001 = %trim(b49car);
249400230131       PLN002 = %trim(auccar);
249500230131       write PLANSR;
249600230203       g_count = g_count + 1;
249700230131       Endif;
249800230131
249900230131       PLN001 = %trim(b49pln);
250000230131       PLN002 = %trim(aucpln);
250100230131       write PLANSR;
250200230203       g_count = g_count + 1;
250300230131
250400230131       PLN001 = %trim(grptxt9) + ': ' +  %trim(b49grp);
250500230131       PLN002 = %trim(grptxt0) + ': ' +  %trim(aucgrp);
250600230131       write PLANSR;
250700230203       g_count = g_count + 1;
250800230131
250900230131       PLN001 = %trim(b49cov) + ' ' + %trim(b49dsc) + ' ' + %char(b49dat);
251000230131       PLN002 = %trim(auccvg) + ' ' + %trim(aucdds) + ' ' + %char(aucdat);
251100230131       write PLANSR;
251200230203       g_count = g_count + 1;
251300230131
251400230131       PLN001 = *blanks;
251500230131       PLN002 = *blanks;
251600230131       write PLANSR;
251700230203       g_count = g_count + 1;
251800230131       Endif;
251900230131       Endif;
252000230131       Endif;
252100230131       Enddo;
252200230502
252300230502       if   APTTL01 <> *blanks;
252400231018F001      chain ( APSSID ) oeformadpp;
252500231018          If  not %found(oeformadpp);
252600230502       write   OE_ADPR;
252700231018       Endif;
252800230502       Endif;
252900230502
253000230131       Endif;
253100230126
253200230127       BEN_DUPLICATES();
253300230127
253400230203       If  %trim(b51pln) <> *blanks or %trim(b52pln) <> *blanks;
253500230203       skip_cont = '';
253600230227       if g_count >= 50;
253700230203       skip_cont = 'Y';
253800230203       LifeOverFlow();
253900230203       skip_cont = '';
254000230203       endif;
254100230306       BOLD01 = 'LIFE INSURANCE BENEFICIARY';
254200230127       write BOLD;
254300230203       g_count = g_count + 1;
254400230306       write ULINE;
254500230203       endif;
254600230130
254700230130       PLN001 = *blanks;
254800230130       PLN002 = *blanks;
254900230130       write PLANSR;
255000230203       g_count = g_count + 1;
255100230127
255200230407        B1NAME    = %trim(b51NAM);
255300230407        B1RELAT   = %trim(b51REL);
255400230407        B1PERCENT = %trim(b51PER);
255500230411        B1EFFDT = %ScanRpl( '01/01/0001' : '  ' : %char(b51eff));
255600230407        B1PLAN    = %trim(b51PLN);
255700230407
255800230407        B2NAME    = %trim(b52NAM);
255900230407        B2RELAT   = %trim(b52REL);
256000230407        B2PERCENT = %trim(b52PER);
256100230411        B2EFFDT = %ScanRpl( '01/01/0001' : '  ' : %char(b52eff));
256200230407        B2PLAN    = %trim(b52PLN);
256300230407
256400230407        B3NAME    = %trim(b53NAM);
256500230407        B3RELAT   = %trim(b53REL);
256600230407        B3PERCENT = %trim(b53PER);
256700230411        B3EFFDT = %ScanRpl( '01/01/0001' : '  ' : %char(b53eff));
256800230407        B3PLAN    = %trim(b53PLN);
256900230407
257000230407        B4NAME    = %trim(b54NAM);
257100230407        B4RELAT   = %trim(b54REL);
257200230407        B4PERCENT = %trim(b54PER);
257300230411        B4EFFDT = %ScanRpl( '01/01/0001' : '  ' : %char(b54eff));
257400230407        B4PLAN    = %trim(b54PLN);
257500230407
257600230407        B5NAME    = %trim(b55NAM);
257700230407        B5RELAT   = %trim(b55REL);
257800230407        B5PERCENT = %trim(b55PER);
257900230411        B5EFFDT = %ScanRpl( '01/01/0001' : '  ' : %char(b55eff));
258000230407        B5PLAN    = %trim(b55PLN);
258100230407
258200230413        if BOSSID <> *blanks and B1NAME <> ' ';
258300231018F001      chain ( BOSSID ) oeformbenp;
258400231018          If  not %found(oeformbenp);
258500230407        write  OE_BENER;
258600231018        endif;
258700230411        endif;
258800230407
258900230127       If  %trim(b51pln) <> *blanks or %trim(b52pln) <> *blanks;
259000230203       LifeOverFlow();
259100230127       PLN001 = %trim(b51pln);
259200230321       If  %trim(b52pln) <> *blanks;
259300230127       PLN002 = %trim(b52pln);
259400230321       else;
259500230321       PLN002 = *blanks;
259600230321       endif;
259700230127       write PLANSR;
259800230203       g_count = g_count + 1;
259900230127
260000230127       PLN001 = %trim(b51nam);
260100230321       If  %trim(b52nam) <> *blanks;
260200230321       PLN002 = %trim(b52nam);
260300230321       else;
260400230321       PLN002 = *blanks;
260500230321       endif;
260600230127       write PLANSR;
260700230203       g_count = g_count + 1;
260800230127
260900230127       PLN001 = 'Relationship: ' + %trim(b51rel);
261000230321       If  %trim(b52rel) <> *blanks;
261100230321       PLN002 = 'Relationship: ' + %trim(b52rel);
261200230321       else;
261300230321       PLN002 = *blanks;
261400230321       endif;
261500230127       write PLANSR;
261600230203       g_count = g_count + 1;
261700230127
261800230127       PLN001 = 'Percentage: ' + %trim(b51per);
261900230321       If  %trim(b52per) <> *blanks;
262000230321       PLN002 = 'Percentage: ' + %trim(b52per);
262100230321       else;
262200230321       PLN002 = *blanks;
262300230321       endif;
262400230127       write PLANSR;
262500230203       g_count = g_count + 1;
262600230127
262700230127       PLN001 = 'Effective Date: ' + %char(b51eff);
262800230321       If  %trim(b52nam) <> *blanks;
262900230321       PLN002 = 'Effective Date: ' + %char(b52eff);
263000230321       else;
263100230321       PLN002 = *blanks;
263200230321       endif;
263300230127       write PLANSR;
263400230203       g_count = g_count + 1;
263500230130
263600230130       PLN001 = *blanks;
263700230130       PLN002 = *blanks;
263800230130       write PLANSR;
263900230203       g_count = g_count + 1;
264000230127       Endif;
264100230203
264200230127
264300230127       If  %trim(b53pln) <> *blanks or %trim(b54pln) <> *blanks;
264400230203       LifeOverFlow();
264500230127       PLN001 = %trim(b53pln);
264600230321       If  %trim(b54pln) <> *blanks;
264700230127       PLN002 = %trim(b54pln);
264800230321       else;
264900230321       PLN002 = *blanks;
265000230321       endif;
265100230127       write PLANSR;
265200230203       g_count = g_count + 1;
265300230127
265400230127       PLN001 = %trim(b53nam);
265500230321       If  %trim(b54nam) <> *blanks;
265600230321       PLN002 = %trim(b54nam);
265700230321       else;
265800230321       PLN002 = *blanks;
265900230321       endif;
266000230127       write PLANSR;
266100230203       g_count = g_count + 1;
266200230127
266300230127       PLN001 = 'Relationship: ' + %trim(b53rel);
266400230321       If  %trim(b54nam) <> *blanks;
266500230321       PLN002 = 'Relationship: ' + %trim(b54rel);
266600230321       else;
266700230321       PLN002 = *blanks;
266800230321       endif;
266900230127       write PLANSR;
267000230203       g_count = g_count + 1;
267100230127
267200230127       PLN001 = 'Percentage: ' + %trim(b53per);
267300230321       If  %trim(b54nam) <> *blanks;
267400230321       PLN002 = 'Percentage: ' + %trim(b54per);
267500230321       else;
267600230321       PLN002 = *blanks;
267700230321       endif;
267800230127       write PLANSR;
267900230203       g_count = g_count + 1;
268000230127
268100230127       PLN001 = 'Effective Date: ' + %char(b53eff);
268200230321       If  %trim(b54nam) <> *blanks;
268300230321       PLN002 = 'Effective Date: ' + %char(b54eff);
268400230321       else;
268500230321       PLN002 = *blanks;
268600230321       endif;
268700230127       write PLANSR;
268800230203       g_count = g_count + 1;
268900230130
269000230130       PLN001 = *blanks;
269100230130       PLN002 = *blanks;
269200230130       write PLANSR;
269300230203       g_count = g_count + 1;
269400230127       Endif;
269500230126
269600230130       If  %trim(b55pln) <> *blanks or %trim(b56pln) <> *blanks;
269700230203       LifeOverFlow();
269800230130       PLN001 = %trim(b55pln);
269900230321       If  %trim(b56pln) <> *blanks;
270000230130       PLN002 = %trim(b56pln);
270100230321       else;
270200230321       PLN002 = *blanks;
270300230321       endif;
270400230127       write PLANSR;
270500230203       g_count = g_count + 1;
270600230127
270700230130       PLN001 = %trim(b55nam);
270800230321       If  %trim(b56pln) <> *blanks;
270900230321       PLN002 = %trim(b56nam);
271000230321       else;
271100230321       PLN002 = *blanks;
271200230321       endif;
271300230127       write PLANSR;
271400230203       g_count = g_count + 1;
271500230127
271600230130       PLN001 = 'Relationship: ' + %trim(b55rel);
271700230321       If  %trim(b56pln) <> *blanks;
271800230321       PLN002 = 'Relationship: ' + %trim(b56rel);
271900230321       else;
272000230321       PLN002 = *blanks;
272100230321       endif;
272200230127       write PLANSR;
272300230203       g_count = g_count + 1;
272400230127
272500230130       PLN001 = 'Percentage: ' + %trim(b55per);
272600230321       If  %trim(b56pln) <> *blanks;
272700230321       PLN002 = 'Percentage: ' + %trim(b56per);
272800230321       else;
272900230321       PLN002 = *blanks;
273000230321       endif;
273100230127       write PLANSR;
273200230203       g_count = g_count + 1;
273300230127
273400230130       PLN001 = 'Effective Date: ' + %char(b55eff);
273500230321       If  %trim(b56pln) <> *blanks;
273600230321       PLN002 = 'Effective Date: ' + %char(b56eff);
273700230321       else;
273800230321       PLN002 = *blanks;
273900230321       endif;
274000230127       write PLANSR;
274100230203       g_count = g_count + 1;
274200230130
274300230130       PLN001 = *blanks;
274400230130       PLN002 = *blanks;
274500230130       write PLANSR;
274600230203       g_count = g_count + 1;
274700230127       Endif;
274800230127
274900230127       PLN001 = *blanks;
275000230127       PLN002 = *blanks;
275100230127       write PLANSR;
275200230203       g_count = g_count + 1;
275300230127
275400230130        // Sign the form
275500230203       certOverFlow();
275600230306       BOLD01 = 'CERTIFICATION';
275700230130       write BOLD;
275800230203       g_count = g_count + 1;
275900230306       write ULINE;
276000230203
276100230203       PLN001 = *blanks;
276200230203       PLN002 = *blanks;
276300230203       write PLANSR;
276400230203       g_count = g_count + 1;
276500230130
276600230130          E_LINE1 = getmessage('LINE030');
276700230130          write EMPLINE;
276800230130          E_LINE1 = getmessage('LINE031');
276900230130          write EMPLINE;
277000230130          E_LINE1 = getmessage('LINE032');
277100230130          write EMPLINE;
277200230130          E_LINE1 = getmessage('LINE033');
277300230130          write EMPLINE;
277400230130          E_LINE1 = getmessage('LINE034');
277500230130          write EMPLINE;
277600230130          E_LINE1 = getmessage('LINE035');
277700230130          write EMPLINE;
277800230130          E_LINE1 = getmessage('LINE036');
277900230130          write EMPLINE;
278000230130          E_LINE1 = getmessage('LINE037');
278100230130          write EMPLINE;
278200230130          E_LINE1 = getmessage('LINE038');
278300230130          write EMPLINE;
278400230203        //  E_LINE1 = getmessage('LINE039');
278500230203        //  write EMPLINE;
278600230130
278700230130       PLN001 = *blanks;
278800230130       PLN002 = *blanks;
278900230130       write PLANSR;
279000230203       g_count = g_count + 1;
279100230328
279200230328          if waiver = 'Y';
279300230419           clear    OE_WAVR;
279400230419           WASSID = IN_OESSID;
279500230419           WANAME = %trim(wwname);
279600230328
279700230328       certOverFlow();
279800230328       BOLD01 = 'WAIVER';
279900230328       write BOLD;
280000230328       g_count = g_count + 1;
280100230328       write ULINE;
280200230328
280300230328       PLN001 = *blanks;
280400230328       PLN002 = *blanks;
280500230328       write PLANSR;
280600230328       g_count = g_count + 1;
280700230328
280800230328          E_LINE1 = getmessage('LINE040');
280900230328          write EMPLINE;
281000230328          E_LINE1 = getmessage('LINE041');
281100230328          write EMPLINE;
281200230328          E_LINE1 = getmessage('LINE042');
281300230328          write EMPLINE;
281400230328          E_LINE1 = getmessage('LINE043');
281500230328          write EMPLINE;
281600230328
281700230328       PLN001 = *blanks;
281800230328       PLN002 = *blanks;
281900230328       write PLANSR;
282000230328       g_count = g_count + 1;
282100230328
282200230328          endif;
282300230130
282400230419                 WASIGNUSR = %trim(wwname);
282500230130          If  %subst(oessid:16:1) = 'M';
282600230130           If  oesigf = 'Y';
282700230130               If  %trim(OEGRPV) = 'DECLINED';
282800230130                 wname = 'DECLINED';
282900230419                 WASIGNUSR = %trim(wname);
283000230130               Endif;
283100230130
283200230130          E_LINE1 = getmessage('LINE050');
283300230227          E_LINE1 = %ScanRpl( '@A' : %trim(wwname) : E_LINE1);
283400230130          E_LINE1 = %ScanRpl( '@B' : %char(pdate) : E_LINE1);
283500230420          write EMPLINE;
283600230420       g_count = g_count + 1;
283700230420
283800230420     C                   If        oesigd <> 0
283900230420     C                   Eval      pdate = #getusa(oesigd)
284000230420     C                   Else
284100230420     C                   Eval      wiso   = %Date
284200230420     C                   Eval      wtoday = #get80i(wiso)
284300230420     C                   Eval      pdate = #getusa(wtoday)
284400230420     C                   End
284500230419          WASIGNDAT = %char(pdate);
284600230419
284700230130          else;
284800230419
284900230419          WASIGNUSR = 'Preliminary Election Form Pending Electronic ' +
285000230419                      'Signature';
285100230419
285200230130          E_LINE1 = getmessage('LINE051');
285300230130          write EMPLINE;
285400230203       g_count = g_count + 1;
285500230130
285600230130          Endif;
285700230130          else;
285800230420
285900230420                 WASIGNUSR = *blanks;
286000230420                 WASIGNDAT = *blanks;
286100230420
286200230420
286300230130
286400230130          E_LINE1 = getmessage('LINE052');
286500230130          E_LINE1 = %ScanRpl( '@C' : '_________________________' : E_LINE1);
286600230130          E_LINE1 = %ScanRpl( '@D' : '__________ ' : E_LINE1);
286700230130          write EMPLINE;
286800230203       g_count = g_count + 1;
286900230130
287000230130       PLN001 = *blanks;
287100230130       PLN002 = *blanks;
287200230130       write PLANSR;
287300230203       g_count = g_count + 1;
287400230130
287500230130          E_LINE1 = getmessage('LINE053');
287600230130          E_LINE1 = %ScanRpl( '@E' : '_________________________' : E_LINE1);
287700230130          E_LINE1 = %ScanRpl( '@F' : '__________ ' : E_LINE1);
287800230130          write EMPLINE;
287900230203       g_count = g_count + 1;
288000230130
288100230130          Endif;
288200230419
288300230419          if waiver = 'Y';
288400230419            if WASSID <> *blanks;
288500230419              WADATE = %trim(curdattim);
288600230419              WASSN = %trim(wwssn);
288700230419              WATSA = %trim(wGBSTSA#);
288800230419              WATSANAM = %trim(acnam1);
288900231018F001      chain ( WASSID ) oeformwavp;
289000231018          If  not %found(oeformwavp);
289100230419            write OE_WAVR;
289200231018            endif;
289300230419            endif;
289400230419          endif;
289500230130
289600230130        If Overflow = 'Y';
289700230130
289800230130         PLN001 = *blanks;
289900230130         PLN002 = *blanks;
290000230130         write PLANSR;
290100230203       g_count = g_count + 1;
290200230203
290300230306         BOLD01 = 'ADDENDUM FOLLOWS';
290400230203         write BOLD;
290500230203       g_count = g_count + 1;
290600230307       write ULINE;
290700230130
290800230203       if g_count > 40;
290900230130           AddeOverFlow();
291000230203       else;
291100230203         PLN001 = *blanks;
291200230203         PLN002 = *blanks;
291300230203         write PLANSR;
291400230203       g_count = g_count + 1;
291500230203       endif;
291600230130
291700230306       BOLD01 = 'EMPLOYEE ELECTION FORM - ADDENDUM';
291800230130       write BOLD;
291900230203       g_count = g_count + 1;
292000230306       write ULINE;
292100230130
292200230131       PLN001 = %trim(wwname);
292300230131       PLN002 = getmessage('LINE002');
292400230131       PLN002 = %ScanRpl( '@B' : %trim(wwssn): PLN002);
292500230131       write PLANSR;
292600230203       g_count = g_count + 1;
292700230202
292800230202       PLN001 = %trim(addr1);
292900230202       PLN002 = getmessage('LINE003');
293000230202       PLN002 = %ScanRpl( '@C' : %trim(DOB_date): PLN002);
293100230202       write PLANSR;
293200230203       g_count = g_count + 1;
293300230202
293400230202       PLN001 = *blanks;
293500230202       PLN002 = *blanks;
293600230202
293700230202       if addr2 > '';
293800230202       PLN001 = %trim(addr2);
293900230202       PLN002 = getmessage('LINE004');
294000230202       PLN002 = %ScanRpl( '@D' : %trim(ENR_date): PLN002);
294100230202         write PLANSR;
294200230203       g_count = g_count + 1;
294300230202       endif;
294400230202
294500230202       wZip = %Editc(Zip: 'X' );
294600230202       Line01 = %Trim( City ) + ', '
294700230202         + %Trim( State ) + ' '
294800230202         + %Subst( wZip : 1 : 5 ) ;
294900230202
295000230202       if %Subst( wZip : 6 : 4) <>'0000' ;
295100230202         Line01 = %Trim( Line01) + '-' + %Subst( wZip : 6 : 4 ) ;
295200230202       EndIf;
295300230202
295400230202       PLN001 = %trim(Line01);
295500230202       if %trim(PLN002) = *blanks;
295600230202       PLN002 = getmessage('LINE004');
295700230202       PLN002 = %ScanRpl( '@D' : %trim(ENR_date): PLN002);
295800230202       else;
295900230202       PLN002 = *blanks;
296000230202       endif;
296100230202       write PLANSR;
296200230203       g_count = g_count + 1;
296300230202
296400230202       wline = '$' + %trim(%editc(salary:'J')) ;
296500230202       PLN001 = getmessage('LINE005');
296600230202       PLN001 = %ScanRpl( '@E' : %trim(wline): PLN001);
296700230202       PLN002 = getmessage('LINE006');
296800230202       PLN002 = %ScanRpl( '@F' : %trim(SAL_date): PLN002);
296900230202       write PLANSR;
297000230203       g_count = g_count + 1;
297100230202
297200230202       wline = *blanks;
297300230202       PLN001 = getmessage('LINE007');
297400230202       PLN001 = %ScanRpl( '@G' : %trim(wmarsts) : PLN001);
297500230202       PLN002 = getmessage('LINE008');
297600230202       PLN002 = %ScanRpl( '@H' : %trim(MAR_date): PLN002);
297700230202       write PLANSR;
297800230203       g_count = g_count + 1;
297900230202
298000230202       PLN001 = getmessage('LINE009');
298100230202       PLN001 = %ScanRpl( '@I' : %trim(sex): PLN001);
298200230202       PLN002 = getmessage('LINE012');
298300230202       PLN002 = %ScanRpl( '@L' : %trim(occupation) : PLN002);
298400230202       write PLANSR;
298500230203       g_count = g_count + 1;
298600230202
298700230202       PLN001 = getmessage('LINE010');
298800230202       PLN001 = %ScanRpl( '@J' : %trim(wphone): PLN001);
298900230202       PLN002 = getmessage('LINE011');
299000230202       PLN002 = %ScanRpl( '@K' : %Subst(Fill66:1:65) : PLN002);
299100230202       write PLANSR;
299200230203       g_count = g_count + 1;
299300230202
299400230202       PLN001 = getmessage('LINE105');
299500230202       PLN001 = %ScanRpl( '@J' : %trim(acnam1): PLN001);
299600230202       PLN002 = *blanks;
299700230202       write PLANSR;
299800230203       g_count = g_count + 1;
299900230130
300000230130       PLN001 = *blanks;
300100230130       PLN002 = *blanks;
300200230130       write PLANSR;
300300230203       g_count = g_count + 1;
300400230203
300500230203       if g_count > 40;
300600230203           AddeOverFlow();
300700230203       endif;
300800230130
300900230306       BOLD01 = 'PERSONNEL INFORMATION';
301000230130       write BOLD;
301100230203       g_count = g_count + 1;
301200230306       write ULINE;
301300230130
301400230131       PLN001 = getmessage('LINE068');
301500230131       PLN001 = %ScanRpl( '@A' : %trim(s_pyemp): PLN001);
301600230131       PLN002 = getmessage('LINE069');
301700230131       PLN002 = %ScanRpl( '@A' : %trim(s_pyclk): PLN002);
301800230131       write PLANSR;
301900230203       g_count = g_count + 1;
302000230130
302100230130
302200230130           PCTRST = OETRST;
302300230130           PCSUB# = OESUB#;
302400230130           PCACCT = OEACCT;
302500230130           PCDESC = *Blanks;
302600230130           PCGRPR = 'EMPSTAT';
302700230130           PCCODE = S_PYSTS;
302800230130     C     KEYCODE       Chain     WEBPAYCHP
302900230130     C                   If        not %found(WEBPAYCHP)
303000230130     C                   Eval      PCTRST = 0
303100230130     C                   Eval      PCSUB# = 0
303200230130     C                   Eval      PCACCT = 0
303300230130     C     KEYCODE       Chain     WEBPAYCHP
303400230130     C                   EndIf
303500230130
303600230131       PLN001 = getmessage('LINE073');
303700230131       PLN001 = %ScanRpl( '@A' : %trim(PCDESC): PLN001);
303800230130
303900230130           PCTRST = OETRST;
304000230130           PCSUB# = OESUB#;
304100230130           PCACCT = OEACCT;
304200230130           PCDESC = *Blanks;
304300230130           PCGRPR = 'PAYSTAT';
304400230130           PCCODE = S_PYPST;
304500230130     C     KEYCODE       Chain     WEBPAYCHP
304600230130     C                   If        not %found(WEBPAYCHP)
304700230130     C                   Eval      PCTRST = 0
304800230130     C                   Eval      PCSUB# = 0
304900230130     C                   Eval      PCACCT = 0
305000230130     C     KEYCODE       Chain     WEBPAYCHP
305100230130     C                   EndIf
305200230130
305300230131       PLN002 = getmessage('LINE074');
305400230131       PLN002 = %ScanRpl( '@A' : %trim(PCDESC): PLN002);
305500230131       write PLANSR;
305600230203       g_count = g_count + 1;
305700230130
305800230202       PLN001 = getmessage('LINE011');
305900230202       PLN001 = %ScanRpl( '@K' : %Subst(Fill66:1:65) : PLN001);
306000230202           PCTRST = OETRST;
306100230202           PCSUB# = OESUB#;
306200230202           PCACCT = OEACCT;
306300230202           PCDESC = *Blanks;
306400230202           PCGRPR = 'COSTCENTER';
306500230202           PCCODE = S_PYCCC;
306600230202     C     KEYCODE       Chain     WEBPAYCHP
306700230202     C                   If        not %found(WEBPAYCHP)
306800230202     C                   Eval      PCTRST = 0
306900230202     C                   Eval      PCSUB# = 0
307000230202     C                   Eval      PCACCT = 0
307100230202     C     KEYCODE       Chain     WEBPAYCHP
307200230202     C                   EndIf
307300230202       PLN002 = getmessage('LINE072');
307400230202       PLN002 = %ScanRpl( '@A' : %trim(PCDESC): PLN002);
307500230202       write PLANSR;
307600230203       g_count = g_count + 1;
307700230202
307800230202       PLN001 = getmessage('LINE077');
307900230202       PLN001 = %ScanRpl( '@J' : %trim(occupation) : PLN001);
308000230202       PLN002 = getmessage('LINE078');
308100230202       PLN002 = %ScanRpl( '@J' : %trim(ENR_Date) : PLN002);
308200230202       write PLANSR;
308300230203       g_count = g_count + 1;
308400230202
308500230202           PCTRST = OETRST;
308600230202           PCSUB# = OESUB#;
308700230202           PCACCT = OEACCT;
308800230202           PCDESC = *Blanks;
308900230202           PCGRPR = 'DIVISION';
309000230202           PCCODE = S_PYDIV;
309100230202     C     KEYCODE       Chain     WEBPAYCHP
309200230202     C                   If        not %found(WEBPAYCHP)
309300230202     C                   Eval      PCTRST = 0
309400230202     C                   Eval      PCSUB# = 0
309500230202     C                   Eval      PCACCT = 0
309600230202     C     KEYCODE       Chain     WEBPAYCHP
309700230202     C                   EndIf
309800230202       PLN001 = getmessage('LINE079');
309900230202       PLN001 = %ScanRpl( '@J' : %trim(PCDESC) : PLN001);
310000230202
310100230202           PCTRST = OETRST;
310200230202           PCSUB# = OESUB#;
310300230202           PCACCT = OEACCT;
310400230202           PCDESC = *Blanks;
310500230202           PCGRPR = 'EEOC';
310600230202           PCCODE = S_PYEEO;
310700230202     C     KEYCODE       Chain     WEBPAYCHP
310800230202     C                   If        not %found(WEBPAYCHP)
310900230202     C                   Eval      PCTRST = 0
311000230202     C                   Eval      PCSUB# = 0
311100230202     C                   Eval      PCACCT = 0
311200230202     C     KEYCODE       Chain     WEBPAYCHP
311300230202     C                   EndIf
311400230202       PLN002 = getmessage('LINE080');
311500230202       PLN002 = %ScanRpl( '@J' : %trim(PCDESC) : PLN002);
311600230202       write PLANSR;
311700230203       g_count = g_count + 1;
311800230202
311900230202           PCTRST = OETRST;
312000230202           PCSUB# = OESUB#;
312100230202           PCACCT = OEACCT;
312200230202           PCDESC = *Blanks;
312300230202           PCGRPR = 'DEPARTMENT';
312400230202           PCCODE = S_PYDPT;
312500230202     C     KEYCODE       Chain     WEBPAYCHP
312600230202     C                   If        not %found(WEBPAYCHP)
312700230202     C                   Eval      PCTRST = 0
312800230202     C                   Eval      PCSUB# = 0
312900230202     C                   Eval      PCACCT = 0
313000230202     C     KEYCODE       Chain     WEBPAYCHP
313100230202     C                   EndIf
313200230202       PLN001 = getmessage('LINE081');
313300230202       PLN001 = %ScanRpl( '@J' : %trim(PCDESC) : PLN001);
313400230202
313500230202           PCTRST = OETRST;
313600230202           PCSUB# = OESUB#;
313700230202           PCACCT = OEACCT;
313800230202           PCDESC = *Blanks;
313900230202           PCGRPR = 'LOCATION';
314000230202           PCCODE = S_PYLOC;
314100230202     C     KEYCODE       Chain     WEBPAYCHP
314200230202     C                   If        not %found(WEBPAYCHP)
314300230202     C                   Eval      PCTRST = 0
314400230202     C                   Eval      PCSUB# = 0
314500230202     C                   Eval      PCACCT = 0
314600230202     C     KEYCODE       Chain     WEBPAYCHP
314700230202     C                   EndIf
314800230202       PLN002 = getmessage('LINE082');
314900230202       PLN002 = %ScanRpl( '@J' : %trim(PCDESC) : PLN002);
315000230202       write PLANSR;
315100230203       g_count = g_count + 1;
315200230202
315300230130           PCTRST = OETRST;
315400230130           PCSUB# = OESUB#;
315500230130           PCACCT = OEACCT;
315600230130           PCDESC = *Blanks;
315700230130           PCGRPR = 'RULE';
315800230130           PCCODE = S_PYBPC;
315900230130     C     KEYCODE       Chain     WEBPAYCHP
316000230130     C                   If        not %found(WEBPAYCHP)
316100230130     C                   Eval      PCTRST = 0
316200230130     C                   Eval      PCSUB# = 0
316300230130     C                   Eval      PCACCT = 0
316400230130     C     KEYCODE       Chain     WEBPAYCHP
316500230130     C                   EndIf
316600230130
316700230131       PLN001 = getmessage('LINE070');
316800230131       PLN001 = %ScanRpl( '@A' : %trim(PCDESC): PLN001);
316900230202
317000230202           PCTRST = OETRST;
317100230202           PCSUB# = OESUB#;
317200230202           PCACCT = OEACCT;
317300230202           PCDESC = *Blanks;
317400230202           PCGRPR = 'OVERTIME';
317500230202           PCCODE = S_PYOTF;
317600230202     C     KEYCODE       Chain     WEBPAYCHP
317700230202     C                   If        not %found(WEBPAYCHP)
317800230202     C                   Eval      PCTRST = 0
317900230202     C                   Eval      PCSUB# = 0
318000230202     C                   Eval      PCACCT = 0
318100230202     C     KEYCODE       Chain     WEBPAYCHP
318200230202     C                   EndIf
318300230202       PLN002 = getmessage('LINE083');
318400230202       PLN002 = %ScanRpl( '@J' : %trim(PCDESC): PLN002);
318500230131       write PLANSR;
318600230203       g_count = g_count + 1;
318700230202
318800230202       PLN001 = getmessage('LINE085');
318900230202       PLN001 = %ScanRpl( '@J' : %char(PYRAT): PLN001);
319000230202       PLN002 = getmessage('LINE086');
319100230202       PLN002 = %ScanRpl( '@J' : %char(PYSAL): PLN002);
319200230202       write PLANSR;
319300230203       g_count = g_count + 1;
319400230202
319500230202       PLN001 = getmessage('LINE087');
319600230202       PLN001 = %ScanRpl( '@J' : %char(PYHRS): PLN001);
319700230202       PLN002 = getmessage('LINE088');
319800230202       PLN002 = %ScanRpl( '@J' : %char(PYANS): PLN002);
319900230202       write PLANSR;
320000230203       g_count = g_count + 1;
320100230210
320200230223     C                   eval      wiso   = #getiso(pysaldt)
320300230210     C                   eval      salchgdt = wiso
320400230202
320500230202       PLN001 = getmessage('LINE089');
320600230202       PLN001 = %ScanRpl( '@J' : %char(S_BONUS): PLN001);
320700230202       PLN002 = getmessage('LINE090');
320800230223       If %char(salchgdt) = '01/01/0001';
320900230223       PLN002 = %ScanRpl( '@J' : '  ' : PLN002);
321000230223       else;
321100230202       PLN002 = %ScanRpl( '@J' : %char(salchgdt): PLN002);
321200230223       endif;
321300230202       write PLANSR;
321400230203       g_count = g_count + 1;
321500230202
321600230202           PCTRST = OETRST;
321700230202           PCSUB# = OESUB#;
321800230202           PCACCT = OEACCT;
321900230202           PCDESC = *Blanks;
322000230202           PCGRPR = 'WORKCOMP';
322100230202           PCCODE = S_PYWCC;
322200230202     C     KEYCODE       Chain     WEBPAYCHP
322300230202     C                   If        not %found(WEBPAYCHP)
322400230202     C                   Eval      PCTRST = 0
322500230202     C                   Eval      PCSUB# = 0
322600230202     C                   Eval      PCACCT = 0
322700230202     C     KEYCODE       Chain     WEBPAYCHP
322800230202     C                   EndIf
322900230202       PLN001 = getmessage('LINE091');
323000230202       PLN001 = %ScanRpl( '@J' : %trim(PCDESC): PLN001);
323100230202       PLN002 = getmessage('LINE092');
323200230202       PLN002 = %ScanRpl( '@J' : %trim(s_pysui): PLN002);
323300230202       write PLANSR;
323400230203       g_count = g_count + 1;
323500230202
323600230202           PCTRST = OETRST;
323700230202           PCSUB# = OESUB#;
323800230202           PCACCT = OEACCT;
323900230202           PCDESC = *Blanks;
324000230202           PCGRPR = 'YN';
324100230202           PCCODE = S_PYRPE;
324200230202     C     KEYCODE       Chain     WEBPAYCHP
324300230202     C                   If        not %found(WEBPAYCHP)
324400230202     C                   Eval      PCTRST = 0
324500230202     C                   Eval      PCSUB# = 0
324600230202     C                   Eval      PCACCT = 0
324700230202     C     KEYCODE       Chain     WEBPAYCHP
324800230202     C                   EndIf
324900230202       PLN001 = getmessage('LINE093');
325000230202       PLN001 = %ScanRpl( '@J' : %char(PCDESC): PLN001);
325100230202
325200230202           PCTRST = OETRST;
325300230202           PCSUB# = OESUB#;
325400230202           PCACCT = OEACCT;
325500230202           PCDESC = *Blanks;
325600230202           PCGRPR = 'RACE';
325700230202           PCCODE = S_PYRAC;
325800230202     C     KEYCODE       Chain     WEBPAYCHP
325900230202     C                   If        not %found(WEBPAYCHP)
326000230202     C                   Eval      PCTRST = 0
326100230202     C                   Eval      PCSUB# = 0
326200230202     C                   Eval      PCACCT = 0
326300230202     C     KEYCODE       Chain     WEBPAYCHP
326400230202     C                   EndIf
326500230202       PLN002 = getmessage('LINE094');
326600230202       PLN002 = %ScanRpl( '@J' : %trim(PCDESC): PLN002);
326700230202       write PLANSR;
326800230203       g_count = g_count + 1;
326900230202
327000230202           PCTRST = OETRST;
327100230202           PCSUB# = OESUB#;
327200230202           PCACCT = OEACCT;
327300230202           PCDESC = *Blanks;
327400230202           PCGRPR = 'YN';
327500230202           PCCODE = S_PYSMK;
327600230202     C     KEYCODE       Chain     WEBPAYCHP
327700230202     C                   If        not %found(WEBPAYCHP)
327800230202     C                   Eval      PCTRST = 0
327900230202     C                   Eval      PCSUB# = 0
328000230202     C                   Eval      PCACCT = 0
328100230202     C     KEYCODE       Chain     WEBPAYCHP
328200230202     C                   EndIf
328300230202       PLN001 = getmessage('LINE095');
328400230202       PLN001 = %ScanRpl( '@J' : %char(PCDESC): PLN001);
328500230202       PLN002 = getmessage('LINE096');
328600230202       PLN002 = %ScanRpl( '@J' : %char(S_PYSTA): PLN002);
328700230202       write PLANSR;
328800230203       g_count = g_count + 1;
328900230202
329000230202           PCTRST = OETRST;
329100230202           PCSUB# = OESUB#;
329200230202           PCACCT = OEACCT;
329300230202           PCDESC = *Blanks;
329400230202           PCGRPR = 'MARSTAT2';
329500230202           PCCODE = S_PYMST;
329600230202     C     KEYCODE       Chain     WEBPAYCHP
329700230202     C                   If        not %found(WEBPAYCHP)
329800230202     C                   Eval      PCTRST = 0
329900230202     C                   Eval      PCSUB# = 0
330000230202     C                   Eval      PCACCT = 0
330100230202     C     KEYCODE       Chain     WEBPAYCHP
330200230202     C                   EndIf
330300230202       PLN001 = getmessage('LINE097');
330400230202       PLN001 = %ScanRpl( '@J' : %char(PCDESC): PLN001);
330500230202
330600230202           PCTRST = OETRST;
330700230202           PCSUB# = OESUB#;
330800230202           PCACCT = OEACCT;
330900230202           PCDESC = *Blanks;
331000230202           PCGRPR = 'EXEMPT';
331100230202           PCCODE = S_PYSEX;
331200230202     C     KEYCODE       Chain     WEBPAYCHP
331300230202     C                   If        not %found(WEBPAYCHP)
331400230202     C                   Eval      PCTRST = 0
331500230202     C                   Eval      PCSUB# = 0
331600230202     C                   Eval      PCACCT = 0
331700230202     C     KEYCODE       Chain     WEBPAYCHP
331800230202     C                   EndIf
331900230202       PLN002 = getmessage('LINE098');
332000230202       PLN002 = %ScanRpl( '@J' : %trim(PCDESC): PLN002);
332100230202       write PLANSR;
332200230203       g_count = g_count + 1;
332300230202
332400230202           PCTRST = OETRST;
332500230202           PCSUB# = OESUB#;
332600230202           PCACCT = OEACCT;
332700230202           PCDESC = *Blanks;
332800230202           PCGRPR = 'MARSTAT2';
332900230202           PCCODE = S_PYMST;
333000230202     C     KEYCODE       Chain     WEBPAYCHP
333100230202     C                   If        not %found(WEBPAYCHP)
333200230202     C                   Eval      PCTRST = 0
333300230202     C                   Eval      PCSUB# = 0
333400230202     C                   Eval      PCACCT = 0
333500230202     C     KEYCODE       Chain     WEBPAYCHP
333600230202     C                   EndIf
333700230202       PLN001 = getmessage('LINE099');
333800230202       PLN001 = %ScanRpl( '@J' : %char(PCDESC): PLN001);
333900230202
334000230202           PCTRST = OETRST;
334100230202           PCSUB# = OESUB#;
334200230202           PCACCT = OEACCT;
334300230202           PCDESC = *Blanks;
334400230202           PCGRPR = 'EXEMPT';
334500230202           PCCODE = S_PYFEX;
334600230202     C     KEYCODE       Chain     WEBPAYCHP
334700230202     C                   If        not %found(WEBPAYCHP)
334800230202     C                   Eval      PCTRST = 0
334900230202     C                   Eval      PCSUB# = 0
335000230202     C                   Eval      PCACCT = 0
335100230202     C     KEYCODE       Chain     WEBPAYCHP
335200230202     C                   EndIf
335300230202       PLN002 = getmessage('LINE100');
335400230202       PLN002 = %ScanRpl( '@J' : %trim(PCDESC): PLN002);
335500230202       write PLANSR;
335600230203       g_count = g_count + 1;
335700230202
335800230130
335900230131       PLN001 = *blanks;
336000230130       PLN002 = *blanks;
336100230130       write PLANSR;
336200230203       g_count = g_count + 1;
336300230203
336400230203       if g_count > 50;
336500230203           AddeOverFlow();
336600230203       endif;
336700230131
336800230131     C                   If        OverDepi = 'Y'   and
336900230131     C                             do# > 5
337000230203
337100230306       BOLD01 = 'DEPENDENT INFORMATION';
337200230203       write BOLD;
337300230203       g_count = g_count + 1;
337400230306       write ULINE;
337500230502
337600230502              ADSSID = IN_OESSID;
337700230502              ADDATE = %trim(curdattim);
337800230502              ADNAME = %trim(wwname);
337900230502              ADSSN  = %trim(wwssn);
338000230502              ADTSA  = %trim(wGBSTSA#);
338100230502              ADTSANAM = %trim(acnam1);
338200230511
338300230511              overAddr = ' ';
338400230511              ACSSID = IN_OESSID;
338500230511              ACDATE = %trim(curdattim);
338600230511              ACNAME = %trim(wwname);
338700230511              ACSSN  = %trim(wwssn);
338800230511              ACTSA  = %trim(wGBSTSA#);
338900230511              ACTSANAM = %trim(acnam1);
339000230203
339100230131     C     1             Do        20            oedseq
339200230131     C     oedseq        occur     webadepids
339300230131     C                   If        %trim(AUDFST) = *blanks
339400230131     C                   iter
339500230131     C                   Else
339600230131     C                   If        AUDSEQ = 0
339700230131     C                   iter
339800230131     C                   End
339900230131     C                   Eval      WebDep = #frmdep(oetrn#:oetrst:oesub#:
340000230131     C                                              oeacct:oessno:oedseq:'C')
340100230131
340200230131           wwssn2 = %editc(audssn : 'X') ;
340300230131           wwssn2  = %subst(wwssn2:1:3) +
340400230131                    '-' +
340500230131                    %subst(wwssn2:4:2) +
340600230131                    '-' +
340700230131                    %subst(wwssn2:6:4);
340800230131                if audssn = 0;
340900230131                wwssn2 = *blanks;
341000230131                endif;
341100230130
341200230502            select;
341300230502            when    ADTTL01 = *blanks;
341400230511              ADTTL01 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
341500230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
341600230502              ADSSN01 = %trim(wwssn2);
341700230502              ADDOB01 = %char(AUDBTH);
341800230502              ADGEN01 = %trim(AUDSEX);
341900230511              if  %trim(AUDFTS) = 'Y' and %trim(AUDSCH) <> *blanks;
342000230511              ADFTS01 = %trim(AUDFTS) + ' School: ' + %trim(AUDSCH);
342100230511              else;
342200230511              ADFTS01 = %trim(AUDFTS);
342300230511              endif;
342400230502              ADDIS01 = %trim(AUDDIS);
342500230502              ADPNA01 = %trim(AUDDOCMED);
342600230502              ADPNB01 = %trim(AUDPCPMED);
342700230502              ADEXI01 = %trim(AUDEXSMED);
342800230502              ADDEN01 = %trim(AUDPCPDEN);
342900230502
343000230502            when    ADTTL02 = *blanks;
343100230511              ADTTL02 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
343200230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
343300230502              ADSSN02 = %trim(wwssn2);
343400230502              ADDOB02 = %char(AUDBTH);
343500230502              ADGEN02 = %trim(AUDSEX);
343600230502              ADFTS02 = %trim(AUDFTS);
343700230511              if  %trim(AUDFTS) = 'Y' and %trim(AUDSCH) <> *blanks;
343800230511              ADFTS02 = %trim(AUDFTS) + ' School: ' + %trim(AUDSCH);
343900230511              else;
344000230511              ADFTS02 = %trim(AUDFTS);
344100230511              endif;
344200230502              ADDIS02 = %trim(AUDDIS);
344300230502              ADPNA02 = %trim(AUDDOCMED);
344400230502              ADPNB02 = %trim(AUDPCPMED);
344500230502              ADEXI02 = %trim(AUDEXSMED);
344600230502              ADDEN02 = %trim(AUDPCPDEN);
344700230502
344800230502            when    ADTTL03 = *blanks;
344900230511              ADTTL03 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
345000230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
345100230502              ADSSN03 = %trim(wwssn2);
345200230502              ADDOB03 = %char(AUDBTH);
345300230502              ADGEN03 = %trim(AUDSEX);
345400230511              if  %trim(AUDFTS) = 'Y' and %trim(AUDSCH) <> *blanks;
345500230511              ADFTS03 = %trim(AUDFTS) + ' School: ' + %trim(AUDSCH);
345600230511              else;
345700230511              ADFTS03 = %trim(AUDFTS);
345800230511              endif;
345900230502              ADDIS03 = %trim(AUDDIS);
346000230502              ADPNA03 = %trim(AUDDOCMED);
346100230502              ADPNB03 = %trim(AUDPCPMED);
346200230502              ADEXI03 = %trim(AUDEXSMED);
346300230502              ADDEN03 = %trim(AUDPCPDEN);
346400230502
346500230502            when    ADTTL04 = *blanks;
346600230511              ADTTL04 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
346700230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
346800230502              ADSSN04 = %trim(wwssn2);
346900230502              ADDOB04 = %char(AUDBTH);
347000230502              ADGEN04 = %trim(AUDSEX);
347100230511              if  %trim(AUDFTS) = 'Y' and %trim(AUDSCH) <> *blanks;
347200230511              ADFTS04 = %trim(AUDFTS) + ' School: ' + %trim(AUDSCH);
347300230511              else;
347400230511              ADFTS04 = %trim(AUDFTS);
347500230511              endif;
347600230502              ADDIS04 = %trim(AUDDIS);
347700230502              ADPNA04 = %trim(AUDDOCMED);
347800230502              ADPNB04 = %trim(AUDPCPMED);
347900230502              ADEXI04 = %trim(AUDEXSMED);
348000230502              ADDEN04 = %trim(AUDPCPDEN);
348100230502
348200230502            when    ADTTL05 = *blanks;
348300230511              ADTTL05 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
348400230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
348500230502              ADSSN05 = %trim(wwssn2);
348600230502              ADDOB05 = %char(AUDBTH);
348700230502              ADGEN05 = %trim(AUDSEX);
348800230511              if  %trim(AUDFTS) = 'Y' and %trim(AUDSCH) <> *blanks;
348900230511              ADFTS05 = %trim(AUDFTS) + ' School: ' + %trim(AUDSCH);
349000230511              else;
349100230511              ADFTS05 = %trim(AUDFTS);
349200230511              endif;
349300230502              ADDIS05 = %trim(AUDDIS);
349400230502              ADPNA05 = %trim(AUDDOCMED);
349500230502              ADPNB05 = %trim(AUDPCPMED);
349600230502              ADEXI05 = %trim(AUDEXSMED);
349700230502              ADDEN05 = %trim(AUDPCPDEN);
349800230502
349900230502            when    ADTTL06 = *blanks;
350000230511              ADTTL06 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
350100230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
350200230502              ADSSN06 = %trim(wwssn2);
350300230502              ADDOB06 = %char(AUDBTH);
350400230502              ADGEN06 = %trim(AUDSEX);
350500230511              if  %trim(AUDFTS) = 'Y' and %trim(AUDSCH) <> *blanks;
350600230511              ADFTS06 = %trim(AUDFTS) + ' School: ' + %trim(AUDSCH);
350700230511              else;
350800230511              ADFTS06 = %trim(AUDFTS);
350900230511              endif;
351000230502              ADDIS06 = %trim(AUDDIS);
351100230502              ADPNA06 = %trim(AUDDOCMED);
351200230502              ADPNB06 = %trim(AUDPCPMED);
351300230502              ADEXI06 = %trim(AUDEXSMED);
351400230502              ADDEN06 = %trim(AUDPCPDEN);
351500230502
351600230502            when    ADTTL07 = *blanks;
351700230511              ADTTL07 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
351800230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
351900230502              ADSSN07 = %trim(wwssn2);
352000230502              ADDOB07 = %char(AUDBTH);
352100230502              ADGEN07 = %trim(AUDSEX);
352200230511              if  %trim(AUDFTS) = 'Y' and %trim(AUDSCH) <> *blanks;
352300230511              ADFTS07 = %trim(AUDFTS) + ' School: ' + %trim(AUDSCH);
352400230511              else;
352500230511              ADFTS07 = %trim(AUDFTS);
352600230511              endif;
352700230502              ADDIS07 = %trim(AUDDIS);
352800230502              ADPNA07 = %trim(AUDDOCMED);
352900230502              ADPNB07 = %trim(AUDPCPMED);
353000230502              ADEXI07 = %trim(AUDEXSMED);
353100230502              ADDEN07 = %trim(AUDPCPDEN);
353200230502
353300230502            endsl;
353400230511
353500230515            If depadrchg(oedseq) <> 0;
353600230511            select;
353700230511            when    ACTTL01 = *blanks;
353800230511              ACTTL01 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
353900230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
354000230511              if  %trim(AUDAD1) <> *blanks;
354100230511              acad101 = %trim(AUDAD1);
354200230511              overAddr = 'Y';
354300230511              endif;
354400230511              if  %trim(AUDAD2) <> *blanks;
354500230511              acad201 = %trim(AUDAD2);
354600230511              overAddr = 'Y';
354700230511              endif;
354800230511              if  %trim(AUDCTY) <> *blanks;
354900230511              accty01 = %trim(AUDCTY);
355000230511              overAddr = 'Y';
355100230511              endif;
355200230511              if  %trim(AUDSTA) <> *blanks;
355300230511              acsta01 = %trim(AUDSTA);
355400230511              overAddr = 'Y';
355500230511              endif;
355600230511              if  %char(AUDZIP) <> *blanks;
355700230511              aczip01 = %char(AUDZIP);
355800230511              overAddr = 'Y';
355900230511              endif;
356000230511              if  %trim(AUDPHN) <> *blanks;
356100230511              acphn01 = %trim(AUDPHN);
356200230511              overAddr = 'Y';
356300230511              endif;
356400230511
356500230511            when    ACTTL02 = *blanks;
356600230511              ACTTL02 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
356700230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
356800230511              if  %trim(AUDAD1) <> *blanks;
356900230511              acad102 = %trim(AUDAD1);
357000230511              overAddr = 'Y';
357100230511              endif;
357200230511              if  %trim(AUDAD2) <> *blanks;
357300230511              acad202 = %trim(AUDAD2);
357400230511              overAddr = 'Y';
357500230511              endif;
357600230511              if  %trim(AUDCTY) <> *blanks;
357700230511              accty02 = %trim(AUDCTY);
357800230511              overAddr = 'Y';
357900230511              endif;
358000230511              if  %trim(AUDSTA) <> *blanks;
358100230511              acsta02 = %trim(AUDSTA);
358200230511              overAddr = 'Y';
358300230511              endif;
358400230511              if  %char(AUDZIP) <> *blanks;
358500230511              aczip02 = %char(AUDZIP);
358600230511              overAddr = 'Y';
358700230511              endif;
358800230511              if  %trim(AUDPHN) <> *blanks;
358900230511              acphn02 = %trim(AUDPHN);
359000230511              overAddr = 'Y';
359100230511              endif;
359200230511
359300230511            when    ACTTL03 = *blanks;
359400230511              ACTTL03 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
359500230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
359600230511              if  %trim(AUDAD1) <> *blanks;
359700230511              acad103 = %trim(AUDAD1);
359800230511              overAddr = 'Y';
359900230511              endif;
360000230511              if  %trim(AUDAD2) <> *blanks;
360100230511              acad203 = %trim(AUDAD2);
360200230511              overAddr = 'Y';
360300230511              endif;
360400230511              if  %trim(AUDCTY) <> *blanks;
360500230511              accty03 = %trim(AUDCTY);
360600230511              overAddr = 'Y';
360700230511              endif;
360800230511              if  %trim(AUDSTA) <> *blanks;
360900230511              acsta03 = %trim(AUDSTA);
361000230511              overAddr = 'Y';
361100230511              endif;
361200230511              if  %char(AUDZIP) <> *blanks;
361300230511              aczip03 = %char(AUDZIP);
361400230511              overAddr = 'Y';
361500230511              endif;
361600230511              if  %trim(AUDPHN) <> *blanks;
361700230511              acphn03 = %trim(AUDPHN);
361800230511              overAddr = 'Y';
361900230511              endif;
362000230511
362100230511            when    ACTTL04 = *blanks;
362200230511              ACTTL04 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
362300230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
362400230511              if  %trim(AUDAD1) <> *blanks;
362500230511              acad104 = %trim(AUDAD1);
362600230511              overAddr = 'Y';
362700230511              endif;
362800230511              if  %trim(AUDAD2) <> *blanks;
362900230511              acad204 = %trim(AUDAD2);
363000230511              overAddr = 'Y';
363100230511              endif;
363200230511              if  %trim(AUDCTY) <> *blanks;
363300230511              accty04 = %trim(AUDCTY);
363400230511              overAddr = 'Y';
363500230511              endif;
363600230511              if  %trim(AUDSTA) <> *blanks;
363700230511              acsta04 = %trim(AUDSTA);
363800230511              overAddr = 'Y';
363900230511              endif;
364000230511              if  %char(AUDZIP) <> *blanks;
364100230511              aczip04 = %char(AUDZIP);
364200230511              overAddr = 'Y';
364300230511              endif;
364400230511              if  %trim(AUDPHN) <> *blanks;
364500230511              acphn04 = %trim(AUDPHN);
364600230511              overAddr = 'Y';
364700230511              endif;
364800230511
364900230511            when    ACTTL05 = *blanks;
365000230511              ACTTL05 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
365100230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
365200230511              if  %trim(AUDAD1) <> *blanks;
365300230511              acad105 = %trim(AUDAD1);
365400230511              overAddr = 'Y';
365500230511              endif;
365600230511              if  %trim(AUDAD2) <> *blanks;
365700230511              acad205 = %trim(AUDAD2);
365800230511              overAddr = 'Y';
365900230511              endif;
366000230511              if  %trim(AUDCTY) <> *blanks;
366100230511              accty05 = %trim(AUDCTY);
366200230511              overAddr = 'Y';
366300230511              endif;
366400230511              if  %trim(AUDSTA) <> *blanks;
366500230511              acsta05 = %trim(AUDSTA);
366600230511              overAddr = 'Y';
366700230511              endif;
366800230511              if  %char(AUDZIP) <> *blanks;
366900230511              aczip05 = %char(AUDZIP);
367000230511              overAddr = 'Y';
367100230511              endif;
367200230511              if  %trim(AUDPHN) <> *blanks;
367300230511              acphn05 = %trim(AUDPHN);
367400230511              overAddr = 'Y';
367500230511              endif;
367600230511
367700230511            when    ACTTL06 = *blanks;
367800230511              ACTTL06 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
367900230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
368000230511              if  %trim(AUDAD1) <> *blanks;
368100230511              acad106 = %trim(AUDAD1);
368200230511              overAddr = 'Y';
368300230511              endif;
368400230511              if  %trim(AUDAD2) <> *blanks;
368500230511              acad206 = %trim(AUDAD2);
368600230511              overAddr = 'Y';
368700230511              endif;
368800230511              if  %trim(AUDCTY) <> *blanks;
368900230511              accty06 = %trim(AUDCTY);
369000230511              overAddr = 'Y';
369100230511              endif;
369200230511              if  %trim(AUDSTA) <> *blanks;
369300230511              acsta06 = %trim(AUDSTA);
369400230511              overAddr = 'Y';
369500230511              endif;
369600230511              if  %char(AUDZIP) <> *blanks;
369700230511              aczip06 = %char(AUDZIP);
369800230511              overAddr = 'Y';
369900230511              endif;
370000230511              if  %trim(AUDPHN) <> *blanks;
370100230511              acphn06 = %trim(AUDPHN);
370200230511              overAddr = 'Y';
370300230511              endif;
370400230511
370500230511            when    ACTTL07 = *blanks;
370600230511              ACTTL07 = %trim(DFNAME) + ' ' + %trim(DMI) + ' ' +
370700230511                        %trim(DLNAME) + '  (' + %char(AUDSEQ) + ')';
370800230511              if  %trim(AUDAD1) <> *blanks;
370900230511              acad107 = %trim(AUDAD1);
371000230511              overAddr = 'Y';
371100230511              endif;
371200230511              if  %trim(AUDAD2) <> *blanks;
371300230511              acad207 = %trim(AUDAD2);
371400230511              overAddr = 'Y';
371500230511              endif;
371600230511              if  %trim(AUDCTY) <> *blanks;
371700230511              accty07 = %trim(AUDCTY);
371800230511              overAddr = 'Y';
371900230511              endif;
372000230511              if  %trim(AUDSTA) <> *blanks;
372100230511              acsta07 = %trim(AUDSTA);
372200230511              overAddr = 'Y';
372300230511              endif;
372400230511              if  %char(AUDZIP) <> *blanks;
372500230511              aczip07 = %char(AUDZIP);
372600230511              overAddr = 'Y';
372700230511              endif;
372800230511              if  %trim(AUDPHN) <> *blanks;
372900230511              acphn07 = %trim(AUDPHN);
373000230511              overAddr = 'Y';
373100230511              endif;
373200230511
373300230511            endsl;
373400230515              endif;
373500230502
373600230131       PLN001 = %trim(DFNAME) + ' ' + %trim(DLNAME) + '  (' +
373700230131                %char(AUDSEQ) + ')';
373800230202       PLN002 = 'SSN:  ' + %trim(wwssn2);
373900230131       write PLANSR;
374000230203       g_count = g_count + 1;
374100230202
374200230202       PLN001 = getmessage('LINE102');
374300230202       PLN001 = %ScanRpl( '@J' : %trim(audrlt): PLN001);
374400230202       PLN002 = getmessage('LINE009');
374500230202       PLN002 = %ScanRpl( '@I' : %trim(audsex): PLN002);
374600230202       write PLANSR;
374700230203       g_count = g_count + 1;
374800230202
374900230202       if  %trim(audfts) = 'N';
375000230202       audsch = *blanks;
375100230202       endif;
375200230202
375300230202       PLN001 = getmessage('LINE106');
375400230202       PLN001 = %ScanRpl( '@J' : %trim(audsch): PLN001);
375500230202       PLN002 = getmessage('LINE107');
375600230202       PLN002 = %ScanRpl( '@J' : %trim(audfts): PLN002);
375700230202       write PLANSR;
375800230203       g_count = g_count + 1;
375900230131
376000230202     C                   If        %trim(AUDSPCMED) <> *blanks
376100230202       PLN001 = getmessage('LINE108');
376200230202       PLN001 = %ScanRpl( '@J' : %trim(audpcpMED): PLN001);
376300230202       PLN002 = getmessage('LINE109');
376400230202       PLN002 = %ScanRpl( '@J' : %trim(auddocMED): PLN002);
376500230202       write PLANSR;
376600230203       g_count = g_count + 1;
376700230202       PLN001 = getmessage('LINE110');
376800230202       PLN001 = %ScanRpl( '@J' : %trim(audexsMED): PLN001);
376900230202       PLN002 = getmessage('LINE111');
377000230202       PLN002 = %ScanRpl( '@J' : %char(audpefMED): PLN002);
377100230202       write PLANSR;
377200230203       g_count = g_count + 1;
377300230202       PLN001 = getmessage('LINE112');
377400230202       PLN001 = %ScanRpl( '@J' : %trim(audspcMED): PLN001);
377500230202       PLN002 = *blanks;
377600230202       write PLANSR;
377700230203       g_count = g_count + 1;
377800230202     C                   End
377900230202     C                   If        %trim(AUDSPCDEN) <> *blanks
378000230202       PLN001 = getmessage('LINE108');
378100230202       PLN001 = %ScanRpl( '@J' : %trim(audpcpDEN): PLN001);
378200230202       PLN002 = getmessage('LINE109');
378300230202       PLN002 = %ScanRpl( '@J' : %trim(auddocDEN): PLN002);
378400230202       write PLANSR;
378500230203       g_count = g_count + 1;
378600230202       PLN001 = getmessage('LINE110');
378700230202       PLN001 = %ScanRpl( '@J' : %trim(audexsDEN): PLN001);
378800230202       PLN002 = getmessage('LINE111');
378900230202       PLN002 = %ScanRpl( '@J' : %char(audpefDEN): PLN002);
379000230202       write PLANSR;
379100230203       g_count = g_count + 1;
379200230202       PLN001 = getmessage('LINE112');
379300230202       PLN001 = %ScanRpl( '@J' : %trim(audspcDEN): PLN001);
379400230202       PLN002 = *blanks;
379500230202       write PLANSR;
379600230203       g_count = g_count + 1;
379700230202     C                   End
379800230202
379900230202       PLN001 = *blanks;
380000230202       PLN002 = *blanks;
380100230202       write PLANSR;
380200230203       g_count = g_count + 1;
380300230131
380400230131     C                   End
380500230131     C                   Enddo
380600230502
380700230502       if   ADTTL01 <> *blanks;
380800231018F001      chain ( ADSSID ) oeformaddp;
380900231018          If  not %found(oeformaddp);
381000230502       write   OE_ADDR;
381100231018       Endif;
381200230502       Endif;
381300230511
381400230515       if   ACTTL01 <> *blanks;
381500231018F001      chain ( ACSSID ) oeformadcp;
381600231018          If  not %found(oeformadcp);
381700230511       write   OE_ADCR;
381800231018       Endif;
381900230511       Endif;
382000230502
382100230131     C                   End
382200230131
382300230130       PLN001 = *blanks;
382400230130       PLN002 = *blanks;
382500230130       write PLANSR;
382600230203       g_count = g_count + 1;
382700230203
382800230203       if g_count > 50;
382900230203           AddeOverFlow();
383000230203       endif;
383100230130
383200230130           If OverBen = 'Y' and bo# > 0 or ContFlg = 'Y' and bo# > 0;
383300230130              bo# = 0;
383400230130              benwrk = 0;
383500230130              bentot = 0;
383600230502
383700230502              ABSSID = IN_OESSID;
383800230502              ABDATE = %trim(curdattim);
383900230502              ABNAME = %trim(wwname);
384000230502              ABSSN  = %trim(wwssn);
384100230502              ABTSA  = %trim(wGBSTSA#);
384200230502              ABTSANAM = %trim(acnam1);
384300230202
384400230202           ContOverFlow();
384500230130
384600230306       BOLD01 = 'CONTINGENT BENEFICIARY INFORMATION';
384700230130       write BOLD;
384800230307       g_count = g_count + 1;
384900230306       write ULINE;
385000230130
385100230130            For x = 99 downto 1 by 1;
385200230130     C     x             occur     webabenids
385300230130           If  AUBPLN <> *blanks;
385400230515           If  AUBBEN <> Save_Name or
385500230515               AUBPLN <> Save_Plan;
385600230130
385700230502           select;
385800230502           when   ABTTL01 = *blanks;
385900230502           ABTTL01 = %trim(AUBBEN);
386000230502           ABREL01 = %trim(AUBRLT);
386100230502           ABPER01 = %trim(AUBPER);
386200230502           ABEFF01 = %char(AUBEFF);
386300230502           ABPLN01 = %trim(AUBPLN);
386400230502
386500230502           when   ABTTL02 = *blanks;
386600230502           ABTTL02 = %trim(AUBBEN);
386700230502           ABREL02 = %trim(AUBRLT);
386800230502           ABPER02 = %trim(AUBPER);
386900230502           ABEFF02 = %char(AUBEFF);
387000230502           ABPLN02 = %trim(AUBPLN);
387100230502
387200230502           when   ABTTL03 = *blanks;
387300230502           ABTTL03 = %trim(AUBBEN);
387400230502           ABREL03 = %trim(AUBRLT);
387500230502           ABPER03 = %trim(AUBPER);
387600230502           ABEFF03 = %char(AUBEFF);
387700230502           ABPLN03 = %trim(AUBPLN);
387800230502
387900230502           when   ABTTL04 = *blanks;
388000230502           ABTTL04 = %trim(AUBBEN);
388100230502           ABREL04 = %trim(AUBRLT);
388200230502           ABPER04 = %trim(AUBPER);
388300230502           ABEFF04 = %char(AUBEFF);
388400230502           ABPLN04 = %trim(AUBPLN);
388500230502
388600230502           when   ABTTL05 = *blanks;
388700230502           ABTTL05 = %trim(AUBBEN);
388800230502           ABREL05 = %trim(AUBRLT);
388900230502           ABPER05 = %trim(AUBPER);
389000230502           ABEFF05 = %char(AUBEFF);
389100230502           ABPLN05 = %trim(AUBPLN);
389200230502
389300230502           when   ABTTL06 = *blanks;
389400230502           ABTTL06 = %trim(AUBBEN);
389500230502           ABREL06 = %trim(AUBRLT);
389600230502           ABPER06 = %trim(AUBPER);
389700230502           ABEFF06 = %char(AUBEFF);
389800230502           ABPLN06 = %trim(AUBPLN);
389900230502
390000230502           when   ABTTL07 = *blanks;
390100230502           ABTTL07 = %trim(AUBBEN);
390200230502           ABREL07 = %trim(AUBRLT);
390300230502           ABPER07 = %trim(AUBPER);
390400230502           ABEFF07 = %char(AUBEFF);
390500230502           ABPLN07 = %trim(AUBPLN);
390600230502
390700230502           when   ABTTL08 = *blanks;
390800230502           ABTTL08 = %trim(AUBBEN);
390900230502           ABREL08 = %trim(AUBRLT);
391000230502           ABPER08 = %trim(AUBPER);
391100230502           ABEFF08 = %char(AUBEFF);
391200230502           ABPLN08 = %trim(AUBPLN);
391300230502
391400230502           when   ABTTL09 = *blanks;
391500230502           ABTTL09 = %trim(AUBBEN);
391600230502           ABREL09 = %trim(AUBRLT);
391700230502           ABPER09 = %trim(AUBPER);
391800230502           ABEFF09 = %char(AUBEFF);
391900230502           ABPLN09 = %trim(AUBPLN);
392000230502
392100230502           when   ABTTL10 = *blanks;
392200230502           ABTTL10 = %trim(AUBBEN);
392300230502           ABREL10 = %trim(AUBRLT);
392400230502           ABPER10 = %trim(AUBPER);
392500230502           ABEFF10 = %char(AUBEFF);
392600230502           ABPLN10 = %trim(AUBPLN);
392700230502
392800230502           when   ABTTL11 = *blanks;
392900230502           ABTTL11 = %trim(AUBBEN);
393000230502           ABREL11 = %trim(AUBRLT);
393100230502           ABPER11 = %trim(AUBPER);
393200230502           ABEFF11 = %char(AUBEFF);
393300230502           ABPLN11 = %trim(AUBPLN);
393400230502
393500230502           when   ABTTL12 = *blanks;
393600230502           ABTTL12 = %trim(AUBBEN);
393700230502           ABREL12 = %trim(AUBRLT);
393800230502           ABPER12 = %trim(AUBPER);
393900230502           ABEFF12 = %char(AUBEFF);
394000230502           ABPLN12 = %trim(AUBPLN);
394100230502
394200230502           when   ABTTL13 = *blanks;
394300230502           ABTTL13 = %trim(AUBBEN);
394400230502           ABREL13 = %trim(AUBRLT);
394500230502           ABPER13 = %trim(AUBPER);
394600230502           ABEFF13 = %char(AUBEFF);
394700230502           ABPLN13 = %trim(AUBPLN);
394800230502
394900230502           when   ABTTL14 = *blanks;
395000230502           ABTTL14 = %trim(AUBBEN);
395100230502           ABREL14 = %trim(AUBRLT);
395200230502           ABPER14 = %trim(AUBPER);
395300230502           ABEFF14 = %char(AUBEFF);
395400230502           ABPLN14 = %trim(AUBPLN);
395500230502
395600230502           endsl;
395700230502
395800230131       PLN001 = getmessage('LINE075');
395900230131       PLN001 = %ScanRpl( '@A' : %trim(aubpln): PLN001);
396000230131       PLN002 = getmessage('LINE076');
396100230131       PLN002 = %ScanRpl( '@A' : %trim(aubcov): PLN002);
396200230131       write PLANSR;
396300230203       g_count = g_count + 1;
396400230202
396500230202       PLN001 = getmessage('LINE101');
396600230202       PLN001 = %ScanRpl( '@J' : %trim(aubben): PLN001);
396700230202       PLN002 = getmessage('LINE102');
396800230202       PLN002 = %ScanRpl( '@J' : %trim(aubrlt): PLN002);
396900230202       write PLANSR;
397000230203       g_count = g_count + 1;
397100230202
397200230202       PLN001 = getmessage('LINE103');
397300230202       PLN001 = %ScanRpl( '@J' : %trim(aubper): PLN001);
397400230202       PLN002 = %trim(aubrlt);
397500230202       PLN002 = getmessage('LINE104');
397600230202       PLN002 = %ScanRpl( '@J' : %char(aubeff): PLN002);
397700230202       write PLANSR;
397800230203       g_count = g_count + 1;
397900230130
398000230512           Save_Plan = AUBPLN;
398100230512           Save_Name = AUBBEN;
398200230203
398300230203         PLN001 = *blanks;
398400230203         PLN002 = *blanks;
398500230203         write PLANSR;
398600230203       g_count = g_count + 1;
398700230130
398800230130           Endif;
398900230130           Endif;
399000230130
399100230130           Endfor;
399200230502
399300230502       if   ABTTL01 <> *blanks;
399400231018F001      chain ( ABSSID ) oeformadbp;
399500231018          If  not %found(oeformadbp);
399600230502       write   OE_ADBR;
399700231018       Endif;
399800230502       Endif;
399900230502
400000230130           Endif;
400100230130
400200230130       PLN001 = *blanks;
400300230130       PLN002 = *blanks;
400400230130       write PLANSR;
400500230203       g_count = g_count + 1;
400600230130
400700230130        Endif;
400800230130
400900230130
401000230130       PLN001 = *blanks;
401100230130       PLN002 = *blanks;
401200230130       write PLANSR;
401300230203       g_count = g_count + 1;
401400230130
401500230203       skip_cont = '';
401600230203       if g_count > 35;
401700230203       skip_cont = 'Y';
401800230203       NoteOverFlow();
401900230203       skip_cont = '';
402000230203       endif;
402100230130
402200230306       BOLD01 = 'NOTES';
402300230127       write BOLD;
402400230203       g_count = g_count + 1;
402500230306       write ULINE;
402600230127
402700230203           if  noteb(1) <> *blanks;
402800230203       PLN001 = *blanks;
402900230203       PLN002 = *blanks;
403000230203       write PLANSR;
403100230203       g_count = g_count + 1;
403200230203           Else;
403300230512       noteb(1) = 'Transaction Type: ' + %trim(svgroupvar);
403400230203       PLN001 = 'N/A';
403500230203       PLN002 = *blanks;
403600230203       write PLANSR;
403700230203       g_count = g_count + 1;
403800230203           EndIf;
403900230203
404000230407           no# = 0;
404100230407           clear    OE_NOTER;
404200230413           prtNotes_SSID = IN_OESSID;
404300230413           prtNotes_NODA = %trim(curdattim);
404400230413           prtNotes_NONA = %trim(wwname);
404500230413           prtNotes_NOSSN = %trim(wwssn);
404600230413           prtNotes_NOTSA = %trim(wGBSTSA#);
404700230413           prtNotes_NOACC = %trim(acnam1);
404800230407
404900230407           nn# = 1;
405000230127           Dow  noteb(nn#) <> *blanks;
405100230203       NoteOverFlow();
405200230203
405300230127           CO# = %scan('DECLINED':%trim(noteb(nn#)));
405400230127           If  CO# > 0;
405500230127           noteb(nn#) = 'No Action:' + %trim(noteb(nn#));
405600230203           CO# = %scan('Reason:':%trim(noteb(nn#)));
405700230203           If  CO# > 0;
405800230203           E_LINE1 = %subst(%trim(noteb(nn#)):1:co#-1);
405900230203           write EMPLINE;
406000230407
406100230407           no# = no# + 1;
406200230407           prtNotes_Array(no#) = %trim(E_LINE1);
406300230407
406400230203       g_count = g_count + 1;
406500230203           E_LINE1 = %subst(%trim(noteb(nn#)):co#);
406600230203           write EMPLINE;
406700230407
406800230407           no# = no# + 1;
406900230407           prtNotes_Array(no#) = %trim(E_LINE1);
407000230407
407100230203       g_count = g_count + 1;
407200230203           EndIf;
407300230203           Else;
407400230127
407500230127          E_LINE1 = %trim(noteb(nn#));
407600230127          write EMPLINE;
407700230203       g_count = g_count + 1;
407800230407
407900230407           no# = no# + 1;
408000230407           prtNotes_Array(no#) = %trim(E_LINE1);
408100230407
408200230203           EndIf;
408300230127
408400230130           nn# = nn#+1;
408500230130
408600230130           n_count = n_count+1;
408700230130           NoteOverFlow();
408800230127           Enddo;
408900230407
409000230512           if NOTE001 <> *blanks;
409100231018F001      chain ( NOSSID ) oeformnotp;
409200231018          If  not %found(oeformnotp);
409300230407           Write   OE_NOTER;
409400231018           endif;
409500230411           endif;
409600230127
409700230126       End-Proc;
409800230125       // ----------------------------------------------------------------
409900230228       dcl-proc PopulateForm;
410000230228
410100230228ja01 C     SESSKEY       klist
410200230228ja01 C                   kfld                    SVSESSNID
410300230228ja01 C                   kfld                    SVVARNAME
410400230228
410500230228                 in_oessid = %trim(in_ssid);
410600230228
410700230228ja01  * Do not send emails if internal GBS user
410800230228 |   C                   open      SESSNVARP
410900230228 |   C                   open      SESSNVARL2
411000230228 |   C     in_oessid     chain     SESSNVARL2
411100230228 |   C                   if        %found(SESSNVARL2)
411200230228     C                   eval      SVVARNAME = 'FORM_SSN'
411300230228 |   C     SESSKEY       chain     SESSNVARP
411400230228 |   C                   if        %found(SESSNVARP)
411500230228     C                   eval      in_oessno = %dec(%trim(SVVARVALUE):9:0)
411600230228 |   C                   end
411700230228     C                   eval      SVVARNAME = 'FORM_TRS'
411800230228 |   C     SESSKEY       chain     SESSNVARP
411900230228 |   C                   if        %found(SESSNVARP)
412000230228     C                   eval      in_oetrst = %dec(%trim(SVVARVALUE):3:0)
412100230228 |   C                   end
412200230228     C                   eval      SVVARNAME = 'FORM_SUB'
412300230228 |   C     SESSKEY       chain     SESSNVARP
412400230228 |   C                   if        %found(SESSNVARP)
412500230228     C                   eval      in_oesub# = %dec(%trim(SVVARVALUE):3:0)
412600230228 |   C                   end
412700230228     C                   eval      SVVARNAME = 'FORM_ACC'
412800230228 |   C     SESSKEY       chain     SESSNVARP
412900230228 |   C                   if        %found(SESSNVARP)
413000230228     C                   eval      in_oeacct = %dec(%trim(SVVARVALUE):4:0)
413100230228 |   C                   end
413200230228 |   C                   end
413300230228 |   C                   close     SESSNVARP
413400230228ja01 C                   close     SESSNVARL2
413500230228
413600230228                    GetActNam();
413700230228                    PopMemberForm();
413800230228                    PopTheForm();
413900230228                    PopDependForm();
414000230228                    PopPlanForm();
414100230228                    CarrierDiscl();
414200230228                    ResetTheForm();
414300230228                    Save_OESSID = In_OESSID;
414400230125
414500230228       End-Proc;
414600230228       // ----------------------------------------------------------------
414700230228       dcl-proc PopTheForm;
414800230228
414900230125     C     1             do        25            ps#
415000230125     C                   Eval      Pssid(ps#) = *blanks
415100230125     C                   Enddo
415200230125     C                   Eval      ps# = 0
415300230125     C                   eval      multssid = *blanks
415400230125     C     WebKeySet     Setll     webtranl4
415500230125     C     WebKeyReade   Reade     webtranl4
415600230125     C                   dow       not %eof(webtranl4)
415700230125     C                   If        oeprtd <> 0 and
415800230125     C                             In_Tool <> 'G' and
415900230125     C                             In_Tool <> 'E' and
416000230125     C                             In_Tool <> 'Y' and
416100230125bat1 C                             In_Batch <> 'Y'
416200230125     C                   Else
416300230125     C                   If        multid > 1
416400230125     C                   Eval      multssid = '*'
416500230125     C                   End
416600230125     C                   if        oedseq <> 0
416700230125     C                   eval      webcfs = #cchain(oessno:oedseq)
416800230125     C                   eval      len = %len(%trimr(CFSLST))
416900230125     C                   If        %trim(cfslst) <> *blanks  and len > 18
417000230125     C                   Eval      n# = n# + 1
417100230125     C                   Eval      NoteA(n#) = 'Longer Last Name: ' +
417200230125     C                                         %trim(CFSLST) + ' (' +
417300230125     C                                         %char(oedseq) + ')'
417400230125     C                   End
417500230125     C                   eval      len = %len(%trimr(CFSFST))
417600230125     C                   If        %trim(cfsfst) <> *blanks  and len > 12
417700230125     C                   Eval      n# = n# + 1
417800230125     C                   Eval      NoteA(n#) = 'Longer First Name: ' +
417900230125     C                                         %trim(CFSFST) + ' ('  +
418000230125     C                                         %char(oedseq) + ')'
418100230125     C                   End
418200230125     C     oedseq        occur     webadepids
418300230125     C                   Eval      WebDep = #frmdep(oetrn#:oetrst:oesub#:
418400230125     C                                              oeacct:oessno:oedseq:'C')
418500230125     C                   Eval      AUDLST = %trim(DLNAME)
418600230125     C                   Eval      AUDFST = %trim(DFNAME)
418700230125     C                   Eval      AUDMMI = %trim(DMI)
418800230125     C                   Eval      AUDSSN = DEPSS#
418900230125     C                   Eval      AUDSEQ = oedseq
419000230125     C                   Eval      AUDAD1 = %trim(DADDR1)
419100230125     C                   Eval      AUDAD2 = %trim(DADDR2)
419200230125     C                   Eval      AUDCTY = %trim(DCITY)
419300230125     C                   Eval      AUDSTA = %trim(DSTATE)
419400230125     C                   Eval      AUDZIP = DZIP
419500230125     C                   Eval      AUDPHN = #fmtphn(DAREA:DPHONE)
419600230125     C                   Eval      AUDRLT = #getrel(DRELCD)
419700230125     C                   Eval      AUDREL = %trim(DRELCD)
419800230125     C                   Eval      AUDBTH = #getusa(DBIRTH)
419900230125     C                   Eval      AUDSEX = DSEX
420000230125     C                   Eval      AUDDIS = DHNDCP
420100230125     C                   Eval      AUDFTS = DSTUDN
420200230125     C                   Eval      AUDSCH = %trim(FTSNAME)
420300230125     C                   Eval      AUDEFF = #getusa(FTSEFF)
420400230125     C                   End
420500230125     C     21            occur     webadepids
420600230125     C                   Eval      AUDLST = %trim(MLNAME)
420700230125     C                   Eval      AUDFST = %trim(MFNAME)
420800230125     C                   Eval      AUDMMI = %trim(MMI)
420900230125     C                   Eval      AUDSSN = MBSSNO
421000230125     C                   Eval      AUDSEQ = 21
421100230125     C                   Eval      AUDAD1 = %trim(ADDR1)
421200230125     C                   Eval      AUDAD2 = %trim(ADDR2)
421300230125     C                   Eval      AUDCTY = %trim(CITY)
421400230125     C                   Eval      AUDSTA = %trim(STATE)
421500230125     C                   Eval      AUDZIP = ZIP
421600230125     C                   Eval      AUDPHN = #fmtphn(AREA:PHONE)
421700230125     C                   Eval      AUDBTH = #getusa(BIRTH)
421800230125     C                   Eval      AUDSEX = SEX
421900230125     C                   Eval      AUDDIS = HNDICP
422000230512     C                   if        svgroupvar = *blanks
422100230512     C                   eval      svgroupvar = %trim(OEGRPV)
422200230512     C                   end
422300230125     C                   Select
422400230125     C                   When      %trim(OEGRPV) = 'ADD_EMP'
422500230126              ADD_EMP();
422600230125     C                   When      %trim(OEGRPV) = 'REI_EMP'
422700230126              REI_EMP();
422800230125     C                   When      %trim(OEGRPV) = 'TRM_EMP'
422900230126              TRM_EMP();
423000230125     C                   When      %trim(OEGRPV) = 'PER_INFO'
423100230126              PER_INFO();
423200230125     C                   When      %trim(OEGRPV) = 'EMP_INFO'
423300230126              EMP_INFO();
423400230125     C                   When      %trim(OEGRPV) = 'ADD_COVG'
423500230126              ADD_COVG();
423600230126              CHG_PCP();
423700230126              CHG_BEN();
423800230126              CHG_SAL();
423900230125     C                   When      %trim(OEGRPV) = 'UPD_BENE' and
424000230125     C                             %trim(OERETU) <> 'RETBENER'
424100230126              ADD_COVG();
424200230125     C                   When      %trim(OEGRPV) = 'TRM_COVG'
424300230126              TRM_COVG();
424400230125     C                   When      %trim(OEGRPV) = 'REI_COVG'
424500230126              REI_COVG();
424600230125     C                   When      %trim(OEGRPV) = 'COB_SUBS'
424700230126              COB_SUBS();
424800230125     C                   When      %trim(OEGRPV) = 'CHG_PCP'
424900230126              CHG_PCP();
425000230125     C                   When      %trim(OEGRPV) = 'CHG_BEN'
425100230126              CHG_BEN();
425200230125     C                   When      %trim(OEGRPV) = 'DEP_INFO'
425300230126              DEP_INFO();
425400230125     C                   When      %trim(OEGRPV) = 'ADD_DEPN'
425500230126              ADD_DEPN();
425600230125     C                   When      %trim(OEGRPV) = 'TRM_DEPN'
425700230126              TRM_DEPN();
425800230125     C                   When      %trim(OEGRPV) = 'REI_DEPN'
425900230126              REI_DEPN();
426000230125     C                   When      %trim(OEGRPV) = 'ADD_DEPC'
426100230126              ADD_DEPC();
426200230125     C                   When      %trim(OEGRPV) = 'TRM_DEPC'
426300230126              TRM_DEPC();
426400230125     C                   When      %trim(OEGRPV) = 'COB_DEPN'
426500230126              COB_DEPN();
426600230125     C                   When      %trim(OEGRPV) = 'KEEP'
426700230126              PRT_KEEP();
426800230125     C                   Endsl
426900230125     C                   Eval      s# = %lookup(%trim(OESSID):Pssid)
427000230125     C                   If        s# = 0
427100230125     C                   Eval      ps# = ps# + 1
427200230125     C                   Eval      Pssid(ps#) = %trim(OESSID)
427300230125     C                   End
427400230125     C                   if        oedseq <> 0
427500230125     C                   Eval      v# = %lookup(OEDSEQ:Save_OEDSEQ)
427600230125     C                   If        v# = 0
427700230125     C                   Eval      Save_OEDSEQ(oedseq) = OEDSEQ
427800230125     C                   Eval      do# = do# + 1
427900230125     C                   If        do# > 5
428000230125     C                   Eval      overflow = 'Y'
428100230125     C                   Eval      overdepi = 'Y'
428200230125     C                   End
428300230125     C                   End
428400230125     C                   End
428500230125     C                   End
428600230125     C     WebKeyReade   Reade     webtranl4
428700230125     C                   Enddo
428800230125     C                   Select
428900230125     C                   When      NoPrint = ' '
429000230125     C                   If        %trim(webuser) = *blanks
429100230125     C                   Eval      oeprtu = 'BATCH'
429200230125     C                   Else
429300230125     C                   eval      oeprtu = webuser
429400230125     C                   End
429500230901     C                   eval      out_print = #webprt(webtrn:pssid)
429600230125     C                   eval      oeprtd = out_prtd
429700230125     C                   Eval      oeprtt = out_prtt
429800230125     C                   When      NoPrint = 'R'
429900230125     C                   eval      oeemru = webuser
430000230125     C                   Callp     #webemr(webtrn:pssid:noprint)
430100230125     C                   Other
430200230125     C                   Endsl
430300230125
430400230126            Load_Add_Emp();
430500230126            Load_Add_Depn();
430600230127            SFLDCOV();
430700230127
430800230515      // Add Depn Address Changes
430900230515     C                   Do        e##           e#
431000230515     C                   If        depadrchg(e#) <> 0
431100230515     C                   If        %trim(OEGRPV) <> 'ADD_EMP'
431200230515     C                   Eval      n# = n# + 1
431300230515     C                   Eval      NoteA(n#) = 'Dependent Demograph Change: ' +
431400230515     C                                      '(' + %char(depadrchg(e#)) + ')'
431500230515     C                   End
431600230515     C                   End
431700230515     C                   Enddo
431800230127      // Remove Duplicate Notes
431900230127     C                   eval      b# = 1
432000230127     C                   Clear                   NoteB
432100230127     C     1             do        n#            d#
432200230127     C                   eval      dupnot = %lookup(NoteA(d#):NoteB)
432300230127     C                   If        dupnot = 0
432400230127     C                   Eval      NoteB(b#) = NoteA(d#)
432500230127     C                   Eval      b# = b# + 1
432600230127     C                   End
432700230127     C                   enddo
432800230127
432900230125       End-Proc;
433000230124       // ----------------------------------------------------------------
433100230124       dcl-proc ResetTheForm;
433200230124
433300230203                         a_count = 0;
433400230203                         c_count = 0;
433500230203                         g_count = 0;
433600230203                         n_count = 0;
433700230203                         p_count = 0;
433800230203                         Overflow = ' ';
433900230203                         Skip_cont = ' ';
434000230126     C                   eval      b# = 0
434100230126     C                   eval      n# = 0
434200230126     C                   eval      d# = 0
434300230126     C                   eval      e# = 0
434400230126     C                   eval      e## = 0
434500230126     C                   eval      c# = 0
434600230126     C                   eval      l# = 0
434700230126     C                   eval      zz# = 0
434800230126     C                   eval      cb# = 0
434900230126     C                   eval      hdr = 0
435000230126     C                   eval      cd# = 0
435100230126     C                   eval      cr# = 0
435200230126     C                   eval      page# = 0
435300230126     C                   eval      currentdep = 0
435400230126     C                   eval      multid = 0
435500230126     C                   eval      S_ANNUAL = 0
435600230126     C                   eval      S_BONUS = 0
435700230126     C                   Clear                   occupation
435800230126     C                   Clear                   CCFLG
435900230126     C                   Clear                   hrswrk
436000230126     C                   Clear                   med#usa
436100230126     C                   Clear                   den#usa
436200230126     C                   Clear                   vis#usa
436300230126     C                   Clear                   lif#usa
436400230126     C                   Clear                   ltd#usa
436500230126     C                   clear                   depadrchg
436600230126     C                   clear                   cardis
436700230126     C                   clear                   child
436800230126     C                   clear                   lplan
436900230126     C                   clear                   note
437000230126     C                   clear                   noteA
437100230126     C                   clear                   noteB
437200230126     C                   clear                   web2
437300230126     C                   clear                   web3
437400230126     C                   clear                   web4
437500230126     C                   clear                   web5
437600230126     C                   clear                   webpln
437700230126     C                   clear                   webplnds
437800230126     C                   Clear                   qbefore
437900230126     C                   Clear                   qafter
438000230126     C                   Clear                   DateText
438100230126     C                   Clear                   TermText
438200230512     C                   Clear                   BenTrmDt
438300230512     C                   Clear                   svgroupvar
438400230126     C                   Clear                   webmbr
438500230126     C     1             Do        21            do#
438600230126     C     do#           occur     webadepids
438700230126     C                   Clear                   webadepids
438800230126     C                   Enddo
438900230126     C     1             Do        99            do#
439000230126     C     do#           occur     webabenids
439100230126     C                   Clear                   webabenids
439200230126     C                   Enddo
439300230126     C     1             Do        99            do#
439400230126     C     do#           occur     webaplnids
439500230126     C                   Clear                   webaplnids
439600230126     C                   Enddo
439700230126     C     1             Do        99            do#
439800230126     C     do#           occur     webacobids
439900230126     C                   Clear                   webacobids
440000230126     C                   Enddo
440100230126     C                   Eval      do# = 0
440200230124
440300230124       End-Proc;
440400190904
440500190904       // ----------------------------------------------------------------
440600190904       dcl-proc GetMessage export;
440700190904
440800190904         dcl-pi *n char(125) ;
440900190904           inLine char(7) value ;
441000190904         end-pi ;
441100190904
441200190904
441300190904         QMHRTVM( RTVM0100 :%SIZE(RTVM0100):'RTVM0100'
441400190904           :inLIne
441500230124           :'PRTOLEMSG GBSPGM    ' :'' :0 :'*NO' :'*NO'
441600190904           : APIErrorCode );
441700190904
441800190904
441900190904         RtnMsg = %subst( RTVM0100.Buffer
442000190904           : 1
442100190904           : RTVM0100.RtnMsgLen);
442200190904
442300190904         Return RtnMsg;
442400190904
442500190904
442600190904       end-proc;
442700190904
442800190905       // ----------------------------------------------------------------
442900190905       dcl-proc GetHeader export;
443000190905
443100190905         dcl-pi *n char(125) ;
443200190905           inLine char(7) value ;
443300190905         end-pi ;
443400190905
443500190905
443600190905         QMHRTVM( RTVM0100 :%SIZE(RTVM0100):'RTVM0100'
443700190905           :inLIne
443800210407           :'AMWHEADER GBSPGM    ' :'' :0 :'*NO' :'*NO'
443900190905           : APIErrorCode );
444000190905
444100190905
444200190905         RtnMsg = %subst( RTVM0100.Buffer
444300190905           : 1
444400190905           : RTVM0100.RtnMsgLen);
444500190905
444600190905         Return RtnMsg;
444700190905
444800190905
444900190905       end-proc;
445000230126
445100230126       // ----------------------------------------------------------------
445200230126       dcl-proc WORK_LIVING;
445300230126     C                   Select
445400230425     C                   When      %subst(oefldv:1:4) = 'RULE'
445500230425     C                   Eval      n# = n# + 1
445600230425     C                   Eval      webcod = #webcod(oegrpv:oefldv)
445700230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
445800230425     C                             %trim(WCDESC) + ' : ' + %trim(oeafter)
445900230425
446000230425           PCTRST = OETRST;
446100230425           PCSUB# = OESUB#;
446200230425           PCACCT = OEACCT;
446300230425           PCDESC = *Blanks;
446400230425           PCGRPR = 'RULE';
446500230425           PCCODE = %trim(OEAFTER);
446600230425     C     KEYCODE       Chain     WEBPAYCHP
446700230425     C                   If        not %found(WEBPAYCHP)
446800230425     C                   Eval      PCTRST = 0
446900230425     C                   Eval      PCSUB# = 0
447000230425     C                   Eval      PCACCT = 0
447100230425     C     KEYCODE       Chain     WEBPAYCHP
447200230425     C                   EndIf
447300230425            if PCDESC <> *Blanks;
447400230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' : ' +
447500230425     C                             %trim(PCDESC)
447600230425            endif;
447700230425     C                   When      %subst(oefldv:1:5) = 'PYSMK'
447800230425     C                   Eval      n# = n# + 1
447900230425     C                   Eval      webcod = #webcod(oegrpv:oefldv)
448000230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
448100230425     C                             %trim(WCDESC) + ' : ' + %trim(oeafter)
448200230425     C                   When      %subst(oefldv:1:4) = 'RACE'
448300230425     C                   Eval      n# = n# + 1
448400230425     C                   Eval      webcod = #webcod(oegrpv:oefldv)
448500230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
448600230425     C                             %trim(WCDESC) + ' : ' + %trim(oeafter)
448700230425
448800230425           PCTRST = OETRST;
448900230425           PCSUB# = OESUB#;
449000230425           PCACCT = OEACCT;
449100230425           PCDESC = *Blanks;
449200230425           PCGRPR = 'RACE';
449300230425           PCCODE = %trim(OEAFTER);
449400230425     C     KEYCODE       Chain     WEBPAYCHP
449500230425     C                   If        not %found(WEBPAYCHP)
449600230425     C                   Eval      PCTRST = 0
449700230425     C                   Eval      PCSUB# = 0
449800230425     C                   Eval      PCACCT = 0
449900230425     C     KEYCODE       Chain     WEBPAYCHP
450000230425     C                   EndIf
450100230425            if PCDESC <> *Blanks;
450200230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' : ' +
450300230425     C                             %trim(PCDESC)
450400230425            endif;
450500230126     C                   When      %subst(oefldv:1:12) = 'HOURS_WORKED'  and
450600230126     C                             %trim(OEAFTER) <> '00000'
450700230126     C                   movel     OEAFTER       hrswrk
450800230126     C                   Eval      n# = n# + 1
450900230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
451000230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
451100230424     C                             %trim(WCDESC) + ' : ' + %editc(hrswrk:'J')
451200230126     C                   When      %subst(oefldv:1:10) = 'OCCUPATION'   and
451300230126     C                             %trim(OEAFTER) <> *blanks
451400230126     C                   movel     OEAFTER       GCJOBCCD
451500230126     C     occkey        klist
451600230126     C                   kfld                    oetrst
451700230126     C                   kfld                    oesub#
451800230126     C                   kfld                    oeacct
451900230126     C                   kfld                    GCJOBCCD
452000230126     C     occkey        Chain     GBSCLS
452100230126     C                   Eval      occupation = %trim(GCJOBCCD) + '/' +
452200230126     C                                          %trim(GCJCDESC)
452300230126     C                   Eval      n# = n# + 1
452400230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
452500230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
452600230424     C                             %trim(WCDESC) + ' : ' + %trim(occupation)
452700230126     C                   When      %subst(oefldv:1:10) = 'COSTCENTER'   and
452800230126     C                             %trim(OEAFTER) <> *blanks
452900230126     C                   Eval      PCGRPR = 'COSTCENTER'
453000230126     C                   Eval      PCCODE = %trim(OEAFTER)
453100230126     C                   Eval      PCTRST = OETRST
453200230126     C                   Eval      PCSUB# = OESUB#
453300230126     C                   Eval      PCACCT = OEACCT
453400230126     C                   Eval      PCDESC = *Blanks
453500230126     C     KEYCODE       Chain     WEBPAYCHP
453600230126     C                   If        not %found(WEBPAYCHP)
453700230126     C                   Eval      PCTRST = 0
453800230126     C                   Eval      PCSUB# = 0
453900230126     C                   Eval      PCACCT = 0
454000230126     C     KEYCODE       Chain     WEBPAYCHP
454100230126     C                   EndIf
454200230126     C                   Eval      n# = n# + 1
454300230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
454400230126     C                             'Cost Center: '+ %trim(OEAFTER) +
454500230126     C                             ': '+ %trim(PCDESC)
454600230126     C                   Endsl
454700230126     C                   If        %trim(occupation) = *blanks
454800230126     C                   Eval      GCJOBCCD = %trim(CCFLG)
454900230126     C     occkey        Chain     GBSCLS
455000230126     C                   Eval      occupation = %trim(GCJOBCCD) +  '/' +
455100230126     C                                          %trim(GCJCDESC)
455200230126     C                   End
455300230126
455400230126       end-proc;
455500230126
455600230126       dcl-proc OtherSR;
455700230126     C                   If        multid > 1
455800230126     C                   Eval      cossid = *blanks
455900230126     C                   Else
456000230126     C                   Eval      cossid = %trim(oessid)
456100230126     C                   End
456200230126     C                   Eval      cossid = *blanks
456300230126     C                   Eval      webcobd = #getcob(oetrst:oesub#:oeacct:
456400230126     C                                               oessno:0:cossid)
456500230126     C                   If        %trim(OTHERCOV) = 'Y'
456600230126     C                   Eval      b31yes = 'X'
456700230126     C                   Eval      b31no  = ' '
456800230126     C                   Else
456900230126     C                   Eval      b31yes = ' '
457000230126     C                   Eval      b31no  = 'X'
457100230126     C                   End
457200230126     C                   Select
457300230126     C                   When      %trim(WHOCOVR) = 'SELF'
457400230126     C                   Eval      b32slf = 'X'
457500230126     C                   Eval      b32sps = ' '
457600230126     C                   Eval      b32all = ' '
457700230126     C                   Eval      b32oth = ' '
457800230126     C                   When      %trim(WHOCOVR) = 'SPOUSE'
457900230126     C                   Eval      b32slf = ' '
458000230126     C                   Eval      b32sps = 'X'
458100230126     C                   Eval      b32all = ' '
458200230126     C                   Eval      b32oth = ' '
458300230126     C                   When      %trim(WHOCOVR) = 'ALL'
458400230126     C                   Eval      b32slf = ' '
458500230126     C                   Eval      b32sps = ' '
458600230126     C                   Eval      b32all = 'X'
458700230126     C                   Eval      b32oth = ' '
458800230126     C                   When      %trim(WHOCOVR) = 'OTHER'
458900230126     C                   Eval      b32slf = ' '
459000230126     C                   Eval      b32sps = ' '
459100230126     C                   Eval      b32all = ' '
459200230126     C                   Eval      b32oth = 'X'
459300230126     C                   Other
459400230126     C                   Eval      b32slf = ' '
459500230126     C                   Eval      b32sps = ' '
459600230126     C                   Eval      b32all = ' '
459700230126     C                   Eval      b32oth = ' '
459800230126     C                   Endsl
459900230126     C                   Eval      wiso   = %date
460000230126     C                   Eval      wtoday = #get80i(wiso)
460100230126     C                   Eval      pdate = #getusa(wtoday)
460200230126     C                   If        %char(OTHERTRM)  = '01/01/0001'  and
460300230126     C                             %char(OTHEREFF) <> '01/01/0001'  or
460400230126     C                             %char(OTHEREFF) <> '01/01/0001'  and
460500230126     C                                   OTHERTRM  >= pdate         or
460600230126     C                             b32slf <> ' ' or
460700230126     C                             b32sps <> ' ' or
460800230126     C                             b32all <> ' ' or
460900230126     C                             b32oth <> ' '
461000230126     C                   Eval      b33Yes = 'X'
461100230126     C                   Eval      b33no =  ' '
461200230126     C                   else
461300230126     C                   Eval      b33yes = ' '
461400230126     C                   Eval      b33no  = 'X'
461500230126     C                   end
461600230126     C                   Eval      B32PLY = %trim(POLYNAM)
461700230126     C                   Eval      B32PL# = %trim(POLYNBR)
461800230126     C                   Select
461900230126     C                   When      %trim(POLYTYP) = 'IND'
462000230126     C                   Eval      b33ind = 'X'
462100230126     C                   Eval      b33sem = ' '
462200230126     C                   When      %trim(POLYTYP) = 'SPOUSE'
462300230126     C                   Eval      b33ind = ' '
462400230126     C                   Eval      b33sem = 'X'
462500230126     C                   Other
462600230126     C                   Eval      b33ind = ' '
462700230126     C                   Eval      b33sem = ' '
462800230126     C                   Endsl
462900230126     C                   If        %trim(COBMEDF) = 'Y'
463000230126     C                   Eval      b34yes = 'X'
463100230126     C                   Eval      b34no  = ' '
463200230126     C                   Else
463300230126     C                   Eval      b34yes = ' '
463400230126     C                   Eval      b34no  = 'X'
463500230126     C                   End
463600230126     C                   Eval      B35YES = ' '
463700230126     C                   Eval      B35NO  = 'X'
463800230126     C     1             Do        cb#           x
463900230126     C     x             occur     webacobids
464000230126     C                   If        auzmed# <> *blanks
464100230126     C                   Eval      B35YES = 'X'
464200230126     C                   Eval      B35NO  = ' '
464300230126     C                   Leave
464400230126     C                   End
464500230126     C                   Enddo
464600230126     C     paykey        Klist
464700230126     C                   kfld                    oetrst
464800230126     C                   kfld                    oesub#
464900230126     C                   kfld                    oeacct
465000230126     C                   kfld                    oessno
465100230126     C     paykey        Chain     WebPayroll
465200230126     C                   If        %found(WebPayroll)
465300230126     C                   If        %trim(pybpc) = '0'
465400230126     C                   Eval      b41hed = 'PART-TIME INELIGIBLE'
465500230126     C                   End
465600230126     C                   End
465700230126
465800230126       end-proc;
465900230126
466000230126       dcl-proc ADD_EMP;
466100230126     C                   If        waiver = ' '
466200230126     C                   Eval      waiver = 'Y'
466300230126     C                   End
466400230126     C                   Select
466500230126     C                   When      %trim(OEFLDV) = 'HEADER'
466600230126     C                   Eval      n# = n# + 1
466700230126     C                   Eval      NoteA(n#) = 'EMPLOYEE ADD:'
466800230126     C                   Eval      oegrpv = *blanks
466900230126     C                   Eval      oefldv = *blanks
467000230126     C                   When      %trim(OEFLDV) = 'DEMOGRAPH_ONLY'
467100230126     C                   Eval      n# = n# + 1
467200230126     C                   Eval      NoteA(n#) = 'DEMOGRAPH_ONLY'
467300230126     C                   Other
467400230126     C                   If        oedseq = 0
467500230126          WORK_LIVING();
467600230126          TOOL_DEMO();
467700230126          COB_SUBS();
467800230126          ADD_COVG();
467900230126          CHG_PCP();
468000230126          CHG_BEN();
468100230126          CHG_SAL();
468200230126     C                   Else
468300230126          ADD_DEPN();
468400230126     C                   End
468500230126     C                   Endsl
468600230126       end-proc;
468700230126
468800230126       dcl-proc TRM_EMP;
468900230126     C                   Select
469000230126     C                   When      %subst(OEFLDV:1:6) = 'TERMDT'
469100240206trm9 C                   Movel     oebefore      w80date
469200230126     C                   Eval      wtrmdt  = #getusa(w80date)
469300240206     C                   Movel     oeafter       w80date
469400240206     C                   Movel     oeafter       BENTRMDT
469500240206     C                   Eval      wtrmdtb = #getusa(w80date)
469600240206     C                   When      %subst(OEFLDV:1:6) = 'TERMBD'
469700240206     C                   Movel     oeafter       w80date
469800240206     C                   Movel     oeafter       BENTRMDT
469900230126     C                   Eval      wtrmdtb = #getusa(w80date)
470000230126     C                   Eval      TermText = 'TRM_EMP'
470100230126     C                   When      %subst(OEFLDV:1:4) = 'ADDR'  or
470200230126     C                             %subst(OEFLDV:1:4) = 'CITY'  or
470300230126     C                             %subst(OEFLDV:1:5) = 'STATE' or
470400230126     C                             %subst(OEFLDV:1:3) = 'ZIP'
470500230126     C                   Eval      AdrChg = 'ADDRESS CHANGED'
470600230126     C                   When      %subst(OEFLDV:1:11) = 'TERM_REASON'
470700230126     C                   Eval      PCGRPR = 'TE_REASON'
470800230126     C                   Eval      PCCODE = %trim(OEAFTER)
470900230126     C                   Eval      PCTRST = oetrst
471000230126     C                   Eval      PCSUB# = oesub#
471100230126     C                   Eval      PCACCT = oeacct
471200230126     C                   Eval      Reason = *blanks
471300230126     C     KEYCODE       Chain     WEBPAYCHP
471400230126     C                   If        %found(WEBPAYCHP)
471500230126     C                   Eval      reason = %trim(PCDESC)
471600230126     C                   Else
471700230126     C                   Eval      PCTRST = 0
471800230126     C                   Eval      PCSUB# = 0
471900230126     C                   Eval      PCACCT = 0
472000230126     C     KEYCODE       Chain     WEBPAYCHP
472100230126     C                   If        %found(WEBPAYCHP)
472200230126     C                   Eval      reason = %trim(PCDESC)
472300230126     C                   End
472400230126     C                   End
472500230126     C                   Eval      REASON = %trim(reason) + '-' + %trim(OEAFTER)
472600230126     C                   When      %subst(OEFLDV:1:7) = 'TRM_EMP'
472700230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
472800230126     C                   Eval      n# = n# + 1
472900240206F004 C                   if        %trim(AdrChg) <> *blanks
473000240206 |   C                   Eval      NoteA(n#) = %trim(WCDESC) + ': ' +
473100240206 |   C                                         %trim(AdrChg) + ': ' +
473200240206 |   C                             'Employment Term Date: ' + %char(wtrmdt) +
473300240206 |   C                             ' Benefit Term Date: ' + %char(wtrmdtb) +
473400240206 |   C                             ' : ' + %trim(Reason)
473500240206 |   C                   else
473600240206 |   C                   Eval      NoteA(n#) = %trim(WCDESC) + ': ' +
473700240206 |   C                             'Employment Term Date: ' + %char(wtrmdt) +
473800240206 |   C                             ' Benefit Term Date: ' + %char(wtrmdtb) +
473900240206 |   C                             ' : ' + %trim(Reason)
474000240206F004 C                   end
474100230126           SFLCCOV();
474200230126     C                   Eval      t# = 1
474300230126     C                   If        plaq(t#) <> *blanks
474400230126     C                   Dow       plaq(t#) <> *blanks
474500230126     C                   If        plaq(t#) <> 'XXXX'
474600230126     C                   Eval      pldpln = %trim(plaq(t#))
474700230126     C                   Eval      pldctg = %trim(pcaq(t#))
474800230126     C                   Eval      plddsc = %trim(desq(t#))
474900230126     C                   Eval      pldeff = #get80i(effq(t#))
475000230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
475100230126     C                                               pldpln:pldeff)
475200230126     C                   eval      pldlvl = #trmclvl(oessno:0:oetrst:oesub#:
475300230126     C                                      oeacct:pldeff:pldpln:oessid)
475400230126     C                   If        %trim(pldlvl) = *blanks
475500230126     C                   Eval      pldlvl = #rtvclvl(oetrst:oesub#:oeacct:
475600230126     C                                               oessno:oessid:pldpln)
475700230126     C                   End
475800230126     C                   If        %trim(pldlvl) = *blanks
475900230126     C                   Eval      pldlvl = #getclvl(oetrst:oesub#:oeacct:
476000230126     C                                      oessno:pldpln:pldctg:pldeff)
476100230126     C                   End
476200230126             LoadPlans();
476300230126     C                   End
476400230126     C                   Eval      t# = t# + 1
476500230126     C                   Enddo
476600230126     C                   End
476700230126     C                   Endsl
476800230126       end-proc;
476900230126
477000230126       dcl-proc REI_EMP;
477100230126     C                   If        %subst(OEFLDV:1:11) = 'REINSTATE_REASON'
477200230126     C                   Eval      REASON = %trim(OEAFTER)
477300230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
477400230126     C                   Eval      n# = n# + 1
477500230424     C                   Eval      NoteA(n#) = %trim(WCDESC) + ' : ' +
477600230126     C                             %trim(Reason)
477700230126     C                   End
477800230126       end-proc;
477900230126
478000230126       dcl-proc PER_INFO;
478100230126     C                   Eval      OverFlow = 'Y'
478200230126     C                   If        d# = 0
478300230126     C                   Eval      d# = 1
478400230126     C                   End
478500230126     C                   Select
478600230126     C                   When      %trim(OEBEFORE) <> %trim(OEAFTER)  and
478700230126     C                             %trim(OEAFTER) <> '00000'
478800230126     C                   Eval      n# = n# + 1
478900230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
479000230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
479100230424     C                             %trim(WCDESC) + ' : ' + %trim(OEAFTER)
479200230126     C                   Endsl
479300230126          Work_Living();
479400230126       end-proc;
479500230126
479600230126       dcl-proc EMP_INFO;
479700230126     C                   Eval      PayInfo = 'Y'
479800230126     C                   Eval      OverFlow = 'Y'
479900230126     C                   Select
480000230126     C                   When      %trim(oefldv) = 'PYEMP'
480100230126     C                   Eval      S_PYEMP = %trim(OEAFTER)
480200230126     C                   When      %trim(oefldv) = 'PYCLK'
480300230126     C                   Eval      S_PYCLK = %trim(OEAFTER)
480400230126     C                   When      %trim(oefldv) = 'PYSTS'
480500230126     C                   Eval      S_PYSTS = %trim(OEAFTER)
480600230126     C                   When      %trim(oefldv) = 'PYPST'
480700230126     C                   Eval      S_PYPST = %trim(OEAFTER)
480800230126     C                   When      %trim(oefldv) = 'PYOCC'
480900230126     C                   Eval      S_PYOCC = %trim(OEAFTER)
481000230126     C                   When      %trim(oefldv) = 'PYHDT'
481100230126     C                   Movel     OEAFTER       S_PYHDT
481200230126     C                   eval      wiso   = #getiso(S_pyhdt)
481300230126     C                   eval      wempdt = wiso
481400230126     C                   Eval      n# = n# + 1
481500230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
481600230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
481700230425     C                             %trim(WCDESC) + ' : ' + %char(wempdt)
481800230126     C                   When      %trim(oefldv) = 'PYDIV'
481900230126     C                   Eval      S_PYDIV = %trim(OEAFTER)
482000230126     C                   When      %trim(oefldv) = 'PYEEO'
482100230126     C                   Eval      S_PYEEO = %trim(OEAFTER)
482200230126     C                   When      %trim(oefldv) = 'PYDPT'
482300230126     C                   Eval      S_PYDPT = %trim(OEAFTER)
482400230126     C                   Eval      n# = n# + 1
482500230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
482600230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
482700230126     C                                         %trim(WCDESC) + ' changed'
482800230126     C                   When      %trim(oefldv) = 'PYLOC'
482900230126     C                   Eval      S_PYLOC = %trim(OEAFTER)
483000230126     C                   When      %trim(oefldv) = 'PYOTF'
483100230126     C                   Eval      S_PYOTF = %trim(OEAFTER)
483200230126     C                   When      %trim(oefldv) = 'PYCCC'
483300230126     C                   Eval      S_PYCCC = %trim(OEAFTER)
483400240315     C                   if        %trim(OEBEFORE) <> %trim(OEAFTER)
483500240315     C                   Eval      webcod = #webcod(oegrpv:oefldv)
483600240315     C                   Eval      n# = n# + 1
483700240315     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
483800240315     C                             %trim(WCDESC) + ' changed from: ' +
483900240315     C                                         %trim(OEBEFORE) + ' to: ' +
484000240315     C                                         %trim(OEAFTER)
484100240315     C                   end
484200230126     C                   When      %trim(oefldv) = 'PYBPC'
484300230126     C                   Eval      S_PYBPC = %trim(OEAFTER)
484400230126     C                   Eval      n# = n# + 1
484500230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
484600230518     C                   If        %trim(OEBEFORE) = *blanks
484700230518     C                   if        %trim(OEAFTER) <> *blanks
484800230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
484900230424     C                             %trim(WCDESC) + ' : ' +
485000230126     C                                         %trim(OEAFTER)
485100230425
485200230425           PCTRST = OETRST;
485300230425           PCSUB# = OESUB#;
485400230425           PCACCT = OEACCT;
485500230425           PCDESC = *Blanks;
485600230425           PCGRPR = 'RULE';
485700230425           PCCODE = %trim(OEAFTER);
485800230425     C     KEYCODE       Chain     WEBPAYCHP
485900230425     C                   If        not %found(WEBPAYCHP)
486000230425     C                   Eval      PCTRST = 0
486100230425     C                   Eval      PCSUB# = 0
486200230425     C                   Eval      PCACCT = 0
486300230425     C     KEYCODE       Chain     WEBPAYCHP
486400230425     C                   EndIf
486500230425            if PCDESC <> *Blanks;
486600230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' : ' +
486700230425     C                             %trim(PCDESC)
486800230425            endif;
486900230518     C                   End
487000230126     C                   Else
487100230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
487200230126     C                             %trim(WCDESC) + ' changed from: ' +
487300230126     C                                         %trim(OEBEFORE) + ' to: ' +
487400230126     C                                         %trim(OEAFTER)
487500230518     C                   End
487600230126     C                   When      %trim(oefldv) = 'PYRAT'
487700230126     C                   Movel     OEAFTER       S_PYRAT
487800230126     C                   When      %trim(oefldv) = 'PYHRS'
487900230126     C                   Movel     OEAFTER       S_PYHRS
488000230126     C                   When      %trim(oefldv) = 'PYSAL'
488100230126     C                   Movel     OEAFTER       S_PYSAL
488200230126     C                   When      %trim(oefldv) = 'ANNUAL_SALARY'
488300230425     C                   Movel     OEAFTER       S_ANNUAL
488400230425                   FOSALARY = '$' + %trim(%editc(S_ANNUAL:'J')) ;
488500230425     C                   if        %trim(OEAFTER) = '0000000000'
488600230425     C                   eval      oeafter = *blanks
488700230425     C                   end
488800230126     C                   Eval      n# = n# + 1
488900230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
489000230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
489100230425     C                             %trim(WCDESC) + ' : ' + %trim(FOSALARY)
489200230126     C                   When      %trim(oefldv) = 'COMMISSION_BONUS'
489300230126     C                   Eval      n# = n# + 1
489400230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
489500230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
489600230424     C                             %trim(WCDESC) + ' : ' + %trim(OEAFTER)
489700230126     C                   Movel     OEAFTER       S_BONUS
489800230126     C                   When      %trim(oefldv) = 'PYSALDT'
489900230425     C                   Movel     OEAFTER       S_PYSALDT
490000230425     C                   eval      wiso   = #getiso(S_pySALDT)
490100230425     C                   eval      salchgdt = wiso
490200230425     C                   Eval      n# = n# + 1
490300230425     C                   Eval      webcod = #webcod(oegrpv:oefldv)
490400230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
490500230425     C                             %trim(WCDESC) + ' : ' + %char(salchgdt)
490600230126     C                   When      %trim(oefldv) = 'PYSTA'
490700230126     C                   Eval      S_PYSTA = %trim(OEAFTER)
490800230126     C                   When      %trim(oefldv) = 'PYMST'
490900230126     C                   Eval      S_PYMST = %trim(OEAFTER)
491000230126     C                   When      %trim(oefldv) = 'PYSEX'
491100230126     C                   Eval      S_PYSEX = %trim(OEAFTER)
491200230126     C                   When      %trim(oefldv) = 'PYMSTF'
491300230126     C                   Eval      S_PYMSTF = %trim(OEAFTER)
491400230126     C                   When      %trim(oefldv) = 'PYFEX'
491500230126     C                   Eval      S_PYFEX = %trim(OEAFTER)
491600230126     C                   When      %trim(oefldv) = 'PYCNTY'
491700230126     C                   Eval      S_PYCNTY = %trim(OEAFTER)
491800230126     C                   When      %trim(oefldv) = 'PYWCC'
491900230126     C                   Eval      S_PYWCC = %trim(OEAFTER)
492000230126     C                   When      %trim(oefldv) = 'PYWST'
492100230126     C                   Eval      S_PYWST = %trim(OEAFTER)
492200230126     C                   When      %trim(oefldv) = 'PYSUI'
492300230126     C                   Eval      S_PYSUI = %trim(OEAFTER)
492400230126     C                   When      %trim(oefldv) = 'PYRPE'
492500230126     C                   Eval      S_PYRPE = %trim(OEAFTER)
492600230126     C                   When      %trim(oefldv) = 'PYRAC'
492700230126     C                   Eval      S_PYRAC = %trim(OEAFTER)
492800230126     C                   When      %trim(oefldv) = 'PYSMK'
492900230126     C                   Eval      S_PYSMK = %trim(OEAFTER)
493000230126     C                   When      %trim(oefldv) = 'PYFEDE'
493100230126     C                   Eval      S_PYFEDE = %trim(OEAFTER)
493200230126     C                   If        %trim(oebefore) <> %trim(oeafter)
493300230126     C                   eval      EXTAX = 'Y'
493400230126     C                   Eval      n# = n# + 1
493500230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
493600230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
493700230126     C                             %trim(WCDESC) + ' changed from: ' +
493800230126     C                                         %trim(OEBEFORE) + ' to: ' +
493900230126     C                                         %trim(OEAFTER)
494000230126     C                   End
494100230126     C                   When      %trim(oefldv) = 'PYSTAE'
494200230126     C                   Eval      S_PYSTAE = %trim(OEAFTER)
494300230126     C                   If        %trim(oebefore) <> %trim(oeafter)
494400230126     C                   eval      EXTAX = 'Y'
494500230126     C                   Eval      n# = n# + 1
494600230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
494700230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
494800230126     C                             %trim(WCDESC) + ' changed from: ' +
494900230126     C                                         %trim(OEBEFORE) + ' to: ' +
495000230126     C                                         %trim(OEAFTER)
495100230126     C                   End
495200230126     C                   When      %trim(oefldv) = 'PYLOCE'
495300230126     C                   Eval      S_PYLOCE = %trim(OEAFTER)
495400230126     C                   If        %trim(oebefore) <> %trim(oeafter)
495500230126     C                   eval      EXTAX = 'Y'
495600230126     C                   Eval      n# = n# + 1
495700230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
495800230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
495900230126     C                             %trim(WCDESC) + ' changed from: ' +
496000230126     C                                         %trim(OEBEFORE) + ' to: ' +
496100230126     C                                         %trim(OEAFTER)
496200230126     C                   End
496300230126     C                   When      %trim(oefldv) = 'PYMEDE'
496400230126     C                   Eval      S_PYMEDE = %trim(OEAFTER)
496500230126     C                   If        %trim(oebefore) <> %trim(oeafter)
496600230126     C                   eval      EXTAX = 'Y'
496700230126     C                   Eval      n# = n# + 1
496800230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
496900230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
497000230126     C                             %trim(WCDESC) + ' changed from: ' +
497100230126     C                                         %trim(OEBEFORE) + ' to: ' +
497200230126     C                                         %trim(OEAFTER)
497300230126     C                   End
497400230126     C                   When      %trim(oefldv) = 'PYFICE'
497500230126     C                   Eval      S_PYFICE = %trim(OEAFTER)
497600230126     C                   If        %trim(oebefore) <> %trim(oeafter)
497700230126     C                   eval      EXTAX = 'Y'
497800230126     C                   Eval      n# = n# + 1
497900230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
498000230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
498100230126     C                             %trim(WCDESC) + ' changed from: ' +
498200230126     C                                         %trim(OEBEFORE) + ' to: ' +
498300230126     C                                         %trim(OEAFTER)
498400230126     C                   End
498500230126     C                   When      %trim(oefldv) = 'PYCUNE'
498600230126     C                   Eval      S_PYCUNE = %trim(OEAFTER)
498700230126     C                   If        %trim(oebefore) <> %trim(oeafter)
498800230126     C                   eval      EXTAX = 'Y'
498900230126     C                   Eval      n# = n# + 1
499000230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
499100230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
499200230126     C                             %trim(WCDESC) + ' changed from: ' +
499300230126     C                                         %trim(OEBEFORE) + ' to: ' +
499400230126     C                                         %trim(OEAFTER)
499500230126     C                   End
499600230126     C                   When      %trim(oefldv) = 'PYFUTE'
499700230126     C                   Eval      S_PYFUTE = %trim(OEAFTER)
499800230126     C                   If        %trim(oebefore) <> %trim(oeafter)
499900230126     C                   eval      EXTAX = 'Y'
500000230126     C                   Eval      n# = n# + 1
500100230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
500200230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
500300230126     C                             %trim(WCDESC) + ' changed from: ' +
500400230126     C                                         %trim(OEBEFORE) + ' to: ' +
500500230126     C                                         %trim(OEAFTER)
500600230126     C                   End
500700230126     C                   When      %trim(oefldv) = 'PYCDTE'
500800230126     C                   Eval      S_PYCDTE = %trim(OEAFTER)
500900230126     C                   If        %trim(oebefore) <> %trim(oeafter)
501000230126     C                   eval      EXTAX = 'Y'
501100230126     C                   Eval      n# = n# + 1
501200230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
501300230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' ' +
501400230126     C                             %trim(WCDESC) + ' changed from: ' +
501500230126     C                                         %trim(OEBEFORE) + ' to: ' +
501600230126     C                                         %trim(OEAFTER)
501700230126     C                   End
501800230126     C                   Endsl
501900230126       end-proc;
502000230126
502100230126       dcl-proc ADD_COVG;
502200230126     C                   Select
502300230126     C                   When      %subst(OEFLDV:1:5)  = 'EFFDT' or
502400230126     C                             %subst(OEFLDV:1:5)  = 'EFFD_' or
502500230126     C                             %subst(OEFLDV:1:10) = 'PCPPLANEFF'
502600230126     C                   Movel     oeafter       pldeff
502700230126     C                   Movel     oeafter       w80date
502800230126     C                   Eval      flipdt  = #getusa(w80date)
502900230126     C                   Eval      DateText = 'Eff Date: '
503000230126     C                   When      %subst(OEFLDV:1:4) = 'PLAN'   or
503100230126     C                             %subst(OEFLDV:1:8) = 'PCPPLAN'+ %char(OEDSEQ)
503200230126     C                   Eval      pldpln = %trim(OEAFTER)
503300230126     C                   When      %subst(OEFLDV:1:4) = 'PCAT'   or
503400230126     C                             %subst(OEFLDV:1:10) = 'PCPPLANCAT'
503500230126     C                   Eval      pldctg = %trim(OEAFTER)
503600230126     C                   When      %subst(OEFLDV:1:6) = 'AMOUNT'  and
503700230126     C                             %trim(OEGRPV) = 'UPD_BENE'
503800230126     C                   movel     oebefore      savamount
503900230126     C                   If        savamount <> 0
504000230126     C                   Eval      svbeforeD = '$'+ %trim(%editc(savamount:'P'))
504100230126     C                   Else
504200230126     C                   Eval      svbeforeD = *blanks
504300230126     C                   End
504400230126     C                   movel     oeafter       savamount
504500230126     C                   If        savamount <> 0
504600230126     C                   Eval      svafterD =  '$'+ %trim(%editc(savamount:'P'))
504700230126     C                   Else
504800230126     C                   Eval      svafterD = *blanks
504900230126     C                   End
505000230126     C                   When      %subst(OEFLDV:1:6) = 'ANNUAL'  and
505100230126     C                             %trim(OEGRPV) = 'UPD_BENE'
505200230126     C                   movel     oebefore      savamount
505300230126     C                   If        savamount <> 0
505400230126     C                   Eval      svbefore =  '$'+ %trim(%editc(savamount:'P'))
505500230126     C                   Else
505600230126     C                   Eval      svbefore = *blanks
505700230126     C                   End
505800230126     C                   movel     oeafter       savamount
505900230126     C                   If        savamount <> 0
506000230126     C                   Eval      svafter  =  '$'+ %trim(%editc(savamount:'P'))
506100230126     C                   Else
506200230126     C                   Eval      svafter = *blanks
506300230126     C                   End
506400230126     C                   When      %subst(OEFLDV:1:7) = 'PERCENT' and
506500230126     C                             %trim(OEGRPV) = 'UPD_BENE'
506600230126     C                   movel     oebefore      savamount
506700230126     C                   If        savamount <> 0
506800230126     C                   Eval      svbefore =  %trim(%editc(savamount:'P')) +
506900230126     C                                         ' %'
507000230126     C                   Else
507100230126     C                   Eval      svbefore = *blanks
507200230126     C                   End
507300230126     C                   movel     oeafter       savamount
507400230126     C                   If        savamount <> 0
507500230126     C                   Eval      svafter  =  %trim(%editc(savamount:'P')) +
507600230126     C                                         ' %'
507700230126     C                   Else
507800230126     C                   Eval      svafter = *blanks
507900230126     C                   End
508000230126     C                   When      %subst(OEFLDV:1:4) = 'LIFE'  and
508100230126     C                             pldctg = 'PP3'               and
508200230126     C                             paychoice <> 'Y'
508300230126     C                   movel     OEBEFORE      FSAAMT
508400230126     C                   z-add     FSAAMT        FSA_AMT
508500230126     C                   Eval      FSA_AMT = (FSA_AMT/100)
508600230126     C                   When      %subst(OEFLDV:1:10) = 'PERPAY_FSA'  and
508700230126     C                             pldctg = 'PP3'
508800230126     C                   movel     OEAFTER       FSAANL
508900230126     C                   z-add     FSAANL        FSA_ANL
509000230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
509100230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
509200230126     C                                         ' : Per Pay Amt $' +
509300230126     C                                         %trim(%editc(fsa_anl:'P'))
509400230126     C                   Eval      fsa_anl = 0
509500230126     C                   When      %subst(OEFLDV:1:10) = 'ANNUAL_FSA'  and
509600230126     C                             pldctg = 'PP3'
509700230126     C                   movel     OEAFTER       FSAANL
509800230126     C                   z-add     FSAANL        FSA_ANL
509900230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
510000230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
510100230126     C                                         ' : Annual Amt $' +
510200230126     C                                         %trim(%editc(fsa_anl:'P'))
510300230126     C                   Eval      fsa_anl = 0
510400230126     C                   When      %subst(OEFLDV:1:10) = 'PERPAY_FSA'  and
510500230126     C                             pldctg = 'P2P'
510600230126     C                   movel     OEAFTER       FSAANL
510700230126     C                   z-add     FSAANL        FSA_ANL
510800230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
510900230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
511000230126     C                                         ' : Per Pay Amt $' +
511100230126     C                                         %trim(%editc(fsa_anl:'P'))
511200230126     C                   Eval      fsa_anl = 0
511300230126     C                   When      %subst(OEFLDV:1:10) = 'ANNUAL_FSA'  and
511400230126     C                             pldctg = 'P2P'
511500230126     C                   movel     OEAFTER       FSAANL
511600230126     C                   z-add     FSAANL        FSA_ANL
511700230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
511800230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
511900230126     C                                         ' : Annual Amt $' +
512000230126     C                                         %trim(%editc(fsa_anl:'P'))
512100230126     C                   Eval      fsa_anl = 0
512200230126     C                   When      %subst(OEFLDV:1:4) = 'LIFE'  and
512300230126     C                             pldctg = 'PP4'               and
512400230126     C                             paychoice <> 'Y'
512500230126     C                   movel     OEBEFORE      FSAAMT
512600230126     C                   z-add     FSAAMT        FSA_AMT
512700230126     C                   Eval      FSA_AMT = (FSA_AMT/100)
512800230126     C                   When      %subst(OEFLDV:1:10) = 'PERPAY_FSA'  and
512900230126     C                             pldctg = 'PP4'
513000230126     C                   movel     OEAFTER       FSAANL
513100230126     C                   z-add     FSAANL        FSA_ANL
513200230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
513300230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
513400230126     C                                         ' : Per Pay Amt $' +
513500230126     C                                         %trim(%editc(fsa_anl:'P'))
513600230126     C                   Eval      fsa_anl = 0
513700230126     C                   When      %subst(OEFLDV:1:10) = 'ANNUAL_FSA'  and
513800230126     C                             pldctg = 'PP4'
513900230126     C                   movel     OEAFTER       FSAANL
514000230126     C                   z-add     FSAANL        FSA_ANL
514100230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
514200230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
514300230126     C                                         ' : Annual Amt $' +
514400230126     C                                         %trim(%editc(fsa_anl:'P'))
514500230126     C                   Eval      fsa_anl = 0
514600230126     C                   When      %subst(OEFLDV:1:4) = 'LIFE'  and
514700230126     C                             pldctg = 'PP5'               and
514800230126     C                             paychoice <> 'Y'
514900230126     C                   movel     OEBEFORE      FSAAMT
515000230126     C                   z-add     FSAAMT        FSA_AMT
515100230126     C                   Eval      FSA_AMT = (FSA_AMT/100)
515200230126     C                   When      %subst(OEFLDV:1:10) = 'ANNUAL_FSA'  and
515300230126     C                             pldctg = 'PP5'
515400230126     C                   movel     OEAFTER       FSAANL
515500230126     C                   z-add     FSAANL        FSA_ANL
515600230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
515700230126     C                   When      %subst(OEFLDV:1:4) = 'LIFE'  and
515800230126     C                             pldctg = 'PP6'               and
515900230126     C                             paychoice <> 'Y'
516000230126     C                   movel     OEBEFORE      FSAAMT
516100230126     C                   z-add     FSAAMT        FSA_AMT
516200230126     C                   Eval      FSA_AMT = (FSA_AMT/100)
516300230126     C                   When      %subst(OEFLDV:1:10) = 'ANNUAL_FSA'  and
516400230126     C                             pldctg = 'PP6'
516500230126     C                   movel     OEAFTER       FSAANL
516600230126     C                   z-add     FSAANL        FSA_ANL
516700230126     C                   Eval      FSA_ANL = (FSA_ANL/100)
516800230126     C                   When      %subst(OEFLDV:1:4) = 'DESC'   or
516900230126     C                             %subst(OEFLDV:1:11) = 'PCPPLANDESC'
517000230126     C                   Eval      plddsc = %trim(OEAFTER)
517100230126     C                   When      %subst(OEFLDV:1:12) = 'ADD_COVG_COV' or
517200230126     C                             %subst(OEFLDV:1:8) = 'ADD_COVG'      or
517300230126     C                             %subst(OEFLDV:1:8) = 'UPD_BENE'      or
517400230126     C                             %subst(OEFLDV:1:7) = 'CHG_BEN'       or
517500230126     C                             %subst(OEFLDV:1:7) = 'CHG_PCP'
517600230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
517700230126     C                   If        %trim(oegrpv) = 'ADD_EMP'
517800230126     C                   Eval      wcdesc = 'Add_Coverage'
517900230126     C                   End
518000230126     C                   If        %trim(oegrpv) = 'UPD_BENE'
518100230126     C                   Eval      wcdesc = 'Change Benefit'
518200230126     C                   End
518300230126     C                   movel     pldctg        cat               3
518400230126     C                   Eval      webnote = #getnot(cat:oetrst:oesub#:oeacct:
518500230126     C                                               pldeff:pldpln)
518600230126     C                   Eval      plnseq = #getpsq(oetrst:oesub#:oeacct:
518700230126     C                                      oessno:%trim(oegrpv):pldpln:oessid)
518800230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
518900230126     C                                               pldpln:pldeff)
519000230126     C                   Movel     wcdesc        wxdesc
519100230126     C                   If        %trim(cncat) = *blanks
519200230126     C                   If        %subst(plddsc:1:8) = 'DECLINED'
519300230126     C                   eval      grptxt9 = 'Reason:'
519400230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
519500230126     C                                              pldctg)
519600230126           getdclreason();
519700230126j0b9 C                   eval      B49GRP = %trim(PCDESC)
519800230126     C                   Else
519900230126     C                   eval      grptxt9 = 'Group#:'
520000230126j0b9 C                   Eval      B49GRP = %trim(PLNGRP)
520100230126     C                   End
520200230126     C                   Eval      wxdesc = %trim(wxdesc) + ':' + %trim(pldpln)+
520300230126     C                                      %trim(plnseq) + ':' + %trim(plddsc)+
520400230126     C                             ':' + %trim(grptxt9) + %trim(b49grp) +':'
520500230126     C                   Else
520600230126     C                   Eval      wxdesc = %trim(wxdesc) + ':' + pldpln +
520700230126     C                                      %trim(plnseq) + ':' + %trim(plddsc)
520800230126     C                   End
520900230126     C                   If        CNGIA > *zeros
521000230126     C                   Eval      wxdesc = %trim(wxdesc) + ':' + 'GIA: ' +
521100230126     C                                      %editc(CNGIA:'J') + ':'
521200230126     C                   End
521300230126     C                   Eval      n# = n# + 1
521400230126     C                   Eval      NoteA(n#) = %trim(WXDESC) +
521500230126     C                                     'Eff Date: ' + %char(flipdt)
521600230126     C                   Eval      wxdesc = *blanks
521700230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
521800230126     C                                               pldpln:pldeff)
521900230126     C                   Eval      pldlvl = #rtvclvl(oetrst:oesub#:oeacct:
522000230126     C                                               oessno:oessid:pldpln)
522100230126     C                   If        %trim(pldlvl) = *blanks
522200230126     C                   Eval      pldlvl = #getclvl(oetrst:oesub#:oeacct:
522300230126     C                                      oessno:pldpln:pldctg:pldeff)
522400230126     C                   End
522500230126     C                   If        fsa_anl = 0         and
522600230126     C                             pldctg  = 'PP7'     and
522700230126     C                             pldpln  <> *blanks
522800230126     C                   eval      webpayd = #dchain(OETRST:OESUB#:OEACCT:
522900230126     C                                       OESSNO:0:pldctg:pldpln)
523000230126     C                   Eval      fsa_anl = PQHSACH
523100230126     C                   End
523200230126     C                   Eval      pqdamt = *zeros
523300230126           LoadPlans();
523400230126     C                   If        pqdamt <> 0
523500230126     C                   Select
523600230126     C                   When      svbeforeD <> *blanks and
523700230126     C                             svafterD  <> *blanks
523800230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
523900230126     C                                         ' : From ' +
524000230126     C                                         %trim(svbeforeD) +
524100230126     C                                         ' : To ' +
524200230126     C                                         %trim(svafterD)
524300230126     C                   Other
524400230126     C                   Endsl
524500230126     C                   End
524600230126     C                   Select
524700230126     C                   When      svbefore <> *blanks and
524800230126     C                             svafter  <> *blanks
524900230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
525000230126     C                                         ' : From ' +
525100230126     C                                         %trim(svbefore) +
525200230126     C                                         '  To ' +
525300230126     C                                         %trim(svafter)
525400230126     C                   When      svafter <> *blanks
525500230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
525600230126     C                                         ' : Annual Amt ' +
525700230126     C                                         %trim(svafter)
525800230126     C                   When      fsa_anl <> 0
525900230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
526000230126     C                                         ' : Annual Amt $' +
526100230126     C                                         %trim(%editc(fsa_anl:'P'))
526200230126     C                   Eval      fsa_anl = 0
526300230126     C                   Endsl
526400230126     C                   When      %subst(OEFLDV:1:7) = 'QSPOUSE'
526500230126     C                   eval      qbefore = oebefore
526600230126     C                   eval      qafter = oeafter
526700230126     C                   Eval      overflow = 'Y'
526800230126     C                   When      %subst(OEFLDV:1:6) = 'BENAMT'
526900230126     C                   Eval      n# = n# + 1
527000230126     C                   If        %trim(OEAFTER) <> *Blanks
527100230126     C                   eval      len = %len(%trim(OEAFTER))
527200230126     C                   select
527300230126     C                   when      len = 10
527400230126     C                   Movel     OEAFTER       WWBEN
527500230126     C                   Eval      NoteA(n#) = %trim(plddsc) +
527600230126     C                                         ' BENEFIT AMOUNT $' +
527700230126     C                                          %editc(WWBEN:'O')
527800230126     C                   when      len = 9
527900230126     C                   Movel     OEAFTER       WWBEN9
528000230126     C                   Eval      NoteA(n#) = %trim(plddsc) +
528100230126     C                                         ' BENEFIT AMOUNT $' +
528200230126     C                                          %editc(WWBEN9:'O')
528300230126     C                   when      len = 8
528400230126     C                   Movel     OEAFTER       WWBEN9
528500230126     C                   Eval      NoteA(n#) = %trim(plddsc) +
528600230126     C                                         ' BENEFIT AMOUNT $' +
528700230126     C                                          %editc(WWBEN8:'O')
528800230126     C                   endsl
528900230126     C                   If        %trim(pldctg) = 'PSP' or
529000230126     C                             %trim(pldctg) = 'PSA'
529100230126     C                   eval      spsflg = #spsflg(oetrst:oesub#:pldpln:
529200230126     C                             pybpc:pldeff)
529300230126     C                   if        spsflg = 'S'
529400230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
529500230126     C                             '  : Age = Spouse'
529600230126     C                   end
529700230126     C                   end
529800230126     C                   End
529900230126     C                   When      %subst(OEFLDV:1:6) = 'SMOKER' and
530000230126     C                             %trim(OEAFTER) = 'Y'
530100230126     C                   Eval      n# = n# + 1
530200230126     C                   Eval      NoteA(n#) = 'TOBACCO: ' +
530300230126     C                                         %trim(oeafter)
530400230126     C                   When      %subst(OEFLDV:1:5) = 'PYSMK' and
530500230126     C                             %trim(OEAFTER) = 'Y'
530600230126     C                   Eval      n# = n# + 1
530700230126     C                   Eval      NoteA(n#) = 'TOBACCO: ' +
530800230126     C                                         %trim(oeafter)
530900230126     C                   Endsl
531000230126       end-proc;
531100230126
531200230126       dcl-proc TRM_COVG;
531300230126     C                   Select
531400230126     C                   When      %subst(OEFLDV:1:13) = 'TERCOV_REASON'
531500230126     C                   Eval      REASON = %trim(OEAFTER)
531600230126     C                   Eval      PCGRPR = 'TC_REASON'
531700230126     C                   Eval      PCCODE = %trim(OEAFTER)
531800230126     C                   Eval      PCTRST = oetrst
531900230126     C                   Eval      PCSUB# = oesub#
532000230126     C                   Eval      PCACCT = oeacct
532100230126     C                   Eval      Reason = *blanks
532200230126     C     KEYCODE       Chain     WEBPAYCHP
532300230126     C                   If        %found(WEBPAYCHP)
532400230126     C                   Eval      reason = %trim(PCDESC)
532500230126     C                   Else
532600230126     C                   Eval      PCTRST = 0
532700230126     C                   Eval      PCSUB# = 0
532800230126     C                   Eval      PCACCT = 0
532900230126     C     KEYCODE       Chain     WEBPAYCHP
533000230126     C                   If        %found(WEBPAYCHP)
533100230126     C                   Eval      reason = %trim(PCDESC)
533200230126     C                   End
533300230126     C                   End
533400230126     C                   Eval      REASON = %trim(reason) + '-' + %trim(OEAFTER)
533500230126     C                   When      %subst(OEFLDV:1:5) = 'TRMDT'
533600230126     C                   Movel     oeafter       pldeff
533700230126     C                   Movel     oeafter       w80date
533800230126     C                   Eval      flipdt  = #getusa(w80date)
533900230126     C                   eval      termtext = 'TRM_COVG'
534000230126     C                   When      %subst(OEFLDV:1:5) = 'EFFDT'
534100230126     C                   Movel     oeafter       w80date
534200230126     C                   When      %subst(OEFLDV:1:4) = 'PLAN'
534300230126     C                   Eval      pldpln = %trim(OEAFTER)
534400230126     C                   When      %subst(OEFLDV:1:4) = 'PCAT'
534500230126     C                   Eval      pldctg = %trim(OEAFTER)
534600230126     C                   When      %subst(OEFLDV:1:4) = 'DESC'
534700230126     C                   Eval      plddsc = %trim(OEAFTER)
534800230126     C                   When      %subst(OEFLDV:1:8) = 'TRM_COVG'
534900230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
535000230126     C                   Eval      n# = n# + 1
535100240206F004 C                   Eval      WCDESC = 'Term Employee Coverage'
535200240206 |   C                   Eval      NoteA(n#) = %trim(WCDESC) + ': ' +
535300240206 |   C                                         %trim(pldpln) + ': ' +
535400240206 |   C                                         %trim(plddsc) + ': ' +
535500240206 |   C*****                                    %trim(REASON) + '(' +
535600240206 |   C*****                                    %char(OEDSEQ) + ') ' +
535700240206F004 C                              'Benefit Term Date: ' + %char(flipdt)
535800230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
535900230126     C                                               pldpln:w80date)
536000230126     C                   eval      pldlvl = #trmclvl(oessno:0:oetrst:oesub#:
536100230126     C                                      oeacct:w80date:pldpln:oessid)
536200230126     C                   If        %trim(pldlvl) = *blanks
536300230126     C                   Eval      pldlvl = #rtvclvl(oetrst:oesub#:oeacct:
536400230126     C                                               oessno:oessid:pldpln)
536500230126     C                   end
536600230126     C                   If        %trim(pldlvl) = *blanks
536700230126     C                   Eval      pldlvl = #getclvl(oetrst:oesub#:oeacct:
536800230126     C                                      oessno:pldpln:pldctg:w80date)
536900230126     C                   End
537000230126          LoadPlans();
537100230126     C                   Endsl
537200230126       end-proc;
537300230126
537400230126       dcl-proc REI_COVG;
537500230126     C                   Select
537600230126     C                   When      %subst(OEFLDV:1:5) = 'REIDT'
537700230126     C                   Movel     oeafter       pldeff
537800230126     C                   Movel     oeafter       w80date
537900230126     C                   Eval      flipdt  = #getusa(w80date)
538000230126     C                   Eval      DateText = 'Eff Date: '
538100230126     C                   When      %subst(OEFLDV:1:4) = 'PLAN'
538200230126     C                   Eval      pldpln = %trim(OEAFTER)
538300230126     C                   When      %subst(OEFLDV:1:4) = 'PCAT'
538400230126     C                   Eval      pldctg = %trim(OEAFTER)
538500230126     C                   When      %subst(OEFLDV:1:4) = 'DESC'
538600230126     C                   Eval      plddsc = %trim(OEAFTER)
538700230126     C                   When      %subst(OEFLDV:1:5) = 'EFFDT'
538800230126     C                   Movel     oeafter       w80date
538900230126     C                   Eval      weffdt = #getusa(w80date)
539000230126     C                   When      %subst(OEFLDV:1:8) = 'REI_COVG'
539100230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
539200230126     C                   Eval      n# = n# + 1
539300230126     C                   Eval      NoteA(n#) = %trim(WCDESC) + ': ' +
539400230126     C                                         %trim(pldpln) + ': ' +
539500230126     C                                      'Eff Date: ' + %char(flipdt)
539600230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
539700230126     C                                               pldpln:pldeff)
539800230126     C                   Eval      pldlvl = #rtvclvl(oetrst:oesub#:oeacct:
539900230126     C                                               oessno:oessid:pldpln)
540000230126     C                   If        %trim(pldlvl) = *blanks
540100230126     C                   Eval      pldlvl = #getclvl(oetrst:oesub#:oeacct:
540200230126     C                                      oessno:pldpln:pldctg:pldeff)
540300230126     C                   End
540400230126          LoadPlans();
540500230126     C                   Endsl
540600230126       end-proc;
540700230126
540800230126       dcl-proc CHG_PCP;
540900230127     C                   if        oedseq <> 0
541000230127     C     oedseq        occur     webadepids
541100230127     C                   end
541200230126     C                   Select
541300230126     C                   When      %subst(OEFLDV:1:9) = 'PCPID_NBR'
541400230126     C                   Eval      PCPNBR = %trim(OEAFTER)
541500230126     C                   When      %subst(OEFLDV:1:10) = 'PCPID_NAME'
541600230126     C                   Eval      PCPNAM = %trim(OEAFTER)
541700230126     C                   When      %subst(OEFLDV:1:10) = 'PCPID_SPCD'
541800230126     C                   Eval      PCPSPC = %trim(OEAFTER)
541900230126     C                   When      %subst(OEFLDV:1:9) = 'PCPID_EFF'
542000230126     C                   Movel     OEAFTER       pcpeff            8 0
542100230126     C                   Eval      weffdt  = #getusa(pcpeff)
542200230126     C                   Eval      pcpeffdat = #getusa(pcpeff)
542300230126     C                   When      %subst(OEFLDV:1:11) = 'PCPID_EXIST'
542400230126     C                   Eval      PCPEXT = %trim(OEAFTER)
542500230126     C                   If        %subst(PCPSPC:1:3) = 'MED'
542600230126     C                   Eval      AUDPCPMED = %trim(PCPNBR)
542700230126     C                   Eval      SAVEPCP   = 'MED'
542800230126     C                   Eval      AUDDOCMED = %trim(PCPNAM)
542900230126     C                   Eval      AUDSPCMED = %subst(PCPSPC:1:3)
543000230126     C                   Eval      AUDEXSMED = %trim(PCPEXT)
543100230126     C                   Eval      AUDPEFMED = PCPEFFDAT
543200230126     C                   End
543300230126     C                   If        %subst(PCPSPC:1:3) = 'DEN'
543400230126     C                   Eval      AUDPCPDEN = %trim(PCPNBR)
543500230126     C                   Eval      SAVEPCP   = 'DEN'
543600230126     C                   Eval      AUDDOCDEN = %trim(PCPNAM)
543700230126     C                   Eval      AUDSPCDEN = %subst(PCPSPC:1:3)
543800230126     C                   Eval      AUDEXSDEN = %trim(PCPEXT)
543900230126     C                   Eval      AUDPEFDEN = PCPEFFDAT
544000230126     C                   End
544100230126     C                   Endsl
544200230126     C                   If        PCPNBR <> *blanks and
544300230126     C                             PCPNAM <> *blanks and
544400230126     C                             PCPSPC <> *blanks and
544500230127     C                             PCPEXT <> *blanks
544600230127     C**********************       PCPEFF <> *zeros
544700230126     C                   Eval      DocName = #getdoc(oessno:oedseq:PCPNBR:
544800230126     C                                               SAVEPCP)
544900230126     C                   Eval      n# = n# + 1
545000230126     C                   Eval      NoteA(n#) = 'PCP CHANGE: ' + %trim(PCPSPC) +
545100230126     C                             ':' + %trim(PCPNBR)+ ':Doctor: ' +
545200230126     C                             %trim(DocName) +
545300230126     C                             ':Eff: '+ %char(weffdt)+
545400230126     C                             '(' + %char(OEDSEQ) + ')'
545500230126     C                   Clear                   PCPNBR
545600230126     C                   Clear                   PCPNAM
545700230126     C                   Clear                   PCPSPC
545800230126     C                   Clear                   PCPEXT
545900230126     C                   Clear                   PCPEFFDAT
546000230126     C                   End
546100230126       end-proc;
546200230126
546300230126       dcl-proc CHG_BEN;
546400230126     C                   Select
546500230126     C                   When      %subst(OEFLDV:1:5) = 'DESC_'
546600230126     C                   Eval      plddsc = %trim(OEAFTER)
546700230126     C                   When      %subst(OEFLDV:1:5) = 'PLAN_'
546800230126     C                   Eval      pldpln = %trim(OEAFTER)
546900230126     C                   When      %subst(OEFLDV:1:4) = 'PCAT'
547000230126     C                   Eval      pldctg = %trim(OEAFTER)
547100230126     C                   When      %subst(OEFLDV:1:4) = 'EFFD'
547200230126     C                   Movel     oeafter       pldeff
547300230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
547400230126     C                   When      %subst(OEFLDV:1:7) = 'BENNAM#'
547500230126         BenLineNam();
547600230126         ConLineNam();
547700230126     C                   When      %subst(OEFLDV:1:7) = 'BENPLAN'
547800230126         BenLinePln();
547900230126         ConLinePln();
548000230126     C                   When      %subst(OEFLDV:1:7) = 'BENREL#'
548100230126         BenLineRel();
548200230126         ConLineRel();
548300230126     C                   When      %subst(OEFLDV:1:7) = 'BENPER#'
548400230126         BenLinePer();
548500230126         ConLinePer();
548600230126     C                   When      %subst(OEFLDV:1:7) = 'BENEFF#'
548700230126         BenLineEff();
548800230126         ConLineEff();
548900230126     C                   When      %subst(OEFLDV:1:7) = 'CHG_BEN'
549000230126     C                   Endsl
549100230126       end-proc;
549200230126
549300230126       dcl-proc CHG_SAL;
549400230126     C                   Select
549500230126     C                   When      %subst(OEFLDV:1:7) = 'SALARYB' or
549600230126     C                             %subst(OEFLDV:1:7) = 'SALARY_'
549700230126     C                   If        Salary > 0
549800230126     C                   Eval      n# = n# + 1
549900230126     C                   Eval      NoteA(n#) = 'Salary:' +
550000230126     C                                         %char(pyans) + ':Eff Date:' +
550100230126     C                                         %char(wsaleff)
550200230126     C                   End
550300230126     C                   Endsl
550400230126       end-proc;
550500230126
550600230126       dcl-proc DEP_INFO;
550700230126     C                   Select
550800230126     C                   When      %trim(OEFLDV)   =  'DEP_INFO'
550900230126     C                   When      %trim(OEGRPV)   =  'ADD_DEPN'
551000230126     C                   When      %trim(OEGRPV)   =  'ADD_EMP'
551100230126     C                   When      %trim(OEFLDV)   =  'HEADER'
551200230425     C                   Eval      webcod = #webcod(oegrpv:oefldv)
551300230425     C                   Eval      n# = n# + 1
551400230425     C                   Eval      NoteA(n#) = %trim(wcdesc)
551500230126     C                   When      %trim(OEBEFORE) =  '000000000' and
551600230126     C                             %trim(OEAFTER)  =  ' '
551700230126     C                   When      %trim(OEBEFORE) <> %trim(OEAFTER)
551800230126     C                   Eval      n# = n# + 1
551900230126     C                   Eval      webcod = #webcod(oegrpv:oefldv)
552000230126     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) +
552100230126     C                                         %trim(WCDESC) +
552200230126     C                                         '(' + %char(oedseq) + ')'
552300230425     C                   if        %subst(OEFLDV:1:13) = 'HANDICAP_FLAG' or
552400230425     C                             %subst(OEFLDV:1:13) = 'MEDICARE_FLAG' or
552500230425     C                             %subst(OEFLDV:1:12) = 'MEDICARE_NBR'  or
552600230425     C                             %subst(OEFLDV:1:6)  = 'DRELCD'        or
552700230425     C                             %subst(OEFLDV:1:6)  = 'DSTUDN'        or
552800230425     C                             %subst(OEFLDV:1:8)  = 'FTSEFFDT'      or
552900230425     C                             %subst(OEFLDV:1:7)  = 'FTSNAME'       or
553000230425     C                             %subst(OEFLDV:1:5)  = 'DEPSS'
553100230425     C                   Eval      NoteA(n#) = %trim(NoteA(n#)) + ' : ' +
553200230425     C                             %trim(OEAFTER)
553300230425     C                   end
553400230126     C                   Endsl
553500230126     C                   Select
553600230126     C                   When      %subst(OEFLDV:1:6) = 'DLNAME'
553700230126     C                   Eval      DLNAME = %trim(OEAFTER)
553800230126     C                   Eval      AUDLST = %trim(OEAFTER)
553900230126     C                   When      %subst(OEFLDV:1:6) = 'DFNAME'
554000230126     C                   Eval      DFNAME = %trim(OEAFTER)
554100230126     C                   Eval      AUDFST = %trim(OEAFTER)
554200230126     C                   When      %subst(OEFLDV:1:3) = 'DMI'
554300230126     C                   Eval      DMI = %trim(OEAFTER)
554400230126     C                   Eval      AUDMMI = %trim(OEAFTER)
554500230126     C                   When      %subst(OEFLDV:1:4) = 'DSEX'
554600230126     C                   Eval      DSEX = %trim(OEAFTER)
554700230126     C                   Eval      AUDSEX = %trim(OEAFTER)
554800230126     C                   When      %subst(OEFLDV:1:6) = 'DRELCD'
554900230126     C                   Eval      DRELCD = %trim(OEAFTER)
555000230126     C                   Eval      AUDRLT  = #getrel(%trim(OEAFTER))
555100230126     C                   When      %subst(OEFLDV:1:6) = 'DBIRTH'
555200230126     C                   Movel     OEAFTER       DBIRTH
555300230126     C                   Eval      AUDBTH = #getusa(DBIRTH)
555400230126     C                   When      %subst(OEFLDV:1:6) = 'DEPSS#'
555500230126     C                   Movel     OEAFTER       DEPSS#
555600230126     C                   Eval      AUDSSN = DEPSS#
555700230126     C                   When      %subst(OEFLDV:1:6) = 'DSTUDN'
555800230126     C                   Eval      DSTUDN = %trim(OEAFTER)
555900230126     C                   Eval      AUDFTS = %trim(OEAFTER)
556000230126     C                   If        AUDFTS = 'Y'
556100230126     C                   Eval      do# = do# + 5
556200230126     C                   Eval      overflow = 'Y'
556300230126     C                   Eval      overdepi = 'Y'
556400230126     C                   End
556500230126     C                   When      %subst(OEFLDV:1:6) = 'DADDR1'
556600230126     C                   Eval      AUDAD1 = %trim(OEAFTER)
556700230126     C                   If        %trim(AUDAD1) <> %trim(DADDR1) or
556800230126     C                             %trim(AUDAD1) <> %trim(ADDR1)
556900230126     C                   Eval      do# = do# + 5
557000230126     C                   Eval      overflow = 'Y'
557100230126     C                   Eval      overdepi = 'Y'
557200230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
557300230126     C                   If        e# = 0
557400230126     C                   Eval      e## = e## + 1
557500230126     C                   Eval      depadrchg(oedseq) = oedseq
557600230126     C                   End
557700230126     C                   End
557800230126     C                   When      %subst(OEFLDV:1:6) = 'DADDR2'
557900230126     C                   Eval      AUDAD2 = %trim(OEAFTER)
558000230126     C                   If        %trim(AUDAD2) <> %trim(DADDR2) or
558100230126     C                             %trim(AUDAD2) <> %trim(ADDR2)
558200230126     C                   Eval      do# = do# + 5
558300230126     C                   Eval      overflow = 'Y'
558400230126     C                   Eval      overdepi = 'Y'
558500230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
558600230126     C                   If        e# = 0
558700230126     C                   Eval      e## = e## + 1
558800230126     C                   Eval      depadrchg(oedseq) = oedseq
558900230126     C                   End
559000230126     C                   End
559100230126     C                   When      %subst(OEFLDV:1:5) = 'DCITY'
559200230126     C                   Eval      AUDCTY = %trim(OEAFTER)
559300230126     C                   If        %trim(AUDCTY) <> %trim(DCITY) or
559400230126     C                             %trim(AUDCTY) <> %trim(CITY)
559500230126     C                   Eval      do# = do# + 5
559600230126     C                   Eval      overflow = 'Y'
559700230126     C                   Eval      overdepi = 'Y'
559800230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
559900230126     C                   If        e# = 0
560000230126     C                   Eval      e## = e## + 1
560100230126     C                   Eval      depadrchg(oedseq) = oedseq
560200230126     C                   End
560300230126     C                   End
560400230126     C                   When      %subst(OEFLDV:1:6) = 'DSTATE'
560500230126     C                   Eval      AUDSTA = %trim(OEAFTER)
560600230126     C                   If        %trim(AUDSTA) <> %trim(DSTATE)
560700230126     C                   Eval      do# = do# + 5
560800230126     C                   Eval      overflow = 'Y'
560900230126     C                   Eval      overdepi = 'Y'
561000230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
561100230126     C                   If        e# = 0
561200230126     C                   Eval      e## = e## + 1
561300230126     C                   Eval      depadrchg(oedseq) = oedseq
561400230126     C                   End
561500230126     C                   End
561600230126     C                   When      %subst(OEFLDV:1:4) = 'DZIP'
561700230126     C                   Eval      WNBR = %trim(OEAFTER)
561800230126     C     ' ':'0'       xlate     WNBR          WNBR
561900230126     C                   Movel     WNBR          DZIP
562000230126     C                   Eval      AUDZIP = DZIP
562100230126     C                   If        AUDZIP <> DZIP
562200230126     C                   Eval      do# = do# + 5
562300230126     C                   Eval      overflow = 'Y'
562400230126     C                   Eval      overdepi = 'Y'
562500230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
562600230126     C                   If        e# = 0
562700230126     C                   Eval      e## = e## + 1
562800230126     C                   Eval      depadrchg(oedseq) = oedseq
562900230126     C                   End
563000230126     C                   End
563100230126     C                   When      %subst(OEFLDV:1:5) = 'DAREA'
563200230126     C                   Eval      AUDPHN = %trim(OEAFTER)
563300230126     C                   If        %trim(AUDPHN) <> %char(DAREA) and
563400230126     C                             %trim(OEGRPV) <> 'ADD_EMP'    or
563500230126     C                             %trim(AUDPHN) <> %char(AREA)
563600230126     C                   Eval      do# = do# + 5
563700230126     C                   Eval      overflow = 'Y'
563800230126     C                   Eval      overdepi = 'Y'
563900230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
564000230126     C                   If        e# = 0
564100230126     C                   Eval      e## = e## + 1
564200230126     C                   Eval      depadrchg(oedseq) = oedseq
564300230126     C                   End
564400230126     C                   End
564500230126     C     ' ':'0'       Xlate     AUDPHN        AUDPHN
564600230126     C                   Movel     AUDPHN        darea
564700230126     C                   eval      AUDPHN = *blanks
564800230126     C                   When      %subst(OEFLDV:1:6) = 'DPHONE'
564900230126     C                   Eval      AUDPHN = %trim(OEAFTER)
565000230126     C                   If        %trim(AUDPHN) <> %char(DPHONE) and
565100230126     C                             %trim(OEGRPV) <> 'ADD_EMP'     or
565200230126     C                             %trim(AUDPHN) <> %char(PHONE)
565300230126     C                   Eval      do# = do# + 5
565400230126     C                   Eval      overflow = 'Y'
565500230126     C                   Eval      overdepi = 'Y'
565600230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
565700230126     C                   If        e# = 0
565800230126     C                   Eval      e## = e## + 1
565900230126     C                   Eval      depadrchg(oedseq) = oedseq
566000230126     C                   End
566100230126     C                   End
566200230126     C     ' ':'0'       Xlate     AUDPHN        AUDPHN
566300230126     C                   Movel     AUDPHN        DPHONE
566400230126     C                   Eval      AUDPHN = #fmtphn(DAREA:DPHONE)
566500230126     C                   When      %subst(OEFLDV:1:7) = 'FTSNAME'
566600230126     C                   Eval      AUDSCH = %trim(OEAFTER)
566700230126     C                   When      %subst(OEFLDV:1:8) = 'FTSEFFDT'
566800230126     C                   Movel     OEAFTER       ftseff            8 0
566900230126     C                   Eval      AUDEFF = #getusa(ftseff)
567000230126     C                   Endsl
567100230126       end-proc;
567200230126
567300230126       dcl-proc ADD_DEPN;
567400230126     C                   Select
567500230126     C                   When      %subst(OEFLDV:1:1) = 'D' or
567600230126     C                             %subst(OEFLDV:1:1) = 'F'
567700230126     C                   If        %subst(OEFLDV:1:6) = 'DLNAME'
567800230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
567900230126     C                   Eval      n# = n# + 1
568000230515     C                   Eval      NoteA(n#) = 'ADD_DEP ' +
568100230515     C                                      '(' + %char(OEDSEQ) + ')'
568200230126     C                   End
568300230126            DEP_INFO();
568400230126     C                   When      %subst(OEFLDV:1:4) = 'COB_' or
568500230126     C                             %subst(OEFLDV:1:4) = 'MEDI' or
568600230126     C                             %subst(OEFLDV:1:4) = 'HAND'
568700230126            COB_DEPN();
568800230126     C                   When      %subst(OEFLDV:1:4) = 'ADD_'
568900230126            ADD_DEPC();
569000230126     C                   When      %subst(OEFLDV:1:3) = 'PCP'
569100230126            CHG_PCP();
569200230126     C                   Endsl
569300230126     C                   Select
569400230126     C                   When      %subst(OEFLDV:1:8) = 'ADD_DESC'
569500230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
569600230126     C                                               pldpln:pldeff)
569700230126     C                   Eval      plddsc = %trim(oeafter)
569800230126     C                   Eval      pldlvl = #rtvclvl(oetrst:oesub#:oeacct:
569900230126     C                                               oessno:oessid:pldpln)
570000230126     C                   If        %trim(pldlvl) = *blanks
570100230126     C                   Eval      pldlvl = #getclvl(oetrst:oesub#:oeacct:
570200230126     C                                      oessno:pldpln:pldctg:pldeff)
570300230126     C                   End
570400230126          LoadPlans();
570500230126     C                   Eval      webcod = #webcod('ADD_DEPC':'HEADER')
570600230126     C                   Eval      wxdesc = %trim(wxdesc) + ':' + %trim(pldpln)+
570700230126     C                                      ':' + %trim(plddsc) + ':Group#:' +
570800230126     C                                      %trim(PLNGRP) + ':'
570900230126     C                   Movel     pldeff        w80date
571000230126     C                   Eval      flipdt  = #getusa(w80date)
571100230126     C                   Eval      n# = n# + 1
571200230126     C                   Eval      NoteA(n#) = %trim(WXDESC) +
571300230126     C                                      '(' + %char(OEDSEQ) + ') ' +
571400230126     C                                      'Eff Date: ' + %char(flipdt)
571500230126     C                   Eval      WXDESC = *blanks
571600230126     C                   When      %subst(OEFLDV:1:9) = 'CONFIRMED'
571700230126     C                   Eval      AUDEPN = 'Y'
571800230126     C                   Endsl
571900230126       end-proc;
572000230126
572100230126       dcl-proc ADD_DEPC;
572200230126     C                   Select
572300230126     C                   When      %subst(OEFLDV:1:9) = 'ADD_EFFDT'
572400230126     C                   Movel     oeafter       pldeff
572500230126     C                   Movel     oeafter       w80date
572600230126     C                   Eval      flipdt  = #getusa(w80date)
572700230126     C                   Eval      DateText = 'Eff Date: '
572800230126     C                   When      %subst(OEFLDV:1:5) = 'RELCD'
572900230126     C                   Eval      DRELCD = %trim(OEAFTER)
573000230126     C                   When      %subst(OEFLDV:1:8) = 'ADD_PLAN'
573100230126     C                   Eval      pldpln = %trim(OEAFTER)
573200230126     C                   When      %subst(OEFLDV:1:8) = 'ADD_PCAT'
573300230126     C                   Eval      pldctg = %trim(OEAFTER)
573400230126     C                   When      %subst(OEFLDV:1:8) = 'ADD_DESC'
573500230126     C                   Eval      plddsc = %trim(OEAFTER)
573600230126     C                   When      %subst(OEFLDV:1:8) = 'ADD_DEPC'
573700230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
573800230126     C                                               pldpln:pldeff)
573900230126     C                   Eval      pldlvl = #rtvclvl(oetrst:oesub#:oeacct:
574000230126     C                                               oessno:oessid:pldpln)
574100230126     C                   If        %trim(pldlvl) = *blanks
574200230126     C                   Eval      pldlvl = #getclvl(oetrst:oesub#:oeacct:
574300230126     C                                      oessno:pldpln:pldctg:pldeff)
574400230126     C                   End
574500230126        LoadPlans();
574600230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
574700230126     C                   Eval      wcdesc = %trim(wcdesc) + ':' + %trim(pldpln)+
574800230126     C                                      ':' + %trim(plddsc)
574900230126     C                   Eval      n# = n# + 1
575000230126     C                   Eval      NoteA(n#) = %trim(WCDESC) +
575100230126     C                                      '(' + %char(OEDSEQ) + ') ' +
575200230126     C                                      'Eff Date: ' + %char(flipdt)
575300230126     C                   Endsl
575400230126       end-proc;
575500230126
575600230126       dcl-proc TRM_DEPC;
575700230126     C                   Select
575800230126     C                   When      %subst(OEFLDV:1:5) = 'EFFDT'
575900230126     C                   Eval      TermText = 'TRM_DEPC'
576000230126     C                   Movel     oeafter       pldeff
576100230126     C                   Movel     oeafter       w80date
576200230126     C                   Eval      flipdt  = #getusa(w80date)
576300230126     C                   Eval      DateText = *blanks
576400230126     C                   When      %subst(OEFLDV:1:4) = 'PLAN'
576500230126     C                   Eval      pldpln = %trim(OEAFTER)
576600230126     C                   When      %subst(OEFLDV:1:4) = 'PCAT'
576700230126     C                   Eval      pldctg = %trim(OEAFTER)
576800230126     C                   When      %subst(OEFLDV:1:4) = 'DESC'
576900230126     C                   Eval      plddsc = %trim(OEAFTER)
577000230126     C                   When      %subst(OEFLDV:1:15) = 'TERM_DEP_REASON'
577100230126     C                   Eval      Reason = %trim(OEAFTER)
577200230126     C                   Eval      PCGRPR = 'TP_REASON'
577300230126     C                   Eval      PCCODE = %trim(OEAFTER)
577400230126     C                   Eval      PCTRST = oetrst
577500230126     C                   Eval      PCSUB# = oesub#
577600230126     C                   Eval      PCACCT = oeacct
577700230126     C                   Eval      Reason = *blanks
577800230126     C     KEYCODE       Chain     WEBPAYCHP
577900230126     C                   If        %found(WEBPAYCHP)
578000230126     C                   Eval      reason = %trim(PCDESC)
578100230126     C                   Else
578200230126     C                   Eval      PCTRST = 0
578300230126     C                   Eval      PCSUB# = 0
578400230126     C                   Eval      PCACCT = 0
578500230126     C     KEYCODE       Chain     WEBPAYCHP
578600230126     C                   If        %found(WEBPAYCHP)
578700230126     C                   Eval      reason = %trim(PCDESC)
578800230126     C                   End
578900230126     C                   End
579000230126     C                   Eval      REASON = %trim(reason) + '-' + %trim(OEAFTER)
579100230126     C                   When      %subst(OEFLDV:1:8) = 'TRM_DEPC'
579200230126     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
579300230126     C                                               pldpln:pldeff)
579400230126     C                   Eval      pldlvl = #rtvclvl(oetrst:oesub#:oeacct:
579500230126     C                                               oessno:oessid:pldpln)
579600230126     C                   If        %trim(pldlvl) = *blanks
579700230126     C                   Eval      pldlvl = #getclvl(oetrst:oesub#:oeacct:
579800230126     C                                      oessno:pldpln:pldctg:pldeff)
579900230126     C                   End
580000230323             LoadPlans();
580100230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
580200230126     C                   Eval      wcdesc = %trim(wcdesc) + ':' + %trim(pldpln)+
580300230126     C                             ':' + %trim(plddsc)
580400230126     C                   Eval      n# = n# + 1
580500230126     C                   If        %trim(reason) = *blanks
580600230126     C                   Eval      NoteA(n#) = %trim(WCDESC) +
580700230126     C                                      '(' + %char(OEDSEQ) + ') ' +
580800240206     C                                      'Benefit Term Date: ' +
580900240206     C                                      %char(flipdt)
581000230126     C                   Else
581100230126     C                   Eval      NoteA(n#) = %trim(WCDESC) +
581200230126     C                                      '(' + %char(OEDSEQ) + ') ' +
581300240206     C                                      'Benefit Term Date: ' +
581400240206     C                                      %char(flipdt)
581500230126     C                   end
581600230126     C                   Endsl
581700230126       end-proc;
581800230126
581900230126       dcl-proc TRM_DEPN;
582000230126     C                   Select
582100230126     C                   When      %subst(OEFLDV:1:13) = 'TERM_DEP_DATE'
582200230126     C                   Movel     oeafter       w80date
582300230126     C                   Eval      wtrmdt  = #getusa(w80date)
582400230126     C                   When      %subst(OEFLDV:1:15) = 'TERM_DEP_REASON'
582500230126     C                   Eval      Reason = %trim(OEAFTER)
582600230126     C                   Eval      PCGRPR = 'TD_REASON'
582700230126     C                   Eval      PCCODE = %trim(OEAFTER)
582800230126     C                   Eval      PCTRST = oetrst
582900230126     C                   Eval      PCSUB# = oesub#
583000230126     C                   Eval      PCACCT = oeacct
583100230126     C                   Eval      Reason = *blanks
583200230126     C     KEYCODE       Chain     WEBPAYCHP
583300230126     C                   If        %found(WEBPAYCHP)
583400230126     C                   Eval      reason = %trim(PCDESC)
583500230126     C                   Else
583600230126     C                   Eval      PCTRST = 0
583700230126     C                   Eval      PCSUB# = 0
583800230126     C                   Eval      PCACCT = 0
583900230126     C     KEYCODE       Chain     WEBPAYCHP
584000230126     C                   If        %found(WEBPAYCHP)
584100230126     C                   Eval      reason = %trim(PCDESC)
584200230126     C                   End
584300230126     C                   End
584400230126     C                   Eval      REASON = %trim(reason) + '-' + %trim(OEAFTER)
584500230126     C                   When      %subst(OEFLDV:1:6)  = 'DADDR1'
584600230126     C                   Eval      do# = do# + 5
584700230126     C                   Eval      overflow = 'Y'
584800230126     C                   Eval      overdepi = 'Y'
584900230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
585000230126     C                   If        e# = 0
585100230126     C                   Eval      e## = e## + 1
585200230126     C                   Eval      depadrchg(oedseq) = oedseq
585300230126     C                   End
585400230126     C     oedseq        occur     webadepids
585500230126     C                   Eval      audad1 = %trim(oeafter)
585600230126     C                   When      %subst(OEFLDV:1:6)  = 'DADDR2'
585700230126     C                   Eval      do# = do# + 5
585800230126     C                   Eval      overflow = 'Y'
585900230126     C                   Eval      overdepi = 'Y'
586000230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
586100230126     C                   If        e# = 0
586200230126     C                   Eval      e## = e## + 1
586300230126     C                   Eval      depadrchg(oedseq) = oedseq
586400230126     C                   End
586500230126     C     oedseq        occur     webadepids
586600230126     C                   Eval      audad2 = %trim(oeafter)
586700230126     C                   When      %subst(OEFLDV:1:5)  = 'DCITY'
586800230126     C                   Eval      do# = do# + 5
586900230126     C                   Eval      overflow = 'Y'
587000230126     C                   Eval      overdepi = 'Y'
587100230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
587200230126     C                   If        e# = 0
587300230126     C                   Eval      e## = e## + 1
587400230126     C                   Eval      depadrchg(oedseq) = oedseq
587500230126     C                   End
587600230126     C     oedseq        occur     webadepids
587700230126     C                   Eval      audcty = %trim(oeafter)
587800230126     C                   When      %subst(OEFLDV:1:4)  = 'DZIP'
587900230126     C                   Eval      do# = do# + 5
588000230126     C                   Eval      overflow = 'Y'
588100230126     C                   Eval      overdepi = 'Y'
588200230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
588300230126     C                   If        e# = 0
588400230126     C                   Eval      e## = e## + 1
588500230126     C                   Eval      depadrchg(oedseq) = oedseq
588600230126     C                   End
588700230126     C     oedseq        occur     webadepids
588800230126     C                   Eval      WNBR = %trim(OEAFTER)
588900230126     C     ' ':'0'       xlate     WNBR          WNBR
589000230126     C                   Movel     WNBR          DZIP
589100230126     C                   Eval      AUDZIP = DZIP
589200230126     C                   When      %subst(OEFLDV:1:5)  = 'DAREA'
589300230126     C                   Eval      do# = do# + 5
589400230126     C                   Eval      overflow = 'Y'
589500230126     C                   Eval      overdepi = 'Y'
589600230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
589700230126     C                   If        e# = 0
589800230126     C                   Eval      e## = e## + 1
589900230126     C                   Eval      depadrchg(oedseq) = oedseq
590000230126     C                   End
590100230126     C     oedseq        occur     webadepids
590200230126     C                   Eval      WNBR = %trim(OEAFTER)
590300230126     C     ' ':'0'       xlate     WNBR          WNBR
590400230126     C                   Movel     WNBR          DAREA
590500230126     C                   Eval      AUDZIP = DAREA
590600230126     C                   When      %subst(OEFLDV:1:6)  = 'DPHONE'
590700230126     C                   Eval      do# = do# + 5
590800230126     C                   Eval      overflow = 'Y'
590900230126     C                   Eval      overdepi = 'Y'
591000230126     C                   Eval      e# = %lookup(oedseq:depadrchg)
591100230126     C                   If        e# = 0
591200230126     C                   Eval      e## = e## + 1
591300230126     C                   Eval      depadrchg(oedseq) = oedseq
591400230126     C                   End
591500230126     C     oedseq        occur     webadepids
591600230126     C                   Eval      WNBR = %trim(OEAFTER)
591700230126     C     ' ':'0'       xlate     WNBR          WNBR
591800230126     C                   Movel     WNBR          DPHONE
591900230126     C                   Eval      AUDPHN = #fmtphn(DAREA:DPHONE)
592000230126     C                   When      %subst(OEFLDV:1:8) = 'TRM_DEPN'
592100230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
592200230126     C                   Eval      n# = n# + 1
592300240206     C                   Eval      NoteA(n#) = %trim(WCDESC) + ' ' +
592400240206     C                             '(' + %char(OEDSEQ) + ')'
592500230126     C                   Endsl
592600230126       end-proc;
592700230126
592800230126       dcl-proc REI_DEPN;
592900230126     C                   Select
593000230126     C                   When      %subst(OEFLDV:1:14) = 'REINSTATE_DATE'
593100230126     C                   Movel     oeafter       w80date
593200230126     C                   Eval      weffdt  = #getusa(w80date)
593300230126     C                   When      %subst(OEFLDV:1:16) = 'REINSTATE_REASON'
593400230126     C                   Eval      Reason = %trim(OEAFTER)
593500230126     C                   When      %subst(OEFLDV:1:8) = 'REI_DEPN'
593600230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
593700230126     C                   eval      n# = n# + 1
593800230126     C                   Eval      NoteA(n#) = %trim(WCDESC) + ': Reason: ' +
593900230126     C                                      %trim(Reason) + ': Eff Date: ' +
594000230126     C                                      %char(weffdt) +
594100230126     C                                      ' (' + %char(OEDSEQ) + ')'
594200230126     C                   Endsl
594300230126       end-proc;
594400230126
594500230126       dcl-proc COB_DEPN;
594600230126     C                   Select
594700230425     C                   When      %subst(OEFLDV:1:6) = 'HEADER'
594800230425     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
594900230425     C                   eval      n# = n# + 1
595000230425     C                   eval      NoteA(n#) = %trim(WCDESC)
595100230126     C                   When      %subst(OEFLDV:1:13) = 'MEDICARE_FLAG'
595200230126     C                   Eval      cb# = cb# + 1
595300230126     C     cb#           occur     webacobids
595400230126     C                   Eval      auzmed = %trim(OEAFTER)
595500230126     C                   IF        %trim(OEAFTER) = 'Y'
595600230126     C                   Eval      n# = n# + 1
595700230126     C                   Eval      NoteA(n#) = 'VERIFY MEDICARE'
595800230126     C                   End
595900230126     C                   When      %subst(OEFLDV:1:13) = 'HANDICAP_FLAG' and
596000230126     C                             %trim(OEAFTER) = 'Y'
596100230126     C                   Eval      n# = n# + 1
596200230126     C                   Eval      NoteA(n#) = 'VERIFY HANDICAP'
596300230126     C                   When      %subst(OEFLDV:1:14) = 'MEDICARE_A_EFF'
596400230126     C                   Movel     oeafter       w80date
596500230126     C                   Eval      auzmpa   = #getusa(w80date)
596600230126     C                   When      %subst(OEFLDV:1:14) = 'MEDICARE_B_EFF'
596700230126     C                   Movel     oeafter       w80date
596800230126     C                   Eval      auzmpb   = #getusa(w80date)
596900230126     C                   When      %subst(OEFLDV:1:12) = 'MEDICARE_NBR'
597000230126     C                   Eval      auzmed#  = %trim(OEAFTER)
597100230126     C                   Endsl
597200230126     C                   Eval      WebDep = #frmdep(oetrn#:oetrst:oesub#:
597300230126     C                                              oeacct:oessno:oedseq:'C')
597400230126     C                   eval      auzlst = %trim(dlname)
597500230126     C                   eval      auzfst = %trim(dfname)
597600230126     C                   eval      auzmmi = %trim(dmi)
597700230126     C                   eval      auzseq = oedseq
597800230126     C                   eval      auzssn = depss#
597900230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
598000230126     C     1             Do        cb#           x
598100230126     C     x             occur     webacobids
598200230126     C                   If        auzmed# <> *blanks
598300230126     C                   eval      zz# = zz# + 1
598400230126     C                   end
598500230126     C                   enddo
598600230126     C                   If        zz# > 1
598700230126     C                   Eval      Overflow = 'Y'
598800230126     C                   End
598900230126       end-proc;
599000230126
599100230126       dcl-proc PRT_KEEP;
599200230126     C                   Eval      n# = n# + 1
599300230126     C                   Eval      NoteA(n#) = 'Made No Benefit Changes'
599400230126       end-proc;
599500230126
599600230126       dcl-proc SET_HANDCAP;
599700230126     C                   If        oedseq = 0
599800230126     C                   If        multid > 1
599900230126     C                   Eval      cossid = *blanks
600000230126     C                   Else
600100230126     C                   Eval      cossid = %trim(oessid)
600200230126     C                   End
600300230126     C                   Eval      webcobd = #getcob(oetrst:oesub#:oeacct:
600400230126     C                                               oessno:oedseq:cossid)
600500230126     C                   If        HANDICF <> ' '
600600230126     C                   Eval      HNDICP  = HANDICF
600700230126     C                   Else
600800230126     C                   Eval      HNDICP = 'N'
600900230126     C                   Eval      B2MDIS = HNDICP
601000230126     C                   End
601100230126     C                   Else
601200230126     C                   If        multid > 1
601300230126     C                   Eval      cossid = *blanks
601400230126     C                   Else
601500230126     C                   Eval      cossid = %trim(oessid)
601600230126     C                   End
601700230126     C                   Eval      webcobd = #getcob(oetrst:oesub#:oeacct:
601800230126     C                                               oessno:oedseq:cossid)
601900230126     C                   If        HANDICF <> ' '
602000230126     C                   Eval      DHNDCP  = HANDICF
602100230126     C                   Else
602200230126     C                   Eval      DHNDCP = 'N'
602300230126     C                   End
602400230126     C                   End
602500230126       end-proc;
602600230126
602700230126       dcl-proc Load_Add_Emp;
602800230126     C                   eval      oedseq = 0
602900230126           Set_HandCap();
603000230126     C     21            occur     webadepids
603100230126     C                   Eval      B2MLST = %trim(AUDLST)
603200230126     C                   Eval      B2MFST = %trim(AUDFST)
603300230126     C                   Eval      B2MMMI = %trim(AUDMMI)
603400230126     C                   Eval      B2MSSN = AUDSSN
603500230126     C                   Eval      B2MBTH = AUDBTH
603600230126     C                   Eval      B2MSEX = AUDSEX
603700230126     C                   Eval      B2MFTS = *blanks
603800230126     C                   Eval      B2MDIS = HNDICP
603900230126     C                   Eval      B2MPH# = %trim(AUDPCPMED)
604000230126     C                   Eval      B2MPHY = %trim(AUDDOCMED)
604100230126     C                   Eval      B2MEXT = AUDEXSMED
604200230126     C                   Eval      B2MDN# = %trim(AUDPCPDEN)
604300230126       end-proc;
604400230126
604500230126       dcl-proc Load_Add_Depn;
604600230126     C     1             do        20            oedseq
604700230126     C     oedseq        occur     webadepids
604800230126     C                   If        %trim(AUDLST) <> *blanks
604900230126     C                   If        multid > 1
605000230126     C                   Eval      cossid = *blanks
605100230126     C                   Else
605200230126     C                   Eval      cossid = %trim(oessid)
605300230126     C                   End
605400230126     C                   Eval      webcobd = #getcob(oetrst:oesub#:oeacct:
605500230126     C                                               oessno:oedseq:cossid)
605600230126     C                   If        HANDICF <> ' '
605700230126     C                   Eval      AUDDIS  = HANDICF
605800230126     C                   Else
605900230126     C                   Eval      AUDDIS = 'N'
606000230126     C                   End
606100230126     C                   Select
606200230126     C                   When      %trim(AUDREL) = 'RHU'
606300230126     C                   Eval      AUDSEX = 'M'
606400230126     C                   When      %trim(AUDREL) = 'RWI'
606500230126     C                   Eval      AUDSEX = 'F'
606600230126     C                   When      %trim(AUDREL) = 'RSO'
606700230126     C                   Eval      AUDSEX = 'M'
606800230126     C                   When      %trim(AUDREL) = 'RDA'
606900230126     C                   Eval      AUDSEX = 'F'
607000230126     C                   When      %trim(AUDREL) = 'RPA' or
607100230126     C                             %trim(AUDREL) = 'DPM'
607200230126     C                   Eval      AUDSEX = 'M'
607300230126     C                   Eval      n# = n# + 1
607400230126     C                   Eval      NoteA(n#) = 'Domestic Partner'
607500230126     C                   When      %trim(AUDREL) = 'DPF'
607600230126     C                   Eval      AUDSEX = 'F'
607700230126     C                   Eval      n# = n# + 1
607800230126     C                   Eval      NoteA(n#) = 'Domestic Partner'
607900230126     C                   Endsl
608000230126     C                   Select
608100230126     C                   When      %trim(AUDREL) = 'RHU'    or
608200230126     C                             %trim(AUDREL) = 'RWI'    or
608300230126     C                             %trim(AUDREL) = 'RPA'    or
608400230126     C                             %trim(AUDREL) = 'DPF'    or
608500230126     C                             %trim(AUDREL) = 'DPM'
608600230126     C                   Eval      B2SLST = %trim(AUDLST)
608700230126     C                   Eval      B2SFST = %trim(AUDFST)
608800230126     C                   Eval      B2SMMI = %trim(AUDMMI)
608900230126     C                   Eval      B2SSSN = AUDSSN
609000230126     C                   Eval      B2SSEQ = AUDSEQ
609100230126     C                   Eval      B2SBTH = AUDBTH
609200230126     C                   Eval      B2SSEX = AUDSEX
609300230126     C                   Eval      B2SFTS = AUDFTS
609400230126     C                   Eval      B2SDIS = AUDDIS
609500230126     C                   Eval      B2SPH# = %trim(AUDPCPMED)
609600230126     C                   Eval      B2SPHY = %trim(AUDDOCMED)
609700230126     C                   Eval      B2SEXT = AUDEXSMED
609800230126     C                   Eval      B2SDN# = %trim(AUDPCPDEN)
609900230126     C                   When      %trim(AUDREL) = 'RSO'    or
610000230126     C                             %trim(AUDREL) = 'RDA'    or
610100230126     C                             %trim(AUDREL) = 'OTH'
610200230126     C                   Select
610300230126     C                   When      %trim(B21LST) = *blanks
610400230126     C                   Eval      B21LST = %trim(AUDLST)
610500230126     C                   Eval      B21FST = %trim(AUDFST)
610600230126     C                   Eval      B21MMI = %trim(AUDMMI)
610700230126     C                   Eval      B21SSN = AUDSSN
610800230126     C                   Eval      B21SEQ = AUDSEQ
610900230126     C                   Eval      B21BTH = AUDBTH
611000230126     C                   Eval      B21SEX = AUDSEX
611100230126     C                   Eval      B21FTS = AUDFTS
611200230126     C                   Eval      B21DIS = AUDDIS
611300230126     C                   Eval      B21PH# = %trim(AUDPCPMED)
611400230126     C                   Eval      B21PHY = %trim(AUDDOCMED)
611500230126     C                   Eval      B21EXT = AUDEXSMED
611600230126     C                   Eval      B21DN# = %trim(AUDPCPDEN)
611700230126     C                   When      %trim(B22LST) = *blanks
611800230126     C                   Eval      B22LST = %trim(AUDLST)
611900230126     C                   Eval      B22FST = %trim(AUDFST)
612000230126     C                   Eval      B22MMI = %trim(AUDMMI)
612100230126     C                   Eval      B22SSN = AUDSSN
612200230126     C                   Eval      B22SEQ = AUDSEQ
612300230126     C                   Eval      B22BTH = AUDBTH
612400230126     C                   Eval      B22SEX = AUDSEX
612500230126     C                   Eval      B22FTS = AUDFTS
612600230126     C                   Eval      B22DIS = AUDDIS
612700230126     C                   Eval      B22PH# = %trim(AUDPCPMED)
612800230126     C                   Eval      B22PHY = %trim(AUDDOCMED)
612900230126     C                   Eval      B22EXT = AUDEXSMED
613000230126     C                   Eval      B22DN# = %trim(AUDPCPDEN)
613100230126     C                   When      %trim(B23LST) = *blanks
613200230126     C                   Eval      B23LST = %trim(AUDLST)
613300230126     C                   Eval      B23FST = %trim(AUDFST)
613400230126     C                   Eval      B23MMI = %trim(AUDMMI)
613500230126     C                   Eval      B23SSN = AUDSSN
613600230126     C                   Eval      B23SEQ = AUDSEQ
613700230126     C                   Eval      B23BTH = AUDBTH
613800230126     C                   Eval      B23SEX = AUDSEX
613900230126     C                   Eval      B23FTS = AUDFTS
614000230126     C                   Eval      B23DIS = AUDDIS
614100230126     C                   Eval      B23PH# = %trim(AUDPCPMED)
614200230126     C                   Eval      B23PHY = %trim(AUDDOCMED)
614300230126     C                   Eval      B23EXT = AUDEXSMED
614400230126     C                   Eval      B23DN# = %trim(AUDPCPDEN)
614500230126     C                   When      %trim(B24LST) = *blanks
614600230126     C                   Eval      B24LST = %trim(AUDLST)
614700230126     C                   Eval      B24FST = %trim(AUDFST)
614800230126     C                   Eval      B24MMI = %trim(AUDMMI)
614900230126     C                   Eval      B24SSN = AUDSSN
615000230126     C                   Eval      B24SEQ = AUDSEQ
615100230126     C                   Eval      B24BTH = AUDBTH
615200230126     C                   Eval      B24SEX = AUDSEX
615300230126     C                   Eval      B24FTS = AUDFTS
615400230126     C                   Eval      B24DIS = AUDDIS
615500230126     C                   Eval      B24PH# = %trim(AUDPCPMED)
615600230126     C                   Eval      B24PHY = %trim(AUDDOCMED)
615700230126     C                   Eval      B24EXT = AUDEXSMED
615800230126     C                   Eval      B24DN# = %trim(AUDPCPDEN)
615900230126     C                   When      %trim(B25LST) = *blanks
616000230126     C                   Eval      B25LST = %trim(AUDLST)
616100230126     C                   Eval      B25FST = %trim(AUDFST)
616200230126     C                   Eval      B25MMI = %trim(AUDMMI)
616300230126     C                   Eval      B25SSN = AUDSSN
616400230126     C                   Eval      B25SEQ = AUDSEQ
616500230126     C                   Eval      B25BTH = AUDBTH
616600230126     C                   Eval      B25SEX = AUDSEX
616700230126     C                   Eval      B25FTS = AUDFTS
616800230126     C                   Eval      B25DIS = AUDDIS
616900230126     C                   Eval      B25PH# = %trim(AUDPCPMED)
617000230126     C                   Eval      B25PHY = %trim(AUDDOCMED)
617100230126     C                   Eval      B25EXT = AUDEXSMED
617200230126     C                   Eval      B25DN# = %trim(AUDPCPDEN)
617300230126     C                   Other
617400230126     C                   Endsl
617500230126     C                   Endsl
617600230126     C                   End
617700230126     C                   Enddo
617800230126       end-proc;
617900230126
618000230126       dcl-proc  SFLCCOV;
618100230126          calc_eff();
618200230126     C                   Clear                   MemCovg
618300230126     C                   Eval      MemCovg = #sflccov(OETRST:OESUB#:OEACCT:
618400230126     C                                       OESSNO:0:'N':'N':w80date)
618500230126       end-proc;
618600230127
618700230127       dcl-proc  SFLDCOV;
618800230127            calc_eff();
618900230127     C     1             do        20            oedseq
619000230127     C     oedseq        occur     webadepids
619100230127     C                   If        %trim(AUDLST) <> *blanks
619200230127     C                   Clear                   DepCovg
619300230127     C                   Eval      DepCovg = #sfldcov(OESSNO:AUDSEQ:OETRST:
619400230127     C                                       OESUB#:OEACCT:'N':'N':w80date)
619500230127     C                   Eval      p# = 1
619600230127     C                   Eval      p#cnt = 0
619700230127     C                   If        dpln(p#) <> *blanks
619800230127     C                   Dow       dpln(p#) <> *blanks
619900230127     C                   If        dpln(p#) <> 'XXXX' and
620000230127     C                             dcat(p#) <> 'PRX'
620100230127     C                   Eval      p#cnt = p#cnt + 1
620200230127     C                   end
620300230127     C                   Eval      p#    = p#    + 1
620400230127     C                   enddo
620500230127     C                   end
620600230127     C                   If        p#cnt = 0
620700230127     C                   Eval      n# = n# + 1
620800230127     C                   Eval      NoteA(n#) = 'WARNING - This dependent ' +
620900230127     C                                         'has no coverage' +
621000230127     C                                      '(' + %char(AUDSEQ) + ')'
621100230419     C                   eval      NoteA(n#) = %trim(NoteA(n#)) + ' for date ' +
621200230419     C                             %char(w80date)
621300230127     C                   End
621400230127     C                   End
621500230127     C                   Enddo
621600230127       end-proc;
621700230126
621800230126       dcl-proc  CALC_EFF;
621900230126     C                   eval      w80date = #clceff(oetrst:oesub#:oeacct:
622000230126     C                                               w80date:0)
622100230126 |   C                   Eval      NewHire= #chknhr(oetrst:oesub#:oeacct:oessno:
622200230126 |   C                                      '')
622300230126 |   C                   if        NewHire > 0
622400230126 |   C                   if        pyhdt = 0
622500230227           webpay = #pchain(oetrst:oesub#:oeacct:oessno);
622600230227 |   C                   end
622700230227 |   C                   if        pyhdt = 0
622800230227 |   C                   if        empdt = 0
622900230227           WEBMBR = #webdem(OETRST:OESUB#:OEACCT:OESSNO:0:'C');
623000230227 |   C                   end
623100230126 |   C                   eval      pyhdt = empdt
623200230126 |   C                   end
623300230126 |   C                   eval      w80date = #clcnhd(oetrst:oesub#:oeacct:
623400230126 |   C                                               oessno:pyhdt)
623500230126bsm3 C                   End
623600230126       end-proc;
623700230126
623800230126       dcl-proc  LOADPLANS;
623900230126     C                   select
624000230126     C                   when      %subst(oefldv:1:12) = 'ADD_COVG_BEN'
624100230126                         return;
624200230126     C                   when      oedseq <> 0   and
624300230126     C                             %trim(oegrpv) <> 'TRM_DEPC'
624400230126                         return;
624500230126     C                   Endsl
624600230126     C     pldctg        Chain     CODESL1
624700230126     C                   If        not %found(CODESL1)
624800230126     C                   Eval      ldescr = *blanks
624900230126     C                   Else
625000230126     C                   If        Action = 'D' or
625100230126     C                             Action = 'M'
625200230126     C                   Eval      waiver = 'N'
625300230126     C                   End
625400230126     C                   Select
625500230126     C                   When      Action = 'M'
625600230126     C                   Eval      med#usa = #getusa(PLDEFF)
625700230126     C                   When      Action = 'D'
625800230126     C                   Eval      den#usa = #getusa(PLDEFF)
625900230126     C                   When      Action = 'V'
626000230126     C                   Eval      vis#usa = #getusa(PLDEFF)
626100230126     C                   When      Action = 'L'
626200230126     C                   Eval      lif#usa = #getusa(PLDEFF)
626300230126     C                   When      Action = 'T'  or
626400230126     C                             Action = 'S'
626500230126     C                   Eval      ltd#usa = #getusa(PLDEFF)
626600230126     C                   Endsl
626700230126     C                   Eval      wfdesc = %trim(ldescr)
626800230126     C                   Select
626900230126     C                   When      %trim(pldctg) = 'PSL'  or
627000230126     C                             %trim(pldctg) = 'PSP'  or
627100230126     C                             %trim(pldctg) = 'PSD'  or
627200230126     C                             %trim(pldctg) = 'PSA'  or
627300230126     C                             %trim(pldctg) = 'PAC'  or
627400230126     C                             %trim(pldctg) = 'PP4'  or
627500230126     C                             %trim(pldctg) = 'PVL'  or
627600230126     C                             %trim(pldctg) = 'PVW'  or
627700230126     C                             %trim(pldctg) = 'PLF'  or
627800230126     C                             %trim(pldctg) = 'PDL'  or
627900230126     C                             %trim(pldctg) = 'PSE'  or
628000230126     C                             %trim(pldctg) = 'PLT'  or
628100230126     C                             %trim(pldctg) = 'PWD'  or
628200230126     C                             %trim(pldctg) = 'POA'
628300230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
628400230126     C                                       oessno:oedseq:pldctg:pldpln)
628500230126     C                   If        PQBEN > 0
628600230126     C                   Eval      wwben = PQBEN
628700230126     C                   Else
628800230126     C                   Eval      wwben = #benamt(oetrst:oesub#:oeacct:
628900230126     C                                         oessno:pldpln:pldctg:oessid)
629000230126     C                   End
629100230126     C                   If        wwben > 0
629200230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
629300230413     C                             %trim(%editc(WWBEN:'O'))
629400230126     C                   end
629500230126     C                   when      %trim(pldctg) = 'PAA'
629600230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
629700230126     C                                       oessno:oedseq:pldctg:pldpln)
629800230126     C                   If        PQBEN > 0
629900230126     C                   Eval      wwben = PQBEN
630000230126     C                   Else
630100230126     C                   Eval      wwben = #flatamt(oetrst:oesub#:oeacct:
630200230126     C                                         oessno:pldpln:pldctg:oessid)
630300230126     C                   If        wwben = 0
630400230126     C                   Eval      wwben = #benamt(oetrst:oesub#:oeacct:
630500230126     C                                         oessno:pldpln:pldctg:oessid)
630600230126     C                   End
630700230126     C                   End
630800230126     C                   If        wwben > 0
630900230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
631000230413     C                             %trim(%editc(WWBEN:'O'))
631100230126     C                   end
631200230126     C                   When      %trim(pldctg) = 'PSF'
631300230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
631400230126     C                                       oessno:oedseq:pldctg:pldpln)
631500230126     C                   If        PQBEN > 0
631600230126     C                   Eval      wwben = PQBEN
631700230126     C                   Else
631800230126     C                   Eval      wwben = #flatamt(oetrst:oesub#:oeacct:
631900230126     C                                         oessno:pldpln:pldctg:oessid)
632000230126     C                   End
632100230126     C                   If        wwben > 0
632200230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
632300230413     C                             %trim(%editc(WWBEN:'O'))
632400230126     C                   end
632500230126     C                   When      %trim(pldctg) = 'PP1' or
632600230126     C                             %trim(pldctg) = 'PPR'
632700230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
632800230126     C                                       oessno:oedseq:pldctg:pldpln)
632900230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
633000230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
633100230126     C                   Eval      wfdesc = #replace(wfdesc:'%':'')
633200230413     C                   Eval      wfdesc = %trim(wfdesc) + ' ' +
633300230413     C                             %trim(%editc(PQ401P:'3')) + '% per pay'
633400230126     C                   When      %trim(pldctg) = 'PP2' or
633500230126     C                             %trim(pldctg) = 'PPS'
633600230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
633700230126     C                                       oessno:oedseq:pldctg:pldpln)
633800230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
633900230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
634000230126     C                   Eval      wfdesc = #replace(wfdesc:'$':'')
634100230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
634200230413     C                             %trim(%editc(PQ401K:'3')) + ' per pay'
634300230126     C                   When      %trim(pldctg) = 'PP3'
634400230126     C                   If        PayChoice = 'Y'
634500230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
634600230126     C                                       oessno:oedseq:pldctg:pldpln)
634700230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
634800230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
634900230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
635000230413     C                             %trim(%editc(PQFSAM:'3')) + ' per pay'
635100230126     C                   Else
635200230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
635300230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
635400230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
635500230413     C                             %trim(%editc(FSA_AMT:'3')) + ' per pay'
635600230126     C                   End
635700230126     C                   When      %trim(pldctg) = 'P2P'
635800230126     C                   If        PayChoice = 'Y'
635900230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
636000230126     C                                       oessno:oedseq:pldctg:pldpln)
636100230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
636200230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
636300230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
636400230413     C                             %trim(%editc(PQFSAM:'3')) + ' per pay'
636500230126     C                   Else
636600230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
636700230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
636800230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
636900230413     C                             %trim(%editc(FSA_AMT:'3')) + ' per pay'
637000230126     C                   End
637100230126     C                   When      %trim(pldctg) = 'PP4'
637200230126     C                   If        PayChoice = 'Y'
637300230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
637400230126     C                                       oessno:oedseq:pldctg:pldpln)
637500230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
637600230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
637700230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
637800230413     C                             %trim(%editc(PQFSAD:'3')) + ' per pay'
637900230126     C                   Else
638000230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
638100230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
638200230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
638300230413     C                             %trim(%editc(FSA_AMT:'3')) + ' per pay'
638400230126     C                   End
638500230126     C                   When      %trim(pldctg) = 'PP5'
638600230126     C                   If        PayChoice = 'Y'
638700230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
638800230126     C                                       oessno:oedseq:pldctg:pldpln)
638900230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
639000230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
639100230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
639200230413     C                             %trim(%editc(PQFSAP:'3')) + ' per pay'
639300230126     C                   Else
639400230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
639500230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
639600230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
639700230413     C                             %trim(%editc(FSA_AMT:'3')) + ' per pay'
639800230126     C                   End
639900230126     C                   When      %trim(pldctg) = 'PP6'
640000230126     C                   If        PayChoice = 'Y'
640100230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
640200230126     C                                       oessno:oedseq:pldctg:pldpln)
640300230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
640400230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
640500230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
640600230413     C                             %trim(%editc(PQFSAT:'3')) + ' per pay'
640700230126     C                   Else
640800230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
640900230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
641000230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
641100230413     C                             %trim(%editc(FSA_AMT:'3')) + ' per pay'
641200230126     C                   End
641300230126     C                   When      %trim(pldctg) = 'PP7'
641400230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
641500230126     C                                       oessno:oedseq:pldctg:pldpln)
641600230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
641700230413     C                             %trim(%editc(PQHSACH:'3'))
641800230126     C                   When      %trim(pldctg) = 'PV0' or
641900230126     C                             %trim(pldctg) = 'PV1' or
642000230126     C                             %trim(pldctg) = 'PV2' or
642100230126     C                             %trim(pldctg) = 'PV3' or
642200230126     C                             %trim(pldctg) = 'PV4' or
642300230126     C                             %trim(pldctg) = 'PV5' or
642400230126     C                             %trim(pldctg) = 'PV6' or
642500230126     C                             %trim(pldctg) = 'PV7' or
642600230126     C                             %trim(pldctg) = 'PV8' or
642700230126     C                             %trim(pldctg) = 'PV9'
642800230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
642900230126     C                                       oessno:oedseq:pldctg:pldpln)
643000230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
643100230413     C                             %trim(%editc(PQHSA:'3'))
643200230126     C                   When      %trim(pldctg) = 'PFM'
643300230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
643400230126     C                                       oessno:oedseq:pldctg:pldpln)
643500230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
643600230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
643700230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
643800230413     C                             %trim(%editc(PQFSAM:'3')) + ' per pay'
643900230126     C                   When      %trim(pldctg) = 'PFD'
644000230126     C                   Eval      webpayd = #dchain(oetrst:oesub#:oeacct:
644100230126     C                                       oessno:oedseq:pldctg:pldpln)
644200230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
644300230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
644400230413     C                   Eval      wfdesc = %trim(wfdesc) + ' $ ' +
644500230413     C                             %trim(%editc(PQFSAD:'3')) + ' per pay'
644600230126     C                   Endsl
644700230126     C                   End
644800230126     C                   If        DateText = 'Eff Date: '
644900230126     C                   Eval      l# = %lookup(%trim(PLNCRC):CarDis)
645000230126     C                   If        l# = 0
645100230126     C                   Eval      cd# = cd# + 1
645200230126     C                   Eval      CarDis(cd#) = %trim(PLNCRC)
645300230126     C                   End
645400230126     C                   End
645500230126     C                   If        %trim(TermText) = 'TRM_EMP'
645600230126     C                   Eval      DateText = 'Term Date: '
645700230126     C                   Movel     BenTrmDt      PLDEFF
645800230126     C                   End
645900230126     C                   If        %trim(oegrpv) = 'ADD_COVG'
646000230126     C                   Eval      DateText = 'Eff Date: '
646100230126     C                   eval      TermText = *blanks
646200230126     C                   End
646300230126     C                   If        %trim(TermText) = 'TRM_COVG'
646400230126     C                   Eval      DateText = 'Term Date: '
646500230126     C                   End
646600230126     C                   If        %trim(TermText) = 'TRM_DEPC'
646700230126     C                   Eval      DateText = 'Term Date: '
646800230126     C                   End
646900230126     C                   Eval      l# = %lookup(%trim(PLDDSC):LPlan)
647000230126     C                   Eval      wpdesc = %trim(PLDDSC)
647100230126     C                   Select
647200230126     C                   When      %trim(B41HED) = *blanks  or
647300230126     C                             l# = 1
647400230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
647500230126     C                   eval      grptxt1 = 'Reason:'
647600230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
647700230126     C                                              pldctg)
647800230126         getdclreason();
647900230126     C                   eval      B41GRP = %trim(PCDESC)
648000230126     C                   eval      PLNCAR = *blanks
648100230126     C                   Else
648200230126     C                   eval      grptxt1 = 'Group#:'
648300230126     C                   Eval      B41GRP = %trim(PLNGRP)
648400230126     C                   End
648500230203     C                   If        %trim(WPDESC) <> *blanks
648600230126     C                   Eval      LPlan(1) = %trim(PLDDSC)
648700230126     C                   Eval      B41HED = %trim(WFDESC)
648800230126     C                   Eval      B41CAR = %trim(PLNCAR)
648900230126     C                   Eval      B41PLN = %trim(WPDESC)
649000230126     C                   Eval      B41COV = %trim(PLDLVL)
649100230126     C                   Eval      B41DSC = %trim(DateText)
649200230126     C                   If        B41DSC <> *blanks
649300230126     C                   Eval      B41DAT = #getusa(PLDEFF)
649400230126     C                   Else
649500230126     C                   Clear                   B41DAT
649600230203     C                   End
649700230203     C                   Endif
649800230126     C                   When      %trim(B42HED) = *blanks  or
649900230126     C                             l# = 2
650000230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
650100230126     C                   eval      grptxt2 = 'Reason:'
650200230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
650300230126     C                                              pldctg)
650400230126         getdclreason();
650500230126     C                   eval      B42GRP = %trim(PCDESC)
650600230126     C                   eval      PLNCAR = *blanks
650700230126     C                   Else
650800230126     C                   eval      grptxt2 = 'Group#:'
650900230126     C                   Eval      B42GRP = %trim(PLNGRP)
651000230126     C                   End
651100230126HRA1 C                   If        %trim(pldctg) = 'PHR'
651200230126HRA1 C                   eval      PLDLVL = #hraclvl(oetrst:oesub#:oeacct:
651300230126HRA1 C                                               oessno:pldeff)
651400230126HRA1 C                   End
651500230126     C                   Eval      LPlan(2) = %trim(PLDDSC)
651600230126     C                   Eval      B42HED = %trim(WFDESC)
651700230126     C                   Eval      B42CAR = %trim(PLNCAR)
651800230126     C                   Eval      B42PLN = %trim(WPDESC)
651900230126     C                   Eval      B42COV = %trim(PLDLVL)
652000230126     C                   Eval      B42DSC = %trim(DateText)
652100230126     C                   If        B42DSC <> *blanks
652200230126     C                   Eval      B42DAT = #getusa(PLDEFF)
652300230126     C                   Else
652400230126     C                   Clear                   B42DAT
652500230126     C                   End
652600230126     C                   When      %trim(B43HED) = *blanks  or
652700230126     C                             l# = 3
652800230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
652900230126     C                   eval      grptxt3 = 'Reason:'
653000230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
653100230126     C                                              pldctg)
653200230126         getdclreason();
653300230126     C                   eval      B43GRP = %trim(PCDESC)
653400230126     C                   eval      PLNCAR = *blanks
653500230126     C                   Else
653600230126     C                   eval      grptxt3 = 'Group#:'
653700230126     C                   Eval      B43GRP = %trim(PLNGRP)
653800230126     C                   End
653900230126     C                   Eval      LPlan(3) = %trim(PLDDSC)
654000230126     C                   Eval      B43HED = %trim(WFDESC)
654100230126     C                   Eval      B43CAR = %trim(PLNCAR)
654200230126     C                   Eval      B43PLN = %trim(WPDESC)
654300230126     C                   Eval      B43COV = %trim(PLDLVL)
654400230126     C                   Eval      B43DSC = %trim(DateText)
654500230126     C                   If        B43DSC <> *blanks
654600230126     C                   Eval      B43DAT = #getusa(PLDEFF)
654700230126     C                   Else
654800230126     C                   Clear                   B43DAT
654900230126     C                   End
655000230126     C                   When      %trim(B44HED) = *blanks  or
655100230126     C                             l# = 4
655200230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
655300230126     C                   eval      grptxt4 = 'Reason:'
655400230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
655500230126     C                                              pldctg)
655600230126         getdclreason();
655700230126     C                   eval      B44GRP = %trim(PCDESC)
655800230126     C                   eval      PLNCAR = *blanks
655900230126     C                   Else
656000230126     C                   eval      grptxt4 = 'Group#:'
656100230126     C                   Eval      B44GRP = %trim(PLNGRP)
656200230126     C                   End
656300230126     C                   Eval      LPlan(4) = %trim(PLDDSC)
656400230126     C                   Eval      B44HED = %trim(WFDESC)
656500230126     C                   Eval      B44CAR = %trim(PLNCAR)
656600230126     C                   Eval      B44PLN = %trim(WPDESC)
656700230126     C                   Eval      B44COV = %trim(PLDLVL)
656800230126     C                   Eval      B44DSC = %trim(DateText)
656900230126     C                   If        B44DSC <> *blanks
657000230126     C                   Eval      B44DAT = #getusa(PLDEFF)
657100230126     C                   Else
657200230126     C                   Clear                   B44DAT
657300230126     C                   End
657400230126     C                   When      %trim(B45HED) = *blanks  or
657500230126     C                             l# = 5
657600230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
657700230126     C                   eval      grptxt5 = 'Reason:'
657800230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
657900230126     C                                              pldctg)
658000230126         getdclreason();
658100230126     C                   eval      B45GRP = %trim(PCDESC)
658200230126     C                   eval      PLNCAR = *blanks
658300230126     C                   Else
658400230126     C                   eval      grptxt5 = 'Group#:'
658500230126     C                   Eval      B45GRP = %trim(PLNGRP)
658600230126     C                   End
658700230126     C                   Eval      LPlan(5) = %trim(PLDDSC)
658800230126     C                   Eval      B45HED = %trim(WFDESC)
658900230126     C                   Eval      B45CAR = %trim(PLNCAR)
659000230126     C                   Eval      B45PLN = %trim(WPDESC)
659100230126     C                   Eval      B45COV = %trim(PLDLVL)
659200230126     C                   Eval      B45DSC = %trim(DateText)
659300230126     C                   If        B45DSC <> *blanks
659400230126     C                   Eval      B45DAT = #getusa(PLDEFF)
659500230126     C                   Else
659600230126     C                   Clear                   B45DAT
659700230126     C                   End
659800230126     C                   When      %trim(B46HED) = *blanks  or
659900230126     C                             l# = 6
660000230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
660100230126     C                   eval      grptxt6 = 'Reason:'
660200230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
660300230126     C                                              pldctg)
660400230126         getdclreason();
660500230126     C                   eval      B46GRP = %trim(PCDESC)
660600230126     C                   eval      PLNCAR = *blanks
660700230126     C                   Else
660800230126     C                   eval      grptxt6 = 'Group#:'
660900230126     C                   Eval      B46GRP = %trim(PLNGRP)
661000230126     C                   End
661100230126     C                   Eval      LPlan(6) = %trim(PLDDSC)
661200230126     C                   Eval      B46HED = %trim(WFDESC)
661300230126     C                   Eval      B46CAR = %trim(PLNCAR)
661400230126     C                   Eval      B46PLN = %trim(WPDESC)
661500230126     C                   Eval      B46COV = %trim(PLDLVL)
661600230126     C                   Eval      B46DSC = %trim(DateText)
661700230126     C                   If        B46DSC <> *blanks
661800230126     C                   Eval      B46DAT = #getusa(PLDEFF)
661900230126     C                   Else
662000230126     C                   Clear                   B46DAT
662100230126     C                   End
662200230126     C                   When      %trim(B47HED) = *blanks  or
662300230126     C                             l# = 7
662400230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
662500230126     C                   eval      grptxt7 = 'Reason:'
662600230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
662700230126     C                                              pldctg)
662800230126         getdclreason();
662900230126     C                   eval      B47GRP = %trim(PCDESC)
663000230126     C                   eval      PLNCAR = *blanks
663100230126     C                   Else
663200230126     C                   eval      grptxt7 = 'Group#:'
663300230126     C                   Eval      B47GRP = %trim(PLNGRP)
663400230126     C                   End
663500230126     C                   Eval      LPlan(7) = %trim(PLDDSC)
663600230126     C                   Eval      B47HED = %trim(WFDESC)
663700230126     C                   Eval      B47CAR = %trim(PLNCAR)
663800230126     C                   Eval      B47PLN = %trim(WPDESC)
663900230126     C                   Eval      B47COV = %trim(PLDLVL)
664000230126     C                   Eval      B47DSC = %trim(DateText)
664100230126     C                   If        B47DSC <> *blanks
664200230126     C                   Eval      B47DAT = #getusa(PLDEFF)
664300230126     C                   Else
664400230126     C                   Clear                   B47DAT
664500230126     C                   End
664600230126     C                   When      %trim(B48HED) = *blanks  or
664700230126     C                             l# = 8
664800230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
664900230126     C                   eval      grptxt8 = 'Reason:'
665000230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
665100230126     C                                              pldctg)
665200230126         getdclreason();
665300230126     C                   eval      B48GRP = %trim(PCDESC)
665400230126     C                   eval      PLNCAR = *blanks
665500230126     C                   Else
665600230126     C                   eval      grptxt8 = 'Group#:'
665700230126     C                   Eval      B48GRP = %trim(PLNGRP)
665800230126     C                   End
665900230126     C                   Eval      LPlan(8) = %trim(PLDDSC)
666000230126     C                   Eval      B48HED = %trim(WFDESC)
666100230126     C                   Eval      B48CAR = %trim(PLNCAR)
666200230126     C                   Eval      B48PLN = %trim(WPDESC)
666300230126     C                   Eval      B48COV = %trim(PLDLVL)
666400230126     C                   Eval      B48DSC = %trim(DateText)
666500230126     C                   If        B48DSC <> *blanks
666600230126     C                   Eval      B48DAT = #getusa(PLDEFF)
666700230126     C                   Else
666800230126     C                   Clear                   B48DAT
666900230126     C                   End
667000230126     C                   When      %trim(B49HED) = *blanks  or
667100230126     C                             l# = 9
667200230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
667300230126     C                   eval      grptxt9 = 'Reason:'
667400230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
667500230126     C                                              pldctg)
667600230126          getdclreason();
667700230126     C                   eval      B49GRP = %trim(PCDESC)
667800230126     C                   eval      PLNCAR = *blanks
667900230126     C                   Else
668000230126     C                   eval      grptxt9 = 'Group#:'
668100230126     C                   Eval      B49GRP = %trim(PLNGRP)
668200230126     C                   End
668300230126     C                   Eval      LPlan(9) = %trim(PLDDSC)
668400230126     C                   Eval      wfdesc = #replace(wfdesc:'NONBILLABLE':'')
668500230126     C                   Eval      wfdesc = #replace(wfdesc:'NON-BILLABLE':'')
668600230126     C                   Eval      B49HED = %trim(WFDESC)
668700230126     C                   Eval      B49CAR = %trim(PLNCAR)
668800230126     C                   Eval      B49PLN = %trim(WPDESC)
668900230126     C                   Eval      B49COV = %trim(PLDLVL)
669000230126     C                   Eval      B49DSC = %trim(DateText)
669100230126     C                   If        B49DSC <> *blanks
669200230126     C                   Eval      B49DAT = #getusa(PLDEFF)
669300230126     C                   Else
669400230126     C                   Clear                   B49DAT
669500230126     C                   End
669600230126     C                   Other
669700230126     C                   Eval      po# = po# + 1
669800230126     C                   If        po# > 0 and po# <= 99
669900230126     C     po#           occur     webaplnids
670000230126     C                   end
670100230126     C                   Eval      OverPlan = 'Y'
670200230126     C                   Eval      OverFlow = 'Y'
670300230126     C                   If        %subst(WPDESC:1:8) = 'DECLINED'
670400230126     C                   eval      dclrsn = #dclrsn(oetrst:oesub#:oeacct:oessno:
670500230126     C                                              pldctg)
670600230126          getdclreason();
670700230126     C                   eval      AUCGRP = %trim(PCDESC)
670800230126     C                   eval      PLNCAR = *blanks
670900230126     C                   Else
671000230126     C                   Eval      AUCGRP = %trim(PLNGRP)
671100230126     C                   End
671200230126     C                   Eval      AUCBEN = %trim(WFDESC)
671300230126     C                   Eval      AUCCAR = %trim(PLNCAR)
671400230126     C                   Eval      AUCPLN = %trim(WPDESC)
671500230126     C                   Eval      AUCCVG = %trim(PLDLVL)
671600230126     C                   Eval      AUCDDS = %trim(DateText)
671700230126     C                   If        AUCDDS <> *blanks
671800230126     C                   Eval      AUCDAT = #getusa(PLDEFF)
671900230126     C                   End
672000230126     C                   Endsl
672100230126     C                   eval      termtext = *blanks
672200230126       end-proc;
672300230126
672400230126       dcl-proc  GETDCLREASON;
672500230126     C                   Eval      PCGRPR = 'DCL_REASON'
672600230126     C                   Eval      PCCODE = DCLRSN
672700230126     C                   Eval      PCTRST = OETRST
672800230126     C                   Eval      PCSUB# = OESUB#
672900230126     C                   Eval      PCACCT = OEACCT
673000230126     C                   Eval      PCDESC = *Blanks
673100230126     C     KEYCODE       Chain     WEBPAYCHP
673200230126     C                   If        not %found(WEBPAYCHP)
673300230126     C                   Eval      PCTRST = 0
673400230126     C                   Eval      PCSUB# = 0
673500230126     C                   Eval      PCACCT = 0
673600230126     C     KEYCODE       Chain     WEBPAYCHP
673700230126     C                   EndIf
673800230126       end-proc;
673900230126
674000230126       dcl-proc  TOOL_DEMO;
674100230126     C                   If        In_Tool = ' '
674200230126           Return;
674300230126     C                   EndIf
674400230126     C                   select
674500230126     C                   when      %subst(oefldv:1:5) = 'BIRTH'
674600230126     C                   movel     oeafter       birth
674700230126     C                   eval      wiso   = #getiso(birth)
674800230126     C                   eval      wbirth = wiso
674900230126     C                   when      %subst(oefldv:1:5) = 'MARDT'
675000230126     C                   movel     oeafter       mardt
675100230126     C                   eval      wiso   = #getiso(mardt)
675200230126     C                   eval      wmardt = wiso
675300230126     C                   when      %subst(oefldv:1:5) = 'PYMAR'
675400230126     C                   movel     oeafter       mardt
675500230126     C                   eval      wiso   = #getiso(mardt)
675600230126     C                   eval      wmardt = wiso
675700230126     C                   when      %subst(oefldv:1:5) = 'EMPDT'
675800230126     C                   movel     oeafter       empdt
675900230126     C                   eval      wiso   = #getiso(empdt)
676000230126     C                   eval      wempdt = wiso
676100230126     C                   when      %subst(oefldv:1:7) = 'PYSALDT'
676200230126     C                   movel     oeafter       salarydt
676300230126     C                   eval      wiso   = #getiso(salarydt)
676400230126     C                   eval      wsaleff = wiso
676500230126     C                   when      %subst(oefldv:1:5) = 'PYMGS'
676600230126     C                   movel     oeafter       pymgs
676700230126     C                   Eval      PCGRPR = 'MARSTAT'
676800230126     C                   Eval      PCCODE = PYMGS
676900230126     C                   Eval      PCTRST = OETRST
677000230126     C                   Eval      PCSUB# = OESUB#
677100230126     C                   Eval      PCACCT = OEACCT
677200230126     C     KEYCODE       Chain     WEBPAYCHP
677300230126     C                   If        not %found(WEBPAYCHP)
677400230126     C                   Eval      PCTRST = 0
677500230126     C                   Eval      PCSUB# = 0
677600230126     C                   Eval      PCACCT = 0
677700230126     C     KEYCODE       Chain     WEBPAYCHP
677800230126     C                   End
677900230126     C                   Eval      wmarsts = %trim(PCDESC)
678000230126     C                   when      %subst(oefldv:1:5) = 'PYHRS'
678100230126     C                   movel     oeafter       pyhrs
678200230126     C                   Eval      hrswrk = pyhrs
678300230126     C                   when      %subst(oefldv:1:5) = 'PYOCC'
678400230126     C                   movel     oeafter       pyocc
678500230126     C                   Eval      pcdesc = *blanks
678600230126     C                   Eval      PCGRPR = 'JOBTITLE'
678700230126     C                   Eval      PCCODE = PYOCC
678800230126     C                   Eval      PCTRST = OETRST
678900230126     C                   Eval      PCSUB# = OESUB#
679000230126     C                   Eval      PCACCT = OEACCT
679100230126     C     KEYCODE       Chain     WEBPAYCHP
679200230126     C                   If        %found(WEBPAYCHP)
679300230126     C                   Eval      Occupation = %trim(PCDESC)
679400230126     C                   Else
679500230126     C                   Eval      Occupation = %trim(PYOCC)
679600230126     C                   End
679700230126     C                   when      %subst(oefldv:1:5) = 'PYEEO'
679800230126     C                   movel     oeafter       pyeeo
679900230126     C                   Eval      PCGRPR = 'EEOC'
680000230126     C                   Eval      PCCODE = PYEEO
680100230126     C                   Eval      PCTRST = OETRST
680200230126     C                   Eval      PCSUB# = OESUB#
680300230126     C                   Eval      PCACCT = OEACCT
680400230126     C     KEYCODE       Chain     WEBPAYCHP
680500230126     C                   If        not %found(WEBPAYCHP)
680600230126     C                   Eval      PCTRST = 0
680700230126     C                   Eval      PCSUB# = 0
680800230126     C                   Eval      PCACCT = 0
680900230126     C     KEYCODE       Chain     WEBPAYCHP
681000230126     C                   End
681100230126     C                   Eval      Occupation = %trim(PCDESC)
681200230126     C                   endsl
681300230126       end-proc;
681400230126
681500230126       dcl-proc  COB_SUBS;
681600230126     C                   Select
681700230126     C                   When      %subst(OEFLDV:1:8) = 'COB_SUBS'
681800230126     C                   If        %trim(oegrpv) <> 'ADD_EMP'
681900230126     C                   Eval      webcod = #webcod(oegrpv:'HEADER')
682000230126     C                   Eval      n# = n# + 1
682100230126     C                   Eval      NoteA(n#) = %trim(WCDESC)
682200230126     C                   End
682300230126     C                   If        multid > 1
682400230126     C                   Eval      cossid = *blanks
682500230126     C                   Else
682600230126     C                   Eval      cossid = %trim(oessid)
682700230126     C                   End
682800230126     C                   Eval      webcobd = #getcob(oetrst:oesub#:oeacct:
682900230126     C                                               oessno:oedseq:cossid)
683000230126     C                   If        %trim(bcbscity) <> *blanks
683100230126     C                   Eval      n# = n# + 1
683200230126     C                   Eval      NoteA(n#) = 'BCBS City:' + %trim(bcbscity)
683300230126     C                   End
683400230126     C                   If        %trim(bcbsstat) <> *blanks
683500230126     C                   Eval      n# = n# + 1
683600230126     C                   Eval      NoteA(n#) = 'BCBS State:' + %trim(bcbsstat)
683700230126     C                   End
683800230126     C                   When      %subst(OEFLDV:1:13) = 'HANDICAP_FLAG' and
683900230126     C                             %trim(OEAFTER) = 'Y'
684000230126     C                   Eval      n# = n# + 1
684100230126     C                   Eval      NoteA(n#) = 'VERIFY HANDICAP'
684200230126     C                   When      %subst(OEFLDV:1:13) = 'MEDICARE_FLAG' and
684300230126     C                             %trim(OEAFTER) = 'Y'
684400230126     C                   Eval      n# = n# + 1
684500230126     C                   Eval      NoteA(n#) = 'VERIFY MEDICARE'
684600230126     C                   Endsl
684700230126       end-proc;
684800230126
684900230126       dcl-proc  BENLINENAM;
685000230126     C                   Select
685100230126     C                   When      %trim(b51nam) = *blanks
685200230126     C                   Eval      b51nam = %trim(OEAFTER)
685300230126           contingent();
685400230126     C                   If        contflg = 'Y'
685500230126     C                   Eval      b51nam = *blanks
685600230126     C                   Eval      bo# = bo# + 1
685700230126     C     bo#           occur     webabenids
685800230126     C                   Eval      OverBen = 'Y'
685900230126     C                   Eval      OverFlow = 'Y'
686000230126     C                   Eval      aubben  = %trim(OEAFTER)
686100230126     C                   End
686200230126     C                   When      %trim(b52nam) = *blanks
686300230126     C                   Eval      b52nam = %trim(OEAFTER)
686400230126           contingent();
686500230126     C                   If        contflg = 'Y'
686600230126     C                   Eval      b52nam = *blanks
686700230126     C                   Eval      bo# = bo# + 1
686800230126     C     bo#           occur     webabenids
686900230126     C                   Eval      OverBen = 'Y'
687000230126     C                   Eval      OverFlow = 'Y'
687100230126     C                   Eval      aubben  = %trim(OEAFTER)
687200230126     C                   End
687300230126     C                   When      %trim(b53nam) = *blanks
687400230126     C                   Eval      b53nam = %trim(OEAFTER)
687500230126           contingent();
687600230126     C                   If        contflg = 'Y'
687700230126     C                   Eval      b53nam = *blanks
687800230126     C                   Eval      bo# = bo# + 1
687900230126     C     bo#           occur     webabenids
688000230126     C                   Eval      OverBen = 'Y'
688100230126     C                   Eval      OverFlow = 'Y'
688200230126     C                   Eval      aubben  = %trim(OEAFTER)
688300230126     C                   End
688400230126     C                   When      %trim(b54nam) = *blanks
688500230126     C                   Eval      b54nam = %trim(OEAFTER)
688600230126           contingent();
688700230126     C                   If        contflg = 'Y'
688800230126     C                   Eval      b54nam = *blanks
688900230126     C                   Eval      bo# = bo# + 1
689000230126     C     bo#           occur     webabenids
689100230126     C                   Eval      OverBen = 'Y'
689200230126     C                   Eval      OverFlow = 'Y'
689300230126     C                   Eval      aubben  = %trim(OEAFTER)
689400230126     C                   End
689500230126     C                   When      %trim(b55nam) = *blanks
689600230126     C                   Eval      b55nam = %trim(OEAFTER)
689700230126           contingent();
689800230126     C                   If        contflg = 'Y'
689900230126     C                   Eval      b55nam = *blanks
690000230126     C                   Eval      bo# = bo# + 1
690100230126     C     bo#           occur     webabenids
690200230126     C                   Eval      OverBen = 'Y'
690300230126     C                   Eval      OverFlow = 'Y'
690400230126     C                   Eval      aubben  = %trim(OEAFTER)
690500230126     C                   End
690600230130     C                   When      %trim(b56nam) = *blanks
690700230130     C                   Eval      b56nam = %trim(OEAFTER)
690800230130           contingent();
690900230130     C                   If        contflg = 'Y'
691000230130     C                   Eval      b56nam = *blanks
691100230130     C                   Eval      bo# = bo# + 1
691200230130     C     bo#           occur     webabenids
691300230130     C                   Eval      OverBen = 'Y'
691400230130     C                   Eval      OverFlow = 'Y'
691500230130     C                   Eval      aubben  = %trim(OEAFTER)
691600230130     C                   End
691700230126     C                   Endsl
691800230126       end-proc;
691900230126
692000230126       dcl-proc  CONLINENAM;
692100230126          contingent();
692200230126     C                   If        contflg = 'Y'
692300230126     C                   Eval      bo# = bo# + 1
692400230126     C     bo#           occur     webabenids
692500230126     C                   Eval      OverBen = 'Y'
692600230126     C                   Eval      OverFlow = 'Y'
692700230126     C                   Eval      aubben  = %trim(OEAFTER)
692800230126     C                   End
692900230126       end-proc;
693000230126
693100230126       dcl-proc  BENLINEPLN;
693200230126     C                   Select
693300230126     C                   When      %trim(b51pln)= *blanks
693400230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
693500230126     C                                        oeacct:pldeff:%trim(oeafter))
693600230126     C                   Eval      b51pln = %trim(cndsc)
693700230126         contingent();
693800230126     C                   If        contflg = 'Y'
693900230126     C                   Eval      b51pln = *blanks
694000230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
694100230126     C                                        oeacct:pldeff:%trim(oeafter))
694200230126     C                   Eval      aubpln = %trim(cndsc)
694300230126     C                   Eval      aubcov = %trim(oeafter)
694400230126     C                   End
694500230126     C                   When      %trim(b52pln)= *blanks
694600230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
694700230126     C                                        oeacct:pldeff:%trim(oeafter))
694800230126     C                   Eval      b52pln = %trim(cndsc)
694900230126         contingent();
695000230126     C                   If        contflg = 'Y'
695100230126     C                   Eval      b52pln = *blanks
695200230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
695300230126     C                                        oeacct:pldeff:%trim(oeafter))
695400230126     C                   Eval      aubpln = %trim(cndsc)
695500230126     C                   Eval      aubcov = %trim(oeafter)
695600230126     C                   End
695700230126     C                   When      %trim(b53pln)= *blanks
695800230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
695900230126     C                                        oeacct:pldeff:%trim(oeafter))
696000230126     C                   Eval      b53pln = %trim(cndsc)
696100230126         contingent();
696200230126     C                   If        contflg = 'Y'
696300230126     C                   Eval      b53pln = *blanks
696400230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
696500230126     C                                        oeacct:pldeff:%trim(oeafter))
696600230126     C                   Eval      aubpln = %trim(cndsc)
696700230126     C                   Eval      aubcov = %trim(oeafter)
696800230126     C                   End
696900230126     C                   When      %trim(b54pln)= *blanks
697000230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
697100230126     C                                        oeacct:pldeff:%trim(oeafter))
697200230126     C                   Eval      b54pln = %trim(cndsc)
697300230126         contingent();
697400230126     C                   If        contflg = 'Y'
697500230126     C                   Eval      b54pln = *blanks
697600230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
697700230126     C                                        oeacct:pldeff:%trim(oeafter))
697800230126     C                   Eval      aubpln = %trim(cndsc)
697900230126     C                   Eval      aubcov = %trim(oeafter)
698000230126     C                   End
698100230126     C                   When      %trim(b55pln)= *blanks
698200230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
698300230126     C                                        oeacct:pldeff:%trim(oeafter))
698400230126     C                   Eval      b55pln = %trim(cndsc)
698500230126         contingent();
698600230126     C                   If        contflg = 'Y'
698700230126     C                   Eval      b55pln = *blanks
698800230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
698900230126     C                                        oeacct:pldeff:%trim(oeafter))
699000230126     C                   Eval      aubpln = %trim(cndsc)
699100230126     C                   Eval      aubcov = %trim(oeafter)
699200230126     C                   End
699300230130     C                   When      %trim(b56pln)= *blanks
699400230130     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
699500230130     C                                        oeacct:pldeff:%trim(oeafter))
699600230130     C                   Eval      b56pln = %trim(cndsc)
699700230130         contingent();
699800230130     C                   If        contflg = 'Y'
699900230130     C                   Eval      b56pln = *blanks
700000230130     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
700100230130     C                                        oeacct:pldeff:%trim(oeafter))
700200230130     C                   Eval      aubpln = %trim(cndsc)
700300230130     C                   Eval      aubcov = %trim(oeafter)
700400230130     C                   End
700500230126     C                   Other
700600230126     C                   Endsl
700700230126       end-proc;
700800230126
700900230126       dcl-proc  CONLINEPLN;
701000230126         contingent();
701100230126     C                   If        contflg = 'Y'
701200230126     C                   Eval      webnote = #getnot(pldctg:oetrst:oesub#:
701300230126     C                                        oeacct:pldeff:%trim(oeafter))
701400230126     C                   Eval      aubpln = %trim(cndsc)
701500230126     C                   Eval      aubcov = %trim(oeafter)
701600230126     C                   End
701700230126       end-proc;
701800230126
701900230126       dcl-proc  BENLINEREL;
702000230126     C                   Select
702100230126     C                   When      %trim(b51rel)= *blanks
702200230126     C                   Eval      b51rel = #getrel(%trim(OEAFTER))
702300230126         contingent();
702400230126     C                   If        contflg = 'Y'
702500230126     C                   Eval      b51rel = *blanks
702600230126     C                   Eval      aubrlt  = #getrel(%trim(OEAFTER))
702700230126     C                   End
702800230126     C                   When      %trim(b52rel)= *blanks
702900230126     C                   Eval      b52rel = #getrel(%trim(OEAFTER))
703000230126         contingent();
703100230126     C                   If        contflg = 'Y'
703200230126     C                   Eval      b52rel = *blanks
703300230126     C                   Eval      aubrlt  = #getrel(%trim(OEAFTER))
703400230126     C                   End
703500230126     C                   When      %trim(b53rel)= *blanks
703600230126     C                   Eval      b53rel = #getrel(%trim(OEAFTER))
703700230126         contingent();
703800230126     C                   If        contflg = 'Y'
703900230126     C                   Eval      b53rel = *blanks
704000230126     C                   Eval      aubrlt  = #getrel(%trim(OEAFTER))
704100230126     C                   End
704200230126     C                   When      %trim(b54rel)= *blanks
704300230126     C                   Eval      b54rel = #getrel(%trim(OEAFTER))
704400230126         contingent();
704500230126     C                   If        contflg = 'Y'
704600230126     C                   Eval      b54rel = *blanks
704700230126     C                   Eval      aubrlt  = #getrel(%trim(OEAFTER))
704800230126     C                   End
704900230126     C                   When      %trim(b55rel)= *blanks
705000230126     C                   Eval      b55rel = #getrel(%trim(OEAFTER))
705100230126         contingent();
705200230126     C                   If        contflg = 'Y'
705300230126     C                   Eval      b55rel = *blanks
705400230126     C                   Eval      aubrlt  = #getrel(%trim(OEAFTER))
705500230126     C                   End
705600230130     C                   When      %trim(b56rel)= *blanks
705700230130     C                   Eval      b56rel = #getrel(%trim(OEAFTER))
705800230130         contingent();
705900230130     C                   If        contflg = 'Y'
706000230130     C                   Eval      b56rel = *blanks
706100230130     C                   Eval      aubrlt  = #getrel(%trim(OEAFTER))
706200230130     C                   End
706300230126     C                   Other
706400230126     C                   Endsl
706500230126       end-proc;
706600230126
706700230126       dcl-proc  CONLINEREL;
706800230126          contingent();
706900230126     C                   If        contflg = 'Y'
707000230126     C                   Eval      aubrlt  = #getrel(%trim(OEAFTER))
707100230126     C                   End
707200230126       end-proc;
707300230126
707400230126       dcl-proc  BENLINEPER;
707500230126     C                   Select
707600230126     C                   When      %trim(b51per) = *blanks
707700230126     C                   Eval      b51per = %trim(OEAFTER)
707800230126          contingent();
707900230126     C                   If        contflg = 'Y'
708000230126     C                   Eval      b51per = *blanks
708100230126     C                   Eval      aubper  = %trim(OEAFTER)
708200230126     C                   End
708300230126     C                   When      %trim(b52per) = *blanks
708400230126     C                   Eval      b52per = %trim(OEAFTER)
708500230126          contingent();
708600230126     C                   If        contflg = 'Y'
708700230126     C                   Eval      b52per = *blanks
708800230126     C                   Eval      aubper  = %trim(OEAFTER)
708900230126     C                   End
709000230126     C                   When      %trim(b53per) = *blanks
709100230126     C                   Eval      b53per = %trim(OEAFTER)
709200230126          contingent();
709300230126     C                   If        contflg = 'Y'
709400230126     C                   Eval      b53per = *blanks
709500230126     C                   Eval      aubper  = %trim(OEAFTER)
709600230126     C                   End
709700230126     C                   When      %trim(b54per) = *blanks
709800230126     C                   Eval      b54per = %trim(OEAFTER)
709900230126          contingent();
710000230126     C                   If        contflg = 'Y'
710100230126     C                   Eval      b54per = *blanks
710200230126     C                   Eval      aubper  = %trim(OEAFTER)
710300230126     C                   End
710400230126     C                   When      %trim(b55per) = *blanks
710500230126     C                   Eval      b55per = %trim(OEAFTER)
710600230126          contingent();
710700230126     C                   If        contflg = 'Y'
710800230126     C                   Eval      b55per = *blanks
710900230126     C                   Eval      aubper  = %trim(OEAFTER)
711000230126     C                   End
711100230130     C                   When      %trim(b56per) = *blanks
711200230130     C                   Eval      b56per = %trim(OEAFTER)
711300230130          contingent();
711400230130     C                   If        contflg = 'Y'
711500230130     C                   Eval      b56per = *blanks
711600230130     C                   Eval      aubper  = %trim(OEAFTER)
711700230130     C                   End
711800230126     C                   Other
711900230126     C                   Endsl
712000230126       end-proc;
712100230126
712200230126       dcl-proc  CONLINEPER;
712300230126          contingent();
712400230126     C                   If        contflg = 'Y'
712500230126     C                   Eval      aubper  = %trim(OEAFTER)
712600230126     C                   End
712700230126       end-proc;
712800230126
712900230126       dcl-proc  BENLINEEFF;
713000230126     C                   Select
713100230126     C                   When      %char(b51eff) = '01/01/0001'
713200230126     C                   Movel     oeafter       w80date
713300230126     C                   Eval      b51eff = #getusa(w80date)
713400230126         contingent();
713500230126     C                   If        contflg = 'Y'
713600230126     C                   clear                   b51eff
713700230126     C                   Movel     oeafter       w80date
713800230126     C                   Eval      aubeff  = #getusa(w80date)
713900230126     C                   End
714000230126     C                   When      %char(b52eff) = '01/01/0001'
714100230126     C                   Movel     oeafter       w80date
714200230126     C                   Eval      b52eff = #getusa(w80date)
714300230126         contingent();
714400230126     C                   If        contflg = 'Y'
714500230126     C                   clear                   b52eff
714600230126     C                   Movel     oeafter       w80date
714700230126     C                   Eval      aubeff  = #getusa(w80date)
714800230126     C                   End
714900230126     C                   When      %char(b53eff) = '01/01/0001'
715000230126     C                   Movel     oeafter       w80date
715100230126     C                   Eval      b53eff = #getusa(w80date)
715200230126         contingent();
715300230126     C                   If        contflg = 'Y'
715400230126     C                   clear                   b53eff
715500230126     C                   Movel     oeafter       w80date
715600230126     C                   Eval      aubeff  = #getusa(w80date)
715700230126     C                   End
715800230126     C                   When      %char(b54eff) = '01/01/0001'
715900230126     C                   Movel     oeafter       w80date
716000230126     C                   Eval      b54eff = #getusa(w80date)
716100230126         contingent();
716200230126     C                   If        contflg = 'Y'
716300230126     C                   clear                   b54eff
716400230126     C                   Movel     oeafter       w80date
716500230126     C                   Eval      aubeff  = #getusa(w80date)
716600230126     C                   End
716700230126     C                   When      %char(b55eff) = '01/01/0001'
716800230126     C                   Movel     oeafter       w80date
716900230126     C                   Eval      b55eff = #getusa(w80date)
717000230126         contingent();
717100230126     C                   If        contflg = 'Y'
717200230126     C                   clear                   b55eff
717300230126     C                   Movel     oeafter       w80date
717400230126     C                   Eval      aubeff  = #getusa(w80date)
717500230126     C                   End
717600230130     C                   When      %char(b56eff) = '01/01/0001'
717700230130     C                   Movel     oeafter       w80date
717800230130     C                   Eval      b56eff = #getusa(w80date)
717900230130         contingent();
718000230130     C                   If        contflg = 'Y'
718100230130     C                   clear                   b56eff
718200230130     C                   Movel     oeafter       w80date
718300230130     C                   Eval      aubeff  = #getusa(w80date)
718400230130     C                   End
718500230126     C                   Other
718600230126     C                   Endsl
718700230126       end-proc;
718800230126
718900230126       dcl-proc  CONLINEEFF;
719000230126           contingent();
719100230126     C                   If        contflg = 'Y'
719200230126     C                   Movel     oeafter       w80date
719300230126     C                   Eval      aubeff  = #getusa(w80date)
719400230126     C                   End
719500230126       end-proc;
719600230126
719700230126       dcl-proc  CONTINGENT;
719800230126     C                   Eval      contflg = 'N'
719900230126     C                   Eval      CO# = %scan('LINE6':%trim(OEFLDV))
720000230126     C                   If        CO# > 0
720100230126     C                   Eval      contflg = 'Y'
720200230126          return;
720300230126     C                   End
720400230126     C                   Eval      CO# = %scan('LINE7':%trim(OEFLDV))
720500230126     C                   If        CO# > 0
720600230126     C                   Eval      contflg = 'Y'
720700230126          return;
720800230126     C                   End
720900230126     C                   Eval      CO# = %scan('LINE8':%trim(OEFLDV))
721000230126     C                   If        CO# > 0
721100230126     C                   Eval      contflg = 'Y'
721200230126          return;
721300230126     C                   End
721400230126     C                   Eval      CO# = %scan('LINE9':%trim(OEFLDV))
721500230126     C                   If        CO# > 0
721600230126     C                   Eval      contflg = 'Y'
721700230126          return;
721800230126     C                   End
721900230126     C                   Eval      CO# = %scan('LINE10':%trim(OEFLDV))
722000230126     C                   If        CO# > 0
722100230126     C                   Eval      contflg = 'Y'
722200230126          return;
722300230126     C                   End
722400230127       end-proc;
722500230130       dcl-proc  PLANOVERFLOW;
722600230127
722700230203       // If P_Count < 2;
722800230130       P_Count = 0;
722900230203       // PLN001 = *blanks;
723000230203       // PLN002 = *blanks;
723100230203       // write PLANSR;
723200230203       // return;
723300230203       // endif;
723400230203
723500230203       If G_Count < 52;
723600230203       return;
723700230203       endif;
723800230203
723900230203       //PLN001 = getmessage('LINE113');
724000230203       //PLN001 = %ScanRpl( '@J' : %char(g_count): PLN001);
724100230203       //PLN002 = *blanks;
724200230203       //write PLANSR;
724300230127
724400230127       write HEADER1;
724500230127
724600230210       // write HEADER2;
724700230127
724800230210       // write HEADER3;
724900230127
725000230127       POS_X = 1.95;
725100230203       g_count = 0;
725200230127
725300230127       Exec Sql
725400230127          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
725500230127             || Year(Current_Date)
725600230127             Into :wline
725700230127             From sysibm.sysdummy1 ;
725800230127
725900230127       COX001 = 'Date: ' + %trim(wline);
726000230127       COX002 = 'Session Id: ' + %trim(in_OESSID);
726100230127       COX003 = 'Transaction Type: Online Enrollment';
726200230127       write Data3;
726300230210
726400230210           CurDate = %int(%char(%date : *iso0));
726500230210           CurTime = %Dec(%Time);
726600230210          pdate = #getusa(CurDate);
726700230210          sdate = #getusa(IN_oesigd);
726800230210          COX001 = 'Print Date: ' + %char(pdate)  +
726900230210                    '   Time: ' +  %editw(CurTime:'  :  :  ');
727000230322          COX002 = %trim(wwname);
727100230210          COX003 =  'Signed Date: ' + %char(sdate)  +
727200230210                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
727300230210          write Data3;
727400230210
727500230210          COX001 = *blanks;
727600230210          COX002 = *blanks;
727700230210          COX003 = *blanks;
727800230210          write Data3;
727900230130
728000230306       BOLD01 = 'BENEFIT ELECTIONS Continued...';
728100230130       write BOLD;
728200230203       g_count = g_count + 1;
728300230306       write ULINE;
728400230130
728500230130       PLN001 = *blanks;
728600230130       PLN002 = *blanks;
728700230130       write PLANSR;
728800230203       g_count = g_count + 1;
728900230130
729000230127       end-proc;
729100230203       dcl-proc  LIFEOVERFLOW;
729200230203
729300230203       If G_Count < 50;
729400230203       return;
729500230203       endif;
729600230203
729700230203       write HEADER1;
729800230203
729900230203       POS_X = 1.95;
730000230203
730100230203       Exec Sql
730200230203          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
730300230203             || Year(Current_Date)
730400230203             Into :wline
730500230203             From sysibm.sysdummy1 ;
730600230203
730700230203       COX001 = 'Date: ' + %trim(wline);
730800230203       COX002 = 'Session Id: ' + %trim(in_OESSID);
730900230203       COX003 = 'Transaction Type: Online Enrollment';
731000230203       write Data3;
731100230210
731200230210           CurDate = %int(%char(%date : *iso0));
731300230210           CurTime = %Dec(%Time);
731400230210          pdate = #getusa(CurDate);
731500230210          sdate = #getusa(IN_oesigd);
731600230210          COX001 = 'Print Date: ' + %char(pdate)  +
731700230210                    '   Time: ' +  %editw(CurTime:'  :  :  ');
731800230322          COX002 = %trim(wwname);
731900230210          COX003 =  'Signed Date: ' + %char(sdate)  +
732000230210                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
732100230210          write Data3;
732200230210
732300230210          COX001 = *blanks;
732400230210          COX002 = *blanks;
732500230210          COX003 = *blanks;
732600230210          write Data3;
732700230203
732800230203       if skip_cont <> 'Y';
732900230306       BOLD01 = 'LIFE INSURANCE BENEFICIARY Continued...';
733000230203       write BOLD;
733100230307       g_count = g_count + 1;
733200230306       write ULINE;
733300230203       endif;
733400230203
733500230203       PLN001 = *blanks;
733600230203       PLN002 = *blanks;
733700230203       write PLANSR;
733800230203       g_count = g_count + 1;
733900230227
734000230227       g_count = 1;
734100230203
734200230203       end-proc;
734300230203       dcl-proc  CERTOVERFLOW;
734400230203
734500230203       if g_count < 40;
734600230203       return;
734700230203       endif;
734800230203
734900230203       write HEADER1;
735000230203
735100230210       // write HEADER2;
735200230203
735300230210       // write HEADER3;
735400230203
735500230203       POS_X = 1.95;
735600230203       g_count = 0;
735700230203
735800230203       Exec Sql
735900230203          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
736000230203             || Year(Current_Date)
736100230203             Into :wline
736200230203             From sysibm.sysdummy1 ;
736300230203
736400230203       COX001 = 'Date: ' + %trim(wline);
736500230203       COX002 = 'Session Id: ' + %trim(in_OESSID);
736600230203       COX003 = 'Transaction Type: Online Enrollment';
736700230203       write Data3;
736800230210
736900230210           CurDate = %int(%char(%date : *iso0));
737000230210           CurTime = %Dec(%Time);
737100230210          pdate = #getusa(CurDate);
737200230210          sdate = #getusa(IN_oesigd);
737300230210          COX001 = 'Print Date: ' + %char(pdate)  +
737400230210                    '   Time: ' +  %editw(CurTime:'  :  :  ');
737500230322          COX002 = %trim(wwname);
737600230210          COX003 =  'Signed Date: ' + %char(sdate)  +
737700230210                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
737800230210          write Data3;
737900230210
738000230210          COX001 = *blanks;
738100230210          COX002 = *blanks;
738200230210          COX003 = *blanks;
738300230210          write Data3;
738400230203
738500230203
738600230203       end-proc;
738700230127       dcl-proc  BEN_DUPLICATES;
738800230127     C                   If        b51nam <> *blanks  and
738900230127     C                             b51nam = b52nam and
739000230127     C                             b51pln = b52pln and
739100230127     C                             b51per = b52per
739200230127     C                   eval      b52nam = *blanks
739300230127     C                   eval      b52rel = *blanks
739400230127     C                   eval      b52per = *blanks
739500230127     C                   eval      b52pln = *blanks
739600230127     C                   clear                   b52eff
739700230127     C                   End
739800230127     C                   If        b51nam <> *blanks  and
739900230127     C                             b51nam = b53nam and
740000230127     C                             b51pln = b53pln and
740100230127     C                             b51per = b53per
740200230127     C                   eval      b53nam = *blanks
740300230127     C                   eval      b53rel = *blanks
740400230127     C                   eval      b53per = *blanks
740500230127     C                   eval      b53pln = *blanks
740600230127     C                   clear                   b53eff
740700230127     C                   End
740800230127     C                   If        b51nam <> *blanks  and
740900230127     C                             b51nam = b54nam and
741000230127     C                             b51pln = b54pln and
741100230127     C                             b51per = b54per
741200230127     C                   eval      b54nam = *blanks
741300230127     C                   eval      b54rel = *blanks
741400230127     C                   eval      b54per = *blanks
741500230127     C                   eval      b54pln = *blanks
741600230127     C                   clear                   b54eff
741700230127     C                   End
741800230127     C                   If        b51nam <> *blanks  and
741900230127     C                             b51nam = b55nam and
742000230127     C                             b51pln = b55pln and
742100230127     C                             b51per = b55per
742200230127     C                   eval      b55nam = *blanks
742300230127     C                   eval      b55rel = *blanks
742400230127     C                   eval      b55per = *blanks
742500230127     C                   eval      b55pln = *blanks
742600230127     C                   clear                   b55eff
742700230127     C                   End
742800230127     C                   If        b52nam <> *blanks  and
742900230127     C                             b52nam = b53nam and
743000230127     C                             b52pln = b53pln and
743100230127     C                             b52per = b53per
743200230127     C                   eval      b53nam = *blanks
743300230127     C                   eval      b53rel = *blanks
743400230127     C                   eval      b53per = *blanks
743500230127     C                   eval      b53pln = *blanks
743600230127     C                   clear                   b53eff
743700230127     C                   End
743800230127     C                   If        b52nam <> *blanks  and
743900230127     C                             b52nam = b54nam and
744000230127     C                             b52pln = b54pln and
744100230127     C                             b52per = b54per
744200230127     C                   eval      b54nam = *blanks
744300230127     C                   eval      b54rel = *blanks
744400230127     C                   eval      b54per = *blanks
744500230127     C                   eval      b54pln = *blanks
744600230127     C                   clear                   b54eff
744700230127     C                   End
744800230127     C                   If        b52nam <> *blanks  and
744900230127     C                             b52nam = b55nam and
745000230127     C                             b52pln = b55pln and
745100230127     C                             b52per = b55per
745200230127     C                   eval      b55nam = *blanks
745300230127     C                   eval      b55rel = *blanks
745400230127     C                   eval      b55per = *blanks
745500230127     C                   eval      b55pln = *blanks
745600230127     C                   clear                   b55eff
745700230127     C                   End
745800230127     C                   If        b53nam <> *blanks  and
745900230127     C                             b53nam = b54nam and
746000230127     C                             b53pln = b54pln and
746100230127     C                             b53per = b54per
746200230127     C                   eval      b54nam = *blanks
746300230127     C                   eval      b54rel = *blanks
746400230127     C                   eval      b54per = *blanks
746500230127     C                   eval      b54pln = *blanks
746600230127     C                   clear                   b54eff
746700230127     C                   End
746800230127     C                   If        b53nam <> *blanks  and
746900230127     C                             b53nam = b55nam and
747000230127     C                             b53pln = b55pln and
747100230127     C                             b53per = b55per
747200230127     C                   eval      b55nam = *blanks
747300230127     C                   eval      b55rel = *blanks
747400230127     C                   eval      b55per = *blanks
747500230127     C                   eval      b55pln = *blanks
747600230127     C                   clear                   b55eff
747700230127     C                   End
747800230127     C                   If        b54nam <> *blanks  and
747900230127     C                             b54nam = b55nam and
748000230127     C                             b54pln = b55pln and
748100230127     C                             b54per = b55per
748200230127     C                   eval      b55nam = *blanks
748300230127     C                   eval      b55rel = *blanks
748400230127     C                   eval      b55per = *blanks
748500230127     C                   eval      b55pln = *blanks
748600230127     C                   clear                   b55eff
748700230127     C                   End
748800230127       end-proc;
748900230130       dcl-proc  NOTEOVERFLOW;
749000230407
749100230407       if no# >=  95;
749200230407       no# = 99;
749300230407       endif;
749400230130
749500230130       If N_Count <> 0 and N_Count < 10;
749600230130       return;
749700230130       endif;
749800230203
749900230227       If G_Count <= 35;
750000230203       return;
750100230203       endif;
750200230203
750300230203       //PLN001 = getmessage('LINE113');
750400230203       //PLN001 = %ScanRpl( '@J' : %char(g_count): PLN001);
750500230203       //PLN002 = *blanks;
750600230203       //write PLANSR;
750700230130
750800230130       write HEADER1;
750900230130
751000230210       // write HEADER2;
751100230130
751200230210       // write HEADER3;
751300230130
751400230130       POS_X = 1.95;
751500230203       g_count = 0;
751600230130
751700230130       Exec Sql
751800230130          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
751900230130             || Year(Current_Date)
752000230130             Into :wline
752100230130             From sysibm.sysdummy1 ;
752200230130
752300230130       COX001 = 'Date: ' + %trim(wline);
752400230130       COX002 = 'Session Id: ' + %trim(in_OESSID);
752500230130       COX003 = 'Transaction Type: Online Enrollment';
752600230130       write Data3;
752700230210
752800230210           CurDate = %int(%char(%date : *iso0));
752900230210           CurTime = %Dec(%Time);
753000230210          pdate = #getusa(CurDate);
753100230210          sdate = #getusa(IN_oesigd);
753200230210          COX001 = 'Print Date: ' + %char(pdate)  +
753300230210                    '   Time: ' +  %editw(CurTime:'  :  :  ');
753400230322          COX002 = %trim(wwname);
753500230210          COX003 =  'Signed Date: ' + %char(sdate)  +
753600230210                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
753700230210          write Data3;
753800230210
753900230210          COX001 = *blanks;
754000230210          COX002 = *blanks;
754100230210          COX003 = *blanks;
754200230210          write Data3;
754300230130
754400230203       if skip_cont <> 'Y';
754500230306       BOLD01 = 'NOTES Continued...';
754600230130       write BOLD;
754700230203       g_count = 1;
754800230306       write ULINE;
754900230203       endif;
755000230130
755100230130       PLN001 = *blanks;
755200230130       PLN002 = *blanks;
755300230130       write PLANSR;
755400230203       g_count = g_count + 1;
755500230130
755600230130       N_Count = -30;
755700230130
755800230130       end-proc;
755900230130       dcl-proc  ADDEOVERFLOW;
756000230130
756100230203      //  If A_Count <> 0 and A_count < 10;
756200230203      //  return;
756300230203      //  endif;
756400230203
756500230203       //PLN001 = getmessage('LINE113');
756600230203       //PLN001 = %ScanRpl( '@J' : %char(g_count): PLN001);
756700230203       //PLN002 = *blanks;
756800230203       //write PLANSR;
756900230130
757000230130       write HEADER1;
757100230130
757200230210       // write HEADER2;
757300230130
757400230210       // write HEADER3;
757500230130
757600230130       POS_X = 1.95;
757700230130       A_Count = -30;
757800230203       g_count = 0;
757900230130
758000230130       Exec Sql
758100230130          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
758200230130             || Year(Current_Date)
758300230130             Into :wline
758400230130             From sysibm.sysdummy1 ;
758500230130
758600230130       COX001 = 'Date: ' + %trim(wline);
758700230130       COX002 = 'Session Id: ' + %trim(in_OESSID);
758800230130       COX003 = 'Transaction Type: Online Enrollment';
758900230130       write Data3;
759000230210
759100230210           CurDate = %int(%char(%date : *iso0));
759200230210           CurTime = %Dec(%Time);
759300230210          pdate = #getusa(CurDate);
759400230210          sdate = #getusa(IN_oesigd);
759500230210          COX001 = 'Print Date: ' + %char(pdate)  +
759600230210                    '   Time: ' +  %editw(CurTime:'  :  :  ');
759700230322          COX002 = %trim(wwname);
759800230210          COX003 =  'Signed Date: ' + %char(sdate)  +
759900230210                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
760000230210          write Data3;
760100230210
760200230210          COX001 = *blanks;
760300230210          COX002 = *blanks;
760400230210          COX003 = *blanks;
760500230210          write Data3;
760600230130
760700230130       end-proc;
760800230202       dcl-proc  CONTOVERFLOW;
760900230202
761000230202       If C_Count <> 0 and C_count < 10;
761100230202       return;
761200230202       endif;
761300230203
761400230203       //PLN001 = getmessage('LINE113');
761500230203       //PLN001 = %ScanRpl( '@J' : %char(g_count): PLN001);
761600230203       //PLN002 = *blanks;
761700230203       //write PLANSR;
761800230202
761900230202       write HEADER1;
762000230202
762100230210       // write HEADER2;
762200230202
762300230210       // write HEADER3;
762400230202
762500230202       POS_X = 1.95;
762600230202       A_Count = -30;
762700230203       g_count = 0;
762800230202
762900230202       Exec Sql
763000230202          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
763100230202             || Year(Current_Date)
763200230202             Into :wline
763300230202             From sysibm.sysdummy1 ;
763400230202
763500230202       COX001 = 'Date: ' + %trim(wline);
763600230202       COX002 = 'Session Id: ' + %trim(in_OESSID);
763700230202       COX003 = 'Transaction Type: Online Enrollment';
763800230202       write Data3;
763900230210
764000230210           CurDate = %int(%char(%date : *iso0));
764100230210           CurTime = %Dec(%Time);
764200230210          pdate = #getusa(CurDate);
764300230210          sdate = #getusa(IN_oesigd);
764400230210          COX001 = 'Print Date: ' + %char(pdate)  +
764500230210                    '   Time: ' +  %editw(CurTime:'  :  :  ');
764600230322          COX002 = %trim(wwname);
764700230210          COX003 =  'Signed Date: ' + %char(sdate)  +
764800230210                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
764900230210          write Data3;
765000230210
765100230210          COX001 = *blanks;
765200230210          COX002 = *blanks;
765300230210          COX003 = *blanks;
765400230210          write Data3;
765500230202
765600230202       end-proc;
765700230127       dcl-proc  PRINT_FAKE;
765800230127     C                   Select
765900230127     C                   When      RunOption = 'D'
766000230127     C                   Eval      RunDesc = 'DASHBOARD BATCH PRINT'
766100230127     C                   When      RunOption = 'B'
766200230127     C                   Eval      RunDesc = 'BETA BATCH PRINT'
766300230127     C                   When      RunOption = '5'
766400230127     C                   Eval      RunDesc = 'EDT - CT BATCH PRINT'
766500230127     C                   Other
766600230310     C                   Eval      RunDesc = '??? BATCH PRINT'
766700230127     C                   Endsl
766800230130     C                   Call      'WEBUNRETR'
766900230127
767000230203       g_count = 0;
767100230203
767200230127            write HEADER1;
767300230127            BOLD01 = %trim(RunDesc);
767400230127            write BOLD;
767500230127
767600230127       Exec Sql
767700230127          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
767800230127             || Year(Current_Date)
767900230127             Into :wline
768000230127             From sysibm.sysdummy1 ;
768100230127
768200230127       COX001 = *blanks;
768300230127       COX002 = *blanks;
768400230127       COX003 = *blanks;
768500230127       write Data3;
768600230210
768700230210          COX001 = *blanks;
768800230210          COX002 = *blanks;
768900230210          COX003 = *blanks;
769000230210          write Data3;
769100230127
769200230127       COX001 = 'Run Date: ' + %trim(wline);
769300230127       COX002 = *blanks;
769400230127       COX003 = *blanks;
769500230127       write Data3;
769600230210
769700230210          COX001 = *blanks;
769800230210          COX002 = *blanks;
769900230210          COX003 = *blanks;
770000230210          write Data3;
770100230127
770200230127       RunTime = %dec(%time());
770300230127       COX001 = 'Run Time: ' + %Char(%Time(RunTime:*iso) :*usa);
770400230127       COX002 = *blanks;
770500230127       COX003 = *blanks;
770600230127       write Data3;
770700230127
770800230126       end-proc;
770900230130       // ----------------------------------------------------------------
771000230130       dcl-proc PrintTheForm;
771100230821
771200230821      * Force to populate the form from Tran History Tool
771300230821J001 C                   eval      In_TOOL  = 'Y'
771400230130
771500230130     C     1             Do        21            do#
771600230130     C     do#           occur     webadepids
771700230130     C                   Clear                   webadepids
771800230130     C                   Enddo
771900230130     C                   Eval      do# = 0
772000230130
772100230130     C                   Select
772200230130     C                   When      In_TOOL  = 'Y'
772300230130     C                   Eval      noprint = 'Y'
772400230130     C                   eval      multid = multid + 1
772500231016F001      chain ( in_ssid ) oeformp;
772600231016          If  not %found(oeformp);
772700230228                         PopulateForm();
772800231016          endif;
772900230130     C                   When      In_TOOL  = 'G'
773000230130     C                   Eval      noprint = 'Y'
773100230130     C     1             do        100           g#
773200230130     C                   If        webgcu(g#) <> *blanks
773300230130     C                   eval      multid = multid + 1
773400230130     C                   eval      In_oessid = webgcu(g#)
773500231016F001      chain ( in_ssid ) oeformp;
773600231016          If  not %found(oeformp);
773700230228                         PopulateForm();
773800231016          endif;
773900230130     C                   Else
774000230130     C                   Leave
774100230130     C                   End
774200230130     C                   enddo
774300230130     C                   When      In_TOOL  = 'E'
774400230130     C                   Eval      noprint = 'Y'
774500230130     C                   Eval      webview = #getsse(In_oessno:wlprtd:wlprtt)
774600230130     C     1             do        100           g#
774700230130     C                   If        webgcu(g#) <> *blanks
774800230130     C                   eval      multid = multid + 1
774900230130     C                   eval      In_oessid = webgcu(g#)
775000231016F001      chain ( in_ssid ) oeformp;
775100231016          If  not %found(oeformp);
775200230228                         PopulateForm();
775300231016          endif;
775400230130     C                   Else
775500230130     C                   Leave
775600230130     C                   End
775700230130     C                   enddo
775800230130     C                   Other
775900230130     C                   If        In_WebLevel = 'Y'
776000230130     C                   Call      'WEBLEVEL'
776100230130     C                   Parm                    webparm
776200230130     C                   End
776300230130     C                   If        In_BATCH <> 'Y'
776400230130     C                   Eval      Noprint = #CHKEMR(IN_OETRST:
776500230130     C                                               IN_OESUB#:
776600230130     C                                               IN_OEACCT)
776700230130     C                   Else
776800230130     C                   Eval      Noprint = ' '
776900230130     C                   End
777000230526
777100231016F001      chain ( in_ssid ) oeformp;
777200230526          If  not %found(oeformp);
777300230228                         PopulateForm();
777400230526          Endif;
777500230130     C                   Endsl
777600230130
777700230130       end-proc;
777800230215       // ----------------------------------------------------------------
777900230215       dcl-proc CarrierDiscl;
778000230215
778100230215     C     1             do        cd#           cr#
778200230215     C                   eval      webpages = '/www/production/' +
778300230215     C                             'htdocs/dashboard/pages/'
778400230215     C                   Eval      Include = %trim(webpages) +
778500230215     C                                       'carrierdisclaimers/' +
778600230215     C                                       %trim(CarDis(cr#)) + '.htm'
778700230215     C                   Eval      ifs = #chkifs(%trim(include))
778800230215     C                   If        ifs = 'Y'
778900230215     C                   If        hdr = 0
779000230215
779100230215                         CDoverflow();
779200230215
779300230215              E_LINE1 = getmessage('CD00001');
779400230215              write EMPLINE;
779500230215
779600230215              E_LINE1 = getmessage('CD00002');
779700230215              write EMPLINE;
779800230215
779900230215              E_LINE1 = *blanks;
780000230215              write EMPLINE;
780100230215
780200230215     C                   Eval      hdr = 1
780300230215     C                   End
780400230215
780500230215                select;
780600230215                when      %trim(CarDis(cr#)) = 'GAD';
780700230419
780800230419              clear    OE_GARR;
780900230419              GASSID = IN_OESSID;
781000230419              GADATE = %trim(curdattim);
781100230419              GASSN = %trim(wwssn);
781200230419              GANAME = %trim(wwname);
781300230419              GATSA = %trim(wGBSTSA#);
781400230419              GATSANAM = %trim(acnam1);
781500230419              GASIGNUSR = *blanks;
781600230419              GASIGNDAT = *blanks;
781700230419
781800230419
781900230215                E_LINE1 = getmessage('GAD0001');
782000230215                write EMPLINE;
782100230215                E_LINE1 = *blanks;
782200230215                write EMPLINE;
782300230215                E_LINE1 = getmessage('GAD0002');
782400230215                write EMPLINE;
782500230215                E_LINE1 = getmessage('GAD0003');
782600230215                write EMPLINE;
782700230215                E_LINE1 = *blanks;
782800230215                write EMPLINE;
782900230215                E_LINE1 = getmessage('GAD0004');
783000230215                write EMPLINE;
783100230215                E_LINE1 = getmessage('GAD0005');
783200230215                write EMPLINE;
783300230215                E_LINE1 = getmessage('GAD0006');
783400230215                write EMPLINE;
783500230215                E_LINE1 = getmessage('GAD0007');
783600230215                write EMPLINE;
783700230215                E_LINE1 = getmessage('GAD0008');
783800230215                write EMPLINE;
783900230215                E_LINE1 = *blanks;
784000230215                write EMPLINE;
784100230215                when      %trim(CarDis(cr#)) = 'GAR';
784200230419
784300230419              clear    OE_GARR;
784400230419              GASSID = IN_OESSID;
784500230419              GADATE = %trim(curdattim);
784600230419              GASSN = %trim(wwssn);
784700230419              GANAME = %trim(wwname);
784800230419              GATSA = %trim(wGBSTSA#);
784900230419              GATSANAM = %trim(acnam1);
785000230419              GASIGNUSR = *blanks;
785100230419              GASIGNDAT = *blanks;
785200230419
785300230215                E_LINE1 = getmessage('GAR0001');
785400230215                write EMPLINE;
785500230215                E_LINE1 = *blanks;
785600230215                write EMPLINE;
785700230215                E_LINE1 = getmessage('GAR0002');
785800230215                write EMPLINE;
785900230215                E_LINE1 = getmessage('GAR0003');
786000230215                write EMPLINE;
786100230215                E_LINE1 = *blanks;
786200230215                write EMPLINE;
786300230215                E_LINE1 = getmessage('GAR0004');
786400230215                write EMPLINE;
786500230215                E_LINE1 = getmessage('GAR0005');
786600230215                write EMPLINE;
786700230215                E_LINE1 = getmessage('GAR0006');
786800230215                write EMPLINE;
786900230215                E_LINE1 = getmessage('GAR0008');
787000230215                write EMPLINE;
787100230215                E_LINE1 = getmessage('GAR0009');
787200230215                write EMPLINE;
787300230215                E_LINE1 = *blanks;
787400230215                write EMPLINE;
787500230215                when      %trim(CarDis(cr#)) = 'HSA';
787600230419
787700230419              clear    OE_CFSR;
787800230419              CFSSID = IN_OESSID;
787900230419              CFDATE = %trim(curdattim);
788000230419              CFSSNO = %trim(wwssn);
788100230419              CFNAME = %trim(wwname);
788200230419              CFTSA = %trim(wGBSTSA#);
788300230419              CFTSANAM = %trim(acnam1);
788400230419              CFSIGNUSR = *blanks;
788500230419              CFSIGNDAT = *blanks;
788600230419
788700230215                E_LINE1 = getmessage('HSA0001');
788800230215                write EMPLINE;
788900230215                E_LINE1 = getmessage('HSA0002');
789000230215                write EMPLINE;
789100230215                E_LINE1 = getmessage('HSA0003');
789200230215                write EMPLINE;
789300230215                E_LINE1 = getmessage('HSA0004');
789400230215                write EMPLINE;
789500230215                E_LINE1 = getmessage('HSA0005');
789600230215                write EMPLINE;
789700230215                E_LINE1 = getmessage('HSA0006');
789800230215                write EMPLINE;
789900230215                E_LINE1 = getmessage('HSA0007');
790000230215                write EMPLINE;
790100230215                E_LINE1 = getmessage('HSA0008');
790200230215                write EMPLINE;
790300230215                E_LINE1 = getmessage('HSA0009');
790400230215                write EMPLINE;
790500230215                E_LINE1 = getmessage('HSA0010');
790600230215                write EMPLINE;
790700230215                E_LINE1 = getmessage('HSA0011');
790800230215                write EMPLINE;
790900230215                E_LINE1 = getmessage('HSA0012');
791000230215                write EMPLINE;
791100230215                E_LINE1 = *blanks;
791200230215                write EMPLINE;
791300230215                endsl;
791400230215
791500230215     C                   else
791600230215     C                   end
791700230215     C                   enddo
791800230517
791900230517              if     CFSSID <> *blanks;
792000230517                   CFSIGNUSR = %trim(wwname);
792100230517                   CFSIGNDAT = %char(pdate);
792200231018F001      chain ( CFSSID ) oeformcfsp;
792300231018          If  not %found(oeformcfsp);
792400230517                   write OE_CFSR;
792500231018              endif;
792600230517              endif;
792700230517              if     GASSID <> *blanks;
792800230517                   GASIGNUSR = %trim(wwname);
792900230517                   GASIGNDAT = %char(pdate);
793000231018F001      chain ( GASSID ) oeformgarp;
793100231018          If  not %found(oeformgarp);
793200230517                   write OE_GARR;
793300231018              endif;
793400230517              endif;
793500230215
793600230215     C                   If        hdr <> 0           and
793700230215     C                             %subst(oessid:16:1) = 'E'
793800230215                E_LINE1 = getmessage('TR00001');
793900230215                write EMPLINE;
794000230215                E_LINE1 = *blanks;
794100230215                write EMPLINE;
794200230215                E_LINE1 = getmessage('TR00002');
794300230215                write EMPLINE;
794400230215     C                   End
794500230215
794600230215     C                   If        hdr <> 0           and
794700230215     C                             %subst(oessid:16:1) = 'M'
794800230215                E_LINE1 = getmessage('TR00003');
794900230215                write EMPLINE;
795000230215
795100230215     C                   If        oesigd <> 0
795200230215     C                   Eval      pdate = #getusa(oesigd)
795300230215     C                   Else
795400230215     C                   Eval      wiso   = %Date
795500230215     C                   Eval      wtoday = #get80i(wiso)
795600230215     C                   Eval      pdate = #getusa(wtoday)
795700230215     C                   End
795800230215
795900230215     C                   If        oesigd <> 0
796000230215     C                   If        %trim(OEGRPV) = 'DECLINED'
796100230215     C                   Eval      wname = 'DECLINED'
796200230419     C                   Else
796300230419     C                   Eval      wname = %trim(wwname)
796400230215     C                   End
796500230215
796600230215            E_LINE1 = getmessage('TR00004');
796700230215            E_LINE1 = %ScanRpl( '@J' : %trim(wname): E_LINE1);
796800230215            E_LINE1 = %ScanRpl( '@K' : %char(pdate): E_LINE1);
796900230215            write EMPLINE;
797000230215
797100230215     C                   Else
797200230215
797300230215                E_LINE1 = getmessage('TR00005');
797400230215                write EMPLINE;
797500230215
797600230215     C                   End
797700230215     C                   End
797800230215
797900230215       end-proc;
798000230215       dcl-proc  CDOVERFLOW;
798100230215
798200230215     C                   If        page# = 0
798300230215     C                   Eval      Page# = 2
798400230215     C                   Else
798500230215     C                   Eval      Page# = Page# + 1
798600230215     C                   End
798700230215
798800230215       write HEADER1;
798900230215
799000230215       POS_X = 1.95;
799100230215
799200230215       Exec Sql
799300230215          Select Monthname(Current_Date) || ' ' || Day(Current_Date) || ', '
799400230215             || Year(Current_Date)
799500230215             Into :wline
799600230215             From sysibm.sysdummy1 ;
799700230215
799800230215       COX001 = 'Date: ' + %trim(wline);
799900230215       COX002 = 'Session Id: ' + %trim(in_OESSID);
800000230215       COX003 = 'Transaction Type: Online Enrollment';
800100230215       write Data3;
800200230215
800300230215           CurDate = %int(%char(%date : *iso0));
800400230215           CurTime = %Dec(%Time);
800500230215          pdate = #getusa(CurDate);
800600230215          sdate = #getusa(IN_oesigd);
800700230215          COX001 = 'Print Date: ' + %char(pdate)  +
800800230215                    '   Time: ' +  %editw(CurTime:'  :  :  ');
800900230215          COX002 = *blanks;
801000230215          COX003 =  'Signed Date: ' + %char(sdate)  +
801100230215                    '   Time: ' +  %editw(IN_oesigt:'  :  :  ');
801200230215          write Data3;
801300230215
801400230215          COX001 = *blanks;
801500230215          COX002 = *blanks;
801600230215          COX003 = *blanks;
801700230215          write Data3;
801800230215
801900230306       BOLD01 = 'CARRIER DISCLAIMER';
802000230215       write BOLD;
802100230306       write ULINE;
802200230215
802300230215       PLN001 = *blanks;
802400230215       PLN002 = *blanks;
802500230215       write PLANSR;
802600230215
802700230215       COL001 = %trim(wwname);
802800230215       COL002 = getmessage('LINE002');
802900230215       COL002 = %ScanRpl( '@B' : %trim(wwssn): COL002);
803000230215       write Data2;
803100230215
803200230215          COX001 = *blanks;
803300230215          COX002 = *blanks;
803400230215          COX003 = *blanks;
803500230215          write Data3;
803600230215
803700230215       end-proc;
