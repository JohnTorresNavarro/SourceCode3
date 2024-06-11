000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Delegated Billing Electronic Enrollment
000400000000      *
000500000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - October 24, 2002
000800030513      *
000900030513      * 05/13/03 DLK - add temp group # logic to not transmit when
001000070213      *                a tempoary group # has been set up.
001100030612      * 06/12/03 JON - added reporting.
001200070213      * 03/21/05 JON - add new pcp fields len(20)                      *
001300070213      * 02/13/07 JON - Only send PCP if Add Emp or Add Dep             *
001400131010      * 10/10/13 sbt - hist file expansion project                     *
001500000000      *_________________________________________________________________________
001600021024      *
001700021106     FDW310JF   IP   E           K DISK    Infds(DBFD)
001800021209     FAC2MST    IF   E           K DISK    Prefix(A_)
001900021111     FCLASS     IF   E           K DISK    Prefix(C_)
002000100108     FGRAT24    IF   E           K DISK    Prefix(G_)
002100021204     FDW310LF   IF   E           K DISK    Prefix(X_) rename(dw310r:dwlf)
002200021213     FDW310L2   IF   E           K DISK    Prefix(X_)
002300021213     FDW310PF   IF   E           K DISK    Prefix(X_) rename(dw310r:dwpf)
002400021106     FMEMBER    IF A E           K DISK    Prefix(M_)
002500021111     FDEPNDC    IF A E           K DISK    Prefix(D_)
002600021104     FPCPL1     IF A E           K DISK    Prefix(V_)
002700100414     FHIST      O  A E           K DISK    Prefix(H_)
002800070213     Ftempg#    If   e           k disk
002900021024     FDBTRAN    O  A E             DISK
003000070213     Fqsysprt   O    F  132        printer oflind(*inof)
003100030612     FPRTDBEP   O    E             PRINTER oflind(*in91)
003200021029      *
003300021216     D ISO_DATE        S               D   DATFMT(*ISO)
003400021216      *
003500021210     D Pos             s              2S 0 inz
003600030612     D Count           s              2S 0 inz
003700070125     D T_TERMDT        S              8S 0 inz
003800021112     D W_DRELCD        S              2    inz
003900021111     D W_COVT          S              2    inz
004000021209     D W_CAT           S              3    inz
004100021209     D W_NAME6         S              6    inz
004200021209     D W_FFFFFF        S              1    inz('F')
004300021206     D W_IN_ONLY       S              1    inz('N')
004400021206     D W_TM_ONLY       S              1    inz('N')
004500021111     D W_COVTP         S                   LIKE(X_DWCOVT) inz('TNA')
004600021029     D W_SEVT          S                   LIKE(D3SEVT1) inz
004700021104     D W_SFAM          S                   LIKE(D3SFAM1) inz
004800021104     D W_SSN#          S                   LIKE(V_PCSSN) inz
004900021112     D W_SPCD          S                   LIKE(V_PCSPCD) inz
005000021112     D W_SFX#          S                   LIKE(V_PCDSEQ) inz
005100021203     D W_DEPSSN        S                   LIKE(SOCSOC) inz
005200021203     D W_SEQ           S                   LIKE(D_DPSEQ#) inz
005300021212     D W_DEPTRM        S                   LIKE(X_DWENRL) inz
005400100108     D PLNGRP          S             15A   INZ
005500021111      *
005600021111     D D3SCAT_W        S                   LIKE(D3SCAT1) inz
005700021111     D D3SCEF_W        S                   LIKE(D3SCEF1) inz
005800021111     D D3SEVT_W        S                   LIKE(D3SEVT1) inz
005900021111     D D3SFAM_W        S                   LIKE(D3SFAM1) inz
006000021112      *
006100021112     D W_FILL37        DS
006200021112     D DEPEFFDT                       8    OVERLAY(W_FILL37)
006300021112     D DEPSCHOOL                     25    OVERLAY(W_FILL37:9)
006400021024      *
006500021025     D                 DS
006600021025     D ZIPCHAR                        9
006700021025     D W_ZIP                          9S 0 OVERLAY(ZIPCHAR) inz
006800021025      *
006900021025     D PHONECHAR       DS
007000021025     D W_AREA                         3S 0 OVERLAY(PHONECHAR) inz
007100021025     D W_PHONE                        7S 0 OVERLAY(PHONECHAR:4) inz
007200021025      *
007300021024     D                 DS
007400021024     D MMDDYYYYHHMMSS                14S 0
007500021101     D MMDDYYYY                       8S 0 OVERLAY(MMDDYYYYHHMMSS:1) inz
007600021101     D MMDD                           4    OVERLAY(MMDDYYYYHHMMSS:1)
007700021101     D YY                             2    OVERLAY(MMDDYYYYHHMMSS:5)
007800021101     D HHMM                           4    OVERLAY(MMDDYYYYHHMMSS:9)
007900021101     D HHMMSS                         6S 0 OVERLAY(MMDDYYYYHHMMSS:9) inz
008000021024      *
008100021024     D FileHeader    E DS                  EXTNAME(DBEEFH) inz
008200021024     D GroupHeader   E DS                  EXTNAME(DBGRPH) inz
008300021024     D EnrollmentDataE DS                  EXTNAME(DBEDTL) inz
008400021024     D GroupTrailer  E DS                  EXTNAME(DBGRPT) inz
008500021024     D FileTrailer   E DS                  EXTNAME(DBEEFT) inz
008600021024      *
008700070809     D WDTA          E DS                  EXTNAME(DEPEND) Prefix(D_)
008800070430      *
008900021106      * File DS
009000021106     D DBFD          E DS                  EXTNAME(IODBFD)
009100021106      * Program status data structure
009200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
009300030513
009400070213     D                UDS
009500070213     D  CONAME               201    240
009600000000      *
009700021028     IJOINR         01
009800021106     I                                          GROUP#        L4
009900021106     I                                          SOCSOC        L2
010000021024      * Group Header
010100021106     C                   If        *INL4
010200021024     C                   Exsr      GroupHeaderSR
010300030513     c                   else
010400030513
010500030513      * if real group# has been entered, replace the temp group #
010600030513      * with the real group#
010700030513     c                   if        realgroup = 'Y'
010800030513     c   of              except    head
010900030513     c                   except    tgrel
011000030513     c                   movel     terealg#      group#
011100030513     c                   end
011200030513     C                   End
011300021024      * Enrollment
011400030513     C                   If        *INL2
011500030513     C                   If        skipgroup = 'Y'
011600030513     c   of              except    head
011700030513     c                   except    tgheld
011800030513     c                   else
011900021101     C                   Exsr      EnrollmentSR
012000030513     C                   end
012100030513     C                   End
012200021024      *
012300030513     CL4                 if        skipgroup <> 'Y'
012400030513     CL4                 Exsr      GroupTrailerSR
012500030513     CL4                 end
012600021024     CLR                 Exsr      FileTrailerSR
012700000000      *___________________________________________________________________
012800021024      * Group Header SR
012900000000      *___________________________________________________________________
013000021024     C     GroupHeaderSR BEGSR
013100021024      *
013200070213     C* skip this group if it was set up with a temporary group#
013300070213     C* and is still waiting for the real group #. If the real group #
013400070213     C* has been entered, replace it in the file and allow transmit.
013500030513
013600030513     c                   clear                   skipgroup         1
013700030513     c                   clear                   realgroup         1
013800030513     c     group#        chain     tempg#
013900030513     c                   if        %found(tempg#)
014000030513     c                   if        firsterr <> 'N'
014100030513     c                   move      'N'           firsterr          1
014200030513     c                   except    head
014300030513     c                   end
014400030513      * skip temp g#
014500030513     c                   if        terealg# = *blanks
014600030513     c   of              except    head
014700030513     c                   except    tgheld
014800030513     c                   move      'Y'           skipgroup
014900030513     c                   leavesr
015000030513     c                   else
015100030513      * real g#
015200030513     c   of              except    head
015300030513     c                   except    tgrel
015400030513     c                   movel     terealg#      group#
015500030513     c                   move      'Y'           realgroup         1
015600030513     c                   end
015700070213     C                   end
015800021024      * Total Group Count
015900021024     C                   Eval      D5TGC    =   D5TGC + 1
016000021024      *
016100021024      * Fill Group Header
016200021024     C                   Eval      D2RCD    =    '10'
016300021024     C                   Eval      D2FTYP   =    'PF'
016400021024     C                   Eval      D2GRPN   =    *BLANKS
016500021024     C                   Eval      D2GRPI   =    %trim(%subst(GROUP#:1:8))
016600021024     C                   Eval      D2CNTN   =    %trim('DAVE ABESHOUSE')
016700021024     C                   Eval      D2CNTP   =    %trim('410-832-5151')
016800021024     C                   Move      MMDDYYYY      D2SBMD
016900021024     C                   Eval      D2TRMD   =    *BLANKS
017000021024     C                   Eval      D2BRKN   =    *BLANKS
017100021031     C                   Eval      D2PCP    =    *BLANKS
017200021024     C                   Eval      D2RSBF   =    *BLANKS
017300021024     C                   Eval      D2RSBD   =    *BLANKS
017400021024     C                   Eval      D2RNWL   =    *BLANKS
017500021024     C                   Eval      D2HLD    =    'X'
017600021024     C                   Eval      DB2150   =    GroupHeader
017700021024     C                   Write     DBTRANR
017800021024     C                   Clear                   DBTRANR
017900021024     C                   Clear                   GroupHeader
018000021024      *
018100000000     C                   ENDSR
018200021024      *___________________________________________________________________
018300021024      * Enrollment SR
018400021024      *___________________________________________________________________
018500021024     C     EnrollmentSR  BEGSR
018600021112      *
018700021112      * Reset Enrollment DS
018800021112     C                   Clear                   EnrollmentData
018900041130      *
019000041130      * Check if Re-instatement
019100041130     C                   If        ACTCOD = 'MR'
019200041130     C                   Eval      *in95 = *on
019300041130     C                   Else
019400041130     C                   Eval      *in95 = *off
019500041130     C                   End
019600021025      *
019700021030      * Process Current Member Info
019800021106     C     SocSoc        Chain     Member
019900021106     C                   If        not %Found
020000021106     C                   Clear                   Membr
020100021106     C                   Else
020200021106      *
020300021106      * Fill Subscriber Data on Add or Demographic Change
020400021106     C                   Eval      D3ADR1   =    %trim(M_ADDR1)
020500021106     C                   Eval      D3ADR2   =    %trim(M_ADDR2)
020600021106     C                   Eval      D3ADR3   =    *BLANKS
020700021106     C                   Eval      D3CITY   =    %trim(M_CITY)
020800021106     C                   Eval      D3STAT   =    %trim(M_STATE)
020900021106     C                   Z-Add     M_Zip         W_Zip
021000021106     C                   Eval      D3ZIPC   =    %trim(ZIPCHAR)
021100021106     C                   Eval      D3CNTY   =    *BLANKS
021200021106     C                   Eval      D3CNTR   =    *BLANKS
021300070307      * If 0 send blanks
021400070307     C                   If        M_Phone <> 0
021500021106     C                   Z-Add     M_Area        W_Area
021600021106     C                   Z-Add     M_Phone       W_Phone
021700021106     C                   Eval      D3HOME   =    %trim(PHONECHAR)
021800070307     C                   Else
021900070307     C                   Z-Add     0             W_Area
022000070307     C                   Z-Add     0             W_Phone
022100070307     C                   Eval      D3HOME   =    *blanks
022200070307     C                   End
022300021106      *
022400021106      * Get the Member Coverages
022500021203     C                   Eval      W_SEQ  =   0
022600021106     C                   Exsr      GetPlanMaster
022700021106      *
022800021106      * Member Enrollment Date (MEMBER) to Sub-Group Effect Date
022900021202     C                   Eval      D3SGRE        = D3CLSE
023000021106      *
023100021106      * Member Employment Date (MEMBER) to Subcriber Hire Date
023200021106     C                   Movel     M_EMPDT       Input_Date
023300021106     C                   Eval      Input_Format  = 'YYYYMMDD'
023400021106     C                   Eval      Output_Format = 'MM/DD/YYYY'
023500021106     C                   Exsr      FormatDateSR
023600021106     C                   Eval      D3HIRE        = %trim(Output_Date)
023700021211      *
023800031113      * Term Date (MEMBER) else Same Day Term.
023900031113     C                   If        M_TERMDT <>   *ZEROS
024000031113     C                   If        M_TERMDT <>   M_MBENRL
024100071105     C                   EXSR      OVER_TERM
024200021216     C     *YMD          MOVE      M_TERMDT      ISO_DATE
024300021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
024400070129     C     *ISO          MOVE      ISO_DATE      T_TERMDT
024500070125     C                   Movel     T_TERMDT      Input_Date
024600021216     C                   Eval      Input_Format  = 'YYYYMMDD'
024700021211     C                   Eval      Output_Format = 'MM/DD/YYYY'
024800021211     C                   Exsr      FormatDateSR
024900021211     C                   Eval      D3TRMDT       = %trim(Output_Date)
025000021211     C                   Eval      D3TRMR        = 'SBUN'
025100021212     C                   Exsr      ResetCovg
025200031113     C                   Else
025300070125     C                   Movel     M_TERMDT      Input_Date
025400031113     C                   Eval      Input_Format  = 'YYYYMMDD'
025500031113     C                   Eval      Output_Format = 'MM/DD/YYYY'
025600031113     C                   Exsr      FormatDateSR
025700031113     C                   Eval      D3TRMDT       = %trim(Output_Date)
025800031113     C                   Eval      D3TRMR        = 'SBER'
025900031113     C                   Exsr      ResetCovg
026000031113     C                   End
026100021211     C                   End
026200021106      *
026300021106      * Count Member No Dependents
026400060928     C**************     If        W_IN_ONLY = 'N'
026500060928     C                   Eval      D3NBRD   =    0
026600021111     C     SOCSOC        Setll     DEPNDC
026700021111     C     SOCSOC        Reade     DEPNDC                                 50
026800021106     C     *IN50         Doweq     *OFF
026900021106     C                   Eval      D3NBRD   =    D3NBRD + 1
027000021111     C     SOCSOC        Reade     DEPNDC                                 50
027100021106     C                   Enddo
027200060928     C**************     Else
027300060928     C**************     Eval      D3NBRD   =    0
027400060928     C**************     End
027500021112      *
027600021030      * Subscriber Indicative data
027700021112     C                   Eval      D3REL  = 'M'
027800021112     C                   Eval      D3LST    =    %trim(M_MLNAME)
027900021112     C                   Eval      D3FST    =    %trim(M_MFNAME)
028000021112     C                   Eval      D3MID    =    %trim(M_MMI)
028100021112     C                   Move      SOCSOC        D3SSN
028200021112     C                   Eval      D3SEX    =    %trim(M_SEX)
028300030826     C                   Eval      D3PHN    =    *BLANKS
028400021112     C                   Eval      D3MAR    =    *BLANKS
028500021202      *
028600021202      * Subscriber Status
028700021209     C     WkAcc         Chain     AC2MST
028800021202     C                   If        %Found
028900021209     C                   If        A_A2NCAPDT =  X_DWENRL
029000021209     C                   Eval      D3STS      =  'INIT'
029100021202     C                   Else
029200021209     C                   Eval      D3STS      =  'SUBS'
029300021202     C                   End
029400021224     C                   Else
029500021224     C                   Eval      D3STS      =  'SUBS'
029600021202     C                   End
029700021112      *
029800021202      * Enrollment Date (MEMBER) is Class Effect Date
029900021202     C                   Eval      D3ORGEF       = D3CLSE
030000021112      *
030100021112      * Birth Date (MEMBER) to Birth Date
030200021112     C                   Movel     M_BIRTH       Input_Date
030300021112     C                   Eval      Input_Format  = 'YYYYMMDD'
030400021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
030500021112     C                   Exsr      FormatDateSR
030600021112     C                   Eval      D3BIRTH       = %trim(Output_Date)
030700021030      *
030800021112      * Subscriber Handicap data
030900021112     C                   If        M_hndicp  <>  *Blanks
031000021112      * Effective (MEMBER)
031100021112     C                   Movel     M_HDCPDT      Input_Date
031200021112     C                   Eval      Input_Format  = 'YYYYMMDD'
031300021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
031400021112     C                   Exsr      FormatDateSR
031500021112     C                   Eval      D3HANEFF      = %trim(Output_Date)
031600021112      * Term (MEMBER)
031700021210     C                   If        M_TERMDT <>   *ZEROS
031800021216     C     *YMD          MOVE      M_TERMDT      ISO_DATE
031900021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
032000070129     C     *ISO          MOVE      ISO_DATE      T_TERMDT
032100070125     C                   Movel     T_TERMDT      Input_Date
032200021112     C                   Eval      Input_Format  = 'YYYYMMDD'
032300021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
032400021112     C                   Exsr      FormatDateSR
032500021112     C                   Eval      D3HANTRM      = %trim(Output_Date)
032600021112     C                   Eval      D3HANRES      = 'MHUN'
032700021210     C                   End
032800021112      *
032900021112     C                   Eval      D3HANDES      = %trim('DISABLED')
033000021112     C                   Eval      D3HANTYP      = 'P'
033100021112      *
033200021112     C                   End
033300021210      *
033400021210      * Subscriber Medicare data
033500021210     C                   If        M_MEDICR  <>  *Blanks  and
033600021210     C                             M_MEDICR  <>  'N'
033700021210      *
033800021210      * Find the - or & and pull it out.
033900021210     C                   Eval      Pos    =  %scan('-':M_MED#)
034000021210     C                   If        Pos    =  0
034100021210     C                   Eval      Pos    =  %scan('&':M_MED#)
034200021210     C                   End
034300021210      *
034400021210     C                   If        Pos    =  0
034500021210     C                   Eval      D3HICN =  %trim(M_MED#)
034600021210     C                   Else
034700021210     C                   Eval      D3HICN= %replace(%subst(M_MED#:pos+1:13-pos):
034800021210     C                             M_MED#:pos)
034900021210     C                   End
035000021210      * Medicare Eff-A (MEMBER)
035100021210     C                   If        M_MEDADT <>   *ZEROS
035200021210     C                   Movel     M_MEDADT      Input_Date
035300021210     C                   Eval      Input_Format  = 'YYYYMMDD'
035400021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
035500021210     C                   Exsr      FormatDateSR
035600021210     C                   Eval      D3MEDEFF      = %trim(Output_Date)
035700021210     C                   Eval      D3EVTEFF1     = %trim(Output_Date)
035800021210     C                   Eval      D3MEDEVT1     = 'PRTA'
035900021210     C                   End
036000021210      *
036100021210      * Medicare Eff-B (MEMBER)
036200021210     C                   If        M_MEDBDT <>   *ZEROS
036300021210     C                   Movel     M_MEDBDT      Input_Date
036400021210     C                   Eval      Input_Format  = 'YYYYMMDD'
036500021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
036600021210     C                   Exsr      FormatDateSR
036700021210     C                   If        D3MEDEFF      = *BLANKS
036800021210     C                   Eval      D3MEDEFF      = %trim(Output_Date)
036900021210     C                   Eval      D3EVTEFF1     = %trim(Output_Date)
037000021210     C                   Eval      D3MEDEVT1     = 'PRTB'
037100021210     C                   Else
037200021210     C                   Eval      D3EVTEFF2     = %trim(Output_Date)
037300021210     C                   Eval      D3MEDEVT2     = 'PRTB'
037400021210     C                   End
037500021210     C                   End
037600021210     C                   End
037700021112      *
037800021112      * Subscriber Provider PCP data
037900021112     C                   Z-add     SOCSOC        W_SSN#
038000021112     C                   Z-add     *ZEROS        W_SFX#
038100021112     C                   Eval      W_SPCD    =   'MED'
038200021112     C                   Exsr      GetProvider
038300030523      *
038400030523      * COB Data
038500030523     C                   If        M_COB    = 'Y'
038600030523     C                   Eval      D3COBINF = 'Y'
038700030523     C                   Eval      D3COBFLG = 'Y'
038800030523     C                   Eval      D3COBCON = 'Y'
038900030523     C                   Eval      D3HLDNAM = %trim(M_COBENM)
039000030523     C                   Eval      D3OIPOLY = %trim(M_COBP#)
039100030523     C                   Eval      D3OINAME = %trim(M_MCOBPN)
039200030523     C                   Else
039300030523     C                   Eval      D3COBINF = 'N'
039400030523     C                   End
039500021112      *
039600021112      * Set Group Key elements
039700021112     C                   Eval      D3PRN    =    *BLANKS
039800030611     C                   Eval      D3GRP    =    %trim(%subst(GROUP#:1:8))
039900021112     C                   Eval      D3SGR    =    %trim(%subst(GROUP#:9:4))
040000021112     C                   Move      SOCSOC        D3SUB
040100040304      *
040200040304      * Set Mod for Medicare IN.
040300040304     C                   If        W_COVT   =    'MI'
040400040304     C                   Eval      D3MOD    =    %trim(D3GRP) + 'M'
040500040304     C                   End
040600040304      *
040700021203      * Total Record Counts
040800021203     C                   Eval      D4TRC    =   D4TRC + 1
040900021203     C                   Eval      D5TRC    =   D5TRC + 1
041000041130      *
041100041130      * If Reinstate, override dates
041200041130     C                   If        *in95 = *on
041300041130     C                   Exsr      ReinstateSR
041400041130     C                   End
041500021112      *
041600021112     C                   Eval      D3SFX    =    '00'
041700021112     C                   Eval      D3HLD    =    'X'
041800021112     C                   Eval      DB2150   =    EnrollmentData
041900021112     C                   Write     DBTRANR
042000030612     C                   Exsr      CheckOverflow
042100030612     C                   Write     PRTDTL
042200100414     C                   Exsr      WRTHST
042300030612     C                   Eval      Count = Count + 1
042400070131     C                   Clear                   DBTRANR
042500021112      *
042600021112      * Process Dependents
042700060928     C****************   If        W_IN_ONLY = 'N'
042800021112     C     SOCSOC        Setll     DEPNDC
042900021112     C     SOCSOC        Reade     DEPNDC                                 50
043000021112     C     *IN50         Doweq     *OFF
043100021112     C                   Exsr      ProcessDepSR
043200021112     C     SOCSOC        Reade     DEPNDC                                 50
043300021112     C                   Enddo
043400060928     C****************   End
043500021112      *
043600021112     C                   End
043700021112     C                   ENDSR
043800021112      *___________________________________________________________________
043900021112      * Process Dependents SR
044000021112      *___________________________________________________________________
044100021112     C     ProcessDepSR  BEGSR
044200021112      *
044300021112     C                   Eval      W_FILL37 =   %trim(D_FILL37)
044400021112      *
044500070202      * Reset Each Dep: Number Dependents & Term Info
044600021112     C                   Eval      D3NBRD   =    *ZEROS
044700070202     C                   Eval      D3TRMDT       = *blanks
044800070212     C                   Eval      D3TRMR        = *blanks
044900070212     C                   Eval      D3HIRE        = *blanks
045000021203      *
045100021203      * Get the Dependent Coverages
045200021206     C                   Eval      W_TM_ONLY =   'Y'
045300021212     C                   Exsr      ResetCovg
045400021203     C                   Eval      W_SEQ    =   D_DPSEQ#
045500021213     C     DW310KeyPF    Chain     DW310PF
045600030702     C                   If        %Found(DW310PF)
045700021203     C                   Exsr      GetPlanMaster
045800021213     C                   Else
045900021213     C                   LeaveSR
046000021213     C                   End
046100021206      *
046200021212      * If Completly Termed, Term Date (MEMBER)
046300021212     C                   If        W_TM_ONLY  =  'Y'
046400021212     C                   If        M_TERMDT <>   *ZEROS
046500071105     C                   EXSR      OVER_TERM
046600021216     C     *YMD          MOVE      M_TERMDT      ISO_DATE
046700021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
046800070129     C     *ISO          MOVE      ISO_DATE      T_TERMDT
046900070125     C                   Movel     T_TERMDT      Input_Date
047000070202     C**************     Else
047100070202     C**************     Movel     W_DEPTRM      Input_Date
047200070202     C**************     End
047300021212     C                   Eval      Input_Format  = 'YYYYMMDD'
047400021212     C                   Eval      Output_Format = 'MM/DD/YYYY'
047500021212     C                   Exsr      FormatDateSR
047600021212     C                   Eval      D3TRMDT       = %trim(Output_Date)
047700021212     C                   Eval      D3TRMR        = 'MEUN'
047800070202     C                   Exsr      ResetCovg
047900070202     C                   End
048000021206     C                   End
048100021112      *
048200021112      * Set Relationship code
048300021112     C                   Move      D_DRELCD      W_DRELCD
048400021112     C                   Select
048500021112     C                   When      W_DRELCD = 'WI'
048600021112     C                   Eval      D3REL    = 'W'
048700021112     C                   When      W_DRELCD = 'HU'
048800021112     C                   Eval      D3REL    = 'H'
048900021112     C                   When      W_DRELCD = 'SO'
049000021112     C                   Eval      D3REL    = 'S'
049100021112     C                   When      W_DRELCD = 'DA'
049200021112     C                   Eval      D3REL    = 'D'
049300021112     C                   Other
049400021112     C                   Eval      D3REL    = 'O'
049500021112     C                   Endsl
049600021112      *
049700021112      * Dependent misc.
049800021209     C                   Movel     D_DLNAME      W_NAME6
049900021209     C                   If        W_NAME6  =    'SAME  '
050000021209     C                   Eval      D3LST    =    %trim(M_MLNAME)
050100021209     C                   Else
050200021209     C                   Eval      D3LST    =    %trim(D_DLNAME)
050300021209     C                   End
050400021112     C                   Eval      D3FST    =    %trim(D_DFNAME)
050500021112     C                   Eval      D3MID    =    %trim(D_DMI)
050600070307      *
050700070307      * Send BLANKS if 0
050800070307     C                   If        D_DEPSS# = 0
050900070307     C                   Move      *blanks       D3SSN
051000070307     C                   Z-add     0             W_DEPSSN
051100070307     C                   Else
051200070307     C                   Z-add     D_DEPSS#      W_DEPSSN
051300021112     C                   Move      W_DEPSSN      D3SSN
051400070307     C                   End
051500070307      *
051600021112     C                   Eval      D3SEX    =    %trim(D_DSEX)
051700021112      *
051800021112      * Birth Date (DEPEND) to Birth Date
051900021112     C                   Movel     D_DBIRTH      Input_Date
052000021112     C                   Eval      Input_Format  = 'YYYYMMDD'
052100021112     C                   Eval      Output_Format = 'MM/DD/YYYY'
052200021112     C                   Exsr      FormatDateSR
052300021112     C                   Eval      D3BIRTH       = %trim(Output_Date)
052400021112      *
052500021210      * Student data
052600021030     C                   Exsr      GetStudent
052700021030      *
052800021030      * Handicap data
052900021030     C                   Exsr      GetHandicap
053000021210      *
053100021210      * Medicare data
053200021210     C                   Eval      D3MEDEFF      = *BLANKS
053300021210     C                   Eval      D3EVTEFF1     = *BLANKS
053400021210     C                   Eval      D3MEDEVT1     = *BLANKS
053500021210     C                   Eval      D3EVTEFF2     = *BLANKS
053600021210     C                   Eval      D3MEDEVT2     = *BLANKS
053700080502     C                   Eval      D3HICN        = *BLANKS
053800080502      *
053900021210     C                   If        D_DMEDCR  <>  *Blanks  and
054000021210     C                             D_DMEDCR  <>  'N'
054100021210      *
054200021210      * Find the - or & and pull it out.
054300021210     C                   Eval      Pos    =  %scan('-':D_DMED#)
054400021210     C                   If        Pos    =  0
054500021210     C                   Eval      Pos    =  %scan('&':D_DMED#)
054600021210     C                   End
054700021210      *
054800021210     C                   If        Pos    =  0
054900021210     C                   Eval      D3HICN =  %trim(D_DMED#)
055000021210     C                   Else
055100021210     C                   Eval      D3HICN=%replace(%subst(D_DMED#:pos+1:13-pos):
055200021210     C                             D_DMED#:pos)
055300021210     C                   End
055400021210      * Medicare Eff-A (DEPEND)
055500021210     C                   If        D_DMEDAD <>   *ZEROS
055600080911     C                   Movel     D_DMEDAD      Input_Date
055700021210     C                   Eval      Input_Format  = 'YYYYMMDD'
055800021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
055900021210     C                   Exsr      FormatDateSR
056000021210     C                   Eval      D3MEDEFF      = %trim(Output_Date)
056100021210     C                   Eval      D3EVTEFF1     = %trim(Output_Date)
056200021210     C                   Eval      D3MEDEVT1     = 'PRTA'
056300021210     C                   End
056400021210      *
056500021210      * Medicare Eff-B (DEPEND)
056600080911     C                   If        D_DMEDBD <>   *ZEROS
056700021210     C                   Movel     D_DMEDBD      Input_Date
056800021210     C                   Eval      Input_Format  = 'YYYYMMDD'
056900021210     C                   Eval      Output_Format = 'MM/DD/YYYY'
057000021210     C                   Exsr      FormatDateSR
057100021210     C                   If        D3MEDEFF      = *BLANKS
057200021210     C                   Eval      D3MEDEFF      = %trim(Output_Date)
057300021210     C                   Eval      D3EVTEFF1     = %trim(Output_Date)
057400021210     C                   Eval      D3MEDEVT1     = 'PRTB'
057500021210     C                   Else
057600021210     C                   Eval      D3EVTEFF2     = %trim(Output_Date)
057700021210     C                   Eval      D3MEDEVT2     = 'PRTB'
057800021210     C                   End
057900021210     C                   End
058000021210     C                   End
058100021104      *
058200021104      * Provider PCP data
058300021112     C                   Z-add     SOCSOC        W_SSN#
058400021112     C                   Z-add     D_DPSEQ#      W_SFX#
058500021112     C                   Eval      W_SPCD    =   'MED'
058600021104     C                   Exsr      GetProvider
058700021104      *
058800041130      * If Reinstate, override dates
058900041130     C                   If        *in95 = *on
059000041130     C                   Exsr      ReinstateSR
059100041130     C                   End
059200070430      *
059300070430      * Get Dep# original eff date
059400070430     C                   Call      'DW310DV'
059500080116     C                   Parm                    WDTA
059600080116     C                   Parm                    GROUP#
059700070430     C                   Parm                    D3ORGEF
059800070430      *
059900021104     C                   Eval      D3SFX    =    '99'
060000021024     C                   Eval      D3HLD    =    'X'
060100021024     C                   Eval      DB2150   =    EnrollmentData
060200021209      *
060300021209      * Total Record Counts
060400021209     C                   Eval      D4TRC    =   D4TRC + 1
060500021209     C                   Eval      D5TRC    =   D5TRC + 1
060600021209      *
060700021024     C                   Write     DBTRANR
060800030612     C                   Exsr      CheckOverflow
060900030612     C                   Write     PRTDTL
061000030612     C                   Eval      Count = Count + 1
061100070131     C                   Clear                   DBTRANR
061200070125     C                   Exsr      ResetCovg
061300021106      *
061400021024     C                   ENDSR
061500021024      *___________________________________________________________________
061600021024      * Group Trailer SR
061700021024      *___________________________________________________________________
061800021024     C     GroupTrailerSRBEGSR
061900021217     C                   If        D4TRC    >    0
062000021024     C                   Eval      D4RCD    =    '30'
062100021024     C                   Eval      D4FTYP   =    'PF'
062200021024     C                   Eval      D4HLD    =    'X'
062300021024     C                   Eval      DB2150   =    GroupTrailer
062400021024     C                   Write     DBTRANR
062500021217     C                   End
062600021024     C                   Clear                   DBTRANR
062700021024     C                   Clear                   GroupTrailer
062800021024     C                   ENDSR
062900021024      *___________________________________________________________________
063000021024      * File Trailer SR
063100021024      *___________________________________________________________________
063200021024     C     FileTrailerSR BEGSR
063300021024     C                   Eval      D5RCD    =    '02'
063400021024     C                   Eval      D5HLD    =    'X'
063500021024     C                   Eval      DB2150   =    FileTrailer
063600021024     C                   Write     DBTRANR
063700021024     C                   Clear                   DBTRANR
063800021024     C                   Clear                   FileTrailer
063900021024     C                   ENDSR
064000021030      *___________________________________________________________________
064100021030      * Get Member Student Data
064200021030      *___________________________________________________________________
064300021030     C     GetStudent    BEGSR
064400060929      *
064500060929      * Reset Student
064600060929     C                   Eval      D3STUEFF      = *blanks
064700060929     C                   Eval      D3SCHOOL      = *blanks
064800060929     C                   Eval      D3STUTYP      = *blanks
064900021030      *
065000021112      * Effective (FILL37)
065100021112     C                   If        DEPEFFDT   <>   *BLANKS    and
065200021112     C                             DEPEFFDT   <>   '00000000'
065300021112     C                   Movel     DEPEFFDT      Input_Date
065400021030     C                   Eval      Input_Format  = 'YYYYMMDD'
065500021030     C                   Eval      Output_Format = 'MM/DD/YYYY'
065600021030     C                   Exsr      FormatDateSR
065700021030     C                   Eval      D3STUEFF      = %trim(Output_Date)
065800021217     C                   Eval      D3SCHOOL      = %trim(DEPSCHOOL)
065900021217     C                   Eval      D3STUTYP      = 'F'
066000021217     C                   End
066100021217      *
066200021112      * Term (NO TERM DATE YET)
066300021112     C***                Movel     DCANDT        Input_Date
066400021112     C***                Eval      Input_Format  = 'YYYYMMDD'
066500021112     C***                Eval      Output_Format = 'MM/DD/YYYY'
066600021112     C***                Exsr      FormatDateSR
066700021112     C***                Eval      D3STUTRM      = %trim(Output_Date)
066800021112     C***                Eval      D3STURES      = 'MSUN'
066900021104      *
067000021030     C                   ENDSR
067100021030      *___________________________________________________________________
067200021030      * Get Handicap Data
067300021030      *___________________________________________________________________
067400021030     C     GetHandicap   BEGSR
067500060929      *
067600060929      * Reset Handicap
067700060929     C                   Eval      D3HANEFF      = *blanks
067800060929     C                   Eval      D3HANDES      = *blanks
067900060929     C                   Eval      D3HANTYP      = *blanks
068000021030      * If handicaped
068100021112     C                   If        dhndcp  <>    *Blanks
068200021030      *
068300021112      * Effective (DEPEND)
068400021112     C                   Movel     D_DHDDT       Input_Date
068500021030     C                   Eval      Input_Format  = 'YYYYMMDD'
068600021030     C                   Eval      Output_Format = 'MM/DD/YYYY'
068700021030     C                   Exsr      FormatDateSR
068800021030     C                   Eval      D3HANEFF      = %trim(Output_Date)
068900021112      *
069000021112      * Term (NO TERM DATE YET)
069100021112     C***                Movel                   Input_Date
069200021112     C***                Eval      Input_Format  = 'YYYYMMDD'
069300021112     C***                Eval      Output_Format = 'MM/DD/YYYY'
069400021112     C***                Exsr      FormatDateSR
069500021112     C***                Eval      D3HANTRM      = %trim(Output_Date)
069600021112     C***                Eval      D3HANRES      = 'MHUN'
069700021030      *
069800021030      * Description and Type.
069900021031     C                   Eval      D3HANDES      = %trim('DISABLED')
070000021030     C                   Eval      D3HANTYP      = 'P'
070100021030      *
070200021030     C                   End
070300021030      *
070400021030     C                   ENDSR
070500021104      *___________________________________________________________________
070600021104      * Get Provider Data
070700021104      *___________________________________________________________________
070800021104     C     GetProvider   BEGSR
070900021112      *
071000021112     C                   Eval      D3PRVID1  =   *BLANKS
071100021112     C                   Eval      D3PRIME1  =   *BLANKS
071200021112     C                   Eval      D3PRVEF1  =   *BLANKS
071300021112     C                   Eval      D3PRVTR1  =   *BLANKS
071400021112     C                   Eval      D3PRVID2  =   *BLANKS
071500021112     C                   Eval      D3PRIME2  =   *BLANKS
071600021112     C                   Eval      D3PRVEF2  =   *BLANKS
071700021112     C                   Eval      D3PRVTR2  =   *BLANKS
071800070213      *
071900070213      * New Logic:
072000070213      * Only send PCP information if Add Emp or Add Dep
072100070213     C                   If        ACTCOD = 'MA'    and
072200070213     C                             %trim(OLNAME) =  *blanks  or
072300070213     C                             ACTCOD = 'DA'    and
072400090216     C                             %trim(ODLNAM) =  *blanks  or
072500090216     C                             ACTCOD = 'MT'             or
072600090216     C                             ACTCOD = 'DT'
072700021104      *
072800021104     C     PCPKEY        Setll     PCPL1
072900021104     C     PCPKEY        Reade     PCPL1                                  51
073000021104     C     *IN51         Doweq     *OFF
073100021104      *
073200021104      * Provider 1
073300021104     C                   Eval      D3PRVID1  =   %trim(V_PCID#)
073400021104     C                   Eval      D3PRIME1  =   'MP'
073500021104      * Effective Date
073600021104     C                   Movel     V_PCEFF       Input_Date
073700021104     C                   Eval      Input_Format  = 'YYYYMMDD'
073800021104     C                   Eval      Output_Format = 'MM/DD/YYYY'
073900021104     C                   Exsr      FormatDateSR
074000021104     C                   Eval      D3PRVEF1      = %trim(Output_Date)
074100021104      * Term Date
074200021216     C                   If        V_PCCAN  <>   *ZEROS
074300021104     C                   Movel     V_PCCAN       Input_Date
074400021104     C                   Eval      Input_Format  = 'YYYYMMDD'
074500021104     C                   Eval      Output_Format = 'MM/DD/YYYY'
074600021104     C                   Exsr      FormatDateSR
074700021104     C                   Eval      D3PRVTR1      = %trim(Output_Date)
074800030625     C                   Else
074900030625     C                   Eval      D3PRVTR1      = *BLANKS
075000021216     C                   End
075100021104      * Provider 2
075200021206     C                   Eval      D3PRVID2  =   *BLANKS
075300021206     C                   Eval      D3PRIME2  =   *BLANKS
075400021206     C                   Eval      D3PRVEF2  =   *BLANKS
075500021206     C                   Eval      D3PRVTR2  =   *BLANKS
075600021104      *
075700021104     C     PCPKEY        Reade     PCPL1                                  51
075800070213     C                   Enddo
075900070213     C                   End
076000021104      *
076100070213      * Set Default PCP - ADDED DFT JUNE 11 2003
076200070213     C*****              If        D3PRVID1  =   *BLANKS
076300070213     C*****              Eval      D3PRVID1  =   '999999998'
076400070213     C*****              Eval      D3PRVEF1  =   %trim(D3SCEF1)
076500070213     C*****              Eval      D3PRIME1  =   'MP'
076600070213     C*****              End
076700030611      *
076800021104     C     PCPKEY        KLIST
076900021104     C                   KFLD                    W_SSN#
077000021104     C                   KFLD                    W_SFX#
077100021104     C                   KFLD                    W_SPCD
077200021104      *
077300021104     C                   ENDSR
077400021025      *___________________________________________________________________
077500021025      * Get class record
077600021025      *___________________________________________________________________
077700021025     C     GetClass      BEGSR
077800021106     C                   If        D3CLS    =    *BLANKS
077900021025     C     ClassKey      Chain     CLASS
078000021025     C                   If        %Found
078100021104     C                   Eval      D3CLS    =    C_CLCLASS
078200021106      *
078300021106     C                   If        D3CLSE        = *BLANKS
078400021111     C                   Movel     X_DWENRL      Input_Date
078500021106     C                   Eval      Input_Format  = 'YYYYMMDD'
078600021106     C                   Eval      Output_Format = 'MM/DD/YYYY'
078700021106     C                   Exsr      FormatDateSR
078800021106     C                   Eval      D3CLSE        = %trim(Output_Date)
078900021106     C                   End
079000021106     C                   End
079100021106     C                   End
079200021106      *
079300100108      * Get Plan Group
079400100108     C                   Eval      PLNGRP = *blanks
079500100108     C     GrtKey        Setll     GRAT24
079600100108     C     GrtKey        Reade     GRAT24
079700100108     C                   Dow       not %eof(GRAT24)
079800100108      * GBS Date Logic
079900100108     C                   If        G_frmdat <> G_todat
080000100108     C                   If        G_todat  = *zeros
080100100108     C                   eval      G_todat  = 99999999
080200100108     C                   End
080300100108     C                   if        X_DWENRL >= G_frmdat and
080400100108     C                             X_DWENRL <= G_todat
080500100108      *
080600100108     C                   Eval      PLNGRP = %trim(G_group#)
080700100108      *
080800100108      * This is the real group#
080900100108     C                   Eval      GROUP# = %trim(G_group#)
081000100108      *
081100100108     C                   Leave
081200100108     C                   end
081300100108     C                   end
081400100108     C     GrtKey        Reade     GRAT24
081500100108     C                   Enddo
081600100108      *
081700100108      *
081800100108     C     GrtKey        Klist
081900100108     C                   Kfld                    X_DWTRST
082000100108     C                   Kfld                    X_DWSUB#
082100100108     C                   Kfld                    X_DWPLAN
082200100108      *
082300021025     C                   ENDSR
082400021025      *___________________________________________________________________
082500021025      * Get Plan Master record
082600021025      *___________________________________________________________________
082700021025     C     GetPlanMaster BEGSR
082800021111      *
082900021029      * Medical
083000021111     C                   Eval      W_CAT     = 'PMM'
083100021204     C     DW310Key      Chain     DW310LF
083200030702     C                   If        %Found(DW310LF)
083300021204     C                   Eval      D3SCAT_W  = 'M'
083400021204     C                   Exsr      PlanStatusSR
083500021204     C                   Eval      D3SCEF_W  = %trim(Output_Date)
083600021204     C                   Eval      D3SEVT_W  = W_SEVT
083700021204     C                   Eval      D3SFAM_W  = W_SFAM
083800021204     C                   Exsr      LoadBucketSR
083900021204     C                   Exsr      GetClass
084000021204     C                   Else
084100021213     C     DW310Key      Chain     DW310L2
084200030702     C                   If        %Found(DW310L2)
084300021111     C                   Eval      D3SCAT_W  = 'M'
084400021029     C                   Exsr      PlanStatusSR
084500021111     C                   Eval      D3SCEF_W  = %trim(Output_Date)
084600021111     C                   Eval      D3SEVT_W  = W_SEVT
084700021111     C                   Eval      D3SFAM_W  = W_SFAM
084800021111     C                   Exsr      LoadBucketSR
084900021111     C                   Exsr      GetClass
085000021204     C                   End
085100021204     C                   End
085200021029      * Rx Drug
085300021111     C                   Eval      W_CAT     = 'PRX'
085400021204     C     DW310Key      Chain     DW310LF
085500030702     C                   If        %Found(DW310LF)
085600021204     C                   Eval      D3SCAT_W  = 'R'
085700021204     C                   Exsr      PlanStatusSR
085800021204     C                   Eval      D3SCEF_W  = %trim(Output_Date)
085900021204     C                   Eval      D3SEVT_W  = W_SEVT
086000021204     C                   Eval      D3SFAM_W  = W_SFAM
086100021204     C                   Exsr      LoadBucketSR
086200021204     C                   Exsr      GetClass
086300021204     C                   Else
086400021213     C     DW310Key      Chain     DW310L2
086500030702     C                   If        %Found(DW310L2)
086600021111     C                   Eval      D3SCAT_W  = 'R'
086700021029     C                   Exsr      PlanStatusSR
086800021111     C                   Eval      D3SCEF_W  = %trim(Output_Date)
086900021111     C                   Eval      D3SEVT_W  = W_SEVT
087000021111     C                   Eval      D3SFAM_W  = W_SFAM
087100021111     C                   Exsr      LoadBucketSR
087200021111     C                   Exsr      GetClass
087300021204     C                   End
087400021111     C                   End
087500021029      * Dental
087600021111     C                   Eval      W_CAT     = 'PDR'
087700021204     C     DW310Key      Chain     DW310LF
087800030702     C                   If        %Found(DW310LF)
087900021204     C                   Eval      D3SCAT_W  = 'D'
088000021204     C                   Exsr      PlanStatusSR
088100021204     C                   Eval      D3SCEF_W  = %trim(Output_Date)
088200021204     C                   Eval      D3SEVT_W  = W_SEVT
088300021204     C                   Eval      D3SFAM_W  = W_SFAM
088400021204     C                   Exsr      LoadBucketSR
088500021204     C                   Exsr      GetClass
088600021204     C                   Else
088700021213     C     DW310Key      Chain     DW310L2
088800030702     C                   If        %Found(DW310L2)
088900021111     C                   Eval      D3SCAT_W  = 'D'
089000021029     C                   Exsr      PlanStatusSR
089100021111     C                   Eval      D3SCEF_W  = %trim(Output_Date)
089200021111     C                   Eval      D3SEVT_W  = W_SEVT
089300021111     C                   Eval      D3SFAM_W  = W_SFAM
089400021111     C                   Exsr      LoadBucketSR
089500021111     C                   Exsr      GetClass
089600021204     C                   End
089700021111     C                   End
089800021029      * Vision
089900021111     C                   Eval      W_CAT     = 'PVR'
090000021204     C     DW310Key      Chain     DW310LF
090100030702     C                   If        %Found(DW310LF)
090200021204     C                   Eval      D3SCAT_W  = 'V'
090300021204     C                   Exsr      PlanStatusSR
090400021204     C                   Eval      D3SCEF_W  = %trim(Output_Date)
090500021204     C                   Eval      D3SEVT_W  = W_SEVT
090600021204     C                   Eval      D3SFAM_W  = W_SFAM
090700021204     C                   Exsr      LoadBucketSR
090800021204     C                   Exsr      GetClass
090900021204     C                   Else
091000021213     C     DW310Key      Chain     DW310L2
091100030702     C                   If        %Found(DW310L2)
091200021111     C                   Eval      D3SCAT_W  = 'V'
091300021029     C                   Exsr      PlanStatusSR
091400021111     C                   Eval      D3SCEF_W  = %trim(Output_Date)
091500021111     C                   Eval      D3SEVT_W  = W_SEVT
091600021111     C                   Eval      D3SFAM_W  = W_SFAM
091700021111     C                   Exsr      LoadBucketSR
091800021111     C                   Exsr      GetClass
091900021204     C                   End
092000021111     C                   End
092100021111      *
092200021111     C                   ENDSR
092300021111      *___________________________________________________________________
092400021111      * Load Coverage Bucket
092500021111      *___________________________________________________________________
092600021111     C     LoadBucketSR  BEGSR
092700021111      *
092800021111      * Select Bucket
092900021111     C                   Select
093000021111     C                   When      D3SCAT1  =   *Blanks
093100021111     C                   Eval      D3SCAT1  =   D3SCAT_W
093200021112     C                   Eval      D3SCEF1  =   D3SCEF_W
093300021112     C                   Eval      D3SEVT1  =   D3SEVT_W
093400021112     C                   Eval      D3SFAM1  =   D3SFAM_W
093500021111     C                   When      D3SCAT2  =   *Blanks
093600021111     C                   Eval      D3SCAT2  =   D3SCAT_W
093700021112     C                   Eval      D3SCEF2  =   D3SCEF_W
093800021112     C                   Eval      D3SEVT2  =   D3SEVT_W
093900021112     C                   Eval      D3SFAM2  =   D3SFAM_W
094000021111     C                   When      D3SCAT3  =   *Blanks
094100021111     C                   Eval      D3SCAT3  =   D3SCAT_W
094200021112     C                   Eval      D3SCEF3  =   D3SCEF_W
094300021112     C                   Eval      D3SEVT3  =   D3SEVT_W
094400021112     C                   Eval      D3SFAM3  =   D3SFAM_W
094500021111     C                   When      D3SCAT4  =   *Blanks
094600021111     C                   Eval      D3SCAT4  =   D3SCAT_W
094700021112     C                   Eval      D3SCEF4  =   D3SCEF_W
094800021112     C                   Eval      D3SEVT4  =   D3SEVT_W
094900021112     C                   Eval      D3SFAM4  =   D3SFAM_W
095000021111     C                   Other
095100021111     C                   Endsl
095200021111      *
095300021025     C                   ENDSR
095400021029      *___________________________________________________________________
095500021029      * Determine Plan Status - Term or Enrolled
095600021029      *___________________________________________________________________
095700021029     C     PlanStatusSR  BEGSR
095800021106      *
095900021111     C                   Eval      W_COVT   =    %trim(%subst(X_DWCOVT:2:2))
096000021206     C                   Eval      W_IN_ONLY =   'Y'
096100021029      *
096200021029     C                   Select
096300021219      * Termed (sub -1 day) if not same day term.
096400021111     C                   When      X_DWCAND <>   *ZEROS
096500021219     C                   If        X_DWCAND <>   X_DWENRL
096600021216     C     *YMD          MOVE      X_DWCAND      ISO_DATE
096700021216     C     ISO_DATE      SUBDUR    1:*DAYS       ISO_DATE
096800070129     C     *ISO          MOVE      ISO_DATE      X_DWCAND
096900021219     C                   End
097000021111     C                   Movel     X_DWCAND      Input_Date
097100021029     C                   Eval      Input_Format  = 'YYYYMMDD'
097200021029     C                   Eval      Output_Format = 'MM/DD/YYYY'
097300021029     C                   Exsr      FormatDateSR
097400021029     C                   Eval      W_SEVT        = 'TM'
097500021212      *
097600021212      * Save Lastest Term Date
097700021212     C                   If        W_DEPTRM < X_DWCAND
097800021212     C                   Eval      W_DEPTRM = X_DWCAND
097900021212     C                   End
098000021029      *
098100021029      * Enrollment Date (MCOV) to Subsriber Coverage Effect Date
098200021029     C                   Other
098300021111     C                   Movel     X_DWENRL      Input_Date
098400021029     C                   Eval      Input_Format  = 'YYYYMMDD'
098500021029     C                   Eval      Output_Format = 'MM/DD/YYYY'
098600021029     C                   Exsr      FormatDateSR
098700021029     C                   Eval      W_SEVT        = 'SL'
098800070130     C                   Eval      W_DEPTRM      = 0
098900070130     C                   Eval      W_TM_ONLY = 'N'
099000021029     C                   Endsl
099100021029      *
099200021029      * Set Coverage Type
099300021029     C                   Select
099400021029     C                   When      W_COVT = 'FA'
099500021029     C                   Eval      W_SFAM = 'A'
099600021206     C                   Eval      W_IN_ONLY = 'N'
099700021029     C                   When      W_COVT = 'HW'
099800021029     C                   Eval      W_SFAM = 'B'
099900021206     C                   Eval      W_IN_ONLY = 'N'
100000021029     C                   When      W_COVT = 'IN'
100100021029     C                   Eval      W_SFAM = 'C'
100200040304     C                   When      W_COVT = 'MI'
100300041207     C                   Eval      W_SFAM = 'C'
100400041228     C                   When      W_COVT = 'PC'
100500041228     C                   Eval      W_SFAM = 'D'
100600041228     C                   Eval      W_IN_ONLY = 'N'
100700041228     C                   When      W_COVT = 'P2'
100800060823     C                   Eval      W_SFAM = 'A'
100900021206     C                   Eval      W_IN_ONLY = 'N'
101000021029     C                   Other
101100021029     C                   Eval      W_SFAM = 'O'
101200021206     C                   Eval      W_IN_ONLY = 'N'
101300021029     C                   Endsl
101400021206      *
101500021029     C                   ENDSR
101600041130      *___________________________________________________________________
101700041130      * Reinstate Member
101800041130      *___________________________________________________________________
101900041130     C     ReinstateSR   BEGSR
102000041130     C                   Movel     ENRLDT        Input_Date
102100041130     C                   Eval      Input_Format  = 'YYYYMMDD'
102200041130     C                   Eval      Output_Format = 'MM/DD/YYYY'
102300041130     C                   Exsr      FormatDateSR
102400041130     C                   Eval      D3CLSE        = %trim(Output_Date)
102500100108     C                   Eval      D3SGRE        = %trim(Output_Date)
102600100108     C                   Eval      D3ORGEF       = %trim(Output_Date)
102700041130     C                   If        D3SCEF1  <>   *BLANKS
102800041130     C                   Eval      D3SCEF1       = %trim(Output_Date)
102900041130     C                   End
103000041130     C                   If        D3SCEF2  <>   *BLANKS
103100041130     C                   Eval      D3SCEF2       = %trim(Output_Date)
103200041130     C                   End
103300041130     C                   If        D3SCEF3  <>   *BLANKS
103400041130     C                   Eval      D3SCEF3       = %trim(Output_Date)
103500041130     C                   End
103600041130     C                   If        D3SCEF4  <>   *BLANKS
103700041130     C                   Eval      D3SCEF4       = %trim(Output_Date)
103800041130     C                   End
103900041130     C                   ENDSR
104000071105      *___________________________________________________________________
104100071105      * Override Term Date
104200071105      *___________________________________________________________________
104300071105     C     OVER_TERM     BEGSR
104400071105     C     DW310KeyPF    Setll     DW310L2
104500071105     C     DW310KeyPF    Reade     DW310L2
104600071105     C                   Dow       not %eof(DW310L2)
104700071105     C                   If        X_DWCAND <>   X_DWENRL
104800071105     C                   eval      M_TERMDT = X_DWCAND
104900071105     C                   End
105000071105     C     DW310KeyPF    Reade     DW310L2
105100071105     C                   Enddo
105200071105     C                   ENDSR
105300021212      *___________________________________________________________________
105400021212      * Reset Coverages
105500021212      *___________________________________________________________________
105600021212     C     RESETCOVG     BEGSR
105700021212     C                   Eval      W_DEPTRM =   *Zeros
105800021212     C                   Eval      D3SCAT1  =   *Blanks
105900021212     C                   Eval      D3SCEF1  =   *Blanks
106000021212     C                   Eval      D3SEVT1  =   *Blanks
106100021212     C                   Eval      D3SFAM1  =   *Blanks
106200021212     C                   Eval      D3SCAT2  =   *Blanks
106300021212     C                   Eval      D3SCEF2  =   *Blanks
106400021212     C                   Eval      D3SEVT2  =   *Blanks
106500021212     C                   Eval      D3SFAM2  =   *Blanks
106600021212     C                   Eval      D3SCAT3  =   *Blanks
106700021212     C                   Eval      D3SCEF3  =   *Blanks
106800021212     C                   Eval      D3SEVT3  =   *Blanks
106900021212     C                   Eval      D3SFAM3  =   *Blanks
107000021212     C                   Eval      D3SCAT4  =   *Blanks
107100021212     C                   Eval      D3SCEF4  =   *Blanks
107200021212     C                   Eval      D3SEVT4  =   *Blanks
107300021212     C                   Eval      D3SFAM4  =   *Blanks
107400021212     C                   Eval      D3SCAT_W =   *Blanks
107500021212     C                   Eval      D3SCEF_W =   *Blanks
107600021212     C                   Eval      D3SEVT_W =   *Blanks
107700021212     C                   Eval      D3SFAM_W =   *Blanks
107800021212     C                   ENDSR
107900000000      *___________________________________________________________________
108000000000      * Program open
108100000000      *___________________________________________________________________
108200000000     C     *INZSR        BEGSR
108300021024     C                   Eval      D1RCD    =    '01'
108400021024     C                   Eval      D1REL    =    '001'
108500021024     C                   Eval      MMDDYYYY =    *DATE
108600021024     C                   Time                    HHMMSS
108700021024     C                   Movel     MMDDYYYYHHMMSSD1CRT
108800021113     C                   Eval      D1DBE    =    '521200892'
108900021101     C                   Eval      D1BAT    =    MMDD + YY + HHMM
109000021024     C                   Eval      D1HLD    =    'X'
109100021024     C                   Eval      DB2150   =    FileHeader
109200021024     C                   Write     DBTRANR
109300021024     C                   Clear                   DBTRANR
109400021024     C                   Clear                   FileHeader
109500021106     C                   Eval      *IN99    =    *IN99
109600030612    ?C                   Move      *on           *in91
109700030612     C                   Eval      WQPGMN =      'DW310R'
109800000000     C                   ENDSR
109900021024      *___________________________________________________________________
110000021024      * Format Date
110100021024      *___________________________________________________________________
110200021024     C     FormatDateSR  BEGSR
110300021024     C                   Call      'FMTDATE'
110400021024     C                   Parm                    Input_Date       32
110500021024     C                   Parm                    Input_Format     32
110600021024     C                   Parm                    Output_Format    32
110700021024     C                   Parm                    Output_Date      32
110800021024     C                   Parm                    Output_Error     10
110900021024     C                   ENDSR
111000021024      *___________________________________________________________________
111100021024      * Key List
111200021024      *___________________________________________________________________
111300021024     C     KLIST         BEGSR
111400021213     C     DW310KeyPF    KLIST
111500021213     C                   KFLD                    SOCSOC
111600021213     C                   KFLD                    W_SEQ
111700021111     C     DW310Key      KLIST
111800021111     C                   KFLD                    SOCSOC
111900021203     C                   KFLD                    W_SEQ
112000021111     C                   KFLD                    W_CAT
112100021024     C     ClassKey      KLIST
112200021111     C                   KFLD                    X_DWTRST
112300021111     C                   KFLD                    X_DWSUB#
112400021111     C                   KFLD                    X_DWPlan
112500021106     C                   KFLD                    W_COVTP
112600021024     C                   ENDSR
112700021202     C     WKACC         KLIST
112800021209     C                   KFLD                    W_FFFFFF
112900021202     C                   KFLD                    X_DWTRST
113000021202     C                   KFLD                    X_DWSUB#
113100021202     C                   KFLD                    X_DWACCT
113200030612      *___________________________________________________________________
113300030612      * Check Overflow - Print Header
113400030612      *___________________________________________________________________
113500030612     C     CheckOverflow BEGSR
113600030612     C                   If        *in91  = *on  or
113700030612     C                             Count  = 2
113800030612     C                   Write     PRTHDR
113900030612     C                   Move      *off          *In91
114000030612     C                   Eval      Count =  0
114100030612     C                   End
114200030612     C                   ENDSR
114300100414      *___________________________________________________________________
114400100414      * Plan Tracking
114500100414      *___________________________________________________________________
114600100414     C     WRTHST        BEGSR
114700100414     C                   Clear                   HISTR
114800100414
114900100414     C                   Eval      H_CK#NOT = 'TRANSMITTED'
115000100414     C                   MOVE      SOCSOC        H_HKEY
115100100414     C                   Eval      H_TRCODE = 'U64'
115200100414     C                   Eval      H_HOPER = %trim(QQRVWR)
115300100414     C                   Eval      H_HPRGNM = 'DW310R'
115400100414     C                   Eval      H_HSTRST = TRUST
115500100414     C                   Eval      H_HSSUB# = SUBNO
115600100414     C                   Eval      H_HSACCT = ACCNO
115700100414     C                   Eval      H_HSDLTD = 'A'
115800100414     C     *Date         Mult      10000.0001    H_TRDATE
115900100414     C     *Date         Mult      10000.0001    H_COVTDT
116000131010     c                   eval      h_hstrtime = %time
116100100414     C                   WRITE     HISTR
116200100414     C                   ENDSR
116300030612      *___________________________________________________________________
1164000305130237 Oqsysprt   E            HEAD           2 03
1165000305130126 O                       CONAME              85
1166000305130242 O          E            HEAD           1
1167000305130244 O                                           80 'ISSUES IN DBE TRANSMISSION'
1168000305130242 O          E            HEAD           1
1169000305130248 O                                           25 'PROGRAM NAME: DW310R'
1170000305130249 O                                          122 'PAGE :'
1171000305130250 O                       PAGE          Z    131
1172000305130242 O          E            HEAD           1
1173000305130253 O                                           14 'RUN DATE:'
1174000305130254 O                       UDATE         Y     25
1175000305130255 O                                          122 'TIME :'
1176000305130256 O                       hhmmss             131 '  :  :  '
1177000305130242 O          E            HEAD           1
1178000305130259 O                                           24 '------------------------'
1179000305130260 O                                           48 '------------------------'
1180000305130261 O                                           72 '------------------------'
1181000305130262 O                                           96 '------------------------'
1182000305130263 O                                          120 '------------------------'
1183000305130286 O                                          132 '------------'
1184000305130242 O          E            HEAD           1
1185000305130267 O                                           11 'SSN'
1186000305130268 O                                           26 'PLAN'
1187000305130268 O                                           32 'COV'
1188000305130268 O                                           40 'ISSUE'
1189000305130242 O          E            HEAD           2
1190000305130259 O                                           24 '------------------------'
1191000305130260 O                                           48 '------------------------'
1192000305130261 O                                           72 '------------------------'
1193000305130262 O                                           96 '------------------------'
1194000305130263 O                                          120 '------------------------'
1195000305130286 O                                          132 '------------'
1196000305130287 O          E            tgheld         1
1197000305130288 O                       Socsoc              11 '   -  -    '
1198000305130288 O                       trust               17
1199000305130288 O                       subno               21
1200000305130288 O                       plan#               26
1201000305130288 O                       mcvtyp              32
1202000305200288 O                       group#              50
1203000305130288 O                                           +3 '<--TEMP GROUP # HELD'
1204000305130287 O          E            tgrel          1
1205000305130288 O                       Socsoc              11 '   -  -    '
1206000305130288 O                       trust               17
1207000305130288 O                       subno               21
1208000305130288 O                       plan#               26
1209000305130288 O                       mcvtyp              32
1210000305130288 O                       group#              50
1211000305130288 O                                           +2 '<--TEMP GROUP # RELEASED A'
1212000305130288 O                                           +0 'S -->'
1213000305130288 O                       terealg#            +2
