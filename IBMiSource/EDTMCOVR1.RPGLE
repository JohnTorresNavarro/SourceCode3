000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *_________________________________________________________________________
000400160809     FPLNAUXP   IF   E           K Disk
000500160809     FPLNMST    IF   E           K Disk    extfile('F.PLNMST')
000600160809     FMEMAC#1   IF   E           K Disk    extfile('F.MEMAC#1')
000700160809     FEDTMCOV   IF   E           K Disk
000800160809     FDEPEND    IF   E           K Disk    extfile('F.DEPEND')
000900160809     FMCOVC     IF A E           K Disk    extfile('F.MCOVC')
001000160809     FDCOVC     IF A E           K Disk    extfile('F.DCOVC')
001100160809     FHIST      O    E             DISK    extfile('F.HIST')
001200160809
001300160809     D  trs            s              3s 0 inz(005)
001400160725     D  pos            s              3s 0 inz
001500160809     D w80date         S              8S 0
001600160809     D  spsflg         s              2s 0 inz
001700160809     D  chdflg         s              2s 0 inz
001800160809     D  depflg         s              1a   inz
001900160809
002000160809     D  msmcva         C                   'Coverage Add From EDT Conversion '
002100160725
002200160809     D                 DS
002300160809     D  suba                   1      9
002400160809     D  subn                   1      9  0
002500160809
002600000000      * Program status data structure
002700000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002800160725
002900160809     C     trs           setll     PLNAUXP
003000160809     C     trs           reade     PLNAUXP
003100160809     C                   dow       not %eof(PLNAUXP)
003200160809     C     plnkey        chain     PLNMST
003300160809     C                   if        %found(PLNMST)   and
003400160809     C                             %trim(PLNCAT) = 'PDN'
003500160725
003600160809     C                   exsr      getmeminfo
003700160725
003800160809     C                   end
003900160809     C     trs           reade     PLNAUXP
004000160725     C                   enddo
004100160725
004200160725     C                   eval      *inlr = *on
004300160725     C                   return
004400000000      *___________________________________________________________________
004500160809      * getmeminfo      Code
004600000000      *___________________________________________________________________
004700160809     C     getmeminfo    BEGSR
004800160809     C     acckey        setll     MEMAC#1
004900160809     C     acckey        reade     MEMAC#1
005000160809     C                   dow       not %eof(MEMAC#1)
005100160809
005200160809     C     mbssno        chain     EDTMCOV
005300160809     C                   if        %found(EDTMCOV)
005400160809     C                   exsr      adddental
005500160809     C                   end
005600160809     C     acckey        reade     MEMAC#1
005700160809     C                   enddo
005800000000     C                   ENDSR
005900160809      *___________________________________________________________________
006000160809      * Adddental       Code
006100160809      *___________________________________________________________________
006200160809     C     adddental     BEGSR
006300160809     C     acckey        setll     MEMAC#1
006400160809     C     acckey        reade     MEMAC#1
006500160809     C                   dow       not %eof(MEMAC#1)
006600160809     C                   eval      MDSEQ# = 0
006700160809     C     memkey        chain     MCOVC
006800160809     C                   if        not %found(MCOVC)
006900160809
007000160809     C                   clear                   MCOVR
007100160809
007200160809     C                   eval      MCSSNO = MBSSNO
007300160809     C                   eval      MDSEQ# = 0
007400160809     C                   eval      MCTRST = PXTRST
007500160809     C                   eval      MCSUB# = PXSUB#
007600160809     C                   eval      MCPLAN = PXPLAN
007700160809     C                   eval      ACC#   = PXACCT
007800160809     C                   eval      ENRLDT = 20160901
007900160809     C                   eval      CANDT  = 0
008000160809     C                   eval      MCDLTD = 'A'
008100160809
008200160809     C                   exsr      dependents
008300160809
008400160809     C                   select
008500160809     C                   when      spsflg = 0 and
008600160809     C                             chdflg = 0
008700160809     C                   eval      MCOVTP = 'TIN'
008800160809     C                   when      spsflg > 0 and
008900160809     C                             chdflg > 0
009000160809     C                   eval      MCOVTP = 'TFA'
009100160809     C                   when      spsflg > 0 and
009200160809     C                             chdflg = 0
009300160809     C                   eval      MCOVTP = 'THW'
009400160809     C                   when      spsflg = 0 and
009500160809     C                             chdflg > 0
009600160809     C                   eval      MCOVTP = 'TPC'
009700160809     C                   endsl
009800160809
009900160809     C                   write     MCOVR
010000160809     C                   exsr      MHIST
010100160809
010200160809     C***                if        depflg = 'Y'
010300160809     C***                exsr      dependents
010400160809     C***                end
010500160809
010600160809     C                   end
010700160809     C     acckey        reade     MEMAC#1
010800160809     C                   enddo
010900160809     C                   ENDSR
011000160809      *___________________________________________________________________
011100160809      * dependents
011200160809      *___________________________________________________________________
011300160809     C     dependents    BEGSR
011400160809     C                   eval      spsflg = 0
011500160809     C                   eval      chdflg = 0
011600160809     C     mbssno        setll     DEPEND
011700160809     C     mbssno        reade     DEPEND
011800160809     C                   dow       not %eof(DEPEND)
011900160809
012000160809     C     depkey        chain     DCOVC
012100160809     C                   if        not %found(DCOVC)
012200160809
012300160809     C                   clear                   DCOVR
012400160809     C                   eval      SSNO   = MBSSNO
012500160809     C                   eval      DSEQ#  = DPSEQ#
012600160809     C                   eval      DVTRST = PXTRST
012700160809     C                   eval      DVSUB# = PXSUB#
012800160809     C                   eval      DVPLAN = PXPLAN
012900160809     C                   eval      DVDLTD = 'A'
013000160809     C                   eval      DENRDT = 20160901
013100160809     C                   write     DCOVR
013200160809     C                   exsr      DHIST
013300160809
013400160809     C                   select
013500160809     C                   when      %trim(DRELCD) = 'RWI'
013600160809     C                   eval      spsflg = spsflg + 1
013700160809     C                   when      %trim(DRELCD) = 'RHU'
013800160809     C                   eval      spsflg = spsflg + 1
013900160809     C                   other
014000160809     C                   eval      chdflg = chdflg + 1
014100160809     C                   endsl
014200160809
014300160809     C                   end
014400160809
014500160809     C     mbssno        reade     DEPEND
014600160809     C                   enddo
014700160809     C                   ENDSR
014800160809      *___________________________________________________________________
014900160809      * MCOV - HIST
015000160809      *___________________________________________________________________
015100160809     C     MHIST         BEGSR
015200160809      *
015300160809      *    Write mcov add HIST rec for plan add
015400160809     C                   clear                   histr
015500160809     C                   movel     mbssno        subn
015600160809     C                   move      suba          hkey
015700160809     C                   z-add     DPSEQ#        HDSEQ#
015800160809     C                   eval      trdate = 20160809
015900160810     C                   move      'MAC'         trcode
016000160809     C                   Z-ADD     0             TRAMT
016100160809     C                   MOVE      *BLANKS       CM$FLG
016200160809     C                   MOVEL     msmcva        CK#NOT
016300160809     C                   MOVEL     PXPLAN        NOTE2
016400160809     C                   MOVE      'X'           TRMFLG
016500160809     C                   MOVE      'X'           TRLFLG
016600160809     C                   MOVE      'N'           DTRFLG
016700160809     C                   MOVE      '  '          HDSEQ#
016800160809     C                   MOVEL     'EDTMCOVR'    HPRGNM
016900160809     C                   Z-ADD     0             RECVDT
017000160809     C                   eval      COVTDT = 20160901
017100160809     C                   MOVE      PXTRST        HSTRST
017200160809     C                   MOVE      PXSUB#        HSSUB#
017300160809     C                   MOVE      PXACCT        HSACCT
017400160810     C                   MOVEL     'SHELLY  '    HOPER
017500160809     C                   MOVEL     'A'           HSDLTD
017600160809     c                   eval      hstrtime = %time
017700160809     C                   WRITE     HISTR
017800160809      *
017900160809     C                   ENDSR
018000160809      *___________________________________________________________________
018100160809      * DCOV - HIST
018200160809      *___________________________________________________________________
018300160809     C     DHIST         BEGSR
018400160809      *
018500160809      *    Write mcov add HIST rec for plan add
018600160809     C                   clear                   histr
018700160809     C                   movel     mbssno        subn
018800160809     C                   move      suba          hkey
018900160809     C                   eval      trdate = 20160809
019000160810     C                   move      'MDA'         trcode
019100160809     C                   Z-ADD     0             TRAMT
019200160809     C                   MOVE      *BLANKS       CM$FLG
019300160809     C                   MOVEL     msmcva        CK#NOT
019400160809     C                   MOVEL     PXPLAN        NOTE2
019500160809     C                   MOVE      'X'           TRMFLG
019600160809     C                   MOVE      'X'           TRLFLG
019700160809     C                   MOVE      'N'           DTRFLG
019800160809     C                   MOVE      '  '          HDSEQ#
019900160809     C                   MOVEL     'EDTMCOVR'    HPRGNM
020000160809     C                   Z-ADD     0             RECVDT
020100160809     C                   eval      COVTDT = 20160901
020200160809     C                   MOVE      PXTRST        HSTRST
020300160809     C                   MOVE      PXSUB#        HSSUB#
020400160809     C                   MOVE      PXACCT        HSACCT
020500160810     C                   MOVEL     'SHELLY  '    HOPER
020600160809     C                   MOVEL     'A'           HSDLTD
020700160809     c                   eval      hstrtime = %time
020800160809     C                   WRITE     HISTR
020900160809      *
021000160809     C                   ENDSR
021100160725      *___________________________________________________________________
021200160725      * Key Lists
021300160725      *___________________________________________________________________
021400160725     C     KLIST         BEGSR
021500160809     C     PLNKEY        Klist
021600160809     C                   kfld                    PXTRST
021700160809     C                   kfld                    PXSUB#
021800160809     C                   kfld                    PXPLAN
021900160809     C     ACCKEY        Klist
022000160809     C                   kfld                    PXTRST
022100160809     C                   kfld                    PXSUB#
022200160809     C                   kfld                    PXACCT
022300160809     C     MEMKEY        Klist
022400160809     C                   kfld                    MBSSNO
022500160809     C                   kfld                    MDSEQ#
022600160809     C                   kfld                    PXTRST
022700160809     C                   kfld                    PXSUB#
022800160809     C                   kfld                    PXPLAN
022900160809     C     DEPKEY        Klist
023000160809     C                   kfld                    MBSSNO
023100160809     C                   kfld                    DPSEQ#
023200160809     C                   kfld                    PXTRST
023300160809     C                   kfld                    PXSUB#
023400160809     C                   kfld                    PXPLAN
023500160725     C                   ENDSR
023600000000      *___________________________________________________________________
023700000000      * Program open
023800000000      *___________________________________________________________________
023900000000     C     *INZSR        BEGSR
024000000000     C                   ENDSR
024100000000      *___________________________________________________________________
024200000000      * Program error handler
024300000000      *___________________________________________________________________
024400000000     C     *PSSR         BEGSR
024500000000     C                   CALL      'SNDRPGM'                            50
024600000000     C                   PARM                    WQPGMN
024700000000     C                   PARM                    WQSTSC
024800000000     C                   PARM                    WQRPGS
024900000000     C                   PARM                    WQMSG
025000000000     C                   ENDSR     '*CANCL'
