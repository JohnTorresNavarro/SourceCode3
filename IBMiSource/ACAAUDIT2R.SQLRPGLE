000100140206     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ACAAUDITR')
000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  ACA Audit Report
000500000000      *
000600000000      *  (c)Copyright 2014 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - January 23, 2014
000900000000      *_________________________________________________________________________
001000140123     FPLNAUXP   ip   e           k Disk
001100140123     FACCMST    if   e           k Disk    extfile('F.ACCMST') usropn
001200140127     FMEMBER    if   e           k Disk    extfile('F.MEMBER') usropn
001300140127     FDEPNDC    if   e           k Disk    extfile('F.DEPNDC') usropn
001400140127     FPLNMST    if   e           k Disk    extfile('F.PLNMST') usropn
001500140131     FACAAUDITLFo  a e           k Disk
001600140123
001700140123      /define copy_all_protos_and_fields
001800140203      /copy qcpysrc,acambraudp
001900140123      /undefine copy_all_protos_and_fields
002000140123
002100140210     D wname           s             40A
002200140210     D dname           s             40A
002300140123     D ACA             s              1A
002400140128     D Continue_Flg    s              1A
002500140425     D Skip_This       s              1A
002600140425     D Skip_SDT        s              1A
002700140610     D year1           s              4  0
002800140610     D year2           s              4  0
002900140610     D month1          s              2  0
003000140610     D month2          s              2  0
003100140610    ?d isodat          S               D   datfmt(*iso)                         Input Request
003200140123
003300140130     D d               s              2  0
003400140130     D pos             s              2  0
003500140130     D dep             s              2  0 dim(20) inz
003600140130
003700140127     D seq             s              2  0
003800140123     D idx             s              2  0
003900140127     D prem            s              7  2
004000140127     D prem_dif        s              7  2
004100140123     D prem_aca        s              7  2
004200140127     D prem_count      s              3  0
004300140212     D w80date         s              8  0
004400140408     D w80date2        S              8  0
004500140212     D prodate         s              8  0
004600140408
004700140408     D IsoEff          s               d   datfmt(*iso)
004800140408     D IsoDays         s              3s 0 inz
004900140123
005000140123     D COVDS         e ds                  extname(MCOV) inz
005100140123
005200000000      * Program status data structure
005300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
005400140123
005500140123     IPLNAUXR       01
005600140123
005700140123      * Audit all ACA Plans
005800141231     C   01              If        PXTRST = 591 and
005900141231     C                             PXSUB# = 008 and
006000141231     C                             PXACCT = 0409
006100140123     C                   Exsr      Audit_Plan
006200140123     C                   End
006300140123
006400140123     CLR                 close     ACCMST
006500140127     CLR                 close     PLNMST
006600140127     CLR                 close     MEMBER
006700140127     CLR                 close     DEPNDC
006800140123      *___________________________________________________________________
006900140123      * Audit ACA Plans
007000140123      *___________________________________________________________________
007100140123     C     Audit_Plan    Begsr
007200140123
007300140123      /free
007400140123
007500140130       exec sql declare j1 scroll cursor for select distinct mctrst, mcsub#,
007600140130       mcplan, acc#, enrldt, mcssno, mdseq#, candt from "F.MCOV"
007700140130        where (mctrst = :pxtrst and mcsub# = :pxsub# and
007800140207         mcplan = :pxplan) ;
007900140123
008000140123       exec sql open j1 ;
008100140123
008200140123       //?read all of selected ACA plan...
008300140123         dou       sqlcod <> *zeros ;
008400140123
008500140123       exec sql fetch next from j1 into
008600140130       :mctrst, :mcsub#, :mcplan, :acc#, :enrldt, :mcssno, :mdseq#, :candt ;
008700140123
008800140123         If        sqlcod = 0 ;
008900140123
009000140127         exsr      get_account  ;
009100140127         eval      w80date = 0 ;
009200140128         exsr      get_date ;
009300141231         If        continue_flg = 'Y' and mcssno = 214709998 ;
009400140127         dow    w80date <= acvtdt ;
009500140408         exsr      inthemonth ;
009600140425         if     enrldt <= w80date ;
009700140203         exsr      chk_diff ;
009800140127         exsr      get_date ;
009900140127         mdseq# = 0;
010000140131         else  ;
010100140131         exsr      get_date ;
010200140131         mdseq# = 0;
010300140131         endif ;
010400140127         enddo ;
010500140123         endif ;
010600140123
010700140123         endif ;
010800140123
010900140123         enddo ;
011000140123
011100140123       exec sql close j1 ;
011200140123
011300140123      /end-free
011400140123     C                   Endsr
011500140123
011600140123      *___________________________________________________________________
011700140123      * Get the Premiums and total for that SSN
011800140123      *___________________________________________________________________
011900140203     C     chk_Diff      Begsr
012000140123
012100140123      /free
012200140203
012300140204         p_audit = #aca_mbr_audit(mctrst:mcsub#:acc#:mcssno:
012400140204                                 mcplan:w80date:'A':prem_count) ;
012500140123
012600140123         if prem_count = *zeros ; // no ACA prem found - error!!
012700140123
012800140123         else ;
012900140123
013000140203          for idx = 1 to prem_count ;
013100140203            exsr Audit_Error ;
013200140123          endfor ;
013300140123
013400140425         endif ;
013500140123
013600140123      /end-free
013700140123     C                   Endsr
013800140123
013900000000      *___________________________________________________________________
014000140127      * Get the next date
014100000000      *___________________________________________________________________
014200140127     C     Get_Date      Begsr
014300140127     C                   select
014400140127     C                   when      w80date = 0
014500140127     C                   eval      w80date = 20140101
014600140127     C                   when      w80date = 20140101
014700140127     C                   eval      w80date = 20140201
014800140127     C                   when      w80date = 20140201
014900140127     C                   eval      w80date = 20140301
015000140127     C                   when      w80date = 20140301
015100140127     C                   eval      w80date = 20140401
015200140127     C                   when      w80date = 20140401
015300140127     C                   eval      w80date = 20140501
015400140127     C                   when      w80date = 20140501
015500140127     C                   eval      w80date = 20140601
015600140127     C                   when      w80date = 20140601
015700140127     C                   eval      w80date = 20140701
015800140127     C                   when      w80date = 20140701
015900140127     C                   eval      w80date = 20140801
016000140127     C                   when      w80date = 20140801
016100140127     C                   eval      w80date = 20140901
016200140127     C                   when      w80date = 20140901
016300140127     C                   eval      w80date = 20141001
016400140127     C                   when      w80date = 20141001
016500140127     C                   eval      w80date = 20141101
016600140127     C                   when      w80date = 20141101
016700140127     C                   eval      w80date = 20141201
016800140127     C                   endsl
016900140210
017000140210
017100140127     C                   Endsr
017200140408      *___________________________________________________________________
017300140408      * Check in the month
017400140408      *___________________________________________________________________
017500140408     C     InTheMonth    Begsr
017600140425
017700140425     C                   eval      skip_SDT = 'N'
017800140408
017900140408      * Determine if enrldt is in the month
018000140408     C                   move      enrldt        isoEff
018100140408     C                   Extrct    isoEff:*d     isoDays
018200140408     C                   If        isoDays > 1
018300140408     C                   Eval      isoDays = isoDays - 1
018400140408     C     isoeff        Subdur    isoDays:*d    isoEff
018500140408     C                   End
018600140408
018700140425      * If they match, report on it, else skip it.
018800140408     C                   move      IsoEff        w80date2
018900140408     C                   If        w80date2 = w80date
019000140408     C                   eval      enrldt = w80date
019100140425     C                   Else
019200140425
019300140425      * exception: if same day term
019400140425     C                   if        enrldt = candt
019500140425     C                   eval      skip_SDT = 'Y'
019600140408     C                   End
019700140408
019800140425     C                   End
019900140425
020000140408     C                   Endsr
020100140123      *___________________________________________________________________
020200140123      * Get the ACCMST Record
020300140123      *___________________________________________________________________
020400140123     C     Get_Account   Begsr
020500140123     C     ACCKEY        Chain     ACCMST
020600140123     C                   If        %found(ACCMST)
020700140207     C                   If        ENRLDT <= ACVTDT and
020800140207     C                             LINV#  <> 0
020900140123     C                   eval      continue_flg = 'Y'
021000140123     C                   Else
021100140123     C                   eval      continue_flg = 'N'
021200140123     C                   End
021300140610
021400140610      * Dave K exception(1)
021500140210     C                   If        ENRLDT < GBSBDT
021600140210     C                   eval      continue_flg = 'N'
021700140210     C                   End
021800140610
021900140610      * Dave K exception(2) extract month/year
022000140610     C                   If        continue_flg = 'N'
022100140610
022200140610     C                   clear                   month1
022300140610     C                   clear                   month2
022400140610     C                   clear                   year1
022500140610     C                   clear                   year2
022600140610
022700140610     C                   Move      ENRLDT        isodat
022800140610     C                   Extrct    isodat:*m     month1
022900140610     C                   Extrct    isodat:*y     year1
023000140610     C                   Move      ACVTDT        isodat
023100140610     C                   Extrct    isodat:*m     month2
023200140610     C                   Extrct    isodat:*y     year2
023300140610
023400140610      * if same month/year then continue
023500140610      * Example: ENRLDT = '06/02/2014' and ACVTDT = '06/01/2014'
023600140610     C                   If        month1 = month2   and
023700140610     C                             year1  = year2
023800140610     C                   eval      continue_flg = 'Y'
023900140610     C                   End
024000140610     C                   End
024100140210
024200140123     C                   Else
024300140123     C                   eval      continue_flg = 'N'
024400140123     C                   End
024500140123     C                   Endsr
024600140123      *___________________________________________________________________
024700140123      * Audit Error
024800140123      *___________________________________________________________________
024900140123     C     Audit_Error   BEGSR
025000140203
025100140203     C                   If        p_audit(idx).aseq = 0
025200140203     C                   exsr      NAMES
025300140203     C                   else
025400140203     C                   exsr      NAMES
025500140203     C                   exsr      DNAMES
025600140203     C                   end
025700140203
025800140127     C                   eval      AANAM = %trim(WNAME)
025900140123     C                   eval      AASSN = %editw(mcssno:'   -  -    ')
026000140203     C                   eval      AASEQ = %char(p_audit(idx).aseq)
026100140210     C                   eval      AADNM = %trim(DNAME)
026200140123     C                   eval      AAPLN = %trim(MCPLAN)
026300140127     C                   eval      AAPLND = %trim(PDESCR)
026400140123     C                   eval      AAACT = %char(mctrst) + '-' +
026500140123     C                                     %char(mcsub#) + '-' +
026600140123     C                                     %char(acc#)
026700140131     C                   movel     W80DATE       Input_Date
026800140127     C                   exsr      FMTDATE
026900140127     C                   eval      AAEFF = %trim(Output_Date)
027000140131     C                   movel     ACVTDT        Input_Date
027100140131     C                   exsr      FMTDATE
027200140131     C                   eval      AACDT = %trim(Output_Date)
027300140213     C                   eval      AAPREM = %editc(p_audit(idx).adif:'J')
027400140213     C                   If        p_audit(idx).aman <> 0
027500140213     C                   eval      AAMANAMT = %editc(p_audit(idx).aman:'J')
027600140213     C                   else
027700140213     C                   eval      AAMANAMT = *blanks
027800140213     C                   end
027900140206     C                   eval      AAPRO  = p_audit(idx).apro
028000140212     C                   If        AAPRO  = ' '
028100140207     C                   eval      AAERRD = 'Invoiced INVBILL'
028200140207     C                   else
028300140207     C                   eval      AAERRD = 'Difference in premium'
028400140207     C                   end
028500140212     C                   eval      prodate = p_audit(idx).adat
028600140212     C                   If        prodate <> 0
028700140212     C                   movel     prodate       Input_Date
028800140212     C                   exsr      FMTDATE
028900140212     C                   eval      AAPRODT = %trim(Output_Date)
029000140212     C                   else
029100140212     C                   eval      AAPRODT = *blanks
029200140212     C                   end
029300140127     C                   eval      AAACTD = %trim(ACNAM1)
029400140203     C                   if        p_audit(idx).adif <>  0  and
029500140128     C                             skip_this = 'N'
029600140131     C                   Write(e)  AAUDITR
029700140127     C                   end
029800140123     C                   Endsr
029900140128      *___________________________________________________________________
030000140128      * Get names
030100140128      *___________________________________________________________________
030200140128     C     NAMES         Begsr
030300140210     C                   clear                   WNAME
030400140210     C                   clear                   DNAME
030500140127     C                   clear                   PDESCR
030600140128     C                   eval      skip_this = 'N'
030700140127     C     mcssno        chain     MEMBER
030800140127     C                   if        %trim(MMI) <> *blanks
030900140127     C                   eval      wname = %trim(MFNAME) + ' ' +
031000140127     C                                     %trim(MMI)    + ' ' +
031100140127     C                                     %trim(MLNAME)
031200140127     C                   else
031300140127     C                   eval      wname = %trim(MFNAME) + ' ' +
031400140127     C                                     %trim(MLNAME)
031500140127     C                   end
031600140128
031700140128      * set cobra flag
031800140128     C                   If        CEXPDT <> 0
031900140128     C                   eval      AACOBRA = 'Y'
032000140128
032100140128      * Skip if active cobra during this date
032200140128     C                   If        w80date >= GBSCDT and
032300140128     C                             w80date <= CEXPDT
032400140128     C                   eval      skip_this = 'Y'
032500140128     C                   end
032600140128
032700140128     C                   else
032800140128     C                   eval      AACOBRA = ' '
032900140128     C                   end
033000140128
033100140128      * Exception:  If billed to the cobra member dont skip
033200140127     C     plnkey        chain     PLNMST
033300140128     C                   If        %found(PLNMST)
033400140128     C                   If        %trim(SFADM) = 'Y'
033500140128     C                   eval      skip_this = 'N'
033600140128     C                   end
033700140128     C                   end
033800140128
033900140127     C                   Endsr
034000140127      *___________________________________________________________________
034100140127      * Get D names
034200140127      *___________________________________________________________________
034300140127     C     DNAMES        Begsr
034400140210     C                   clear                   DNAME
034500140127     C                   clear                   PDESCR
034600140203     C                   eval      MDSEQ# = p_audit(idx).aseq
034700140127     C     depkey        chain     DEPNDC
034800140127     C                   if        %trim(DMI) <> *blanks
034900140210     C                   eval      dname = %trim(DFNAME) + ' ' +
035000140127     C                                     %trim(DMI)    + ' ' +
035100140127     C                                     %trim(DLNAME)
035200140127     C                   else
035300140210     C                   eval      dname = %trim(DFNAME) + ' ' +
035400140127     C                                     %trim(DLNAME)
035500140127     C                   end
035600140127     C     plnkey        chain     PLNMST
035700140127     C                   Endsr
035800140123      *___________________________________________________________________
035900140123      * Key Lists
036000140123      *___________________________________________________________________
036100140123     C     KLIST         BEGSR
036200140127     C     DCVKEY        Klist
036300140127     C                   Kfld                    MCSSNO
036400140127     C                   Kfld                    MDSEQ#
036500140127     C                   Kfld                    MCTRST
036600140127     C                   Kfld                    MCSUB#
036700140127     C                   Kfld                    MCPLAN
036800140127     C     DEPKEY        Klist
036900140127     C                   Kfld                    MCSSNO
037000140127     C                   Kfld                    MDSEQ#
037100140127     C     PLNKEY        Klist
037200140127     C                   Kfld                    MCTRST
037300140127     C                   Kfld                    MCSUB#
037400140127     C                   Kfld                    MCPLAN
037500140123     C     ACCKEY        Klist
037600140123     C                   Kfld                    MCTRST
037700140123     C                   Kfld                    MCSUB#
037800140123     C                   Kfld                    ACC#
037900140123     C     INVKEY        Klist
038000140127     C                   Kfld                    W80DATE
038100140123     C                   Kfld                    MCSSNO
038200140123     C                   Kfld                    MDSEQ#
038300140123     C                   Kfld                    MCTRST
038400140123     C                   Kfld                    MCSUB#
038500140123     C                   Kfld                    ACC#
038600140123     C                   Kfld                    MCPLAN
038700140123     C                   ENDSR
038800000000      *___________________________________________________________________
038900000000      * Program open
039000000000      *___________________________________________________________________
039100000000     C     *INZSR        BEGSR
039200140127     C                   open      ACCMST
039300140127     C                   open      MEMBER
039400140127     C                   open      PLNMST
039500140127     C                   open      DEPNDC
039600000000     C                   ENDSR
039700140127      *___________________________________________________________________
039800140127      * Formate Date
039900140127      *___________________________________________________________________
040000140127     C     FMTDATE       BEGSR
040100140127     C                   Call      'FMTDATE'
040200140127     C                   Parm                    Input_Date       32
040300140127     C                   Parm      'YYYYMMDD'    Input_Format     32
040400140127     C                   Parm      'MM/DD/YYYY'  Output_Format    32
040500140127     C                   Parm                    Output_Date      32
040600140127     C                   Parm                    Output_Error     10
040700140127     C                   ENDSR
040800140127
040900000000      *___________________________________________________________________
041000000000      * Program error handler
041100000000      *___________________________________________________________________
041200000000     C     *PSSR         BEGSR
041300000000     C                   CALL      'SNDRPGM'                            50
041400000000     C                   PARM                    WQPGMN
041500000000     C                   PARM                    WQSTSC
041600000000     C                   PARM                    WQRPGS
041700000000     C                   PARM                    WQMSG
041800000000     C                   ENDSR     '*CANCL'
