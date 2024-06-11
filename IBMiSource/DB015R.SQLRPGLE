000100000000      *_________________________________________________________________________
000200000000      *
000300140610      *  Description:  ACA coverage level mismatch report
000400000000      *
000500140610      *  (c)Copyright 2014 by GBS, Inc.
000600000000      *
000700140610      *    Created by:  JALLEN - June 10, 2014
000800160825      * 08/25/16 dlk - Correct spelling of "individual"
000900160923      *
001000160923      * 09/23/16 jva - tighten up editing
001100170117      *
001200170117      * 01/17/17 jva - they should not show due to the tier set.
001300181231      * 12/31/18 dlk - Shelly requested Dominion family plans without a
001400181231      *                spouse not show as an error.
001500191004      * 10/04/19 jva - added grandchild relationship code = GC01
001600181231      *
001700000000      *_________________________________________________________________________
001800140123     FPLNAUXP   ip   e           k Disk
001900140620     FACCMST    if   e           k Disk    extfile('F.ACCMST') prefix(F) usropn
002000140127     FMEMBER    if   e           k Disk    extfile('F.MEMBER') usropn
002100140610     FDEPNDC    if   e           k Disk    extfile('F.DEPNDC') usropn
002200140611     FDCOVC     if   e           k Disk    extfile('F.DCOVC') usropn
002300140611     FMCOVC     if   e           k Disk    extfile('F.MCOVC') usropn
002400140619     FPLNMST    if   e           k Disk    extfile('F.PLNMST') usropn
002500140620     FCODESL1   if   e           k Disk    extfile('F.CODESL1') usropn
002600140620     FAACODE    if   e           k Disk    prefix(A_) usropn
002700140724     FGRAT24    if   e           K disk    extfile('F.GRAT24')
002800181231     Fcarmst    if   e           k Disk    extfile('F.CARMST')
002900140610     FDB015CLVLPif   e           k Disk
003000140610     FDB015LF   o  a e           k Disk
003100140610
003200140210     D wname           s             40A
003300140210     D dname           s             40A
003400140610    ?d isodat          S               D   datfmt(*iso)                         Input Request
003500140123
003600140619     D a               s              2  0
003700140619     D b               s              2  0
003800140610     D d               s              2  0
003900140610     D s               s              2  0
004000140611     D m               s              2  0
004100140610     D n               s              2  0
004200140611     D pos             s              2  0
004300160923     D tp2             s              1
004400160923     D thw             s              1
004500140611     D seq             s              2
004600140610     D dep             s              2    dim(25) inz
004700140130
004800140123     D idx             s              2  0
004900140212     D w80date         s              8  0
005000140408     D w80date2        S              8  0
005100140408
005200140408     D IsoEff          s               d   datfmt(*iso)
005300140408     D IsoDays         s              3s 0 inz
005400140123
005500140123     D COVDS         e ds                  extname(MCOV) inz
005600140123
005700000000      * Program status data structure
005800000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
005900140123
006000140123     IPLNAUXR       01
006100140618
006200140618      * Open up for all plans not just ACA - DAVEK.
006300140610      * Audit all ACA Plans for mismatched coverage levels
006400140618     C***01              If        %trim(PXACAR) = 'Y'
006500140610     C                   Exsr      Audit_Member
006600140610     C                   Exsr      Audit_Depend
006700140618     C***                End
006800140123
006900140620     CLR                 close     AACODE
007000140123     CLR                 close     ACCMST
007100140619     CLR                 close     PLNMST
007200140619     CLR                 close     CODESL1
007300140127     CLR                 close     MEMBER
007400140610     CLR                 close     DEPNDC
007500140611     CLR                 close     DCOVC
007600140611     CLR                 close     MCOVC
007700140123      *___________________________________________________________________
007800140610      * Audit ACA Plans for members
007900140123      *___________________________________________________________________
008000140610     C     Audit_Member  Begsr
008100140123
008200140123      /free
008300140123
008400140130       exec sql declare j1 scroll cursor for select distinct mctrst, mcsub#,
008500140610       mcplan, acc#, mcovtp, enrldt, mcssno, mdseq#, candt from "F.MCOV"
008600140130        where (mctrst = :pxtrst and mcsub# = :pxsub# and
008700140619         mcplan = :pxplan and enrldt <> candt and candt = 0) ;
008800140123
008900140123       exec sql open j1 ;
009000140123
009100140123       //?read all of selected ACA plan...
009200140123         dou       sqlcod <> *zeros ;
009300140123
009400140123       exec sql fetch next from j1 into
009500140610       :mctrst, :mcsub#, :mcplan, :acc#,
009600140610       :mcovtp, :enrldt, :mcssno, :mdseq#, :candt ;
009700140123
009800140123         If        sqlcod = 0 ;
009900140610
010000140610         exsr  check_depn ;
010100140123
010200140123         endif ;
010300140123
010400140123         enddo ;
010500140123
010600140123       exec sql close j1 ;
010700140123
010800140123      /end-free
010900140610     C                   Endsr
011000140610      *___________________________________________________________________
011100140610      * Check Dependent coverage level
011200140610      *___________________________________________________________________
011300140610     C     Check_Depn    BEGSR
011400140610
011500140619     C                   eval      a = 0
011600140619     C                   eval      b = 0
011700140610     C                   eval      s = 0
011800140610     C                   eval      d = 0
011900140610     C                   eval      n = 0
012000140619
012100140619     C                   if        candt = 0
012200140619     C                   eval      a = a+1
012300140619     C                   end
012400140610
012500140610     C     MCOVTP        chain     DB015CLVLP
012600140610     C                   If        %found(DB015CLVLP)
012700140610
012800140610     C     MCSSNO        Setll     DEPNDC
012900140610     C     MCSSNO        Reade     DEPNDC
013000140610     C                   dow       not %eof(DEPNDC)
013100140611
013200140610
013300140610     C                   eval      n = n+1
013400140610
013500140610     C     DCVKEY        Chain     DCOVC
013600140610     C                   If        %found(DCOVC)
013700140611
013800140611     C                   if        (enrldt = denrdt) or
013900140611     C                             (ccandt = 0       and
014000140611     C                             enrldt = denrdt)  or
014100140611     C                             (candt = 0        and
014200140619     C                              ccandt = 0)
014300140611
014400140619     C                   if        ccandt = 0
014500140619
014600140619     C                   if        ccandt = 0
014700140619     C                   eval      b = b+1
014800140619     C                   end
014900140610
015000140610     C                   select
015100140610     C                   When      DRELCD = 'RHU'
015200140610     C                   eval      s = s+1
015300140611     C                   When      DRELCD = 'RWI'
015400140611     C                   eval      s = s+1
015500140611     C                   When      DRELCD = 'RPA'
015600140610     C                   eval      s = s+1
015700140610     C                   When      DRELCD = 'RSO'
015800140610     C                   eval      d = d+1
015900140610     C                   When      DRELCD = 'RDA'
016000140610     C                   eval      d = d+1
016100160928     C                   When      DRELCD = 'ROO'
016200160928     C                   eval      d = d+1
016300191004GC01 C                   When      DRELCD = 'RGC'
016400191004GC01 C                   eval      d = d+1
016500140610     C                   endsl
016600140610
016700140611     C                   End
016800140611     C                   End
016900140610     C                   End
017000140610
017100140610     C     MCSSNO        Reade     DEPNDC
017200140610     C                   Enddo
017300140610
017400140611     C                   if        MCOVTP = 'TIN' and
017500140610     C                             s <> 0
017600160825     C                   eval      AAERRD = 'INDIVIDUAL COV WITH SPOUSE'
017700140610     C                   exsr      Audit_Error
017800140611     C                   end
017900140611
018000140611     C                   if        MCOVTP = 'TIN' and
018100140610     C                             d <> 0
018200160825     C                   eval      AAERRD = 'INDIVIDUAL COV WITH DEPENDENTS'
018300140610     C                   exsr      Audit_Error
018400140611     C                   end
018500140618
018600140618     C                   if        MCOVTP = 'TMI' and
018700140618     C                             s <> 0
018800160825     C                   eval      AAERRD = 'INDIVIDUAL COV WITH SPOUSE'
018900140618     C                   exsr      Audit_Error
019000140618     C                   end
019100140618
019200140618     C                   if        MCOVTP = 'TMI' and
019300140618     C                             d <> 0
019400160825     C                   eval      AAERRD = 'INDIVIDUAL COV WITH DEPENDENTS'
019500140618     C                   exsr      Audit_Error
019600140618     C                   end
019700140611
019800140611     C                   if        MCOVTP = 'THW' and
019900140610     C                             s = 0
020000140610     C                   eval      AAERRD = 'H/W COV MISSING SPOUSE'
020100140610     C                   exsr      Audit_Error
020200140611     C                   end
020300140618
020400140618     C                   if        MCOVTP = 'TMH' and
020500140618     C                             s = 0
020600140618     C                   eval      AAERRD = 'H/W COV MISSING SPOUSE'
020700140618     C                   exsr      Audit_Error
020800140618     C                   end
020900140611
021000140611     C                   if        MCOVTP = 'THW' and
021100140610     C                             d <> 0
021200140610     C                   eval      AAERRD = 'H/W COV WITH DEPENDENTS'
021300140610     C                   exsr      Audit_Error
021400140611     C                   end
021500140618
021600140618     C                   if        MCOVTP = 'TMH' and
021700140618     C                             d <> 0
021800140618     C                   eval      AAERRD = 'H/W COV WITH DEPENDENTS'
021900140618     C                   exsr      Audit_Error
022000140618     C                   end
022100140611
022200181231      * Family must have spouse
022300181231      * Check for P2 level
022400181231      *  * Note - this error message is used elsewhere in the program so
022500181231      *           if the text is changed it needs to be changed there also
022600140724     C                   exsr      CHKP2
022700140611     C                   if        MCOVTP = 'TFA' and
022800140724     C                             s = 0          and
022900181231     C                             TP2 = 'Y'
023000140610     C                   eval      AAERRD = 'FAMILY COV MISSING SPOUSE'
023100140610     C                   exsr      Audit_Error
023200140611     C                   end
023300140611
023400160923      * Check for HW level
023500160923     C                   exsr      CHKHW
023600140611     C                   if        MCOVTP = 'TFA' and
023700160923     C                             d = 0          and
023800160923     C                             THW = 'Y'
023900140610     C                   eval      AAERRD = 'FAMILY COV MISSING DEPENDENTS'
024000140610     C                   exsr      Audit_Error
024100140611     C                   end
024200140611
024300140611     C                   if        MCOVTP = 'TPC' and
024400140610     C                             d = 0
024500140610     C                   eval      AAERRD = 'PARENT/CHILD MISSING DEPENDENT'
024600140610     C                   exsr      Audit_Error
024700140611     C                   end
024800140611
024900140611     C                   if        MCOVTP = 'TP2' and
025000140610     C                             d <= 1
025100140610     C                   eval      AAERRD = 'PARENT/CHILDREN MISSING DEPENDENT'
025200140610     C                   exsr      Audit_Error
025300140611     C                   end
025400140611
025500140610
025600140610
025700140610     C                   End
025800140610
025900140123     C                   Endsr
026000140610      *___________________________________________________________________
026100140610      * Audit ACA Plans for dependents
026200140610      *___________________________________________________________________
026300140610     C     Audit_Depend  Begsr
026400140611
026500140611      /free
026600140611
026700140611       exec sql declare d1 scroll cursor for select distinct dvtrst, dvsub#,
026800140611       dvplan, ssno, dseq#, dvdltd, denrdt, ccandt from "F.DCOV"
026900140611        where (dvtrst = :pxtrst and dvsub# = :pxsub# and
027000140619         dvplan = :pxplan and denrdt <> ccandt and ccandt = 0) ;
027100140611
027200140611       exec sql open d1 ;
027300140611
027400140611       //?read all of selected ACA plan...
027500140611         dou       sqlcod <> *zeros ;
027600140611
027700140611       exec sql fetch next from d1 into
027800140611       :dvtrst, :dvsub#, :dvplan, :ssno,
027900140611       :dseq#, :dvdltd, :denrdt, :ccandt ;
028000140611
028100140611         If        sqlcod = 0 ;
028200140611
028300140611         exsr  check_memb ;
028400140611
028500140611         endif ;
028600140611
028700140611         enddo ;
028800140611
028900140611       exec sql close d1 ;
029000140611
029100140611      /end-free
029200140610
029300140610     C                   Endsr
029400140611      *___________________________________________________________________
029500140611      * Check Member coverage level
029600140611      *___________________________________________________________________
029700140611     C     Check_memb    BEGSR
029800140611
029900140619     C                   eval      m = 0
030000140619     C                   eval      a = 0
030100140619     C                   eval      b = 0
030200140611     C                   eval      dname = *blanks
030300140611     C                   eval      seq   = *blanks
030400140619
030500140619     C                   if        ccandt = 0
030600140619     C                   eval      a = a+1
030700140619     C                   end
030800140611
030900140611     C     MCVKEY        Setgt     MCOVC
031000140611     C     MCVKEY        Readpe    MCOVC
031100140611     C                   dow       not %eof(MCOVC)
031200140611
031300140611     C                   If        denrdt = enrldt
031400140611     C                   leaveSR
031500140611     C                   end
031600140611
031700140611     C                   if        denrdt >= enrldt and
031800140611     C                             ccandt = 0       and
031900140611     C                             candt  = 0
032000140611     C                   leaveSR
032100140611     C                   end
032200140618
032300140618     C                   if        denrdt >= enrldt and
032400140618     C                             ccandt = candt
032500140618     C                   leaveSR
032600140618     C                   end
032700140618
032800140618     C                   if        denrdt >= enrldt and
032900140618     C                             ccandt <= candt
033000140618     C                   leaveSR
033100140618     C                   end
033200140611
033300140611     C                   if        denrdt <= enrldt and
033400140611     C                             ccandt = 0       and
033500140611     C                             candt  = 0
033600140611     C                   leaveSR
033700140611     C                   end
033800140619
033900140619     C                   If        candt = 0
034000140619     C                   eval      b = b+1
034100140619     C                   end
034200140611
034300140611     C     MCVKEY        Readpe    MCOVC
034400140611     C                   Enddo
034500140611
034600140611     C                   eval      AAERRD = 'DEPENDENT COVERAGE EXIST ' +
034700140616     C                                      'OUTSIDE OF MEMBERS EFF DATE'
034800140611     C                   exsr      DNAMES
034900140611     C                   exsr      Audit_Error
035000140611
035100140611     C                   Endsr
035200140123      *___________________________________________________________________
035300140123      * Audit Error
035400140123      *___________________________________________________________________
035500140123     C     Audit_Error   BEGSR
035600140611
035700140203     C                   exsr      NAMES
035800140611     C                   If        termdt <> *zeros
035900140611     C                   LeaveSR
036000140611     C                   End
036100140724
036200170117      * omit
036300140724     C                   If        mctrst = 888
036400140724     C                   LeaveSR
036500140724     C                   End
036600170117
036700170117      * omit - they should not show due to the tier set up
036800170117     C                   If        mctrst = 591  and
036900170117     C                             mcSub# = 003  and
037000170117     C                             acc#   = 0483
037100170117     C                   LeaveSR
037200170117     C                   End
037300140619
037400140619     C     plnkey        chain     PLNMST
037500160923
037600160923      * no edits for VSP
037700160923     C                   if        %trim(PCARR) = 'VSP'
037800160923     C                   LeaveSR
037900160923     C                   End
038000181231
038100181231      * 12/31/18 - Dominion family plans may not have a spouse, do not
038200181231      *            show this error
038300181231       if AAERRD = 'FAMILY COV MISSING SPOUSE';
038400181231        chain pcarr carmst;
038500181231        if %found(carmst) and (cgrpcd = 'DQ' or cgrpcd = 'DO');
038600181231         leavesr;
038700181231        endif;
038800181231       endif;
038900160923
039000140619     C     plncat        chain     CODESL1
039100140619     C                   select
039200140619     C                   when      action = 'M'
039300140619     C                   when      action = 'D'
039400140619     C                   when      action = 'V'
039500140619     C                   other
039600140619     C                   LeaveSR
039700140619     C                   Endsl
039800140619
039900140619     C                   if        a > 0  or
040000140619     C                             b > 0
040100140618
040200140618     C                   If        %trim(PXACAR) = 'Y'
040300140618     C                   eval      AAACA = 'Y'
040400140618     C                   Else
040500140618     C                   eval      AAACA = ' '
040600140618     C                   End
040700140203
040800140127     C                   eval      AANAM = %trim(WNAME)
040900140611     C                   eval      AASSN = %editw(mcssno:'   -  -    ')
041000140611     C                   eval      AASEQ = SEQ
041100140611     C                   eval      AADNM = %trim(DNAME)
041200140611     C                   eval      AAPLN = %trim(MCPLAN)
041300140611     C                   eval      AACLVL = %trim(MCOVTP)
041400140127     C                   eval      AAPLND = %trim(PDESCR)
041500140611     C                   eval      AAACT = %editc(mctrst:'X') + '-' +
041600140611     C                                     %editc(mcsub#:'X') + '-' +
041700140611     C                                     %editc(acc#:'X')
041800140610     C                   movel     ENRLDT        Input_Date
041900140127     C                   exsr      FMTDATE
042000140127     C                   eval      AAEFF = %trim(Output_Date)
042100140610     C                   movel     CANDT         Input_Date
042200140131     C                   exsr      FMTDATE
042300140610     C                   eval      AACAN = %trim(Output_Date)
042400140620     C                   eval      AAACTD = %trim(FACNAM1)
042500140610     C                   Write(e)  DB15R
042600140826     C                   clear                   DB15R
042700140826     C                   clear                   DNAME
042800140826     C                   clear                   SEQ
042900140619     C                   End
043000140619
043100140123     C                   Endsr
043200140128      *___________________________________________________________________
043300140128      * Get names
043400140128      *___________________________________________________________________
043500140128     C     NAMES         Begsr
043600140210     C                   clear                   WNAME
043700140127     C                   clear                   PDESCR
043800140620     C     acckey        chain     ACCMST
043900140620     C     faacode       chain     AACODE
044000140620     C                   eval      AAACTA = %trim(A_AFNAM) + ' ' +
044100140620     C                                      %trim(A_ALNAM)
044200140127     C     mcssno        chain     MEMBER
044300140127     C                   if        %trim(MMI) <> *blanks
044400140127     C                   eval      wname = %trim(MFNAME) + ' ' +
044500140127     C                                     %trim(MMI)    + ' ' +
044600140127     C                                     %trim(MLNAME)
044700140127     C                   else
044800140127     C                   eval      wname = %trim(MFNAME) + ' ' +
044900140127     C                                     %trim(MLNAME)
045000140127     C                   end
045100140128
045200140127     C                   Endsr
045300140127      *___________________________________________________________________
045400140127      * Get D names
045500140127      *___________________________________________________________________
045600140127     C     DNAMES        Begsr
045700140210     C                   clear                   DNAME
045800140127     C                   clear                   PDESCR
045900140611     C     DEPKEY        Chain     DEPNDC
046000140127     C                   if        %trim(DMI) <> *blanks
046100140210     C                   eval      dname = %trim(DFNAME) + ' ' +
046200140127     C                                     %trim(DMI)    + ' ' +
046300140127     C                                     %trim(DLNAME)
046400140127     C                   else
046500140210     C                   eval      dname = %trim(DFNAME) + ' ' +
046600140127     C                                     %trim(DLNAME)
046700140127     C                   end
046800140611     C                   eval      SEQ = %editc(DSEQ#:'X')
046900140127     C                   Endsr
047000140724      *___________________________________________________________________
047100140724      * Check for P2
047200140724      *___________________________________________________________________
047300140724     C     CHKP2         BEGSR
047400140724
047500140724     C     GrtKey        Klist
047600140724     C                   Kfld                    MCTRST
047700140724     C                   Kfld                    MCSUB#
047800140724     C                   Kfld                    MCPLAN
047900140724
048000140724     C                   eval      TP2 = 'N'
048100140724
048200140724     C     GrtKey        Setll     GRAT24
048300140724     C     GrtKey        Reade     GRAT24
048400140724     C                   Dow       not %eof(GRAT24)
048500140724      * Skip Deleted
048600140724     C                   If        grdltd <> 'D'
048700140724      * GBS Date Logic
048800140724     C                   If        frmdat <> todat
048900140724     C                   If        todat   = *zeros
049000140724     C                   eval      todat   = 99999999
049100140724     C                   End
049200140724     C                   if        w80date >= frmdat and
049300140724     C                             w80date <= todat
049400140724
049500140724     C                   If        %trim(TYPECD) = 'TP2'
049600140724     C                   eval      TP2 = 'Y'
049700140724     C                   Leave
049800140724     C                   end
049900140724
050000140724     C                   end
050100140724     C                   end
050200140724     C                   end
050300140724     C     GrtKey        Reade     GRAT24
050400140724     C                   Enddo
050500140724
050600140724     C                   Endsr
050700160923      *___________________________________________________________________
050800160923      * Check for Spouse
050900160923      *___________________________________________________________________
051000160923     C     CHKHW         BEGSR
051100160923
051200160923     C                   eval      THW = 'N'
051300160923
051400160923     C     GrtKey        Setll     GRAT24
051500160923     C     GrtKey        Reade     GRAT24
051600160923     C                   Dow       not %eof(GRAT24)
051700160923      * Skip Deleted
051800160923     C                   If        grdltd <> 'D'
051900160923      * GBS Date Logic
052000160923     C                   If        frmdat <> todat
052100160923     C                   If        todat   = *zeros
052200160923     C                   eval      todat   = 99999999
052300160923     C                   End
052400160923     C                   if        w80date >= frmdat and
052500160923     C                             w80date <= todat
052600160923
052700160923     C                   If        %trim(TYPECD) = 'THW'
052800160923     C                   eval      THW = 'Y'
052900160923     C                   Leave
053000160923     C                   end
053100160923
053200160923     C                   end
053300160923     C                   end
053400160923     C                   end
053500160923     C     GrtKey        Reade     GRAT24
053600160923     C                   Enddo
053700160923
053800160923     C                   Endsr
053900140123      *___________________________________________________________________
054000140123      * Key Lists
054100140123      *___________________________________________________________________
054200140123     C     KLIST         BEGSR
054300140127     C     DCVKEY        Klist
054400140127     C                   Kfld                    MCSSNO
054500140610     C                   Kfld                    DPSEQ#
054600140127     C                   Kfld                    MCTRST
054700140127     C                   Kfld                    MCSUB#
054800140127     C                   Kfld                    MCPLAN
054900140611     C     MCVKEY        Klist
055000140611     C                   Kfld                    SSNO
055100140611     C                   Kfld                    MDSEQ#
055200140611     C                   Kfld                    DVTRST
055300140611     C                   Kfld                    DVSUB#
055400140611     C                   Kfld                    DVPLAN
055500140127     C     DEPKEY        Klist
055600140611     C                   Kfld                    SSNO
055700140611     C                   Kfld                    DSEQ#
055800140127     C     PLNKEY        Klist
055900140127     C                   Kfld                    MCTRST
056000140127     C                   Kfld                    MCSUB#
056100140127     C                   Kfld                    MCPLAN
056200140123     C     ACCKEY        Klist
056300140123     C                   Kfld                    MCTRST
056400140123     C                   Kfld                    MCSUB#
056500140123     C                   Kfld                    ACC#
056600140123     C                   ENDSR
056700000000      *___________________________________________________________________
056800000000      * Program open
056900000000      *___________________________________________________________________
057000000000     C     *INZSR        BEGSR
057100140724     C     *date         mult      10000.0001    w80date
057200140620     C                   open      AACODE
057300140127     C                   open      ACCMST
057400140127     C                   open      MEMBER
057500140619     C                   open      PLNMST
057600140619     C                   open      CODESL1
057700140610     C                   open      DEPNDC
057800140611     C                   open      DCOVC
057900140611     C                   open      MCOVC
058000000000     C                   ENDSR
058100140127      *___________________________________________________________________
058200140127      * Formate Date
058300140127      *___________________________________________________________________
058400140127     C     FMTDATE       BEGSR
058500140127     C                   Call      'FMTDATE'
058600140127     C                   Parm                    Input_Date       32
058700140127     C                   Parm      'YYYYMMDD'    Input_Format     32
058800140127     C                   Parm      'MM/DD/YYYY'  Output_Format    32
058900140127     C                   Parm                    Output_Date      32
059000140127     C                   Parm                    Output_Error     10
059100140127     C                   ENDSR
