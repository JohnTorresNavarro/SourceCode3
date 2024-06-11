000100140206     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ACAAUDITR')
000200161104     H option(*nodebugio)
000300000000      *_________________________________________________________________________
000400000000      *
000500000000      *  Description:  ACA Audit Report
000600000000      *
000700000000      *  (c)Copyright 2014 by Innovative Outsourcing, Inc.
000800000000      *
000900000000      *    Created by:  JALLEN - January 23, 2014
001000160121      *-------------------------------------------------------------------------
001100160121      * Modifications
001200160121      *
001300160121      * Date         Programmer    Mod      Description
001400160121      *-------------------------------------------------------------------------
001500160121      * 1/21/2016    B.Rees        br01     Changed When Select..
001600160307      * 03/07/16     JALLEN                 change aaprem & aamanamt to
001700160307      *                                     numeric
001800160307      *
001900160121      *-------------------------------------------------------------------------
002000140123     FPLNAUXP   ip   e           k Disk
002100140123     FACCMST    if   e           k Disk    extfile('F.ACCMST') usropn
002200140127     FMEMBER    if   e           k Disk    extfile('F.MEMBER') usropn
002300140127     FDEPNDC    if   e           k Disk    extfile('F.DEPNDC') usropn
002400140127     FPLNMST    if   e           k Disk    extfile('F.PLNMST') usropn
002500140131     FACAAUDITLFo  a e           k Disk
002600161104
002700140123      /define copy_all_protos_and_fields
002800140203      /copy qcpysrc,acambraudp
002900140123      /undefine copy_all_protos_and_fields
003000140123
003100140210     D wname           s             40A
003200140210     D dname           s             40A
003300140123     D ACA             s              1A
003400140128     D Continue_Flg    s              1A
003500140425     D Skip_This       s              1A
003600140425     D Skip_SDT        s              1A
003700140610     D year1           s              4  0
003800140610     D year2           s              4  0
003900140610     D month1          s              2  0
004000140610     D month2          s              2  0
004100140610    ?d isodat          S               D   datfmt(*iso)                         Input Request
004200160121
004300140130     D d               s              2  0
004400140130     D pos             s              2  0
004500140130     D dep             s              2  0 dim(20) inz
004600140130
004700140127     D seq             s              2  0
004800140123     D idx             s              2  0
004900140127     D prem            s              7  2
005000140127     D prem_dif        s              7  2
005100140123     D prem_aca        s              7  2
005200140127     D prem_count      s              3  0
005300140212     D w80date         s              8  0
005400140408     D w80date2        S              8  0
005500140212     D prodate         s              8  0
005600140613     D p_mtrans        s              4  0
005700140408
005800140408     D IsoEff          s               d   datfmt(*iso)
005900140408     D IsoDays         s              3s 0 inz
006000140123
006100140613     D COVDS         e ds                  extname(MCOV) inz
006200140613     D MTRANDS       e ds                  extname(MTRANS) inz
006300140123
006400000000      * Program status data structure
006500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
006600140123
006700140123     IPLNAUXR       01
006800140123
006900140123      * Audit all ACA Plans
007000140123     C   01              If        %trim(PXACAR) = 'Y'
007100160304      * ******************************************************************
007200160304      * **** TESTING 3/4/16 ****
007300160307     c****                         and (pxtrst = 3 and pxsub# = 1 and
007400160307     c****                              pxplan = 'BAAK')
007500160304      * ******************************************************************
007600160304
007700140613     C                   Exsr      Audit_Plan
007800140613     C                   Exsr      Audit_Mtrans
007900140123     C                   End
008000140123
008100140123     CLR                 close     ACCMST
008200140127     CLR                 close     PLNMST
008300140127     CLR                 close     MEMBER
008400140127     CLR                 close     DEPNDC
008500140123      *___________________________________________________________________
008600140123      * Audit ACA Plans
008700140123      *___________________________________________________________________
008800140123     C     Audit_Plan    Begsr
008900140123
009000140123      /free
009100140123
009200140130       exec sql declare j1 scroll cursor for select distinct mctrst, mcsub#,
009300140130       mcplan, acc#, enrldt, mcssno, mdseq#, candt from "F.MCOV"
009400140130        where (mctrst = :pxtrst and mcsub# = :pxsub# and
009500140207         mcplan = :pxplan) ;
009600140123
009700140123       exec sql open j1 ;
009800140123
009900140123       //?read all of selected ACA plan...
010000140123         dou       sqlcod <> *zeros ;
010100140123
010200140123       exec sql fetch next from j1 into
010300140130       :mctrst, :mcsub#, :mcplan, :acc#, :enrldt, :mcssno, :mdseq#, :candt ;
010400140123
010500140123         If        sqlcod = 0 ;
010600140613
010700140613         eval      p_mtrans = *zeros ;
010800140123
010900140127         exsr      get_account  ;
011000140127         eval      w80date = 0 ;
011100140128         exsr      get_date ;
011200140123         If        continue_flg = 'Y' ;
011300140127         dow    w80date <= acvtdt ;
011400140408         exsr      inthemonth ;
011500140425         if     enrldt <= w80date ;
011600140203         exsr      chk_diff ;
011700140127         exsr      get_date ;
011800140127         mdseq# = 0;
011900140131         else  ;
012000140131         exsr      get_date ;
012100140131         mdseq# = 0;
012200140131         endif ;
012300140127         enddo ;
012400140123         endif ;
012500140123
012600140123         endif ;
012700140123
012800140123         enddo ;
012900140123
013000140123       exec sql close j1 ;
013100140123
013200140123      /end-free
013300140123     C                   Endsr
013400140123
013500140613      *___________________________________________________________________
013600140613      * Audit ACA Plans from MTRANS
013700140613      *___________________________________________________________________
013800140613     C     Audit_Mtrans  Begsr
013900140613
014000140613      /free
014100140613
014200140613       exec sql declare m1 scroll cursor for select distinct mttrst, mtsub#,
014300140613       mtplan, mtacc#, mtenrl, mtssno, mtseq#, mtcan from "F.MTRANS"
014400140613        where (mttrst = :pxtrst and mtsub# = :pxsub# and
014500140613         mtplan = :pxplan) ;
014600140613
014700140613       exec sql open m1 ;
014800140613
014900140613       //?read all of selected ACA plan...
015000140613         dou       sqlcod <> *zeros ;
015100140613
015200140613       exec sql fetch next from m1 into
015300140613       :mttrst, :mtsub#, :mtplan, :mtacc#, :mtenrl, :mtssno, :mtseq#, :mtcan ;
015400140613
015500140613         If        sqlcod = 0 ;
015600140613
015700140613         eval      mctrst = mttrst;
015800140613         eval      mcsub# = mtsub#;
015900140613         eval      acc#   = mtacc#;
016000140715         eval      mcplan = mtplan;
016100140613         eval      enrldt = mtenrl;
016200140613         eval      mcssno = mtssno;
016300140613         eval      mdseq# = mtseq#;
016400140613         eval      candt  = mtcan;
016500140613         eval      p_mtrans = acc#;
016600140613
016700140613         exsr      get_account  ;
016800140613         eval      w80date = 0 ;
016900140613         exsr      get_date ;
017000140613         If        continue_flg = 'Y' ;
017100140613         dow    w80date <= acvtdt ;
017200140613         exsr      inthemonth ;
017300140613         if     enrldt <= w80date ;
017400140613         exsr      chk_diff ;
017500140613         exsr      get_date ;
017600140613         mdseq# = 0;
017700140613         else  ;
017800140613         exsr      get_date ;
017900140613         mdseq# = 0;
018000140613         endif ;
018100140613         enddo ;
018200140613         endif ;
018300140613
018400140613         endif ;
018500140613
018600140613         enddo ;
018700140613
018800140613       exec sql close m1 ;
018900140613
019000140613      /end-free
019100140613     C                   Endsr
019200140613
019300140123      *___________________________________________________________________
019400140123      * Get the Premiums and total for that SSN
019500140123      *___________________________________________________________________
019600140203     C     chk_Diff      Begsr
019700140123
019800140123      /free
019900140203
020000140204         p_audit = #aca_mbr_audit(mctrst:mcsub#:acc#:mcssno:
020100140613                   mcplan:w80date:'A':prem_count:p_mtrans) ;
020200140123
020300140123         if prem_count = *zeros ; // no ACA prem found - error!!
020400140123
020500140123         else ;
020600140123
020700140203          for idx = 1 to prem_count ;
020800140203            exsr Audit_Error ;
020900140123          endfor ;
021000140123
021100140425         endif ;
021200140123
021300140123      /end-free
021400140123     C                   Endsr
021500140123
021600000000      *___________________________________________________________________
021700140127      * Get the next date
021800000000      *___________________________________________________________________
021900140127     C     Get_Date      Begsr
022000160121     C
022100160122br01 C* B.Rees  Removed the Select Statement, Calculated the
022200160122 |   C* the w80Date
022300160121 |   C                   if        w80date = 0
022400160121 |   C                   eval      w80date = 20140101
022500160121 |   C                   else
022600160121 |   C                   eval      isoDat = %Date(w80Date:*iso)
022700160121 |   C                   eval      isoDat = isoDat + %Months(1)
022800160121 |   C                   eval      w80Date = %Dec(isoDat)
022900160121br01 C                   endif
023000160121     C
023100140127     C                   Endsr
023200140408      *___________________________________________________________________
023300140408      * Check in the month
023400140408      *___________________________________________________________________
023500140408     C     InTheMonth    Begsr
023600140425
023700140425     C                   eval      skip_SDT = 'N'
023800140408
023900140408      * Determine if enrldt is in the month
024000140408     C                   move      enrldt        isoEff
024100140408     C                   Extrct    isoEff:*d     isoDays
024200140408     C                   If        isoDays > 1
024300140408     C                   Eval      isoDays = isoDays - 1
024400140408     C     isoeff        Subdur    isoDays:*d    isoEff
024500140408     C                   End
024600140408
024700140425      * If they match, report on it, else skip it.
024800140408     C                   move      IsoEff        w80date2
024900140408     C                   If        w80date2 = w80date
025000140408     C                   eval      enrldt = w80date
025100140425     C                   Else
025200140425
025300140425      * exception: if same day term
025400140425     C                   if        enrldt = candt
025500140425     C                   eval      skip_SDT = 'Y'
025600140408     C                   End
025700140408
025800140425     C                   End
025900140425
026000140408     C                   Endsr
026100140123      *___________________________________________________________________
026200140123      * Get the ACCMST Record
026300140123      *___________________________________________________________________
026400140123     C     Get_Account   Begsr
026500140123     C     ACCKEY        Chain     ACCMST
026600140123     C                   If        %found(ACCMST)
026700140207     C                   If        ENRLDT <= ACVTDT and
026800140207     C                             LINV#  <> 0
026900140123     C                   eval      continue_flg = 'Y'
027000140123     C                   Else
027100140123     C                   eval      continue_flg = 'N'
027200140123     C                   End
027300140610
027400140610      * Dave K exception(1)
027500140210     C                   If        ENRLDT < GBSBDT
027600140210     C                   eval      continue_flg = 'N'
027700140210     C                   End
027800140610
027900140610      * Dave K exception(2) extract month/year
028000140610     C                   If        continue_flg = 'N'
028100140610
028200140610     C                   clear                   month1
028300140610     C                   clear                   month2
028400140610     C                   clear                   year1
028500140610     C                   clear                   year2
028600140610
028700140610     C                   Move      ENRLDT        isodat
028800140610     C                   Extrct    isodat:*m     month1
028900140610     C                   Extrct    isodat:*y     year1
029000140610     C                   Move      ACVTDT        isodat
029100140610     C                   Extrct    isodat:*m     month2
029200140610     C                   Extrct    isodat:*y     year2
029300140610
029400140610      * if same month/year then continue
029500140610      * Example: ENRLDT = '06/02/2014' and ACVTDT = '06/01/2014'
029600140610     C                   If        month1 = month2   and
029700140610     C                             year1  = year2
029800140610     C                   eval      continue_flg = 'Y'
029900140610     C                   End
030000140610     C                   End
030100140210
030200140123     C                   Else
030300140123     C                   eval      continue_flg = 'N'
030400140123     C                   End
030500140123     C                   Endsr
030600140123      *___________________________________________________________________
030700140123      * Audit Error
030800140123      *___________________________________________________________________
030900140123     C     Audit_Error   BEGSR
031000140203
031100140203     C                   If        p_audit(idx).aseq = 0
031200140203     C                   exsr      NAMES
031300140203     C                   else
031400140203     C                   exsr      NAMES
031500140203     C                   exsr      DNAMES
031600140203     C                   end
031700140203
031800140127     C                   eval      AANAM = %trim(WNAME)
031900140123     C                   eval      AASSN = %editw(mcssno:'   -  -    ')
032000140203     C                   eval      AASEQ = %char(p_audit(idx).aseq)
032100140210     C                   eval      AADNM = %trim(DNAME)
032200140123     C                   eval      AAPLN = %trim(MCPLAN)
032300140127     C                   eval      AAPLND = %trim(PDESCR)
032400140123     C                   eval      AAACT = %char(mctrst) + '-' +
032500140123     C                                     %char(mcsub#) + '-' +
032600140123     C                                     %char(acc#)
032700140131     C                   movel     W80DATE       Input_Date
032800140127     C                   exsr      FMTDATE
032900140127     C                   eval      AAEFF = %trim(Output_Date)
033000140131     C                   movel     ACVTDT        Input_Date
033100140131     C                   exsr      FMTDATE
033200140131     C                   eval      AACDT = %trim(Output_Date)
033300160304
033400160304     C***********        eval      AAPREM = %editc(p_audit(idx).adif:'N')
033500160307     C                   eval      AAPREM = p_audit(idx).adif
033600140213     C                   If        p_audit(idx).aman <> 0
033700160304     C***********        eval      AAMANAMT = %editc(p_audit(idx).aman:'N')
033800160307     C                   eval      AAMANAMT = p_audit(idx).aman
033900140213     C                   else
034000160307     C                   eval      AAMANAMT = *zeros
034100140213     C                   end
034200140206     C                   eval      AAPRO  = p_audit(idx).apro
034300140212     C                   If        AAPRO  = ' '
034400140207     C                   eval      AAERRD = 'Invoiced INVBILL'
034500140207     C                   else
034600140207     C                   eval      AAERRD = 'Difference in premium'
034700140207     C                   end
034800140212     C                   eval      prodate = p_audit(idx).adat
034900140212     C                   If        prodate <> 0
035000140212     C                   movel     prodate       Input_Date
035100140212     C                   exsr      FMTDATE
035200140212     C                   eval      AAPRODT = %trim(Output_Date)
035300140212     C                   else
035400140212     C                   eval      AAPRODT = *blanks
035500140212     C                   end
035600140127     C                   eval      AAACTD = %trim(ACNAM1)
035700140203     C                   if        p_audit(idx).adif <>  0  and
035800140128     C                             skip_this = 'N'
035900140131     C                   Write(e)  AAUDITR
036000140127     C                   end
036100140123     C                   Endsr
036200140128      *___________________________________________________________________
036300140128      * Get names
036400140128      *___________________________________________________________________
036500140128     C     NAMES         Begsr
036600140210     C                   clear                   WNAME
036700140210     C                   clear                   DNAME
036800140127     C                   clear                   PDESCR
036900140128     C                   eval      skip_this = 'N'
037000140127     C     mcssno        chain     MEMBER
037100140127     C                   if        %trim(MMI) <> *blanks
037200140127     C                   eval      wname = %trim(MFNAME) + ' ' +
037300140127     C                                     %trim(MMI)    + ' ' +
037400140127     C                                     %trim(MLNAME)
037500140127     C                   else
037600140127     C                   eval      wname = %trim(MFNAME) + ' ' +
037700140127     C                                     %trim(MLNAME)
037800140127     C                   end
037900140128
038000140128      * set cobra flag
038100140128     C                   If        CEXPDT <> 0
038200140128     C                   eval      AACOBRA = 'Y'
038300140128
038400140128      * Skip if active cobra during this date
038500140128     C                   If        w80date >= GBSCDT and
038600140128     C                             w80date <= CEXPDT
038700140128     C                   eval      skip_this = 'Y'
038800140128     C                   end
038900140128
039000140128     C                   else
039100140128     C                   eval      AACOBRA = ' '
039200140128     C                   end
039300140128
039400140128      * Exception:  If billed to the cobra member dont skip
039500140127     C     plnkey        chain     PLNMST
039600140128     C                   If        %found(PLNMST)
039700140128     C                   If        %trim(SFADM) = 'Y'
039800140128     C                   eval      skip_this = 'N'
039900140128     C                   end
040000140128     C                   end
040100140128
040200140127     C                   Endsr
040300140127      *___________________________________________________________________
040400140127      * Get D names
040500140127      *___________________________________________________________________
040600140127     C     DNAMES        Begsr
040700140210     C                   clear                   DNAME
040800140127     C                   clear                   PDESCR
040900140203     C                   eval      MDSEQ# = p_audit(idx).aseq
041000140127     C     depkey        chain     DEPNDC
041100140127     C                   if        %trim(DMI) <> *blanks
041200140210     C                   eval      dname = %trim(DFNAME) + ' ' +
041300140127     C                                     %trim(DMI)    + ' ' +
041400140127     C                                     %trim(DLNAME)
041500140127     C                   else
041600140210     C                   eval      dname = %trim(DFNAME) + ' ' +
041700140127     C                                     %trim(DLNAME)
041800140127     C                   end
041900140127     C     plnkey        chain     PLNMST
042000140127     C                   Endsr
042100140123      *___________________________________________________________________
042200140123      * Key Lists
042300140123      *___________________________________________________________________
042400140123     C     KLIST         BEGSR
042500140127     C     DCVKEY        Klist
042600140127     C                   Kfld                    MCSSNO
042700140127     C                   Kfld                    MDSEQ#
042800140127     C                   Kfld                    MCTRST
042900140127     C                   Kfld                    MCSUB#
043000140127     C                   Kfld                    MCPLAN
043100140127     C     DEPKEY        Klist
043200140127     C                   Kfld                    MCSSNO
043300140127     C                   Kfld                    MDSEQ#
043400140127     C     PLNKEY        Klist
043500140127     C                   Kfld                    MCTRST
043600140127     C                   Kfld                    MCSUB#
043700140127     C                   Kfld                    MCPLAN
043800140123     C     ACCKEY        Klist
043900140123     C                   Kfld                    MCTRST
044000140123     C                   Kfld                    MCSUB#
044100140123     C                   Kfld                    ACC#
044200140123     C     INVKEY        Klist
044300140127     C                   Kfld                    W80DATE
044400140123     C                   Kfld                    MCSSNO
044500140123     C                   Kfld                    MDSEQ#
044600140123     C                   Kfld                    MCTRST
044700140123     C                   Kfld                    MCSUB#
044800140123     C                   Kfld                    ACC#
044900140123     C                   Kfld                    MCPLAN
045000140123     C                   ENDSR
045100000000      *___________________________________________________________________
045200000000      * Program open
045300000000      *___________________________________________________________________
045400000000     C     *INZSR        BEGSR
045500140127     C                   open      ACCMST
045600140127     C                   open      MEMBER
045700140127     C                   open      PLNMST
045800140127     C                   open      DEPNDC
045900000000     C                   ENDSR
046000140127      *___________________________________________________________________
046100140127      * Formate Date
046200140127      *___________________________________________________________________
046300140127     C     FMTDATE       BEGSR
046400140127     C                   Call      'FMTDATE'
046500140127     C                   Parm                    Input_Date       32
046600140127     C                   Parm      'YYYYMMDD'    Input_Format     32
046700140127     C                   Parm      'MM/DD/YYYY'  Output_Format    32
046800140127     C                   Parm                    Output_Date      32
046900140127     C                   Parm                    Output_Error     10
047000140127     C                   ENDSR
047100140127
047200000000      *___________________________________________________________________
047300000000      * Program error handler
047400000000      *___________________________________________________________________
047500161104     C     *PSSR         BEGSR
047600161104     C                   CALL      'SNDRPGM'                            50
047700161104     C                   PARM                    WQPGMN
047800161104     C                   PARM                    WQSTSC
047900161104     C                   PARM                    WQRPGS
048000161104     C                   PARM                    WQMSG
048100161104     C                   ENDSR     '*CANCL'
