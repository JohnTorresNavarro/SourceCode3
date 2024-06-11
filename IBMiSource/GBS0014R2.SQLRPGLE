000100161109     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200161109    ? *-------------------------------------------------------------------------
000300161109    ? *
000400170601    ? *  Description: Daily Job Master Maintenance
000500170601    ? *  Programmer.: Brian Rees
000600170601    ? *  Date.......: 06/01/2017
000700170511    ? *
000800170511    ? *  To Compile: Add JMS400L to your library list
000900170322    ? *
001000161109    ? *-------------------------------------------------------------------------
001100170601    ?FGBS0014D2 CF   E             WORKSTN
001200161109     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001300161109    ?F                                     SFILE(LSTSFL:rrn)
001400161109
001500170601     FJmsMstP   if   E           k disk    Rename(JmsMstp: r_JmsMstp)
001600170327     FJmsMste   if   E           k disk
001700170706     FJmsDocp   uf a E           k disk    rename(JmsDocp : Doc)
001800161109    ? *-------------------------------------------------------------------------
001900161109    ? * Program status data structure
002000161109    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100161109     D  @pgmq            *proc
002200161109
002300161109    ? * Display file data structure
002400161109    ?D DSPD            DS
002500161109     D  Key                  369    369
002600161109     D  Currec               378    379b 0
002700161111
002800161109     d Rrn             s              5s 0 inz
002900161109     d ReLoad          s              1
003000170110     d today           s               d   inz
003100170110     d HldHour         s              4    inz
003200170125     d wDay            s              2s 0 inz
003300170706     d Counter         s              5s 0 inz
003400161111      *--------------------------------------------
003500161111      *?Procedures
003600161111      *--------------------------------------------
003700170810     d BuildSchedule   pr                  ExtPgm('JMSDAILY')
003800161111
003900161118
004000161109    ? *-------------------------------------------------------------------------
004100161109      *?Mainline Program
004200161109    ? *-------------------------------------------------------------------------
004300170601     C*    *entry        plist
004400170601     C*                  parm                    iJobName         20
004500161111
004600161111
004700161111
004800161109      /Free
004900190125       Exec Sql
005000190125          Set Option Commit = *None, Naming = *Sys;
005100161109
005200161109       Dou btnExit = *on;
005300161109
005400190125         If Reload = 'Y';
005500190125           exsr CLEAR;
005600190125           exsr LOAD;
005700190125           Reload = 'N';
005800190125         endIf;
005900161109
006000190125         exsr DISPLY;
006100161109
006200161109
006300190125         //?Process Selections
006400190125         Select;
006500170602
006600190125         When ChgShowAct = *on;
006700190125           Reload = 'Y';
006800170602
006900190125         When btnSearch = *on;
007000190125           Reload = 'Y';
007100161111
007200190125         When btnReset = *on;
007300190125           Reload = 'Y';
007400190125           s1Search = *blanks;
007500170913
007600190125         When btnAddNew = *on;
007700190125           Clear AddScreen;
007800190125           Exsr Add_Data;
007900190125           Reload = 'Y';
008000170120
008100190125         other;
008200190125           exsr ReadChanged;
008300161109
008400190125         EndSl;
008500161109
008600161109
008700161109       enddo;
008800161109
008900170810       BuildSchedule();
009000161109       *inlr = *on;
009100161109
009200161110       // ----------------------------------------------------------------
009300161109       Begsr *Inzsr;
009400161109
009500190125         Reload = 'Y';
009600190125         ChkShowAct = 'Y';
009700161109
009800161109       Endsr;
009900161109       // ----------------------------------------------------------------
010000161109       Begsr CLEAR;
010100161109
010200190125         //?Clear the Subfile
010300190125         ClrSfl = *on;
010400190125         Write CtlSfl;
010500190125         ClrSfl = *off;
010600190125         rrn = 0;
010700161109
010800161109       Endsr;
010900161109       // ----------------------------------------------------------------
011000170511       Begsr Load;
011100170110
011200190125         Setll *loval JmsMstp;
011300190125         Dou %eof(JmsMstP);
011400161109
011500190125           read JmsMstp;
011600190125           if %eof(JmsMstp);
011700190125             leave;
011800190125           endif;
011900161109
012000190125           if jmJobn = *blanks;
012100190125             iter;
012200190125           endif;
012300170601
012400190125           s1Jobn = jmJobn;
012500190125           s1Mon  = jmMon;
012600190125           s1Tue  = jmTue;
012700190125           s1Wed  = jmWed;
012800190125           s1Thu  = jmThu;
012900190125           s1Fri  = jmFri;
013000190125           s1Sat  = jmSat;
013100190125           s1Sun  = jmSun;
013200170601
013300190125           s1Mth  = jmMth;
013400190125           s1AmPm = jmAmPm;
013500170110
013600190125           s1Active = 'No';
013700190125           if jmonof = 'Y';
013800190125             s1Active = 'Yes';
013900190125           endif;
014000170601
014100170601
014200190125           s1Auto = *blanks;
014300190125           chain jmJobn jmsmste;
014400190125           if %Found(jmsMste);
014500190125             if jeAuto = 'Y';
014600190125               s1Auto = 'Yes';
014700190125             endif;
014800190125           endif;
014900170327
015000190125           hldHour = %Editc(jmHour:'X');
015100190125           s1Hour = %Subst(HldHour:1:2) + ':' + %Subst(HldHour:3:2);
015200170110
015300170602
015400190125           if s1Search = *blanks;
015500170913
015600170602             //?Check the Show Active Checkbox.
015700170602             if ChkShowAct = *Blanks;
015800190125               rrn = rrn + 1;
015900190125               write LstSfl;
016000170602             else;
016100190125               if jmOnof = 'Y';
016200190125                 rrn = rrn + 1;
016300190125                 write LstSfl;
016400190125               endif;
016500170602             endif;
016600170913
016700190125           else;   //?Search Field
016800190125             if %scan( %Trim(s1Search) : s1Jobn ) > 0;
016900190125
017000190125
017100190125
017200190125             //?Check the Show Active Checkbox.
017300190125             if ChkShowAct = *Blanks;
017400190125               rrn = rrn + 1;
017500190125               write LstSfl;
017600190125             else;
017700190125               if jmOnof = 'Y';
017800190125                 rrn = rrn + 1;
017900190125                 write LstSfl;
018000190125               endif;
018100190125             endif;
018200190125
018300190125
018400190125             endif;
018500190125           endif;
018600170913
018700190125           If rrn >= 9999;
018800190125             leave;
018900190125           endIf;
019000161109
019100190125         enddo;
019200161109
019300161110       Endsr;
019400161109
019500161109       // ----------------------------------------------------------------
019600161109       Begsr DISPLY;
019700161109
019800190125         DspSfl = *on  ;
019900190125         exfmt CtlSfl;
020000190125         DspSfl = *off;
020100161109
020200161109       Endsr;
020300161109       // ----------------------------------------------------------------
020400161109       Begsr ReadChanged;
020500161109
020600190125         Dou *in95 = *ON;
020700190125           READC LstSfl;
020800190125           *in95 = %EOF;
020900161109
021000190125           If *in95 = *OFF;
021100161109
021200170124
021300190125             //?Edit Job Record
021400190125             if btnEdit = *on;
021500190125               exsr Load_Data;
021600190125               exsr Chg_Data;
021700190125             endIf;
021800170124
021900190125             //?Work with Notes...
022000190125             if btnNotes = *on;
022100190125               exsr Load_Notes;
022200190125               exsr Chg_Notes;
022300190125             endIf;
022400170706
022500170124
022600190125             btnEdit = *off;
022700190125             btnNotes = *off;
022800190125             update LstSfl;
022900190125             Reload = 'Y';
023000170601
023100190125           endIf;
023200161109
023300190125         enddo;
023400161109       Endsr;
023500161111
023600170601       //-----------------------------------------------------------------
023700170601       Begsr Load_Data;
023800170601
023900190125         Chain s1Jobn JmsMstp;
024000190125         s2Jobn = s1Jobn;
024100190125         s2onof = jmonof;
024200190125         s2Mon  = jmMon;
024300190125         s2Tue  = jmTue;
024400190125         s2Wed  = jmWed;
024500190125         s2Thu  = jmThu;
024600190125         s2Fri  = jmFri;
024700190125         s2Sat  = jmSat;
024800190125         s2Sun  = jmSun;
024900170601
025000190125         s2Mth  = jmMth;
025100190125         s2Dom1 = jmDom1;
025200190125         s2Dom2 = jmDom2;
025300190125         s2Dom3 = jmDom3;
025400190125         s2Dom4 = jmDom4;
025500190125         s2Dom5 = jmDom5;
025600170601
025700190125         s2Hour = jmHour;
025800190125         s2ampm = jmampm;
025900170602
026000170602
026100190125         s2Auto = *Blanks;
026200190125         chain s2Jobn jmsMste;
026300190125         if %Found(jmsMste);
026400190125           s2Auto = jeAuto;
026500190125         endif;
026600170602
026700190125         s2Script = jeScript;
026800190125         s2TaskNm = jeTaskNm;
026900190125         s2TaskIp = jeTaskIp;
027000170623
027100170601       Endsr;
027200170601
027300170601       //-----------------------------------------------------------------
027400170601       //?                     Change Project
027500170601       //-----------------------------------------------------------------
027600170601       Begsr Chg_Data;
027700170601
027800190125         Dou btnCancel = *on;
027900170601
028000190125           exfmt EditScreen;
028100170601
028200190125           if btnCancel = *on;
028300190125             leave;
028400190125           endif;
028500170601
028600170601
028700190125           //----------------------------------------------
028800190125           //?Update.
028900190125           //----------------------------------------------
029000190125           if btnAccept = *on;
029100170601
029200190125             Exec Sql
029300190125                Update jmsmstp
029400190125                   Set jmonof = :s2onof, jmmon = :s2mon, jmtue = :s2tue,
029500190125                       jmwed = :s2wed, jmthu = :s2thu, jmfri = :s2fri,
029600190125                       jmsat = :s2sat, jmsun = :s2sun, jmmth = :s2mth,
029700190125                       jmdom1 = :s2dom1, jmdom2 = :s2dom2, jmdom3 = :s2dom3,
029800190125                       jmdom4 = :s2dom4, jmdom5 = :s2dom5, jmhour = :s2hour,
029900190125                       jmampm = :s2ampm
030000190125                   Where jmjobn = :s2jobn;
030100170601
030200190125               Exec Sql
030300190125                  Update jmsmste
030400190125                     Set jeauto = :s2auto, jescript = :s2script,
030500190125                         jetasknm = :s2tasknm, jetaskip = :s2taskip
030600190125                     Where jejobn = :s2jobn;
030700170623
030800170602
030900190125               leave;
031000190125             endif;
031100170601
031200190125         Enddo;
031300170601
031400170601       Endsr;
031500170601
031600170601
031700170601       //-----------------------------------------------------------------
031800170601       //?                       Add Project
031900170601       //-----------------------------------------------------------------
032000170601       Begsr Add_Data;
032100170601
032200170601
032300190125         Dou btnCancel = *on;
032400170601
032500190125           exfmt AddScreen;
032600190125           errName = *off;
032700170601
032800190125           if btnCancel = *on;
032900190125             leave;
033000190125           endif;
033100170601
033200170601
033300190125           //----------------------------------------------
033400190125           //?Add Update.
033500190125           //----------------------------------------------
033600190125           if btnAccept = *on;
033700170601
033800190125             // Make sure the job name doesn't already exist.
033900190125             chain s2Jobn jmsMstp;
034000190125             if %Found(jmsMstp);
034100190125               errName = *on;
034200190125               iter;
034300190125             endif;
034400170601
034500170601
034600190125             Exec Sql
034700190125                Insert Into jmsmstp(jmjobn, jmmon, jmtue, jmwed, jmthu,
034800190125                                    jmfri, jmsat, jmsun, jmmth, jmdom1,
034900190125                                    jmdom2, jmdom3, jmdom4, jmdom5, jmampm,
035000190125                                    jmhour, jmonof, jmcomp, jmrund, jmrunt,
035100190125                                    jmrunc)
035200190125                   Values (:s2jobn, :s2mon, :s2tue, :s2wed, :s2thu, :s2fri,
035300190125                           :s2sat, :s2sun, :s2mth, :s2dom1, :s2dom2, :s2dom3,
035400190125                           :s2dom4, :s2dom5, :s2ampm, :s2hour, :s2onof, '',
035500190125                           '0001-01-01', '00:00:00', 0);
035600170623
035700170623
035800190125               Exec Sql
035900190125                  Insert Into jmsmste(jejobn, jeauto, jescript, jetasknm,
036000190125                                      jetaskip)
036100190125                     Values (:s2jobn, :s2auto, :s2script, :s2tasknm, :s2taskip);
036200170623
036300190125               leaveSr;
036400190125               endif;
036500170601
036600190125             Enddo;
036700170601
036800190125         Endsr;
036900170601
037000170706
037100170706      *-------------------------------------------------------------------
037200170706      *?                      Notes Section
037300170706      *-------------------------------------------------------------------
037400170706       Begsr Load_Notes;
037500170706
037600190125         s3Jobn = s1Jobn;
037700190125         s3Notes = *Blanks;
037800190125         Counter = 1;
037900170706
038000190125         //?Load the Notes - If there are any.
038100190125         setll s1Jobn JmsDocp;
038200190125         dou %Eof(JmsDocp);
038300190125           reade(n) s1Jobn JmsDocp;
038400190125           if %Eof(JmsDocp);
038500190125             leave;
038600190125           endif;
038700170706
038800190125           %Subst(s3Notes: Counter : 70) = jdNote;
038900190125           Counter  = Counter + 70;
039000190125         enddo;
039100170706
039200170706
039300170706
039400170706       Endsr;
039500170706
039600170706       //-----------------------------------------------------------------
039700170706       //?                     Change Project
039800170706       //-----------------------------------------------------------------
039900170706       Begsr Chg_Notes;
040000170706
040100190125         Dou btnCancel = *on;
040200170706
040300190125           exfmt EditNotes;
040400170706
040500190125           if btnCancel = *on;
040600190125             leave;
040700190125           endif;
040800170706
040900170706
041000190125           //----------------------------------------------
041100190125           //?Update.
041200190125           //----------------------------------------------
041300190125           if btnAccept = *on;
041400170706
041500190125             Exec Sql
041600190125                Delete From jmsdocp Where jdjobn = :s3jobn;
041700170706
041800170706
041900190125             Counter = 1;
042000190125             //   jdSeqn  = 0;
042100190125             dow Counter <= %Len(%Trim(s3Notes));
042200190125               jdJobn = s3Jobn;
042300190125               jdNote = %Subst(s3Notes: Counter : 70);
042400190125               //      jdSeqn = jdSeqn + 10;
042500190125               write Doc;
042600170706
042700190125               Counter = Counter + 70;
042800190125             enddo;
042900170706
043000190125             leave;
043100190125           endif;
043200170706
043300190125         Enddo;
043400170706
043500170706       Endsr;
043600170706
043700170706
