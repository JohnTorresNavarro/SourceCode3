000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *_________________________________________________________________________
000400190722     FEVTMCOVP  IF   E           K Disk
000500190722     FACCMST    IF   E           K Disk    extfile('F.ACCMST')
000600190722     FMEMBER    IF   E           K Disk    extfile('F.MEMBER')
000700190722     FDEPEND    IF   E           K Disk    extfile('F.DEPEND')
000800190715     FMCOVC     IF A E           K Disk
000900190722     FDCOVC     IF A E           K Disk
001000190722     FEVTERRP   O    E             DISK
001100160809     FHIST      O    E             DISK    extfile('F.HIST')
001200160809
001300190711     D up              c                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
001400190711     D lo              c                   CONST('abcdefghijklmnopqrstuvwxyz')
001500190712
001600190711     D  trs            s              3s 0 inz(003)
001700190711     D  sub            s              3s 0 inz(001)
001800190711     D  acc            s              4s 0 inz(2497)
001900160725     D  pos            s              3s 0 inz
002000160809     D w80date         S              8S 0
002100190712     D left            s             13a   inz
002200190712     D right           s              2a   inz
002300190712     D rights          s              2s 0 inz
002400190712     D SalaryPP        s              9s 0 inz
002500190715     D Salary$         s             12s 2 inz
002600190715     D Amt             s              5s 2 inz
002700190712     D ANL             s             14a   inz
002800160809
002900190722     D  msmcva         C                   'Coverage Add From EVT Conversion '
003000160725
003100160809     D                 DS
003200190722     D  suba                   1      9
003300190722     D  subn                   1      9s 0
003400190722
003500190722     D                 DS
003600190722     D  effa                   1      8
003700190722     D  effn                   1      8s 0
003800160809
003900000000      * Program status data structure
004000000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
004100160725
004200190722     C     *loval        setll     EVTMCOVP
004300190722     C                   read      EVTMCOVP
004400190722     C                   dow       not %eof(EVTMCOVP)
004500160725
004600190723     C***                if        EVTSSN = '001569997'
004700160809     C                   exsr      getmeminfo
004800190723     C***                end
004900160725
005000190722     C                   read      EVTMCOVP
005100160725     C                   enddo
005200160725
005300160725     C                   eval      *inlr = *on
005400160725     C                   return
005500000000      *___________________________________________________________________
005600160809      * getmeminfo      Code
005700000000      *___________________________________________________________________
005800160809     C     getmeminfo    BEGSR
005900190722     C                   move      EVTSSN        mbssno
006000190722     C     mbssno        chain     MEMBER
006100190722     C                   if        %found(MEMBER)
006200190723     C                   if        MBTRST = 005
006300190722     C     acckey        chain     ACCMST
006400190722     C                   if        %found(ACCMST)
006500190722     C                   if        LINV# = 0
006600190711     C                   exsr      addmcov
006700190722     C                   else
006800190722     C                   write     EVTRR
006900190723     C                   end
007000190722     C                   end
007100190723     C                   else
007200190724     C     acckey        chain     ACCMST
007300190724     C                   if        %found(ACCMST)
007400190723     C                   write     EVTRR
007500190724     C                   end
007600190722     C                   end
007700190711     C                   end
007800000000     C                   ENDSR
007900160809      *___________________________________________________________________
008000190711      * Add MCOV
008100160809      *___________________________________________________________________
008200190711     C     addmcov       BEGSR
008300160809     C                   eval      MDSEQ# = 0
008400190722     C                   eval      mcplan = %trim(EVTPLAN)
008500190711     C                   if        %trim(mcplan) <> *blanks
008600190711     C     covkey        chain     MCOVC
008700160809     C                   if        not %found(MCOVC)
008800160809
008900160809     C                   clear                   MCOVR
009000160809
009100160809     C                   eval      MCSSNO = MBSSNO
009200160809     C                   eval      MDSEQ# = 0
009300190722     C                   eval      MCTRST = MBTRST
009400190722     C                   eval      MCSUB# = MBSUB#
009500190722     C                   eval      MCPLAN = %trim(EVTPLAN)
009600190722     C                   eval      ACC#   = MBACCT
009700190722     C                   eval      effa = evteff
009800190722     C                   eval      ENRLDT = effn
009900160809     C                   eval      CANDT  = 0
010000160809     C                   eval      MCDLTD = 'A'
010100160809
010200190712     C                   select
010300190722     C                   when      %trim(EVTCOV) = 'FA'
010400190712     C                   eval      MCOVTP = 'TFA'
010500190712     C                   eval      CACTFL = 4
010600190722     C                   when      %trim(EVTCOV) = 'HW'
010700190712     C                   eval      MCOVTP = 'THW'
010800190712     C                   eval      CACTFL = 3
010900190722     C                   when      %trim(EVTCOV) = 'PC'
011000190712     C                   eval      MCOVTP = 'TPC'
011100190712     C                   eval      CACTFL = 2
011200190722     C                   when      %trim(EVTCOV) = 'P2'
011300190712     C                   eval      MCOVTP = 'TP2'
011400190712     C                   eval      CACTFL = 2
011500190722     C                   when      %trim(EVTCOV) = 'IN'
011600190712     C                   eval      MCOVTP = 'TIN'
011700190712     C                   eval      CACTFL = 1
011800190722     C                   when      %trim(EVTCOV) = 'IND'
011900190722     C                   eval      MCOVTP = 'TIN'
012000190722     C                   eval      CACTFL = 1
012100190722     C                   when      %trim(EVTCOV) = 'DB'
012200190722     C                   eval      MCOVTP = 'TDB'
012300190722     C                   eval      CACTFL = 5
012400190712     C                   other
012500190712     C                   eval      MCOVTP = 'TIN'
012600190712     C                   eval      CACTFL = 1
012700190712     C                   endsl
012800160809
012900160809     C                   write     MCOVR
013000160809     C                   exsr      MHIST
013100190722     C                   end
013200190711     C                   end
013300190722
013400190722      * Add dependents
013500190722     C     MBSSNO        setll     DEPEND
013600190722     C     MBSSNO        reade     DEPEND
013700190722     C                   dow       not %eof(DEPEND)
013800190722     C                   exsr      dependents
013900190722     C     MBSSNO        reade     DEPEND
014000190722     C                   enddo
014100190722
014200160809
014300160809     C                   ENDSR
014400160809      *___________________________________________________________________
014500160809      * MCOV - HIST
014600160809      *___________________________________________________________________
014700160809     C     MHIST         BEGSR
014800160809      *
014900160809      *    Write mcov add HIST rec for plan add
015000160809     C                   clear                   histr
015100160809     C                   movel     mbssno        subn
015200160809     C                   move      suba          hkey
015300160810     C                   z-add     *zeros        HDSEQ#
015400190722     C     *date         mult      10000.0001    TRDATE
015500160810     C                   move      'MAC'         trcode
015600160809     C                   Z-ADD     0             TRAMT
015700160809     C                   MOVE      *BLANKS       CM$FLG
015800160809     C                   MOVEL     msmcva        CK#NOT
015900190722     C                   MOVEL     MCPLAN        NOTE2
016000160809     C                   MOVE      'X'           TRMFLG
016100160809     C                   MOVE      'X'           TRLFLG
016200160809     C                   MOVE      'N'           DTRFLG
016300160809     C                   MOVE      '  '          HDSEQ#
016400190722     C                   MOVEL     'EVTMCOVR'    HPRGNM
016500160809     C                   Z-ADD     0             RECVDT
016600190722     C                   eval      COVTDT = ENRLDT
016700190722     C                   MOVE      MBTRST        HSTRST
016800190722     C                   MOVE      MBSUB#        HSSUB#
016900190722     C                   MOVE      MBACCT        HSACCT
017000190722     C                   MOVEL     'SHELLY  '    HOPER
017100160809     C                   MOVEL     'A'           HSDLTD
017200160809     c                   eval      hstrtime = %time
017300160809     C                   WRITE     HISTR
017400160809      *
017500160809     C                   ENDSR
017600190722      *___________________________________________________________________
017700190722      * dependents
017800190722      *___________________________________________________________________
017900190722     C     dependents    BEGSR
018000190722
018100190722     C                   if        DPDLTD = 'A'
018200190722     C                   exsr      adddcov
018300190722     C                   end
018400190722
018500190722     C                   endsr
018600190722      *___________________________________________________________________
018700190722      * add dcov
018800190722      *___________________________________________________________________
018900190722     C     adddcov       BEGSR
019000190722
019100190722     C                   eval      dvplan = %trim(EVTPLAN)
019200190722     C                   if        %trim(dvplan) <> *blanks
019300190722     C     depkey        chain     DCOVC
019400190722     C                   if        not %found(DCOVC)
019500190722
019600190722     C                   clear                   DCOVR
019700190722     C                   eval      SSNO   = MBSSNO
019800190722     C                   eval      DSEQ#  = DPSEQ#
019900190722     C                   eval      DVTRST = MBTRST
020000190722     C                   eval      DVSUB# = MBSUB#
020100190722     C                   eval      DVPLAN = %trim(EVTPLAN)
020200190722     C                   eval      DVDLTD = 'A'
020300190722     C                   eval      DENRDT = 20190701
020400190722     C                   write     DCOVR
020500190722     C                   exsr      DHIST
020600190722
020700190722     C                   end
020800190722     C                   end
020900190722
021000190722     C                   ENDSR
021100190722      *___________________________________________________________________
021200190722      * DCOV - HIST
021300190722      *___________________________________________________________________
021400190722     C     DHIST         BEGSR
021500190722      *
021600190722      *    Write mcov add HIST rec for plan add
021700190722     C                   clear                   histr
021800190722     C                   movel     mbssno        subn
021900190722     C                   move      suba          hkey
022000190722     C                   z-add     DPSEQ#        HDSEQ#
022100190722     C     *date         mult      10000.0001    TRDATE
022200190722     C                   move      'MDA'         trcode
022300190722     C                   Z-ADD     0             TRAMT
022400190722     C                   MOVE      *BLANKS       CM$FLG
022500190722     C                   MOVEL     msmcva        CK#NOT
022600190722     C                   MOVEL     EVTPLAN       NOTE2
022700190722     C                   MOVE      'X'           TRMFLG
022800190722     C                   MOVE      'X'           TRLFLG
022900190722     C                   MOVE      'N'           DTRFLG
023000190722     C                   MOVE      '  '          HDSEQ#
023100190722     C                   MOVEL     'EVTMCOVR'    HPRGNM
023200190722     C                   Z-ADD     0             RECVDT
023300190722     C                   eval      COVTDT = 20190701
023400190722     C                   MOVE      MBTRST        HSTRST
023500190722     C                   MOVE      MBSUB#        HSSUB#
023600190722     C                   MOVE      MBACCT        HSACCT
023700190722     C                   MOVEL     'SHELLY  '    HOPER
023800190722     C                   MOVEL     'A'           HSDLTD
023900190722     c                   eval      hstrtime = %time
024000190722     C                   WRITE     HISTR
024100190722      *
024200190722     C                   ENDSR
024300160725      *___________________________________________________________________
024400160725      * Key Lists
024500160725      *___________________________________________________________________
024600160725     C     KLIST         BEGSR
024700160809     C     ACCKEY        Klist
024800190722     C                   kfld                    MBTRST
024900190722     C                   kfld                    MBSUB#
025000190722     C                   kfld                    MBACCT
025100190711     C     COVKEY        Klist
025200190711     C                   kfld                    MBSSNO
025300190722     C                   kfld                    MDSEQ#
025400190722     C                   kfld                    MBTRST
025500190722     C                   kfld                    MBSUB#
025600190711     C                   kfld                    mcplan
025700190722     C     DEPKEY        Klist
025800190722     C                   kfld                    MBSSNO
025900190722     C                   kfld                    DPSEQ#
026000190722     C                   kfld                    MBTRST
026100190722     C                   kfld                    MBSUB#
026200190722     C                   kfld                    dvplan
026300160725     C                   ENDSR
026400000000      *___________________________________________________________________
026500000000      * Program open
026600000000      *___________________________________________________________________
026700000000     C     *INZSR        BEGSR
026800000000     C                   ENDSR
026900000000      *___________________________________________________________________
027000000000      * Program error handler
027100000000      *___________________________________________________________________
027200000000     C     *PSSR         BEGSR
027300000000     C                   CALL      'SNDRPGM'                            50
027400000000     C                   PARM                    WQPGMN
027500000000     C                   PARM                    WQSTSC
027600000000     C                   PARM                    WQRPGS
027700000000     C                   PARM                    WQMSG
027800000000     C                   ENDSR     '*CANCL'
