000100140429     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ACAAUDIT1R')
000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  ACA Audit Report
000500000000      *
000600000000      *  (c)Copyright 2014 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - January 23, 2014
000900000000      *_________________________________________________________________________
001000160920      *
001100160920      * B.Rees   9/20/2016  During a recompile, we had issues.  AAPREM is no
001200160920      * BR01                longer a character field.
001300160920      *-------------------------------------------------------------------------
001400140123     FPLNAUXP   ip   e           k Disk
001500140123     FACCMST    if   e           k Disk    extfile('F.ACCMST') usropn
001600140127     FMEMBER    if   e           k Disk    extfile('F.MEMBER') usropn
001700140127     FDEPNDC    if   e           k Disk    extfile('F.DEPNDC') usropn
001800140127     FPLNMST    if   e           k Disk    extfile('F.PLNMST') usropn
001900140131     FACAAUDITLFo  a e           k Disk
002000140123
002100140123      /define copy_all_protos_and_fields
002200140203      /copy qcpysrc,acambraudp
002300140123      /undefine copy_all_protos_and_fields
002400140123
002500140210     D wname           s             40A
002600140210     D dname           s             40A
002700140123     D ACA             s              1A
002800140128     D Continue_Flg    s              1A
002900140425     D Skip_This       s              1A
003000140425     D Skip_SDT        s              1A
003100140123
003200140130     D d               s              2  0
003300140130     D pos             s              2  0
003400140130     D dep             s              2  0 dim(20) inz
003500140130
003600140127     D seq             s              2  0
003700140123     D idx             s              2  0
003800140127     D prem            s              7  2
003900140127     D prem_dif        s              7  2
004000140123     D prem_aca        s              7  2
004100140127     D prem_count      s              3  0
004200140212     D w80date         s              8  0
004300140408     D w80date2        S              8  0
004400140212     D prodate         s              8  0
004500140408
004600140408     D IsoEff          s               d   datfmt(*iso)
004700140408     D IsoDays         s              3s 0 inz
004800140123
004900140123     D COVDS         e ds                  extname(MCOV) inz
005000140123
005100000000      * Program status data structure
005200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
005300140123
005400140123     IPLNAUXR       01
005500140123
005600140123      * Audit all ACA Plans
005700140123     C   01              If        %trim(PXACAR) = 'Y'
005800140123     C                   Exsr      Audit_Plan
005900140123     C                   End
006000140123
006100140123     CLR                 close     ACCMST
006200140127     CLR                 close     PLNMST
006300140127     CLR                 close     MEMBER
006400140127     CLR                 close     DEPNDC
006500140123      *___________________________________________________________________
006600140123      * Audit ACA Plans
006700140123      *___________________________________________________________________
006800140123     C     Audit_Plan    Begsr
006900140123
007000140123      /free
007100140123
007200140130       exec sql declare j1 scroll cursor for select distinct mctrst, mcsub#,
007300140130       mcplan, acc#, enrldt, mcssno, mdseq#, candt from "F.MCOV"
007400140130        where (mctrst = :pxtrst and mcsub# = :pxsub# and
007500140207         mcplan = :pxplan) ;
007600140123
007700140123       exec sql open j1 ;
007800140123
007900140123       //?read all of selected ACA plan...
008000140123         dou       sqlcod <> *zeros ;
008100140123
008200140123       exec sql fetch next from j1 into
008300140130       :mctrst, :mcsub#, :mcplan, :acc#, :enrldt, :mcssno, :mdseq#, :candt ;
008400140123
008500140123         If        sqlcod = 0 ;
008600140123
008700140127         exsr      get_account  ;
008800140127         eval      w80date = 0 ;
008900140128         exsr      get_date ;
009000140123         If        continue_flg = 'Y' ;
009100140127         dow    w80date <= acvtdt ;
009200140408         exsr      inthemonth ;
009300140425         if     enrldt <= w80date ;
009400140203         exsr      chk_diff ;
009500140127         exsr      get_date ;
009600140127         mdseq# = 0;
009700140131         else  ;
009800140131         exsr      get_date ;
009900140131         mdseq# = 0;
010000140131         endif ;
010100140127         enddo ;
010200140123         endif ;
010300140123
010400140123         endif ;
010500140123
010600140123         enddo ;
010700140123
010800140123       exec sql close j1 ;
010900140123
011000140123      /end-free
011100140123     C                   Endsr
011200140123
011300140123      *___________________________________________________________________
011400140123      * Get the Premiums and total for that SSN
011500140123      *___________________________________________________________________
011600140203     C     chk_Diff      Begsr
011700140123
011800140123      /free
011900140203
012000140204         p_audit = #aca_mbr_audit(mctrst:mcsub#:acc#:mcssno:
012100140204                                 mcplan:w80date:'A':prem_count) ;
012200140123
012300140123         if prem_count = *zeros ; // no ACA prem found - error!!
012400140123
012500140123         else ;
012600140123
012700140203          for idx = 1 to prem_count ;
012800140203            exsr Audit_Error ;
012900140123          endfor ;
013000140123
013100140425         endif ;
013200140123
013300140123      /end-free
013400140123     C                   Endsr
013500140123
013600000000      *___________________________________________________________________
013700140127      * Get the next date
013800000000      *___________________________________________________________________
013900140127     C     Get_Date      Begsr
014000140127     C                   select
014100140127     C                   when      w80date = 0
014200140127     C                   eval      w80date = 20140101
014300140127     C                   when      w80date = 20140101
014400140127     C                   eval      w80date = 20140201
014500140127     C                   when      w80date = 20140201
014600140127     C                   eval      w80date = 20140301
014700140127     C                   when      w80date = 20140301
014800140127     C                   eval      w80date = 20140401
014900140127     C                   when      w80date = 20140401
015000140127     C                   eval      w80date = 20140501
015100140127     C                   when      w80date = 20140501
015200140127     C                   eval      w80date = 20140601
015300140127     C                   when      w80date = 20140601
015400140127     C                   eval      w80date = 20140701
015500140127     C                   when      w80date = 20140701
015600140127     C                   eval      w80date = 20140801
015700140127     C                   when      w80date = 20140801
015800140127     C                   eval      w80date = 20140901
015900140127     C                   when      w80date = 20140901
016000140127     C                   eval      w80date = 20141001
016100140127     C                   when      w80date = 20141001
016200140127     C                   eval      w80date = 20141101
016300140127     C                   when      w80date = 20141101
016400140127     C                   eval      w80date = 20141201
016500140127     C                   endsl
016600140210
016700140210
016800140127     C                   Endsr
016900140408      *___________________________________________________________________
017000140408      * Check in the month
017100140408      *___________________________________________________________________
017200140408     C     InTheMonth    Begsr
017300140425
017400140425     C                   eval      skip_SDT = 'N'
017500140408
017600140408      * Determine if enrldt is in the month
017700140408     C                   move      enrldt        isoEff
017800140408     C                   Extrct    isoEff:*d     isoDays
017900140408     C                   If        isoDays > 1
018000140408     C                   Eval      isoDays = isoDays - 1
018100140408     C     isoeff        Subdur    isoDays:*d    isoEff
018200140408     C                   End
018300140408
018400140425      * If they match, report on it, else skip it.
018500140408     C                   move      IsoEff        w80date2
018600140408     C                   If        w80date2 = w80date
018700140408     C                   eval      enrldt = w80date
018800140425     C                   Else
018900140425
019000140425      * exception: if same day term
019100140425     C                   if        enrldt = candt
019200140425     C                   eval      skip_SDT = 'Y'
019300140408     C                   End
019400140408
019500140425     C                   End
019600140425
019700140408     C                   Endsr
019800140123      *___________________________________________________________________
019900140123      * Get the ACCMST Record
020000140123      *___________________________________________________________________
020100140123     C     Get_Account   Begsr
020200140123     C     ACCKEY        Chain     ACCMST
020300140123     C                   If        %found(ACCMST)
020400140207     C                   If        ENRLDT <= ACVTDT and
020500140207     C                             LINV#  <> 0
020600140123     C                   eval      continue_flg = 'Y'
020700140123     C                   Else
020800140123     C                   eval      continue_flg = 'N'
020900140123     C                   End
021000140210      * Dave K exception
021100140210     C                   If        ENRLDT < GBSBDT
021200140210     C                   eval      continue_flg = 'N'
021300140210     C                   End
021400140210
021500140123     C                   Else
021600140123     C                   eval      continue_flg = 'N'
021700140123     C                   End
021800140123     C                   Endsr
021900140123      *___________________________________________________________________
022000140123      * Audit Error
022100140123      *___________________________________________________________________
022200140123     C     Audit_Error   BEGSR
022300140203
022400140203     C                   If        p_audit(idx).aseq = 0
022500140203     C                   exsr      NAMES
022600140203     C                   else
022700140203     C                   exsr      NAMES
022800140203     C                   exsr      DNAMES
022900140203     C                   end
023000140203
023100140127     C                   eval      AANAM = %trim(WNAME)
023200140123     C                   eval      AASSN = %editw(mcssno:'   -  -    ')
023300140203     C                   eval      AASEQ = %char(p_audit(idx).aseq)
023400140210     C                   eval      AADNM = %trim(DNAME)
023500140123     C                   eval      AAPLN = %trim(MCPLAN)
023600140127     C                   eval      AAPLND = %trim(PDESCR)
023700140123     C                   eval      AAACT = %char(mctrst) + '-' +
023800140123     C                                     %char(mcsub#) + '-' +
023900140123     C                                     %char(acc#)
024000140131     C                   movel     W80DATE       Input_Date
024100140127     C                   exsr      FMTDATE
024200140127     C                   eval      AAEFF = %trim(Output_Date)
024300140131     C                   movel     ACVTDT        Input_Date
024400140131     C                   exsr      FMTDATE
024500140131     C                   eval      AACDT = %trim(Output_Date)
024600160920br01 C*                  eval      AAPREM = %editc(p_audit(idx).adif:'J')
024700160920br01 C                   eval      AAPREM = p_audit(idx).adif
024800140213     C                   If        p_audit(idx).aman <> 0
024900160920br01 C*                  eval      AAMANAMT = %editc(p_audit(idx).aman:'J')
025000160920br01 C                   eval      AAMANAMT = p_audit(idx).aman
025100140213     C                   else
025200160920br01 C*                  eval      AAMANAMT = *blanks
025300160920br01 C                   eval      AAMANAMT = *Zeros
025400140213     C                   end
025500140206     C                   eval      AAPRO  = p_audit(idx).apro
025600140212     C                   If        AAPRO  = ' '
025700140207     C                   eval      AAERRD = 'Invoiced INVBILL'
025800140207     C                   else
025900140207     C                   eval      AAERRD = 'Difference in premium'
026000140207     C                   end
026100140212     C                   eval      prodate = p_audit(idx).adat
026200140212     C                   If        prodate <> 0
026300140212     C                   movel     prodate       Input_Date
026400140212     C                   exsr      FMTDATE
026500140212     C                   eval      AAPRODT = %trim(Output_Date)
026600140212     C                   else
026700140212     C                   eval      AAPRODT = *blanks
026800140212     C                   end
026900140127     C                   eval      AAACTD = %trim(ACNAM1)
027000140203     C                   if        p_audit(idx).adif <>  0  and
027100140128     C                             skip_this = 'N'
027200140131     C                   Write(e)  AAUDITR
027300140127     C                   end
027400140123     C                   Endsr
027500140128      *___________________________________________________________________
027600140128      * Get names
027700140128      *___________________________________________________________________
027800140128     C     NAMES         Begsr
027900140210     C                   clear                   WNAME
028000140210     C                   clear                   DNAME
028100140127     C                   clear                   PDESCR
028200140128     C                   eval      skip_this = 'N'
028300140127     C     mcssno        chain     MEMBER
028400140127     C                   if        %trim(MMI) <> *blanks
028500140127     C                   eval      wname = %trim(MFNAME) + ' ' +
028600140127     C                                     %trim(MMI)    + ' ' +
028700140127     C                                     %trim(MLNAME)
028800140127     C                   else
028900140127     C                   eval      wname = %trim(MFNAME) + ' ' +
029000140127     C                                     %trim(MLNAME)
029100140127     C                   end
029200140128
029300140128      * set cobra flag
029400140128     C                   If        CEXPDT <> 0
029500140128     C                   eval      AACOBRA = 'Y'
029600140128
029700140128      * Skip if active cobra during this date
029800140128     C                   If        w80date >= GBSCDT and
029900140128     C                             w80date <= CEXPDT
030000140128     C                   eval      skip_this = 'Y'
030100140128     C                   end
030200140128
030300140128     C                   else
030400140128     C                   eval      AACOBRA = ' '
030500140128     C                   end
030600140128
030700140128      * Exception:  If billed to the cobra member dont skip
030800140127     C     plnkey        chain     PLNMST
030900140128     C                   If        %found(PLNMST)
031000140128     C                   If        %trim(SFADM) = 'Y'
031100140128     C                   eval      skip_this = 'N'
031200140128     C                   end
031300140128     C                   end
031400140128
031500140127     C                   Endsr
031600140127      *___________________________________________________________________
031700140127      * Get D names
031800140127      *___________________________________________________________________
031900140127     C     DNAMES        Begsr
032000140210     C                   clear                   DNAME
032100140127     C                   clear                   PDESCR
032200140203     C                   eval      MDSEQ# = p_audit(idx).aseq
032300140127     C     depkey        chain     DEPNDC
032400140127     C                   if        %trim(DMI) <> *blanks
032500140210     C                   eval      dname = %trim(DFNAME) + ' ' +
032600140127     C                                     %trim(DMI)    + ' ' +
032700140127     C                                     %trim(DLNAME)
032800140127     C                   else
032900140210     C                   eval      dname = %trim(DFNAME) + ' ' +
033000140127     C                                     %trim(DLNAME)
033100140127     C                   end
033200140127     C     plnkey        chain     PLNMST
033300140127     C                   Endsr
033400140123      *___________________________________________________________________
033500140123      * Key Lists
033600140123      *___________________________________________________________________
033700140123     C     KLIST         BEGSR
033800140127     C     DCVKEY        Klist
033900140127     C                   Kfld                    MCSSNO
034000140127     C                   Kfld                    MDSEQ#
034100140127     C                   Kfld                    MCTRST
034200140127     C                   Kfld                    MCSUB#
034300140127     C                   Kfld                    MCPLAN
034400140127     C     DEPKEY        Klist
034500140127     C                   Kfld                    MCSSNO
034600140127     C                   Kfld                    MDSEQ#
034700140127     C     PLNKEY        Klist
034800140127     C                   Kfld                    MCTRST
034900140127     C                   Kfld                    MCSUB#
035000140127     C                   Kfld                    MCPLAN
035100140123     C     ACCKEY        Klist
035200140123     C                   Kfld                    MCTRST
035300140123     C                   Kfld                    MCSUB#
035400140123     C                   Kfld                    ACC#
035500140123     C     INVKEY        Klist
035600140127     C                   Kfld                    W80DATE
035700140123     C                   Kfld                    MCSSNO
035800140123     C                   Kfld                    MDSEQ#
035900140123     C                   Kfld                    MCTRST
036000140123     C                   Kfld                    MCSUB#
036100140123     C                   Kfld                    ACC#
036200140123     C                   Kfld                    MCPLAN
036300140123     C                   ENDSR
036400000000      *___________________________________________________________________
036500000000      * Program open
036600000000      *___________________________________________________________________
036700000000     C     *INZSR        BEGSR
036800140127     C                   open      ACCMST
036900140127     C                   open      MEMBER
037000140127     C                   open      PLNMST
037100140127     C                   open      DEPNDC
037200000000     C                   ENDSR
037300140127      *___________________________________________________________________
037400140127      * Formate Date
037500140127      *___________________________________________________________________
037600140127     C     FMTDATE       BEGSR
037700140127     C                   Call      'FMTDATE'
037800140127     C                   Parm                    Input_Date       32
037900140127     C                   Parm      'YYYYMMDD'    Input_Format     32
038000140127     C                   Parm      'MM/DD/YYYY'  Output_Format    32
038100140127     C                   Parm                    Output_Date      32
038200140127     C                   Parm                    Output_Error     10
038300140127     C                   ENDSR
038400140127
038500000000      *___________________________________________________________________
038600000000      * Program error handler
038700000000      *___________________________________________________________________
038800000000     C     *PSSR         BEGSR
038900000000     C                   CALL      'SNDRPGM'                            50
039000000000     C                   PARM                    WQPGMN
039100000000     C                   PARM                    WQSTSC
039200000000     C                   PARM                    WQRPGS
039300000000     C                   PARM                    WQMSG
039400000000     C                   ENDSR     '*CANCL'
