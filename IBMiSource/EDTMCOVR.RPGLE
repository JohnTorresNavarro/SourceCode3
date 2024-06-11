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
001600160809     D  depflg         s              1a   inz
001700160809
001800160809     D  msmcva         C                   'Coverage Add From EDT Conversion '
001900160725
002000160809     D                 DS
002100160809     D  suba                   1      9
002200160809     D  subn                   1      9  0
002300160809
002400000000      * Program status data structure
002500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002600160725
002700160809     C     trs           setll     PLNAUXP
002800160809     C     trs           reade     PLNAUXP
002900160809     C                   dow       not %eof(PLNAUXP)
003000160809     C     plnkey        chain     PLNMST
003100160809     C                   if        %found(PLNMST)   and
003200160809     C                             %trim(PLNCAT) = 'PDN'
003300160725
003400160809     C                   exsr      getmeminfo
003500160725
003600160809     C                   end
003700160809     C     trs           reade     PLNAUXP
003800160725     C                   enddo
003900160725
004000160725     C                   eval      *inlr = *on
004100160725     C                   return
004200000000      *___________________________________________________________________
004300160809      * getmeminfo      Code
004400000000      *___________________________________________________________________
004500160809     C     getmeminfo    BEGSR
004600160809     C     acckey        setll     MEMAC#1
004700160809     C     acckey        reade     MEMAC#1
004800160809     C                   dow       not %eof(MEMAC#1)
004900160809
005000160809     C     mbssno        chain     EDTMCOV
005100160809     C                   if        %found(EDTMCOV)
005200160809     C                   exsr      adddental
005300160809     C                   end
005400160809     C     acckey        reade     MEMAC#1
005500160809     C                   enddo
005600000000     C                   ENDSR
005700160809      *___________________________________________________________________
005800160809      * Adddental       Code
005900160809      *___________________________________________________________________
006000160809     C     adddental     BEGSR
006100160809     C     acckey        setll     MEMAC#1
006200160809     C     acckey        reade     MEMAC#1
006300160809     C                   dow       not %eof(MEMAC#1)
006400160809     C                   eval      MDSEQ# = 0
006500160809     C     memkey        chain     MCOVC
006600160809     C                   if        not %found(MCOVC)
006700160809
006800160809     C                   clear                   MCOVR
006900160809
007000160809     C                   eval      MCSSNO = MBSSNO
007100160809     C                   eval      MDSEQ# = 0
007200160809     C                   eval      MCTRST = PXTRST
007300160809     C                   eval      MCSUB# = PXSUB#
007400160809     C                   eval      MCPLAN = PXPLAN
007500160809     C                   eval      ACC#   = PXACCT
007600160809     C                   eval      ENRLDT = 20160901
007700160809     C                   eval      CANDT  = 0
007800160809     C                   eval      MCDLTD = 'A'
007900160809
008000160809     C                   eval      depflg = *blanks
008100160809     C                   select
008200160809     C                   when      %trim(EDTLVL) = 'FAM'
008300160809     C                   eval      MCOVTP = 'TFA'
008400160809     C                   eval      depflg = 'Y'
008500160809     C                   when      %trim(EDTLVL) = 'HW'
008600160809     C                   eval      MCOVTP = 'THW'
008700160809     C                   eval      depflg = 'Y'
008800160809     C                   when      %trim(EDTLVL) = 'IND'
008900160809     C                   eval      MCOVTP = 'TIN'
009000160809     C                   eval      depflg = 'N'
009100160809     C                   when      %trim(EDTLVL) = 'PC'
009200160809     C                   eval      MCOVTP = 'TPC'
009300160809     C                   eval      depflg = 'Y'
009400160809     C                   endsl
009500160809
009600160809     C                   write     MCOVR
009700160809     C                   exsr      MHIST
009800160809
009900160810      * COV/LEV mismatch report will catch these
010000160810     C***                if        depflg = 'Y'
010100160809     C                   exsr      dependents
010200160810     C***                end
010300160809
010400160809     C                   end
010500160809     C     acckey        reade     MEMAC#1
010600160809     C                   enddo
010700160809     C                   ENDSR
010800160809      *___________________________________________________________________
010900160809      * dependents
011000160809      *___________________________________________________________________
011100160809     C     dependents    BEGSR
011200160809     C     mbssno        setll     DEPEND
011300160809     C     mbssno        reade     DEPEND
011400160809     C                   dow       not %eof(DEPEND)
011500160809
011600160809     C     depkey        chain     DCOVC
011700160809     C                   if        not %found(DCOVC)
011800160809
011900160809     C                   clear                   DCOVR
012000160809     C                   eval      SSNO   = MBSSNO
012100160809     C                   eval      DSEQ#  = DPSEQ#
012200160809     C                   eval      DVTRST = PXTRST
012300160809     C                   eval      DVSUB# = PXSUB#
012400160809     C                   eval      DVPLAN = PXPLAN
012500160809     C                   eval      DVDLTD = 'A'
012600160809     C                   eval      DENRDT = 20160901
012700160809     C                   write     DCOVR
012800160809     C                   exsr      DHIST
012900160809
013000160809     C                   end
013100160809
013200160809     C     mbssno        reade     DEPEND
013300160809     C                   enddo
013400160809     C                   ENDSR
013500160809      *___________________________________________________________________
013600160809      * MCOV - HIST
013700160809      *___________________________________________________________________
013800160809     C     MHIST         BEGSR
013900160809      *
014000160809      *    Write mcov add HIST rec for plan add
014100160809     C                   clear                   histr
014200160809     C                   movel     mbssno        subn
014300160809     C                   move      suba          hkey
014400160810     C                   z-add     *zeros        HDSEQ#
014500160809     C                   eval      trdate = 20160809
014600160810     C                   move      'MAC'         trcode
014700160809     C                   Z-ADD     0             TRAMT
014800160809     C                   MOVE      *BLANKS       CM$FLG
014900160809     C                   MOVEL     msmcva        CK#NOT
015000160809     C                   MOVEL     PXPLAN        NOTE2
015100160809     C                   MOVE      'X'           TRMFLG
015200160809     C                   MOVE      'X'           TRLFLG
015300160809     C                   MOVE      'N'           DTRFLG
015400160809     C                   MOVE      '  '          HDSEQ#
015500160809     C                   MOVEL     'EDTMCOVR'    HPRGNM
015600160809     C                   Z-ADD     0             RECVDT
015700160809     C                   eval      COVTDT = 20160901
015800160809     C                   MOVE      PXTRST        HSTRST
015900160809     C                   MOVE      PXSUB#        HSSUB#
016000160809     C                   MOVE      PXACCT        HSACCT
016100160810     C                   MOVEL     'SHELLY  '    HOPER
016200160809     C                   MOVEL     'A'           HSDLTD
016300160809     c                   eval      hstrtime = %time
016400160809     C                   WRITE     HISTR
016500160809      *
016600160809     C                   ENDSR
016700160809      *___________________________________________________________________
016800160809      * DCOV - HIST
016900160809      *___________________________________________________________________
017000160809     C     DHIST         BEGSR
017100160809      *
017200160809      *    Write mcov add HIST rec for plan add
017300160809     C                   clear                   histr
017400160809     C                   movel     mbssno        subn
017500160809     C                   move      suba          hkey
017600160810     C                   z-add     DPSEQ#        HDSEQ#
017700160809     C                   eval      trdate = 20160809
017800160810     C                   move      'MDA'         trcode
017900160809     C                   Z-ADD     0             TRAMT
018000160809     C                   MOVE      *BLANKS       CM$FLG
018100160809     C                   MOVEL     msmcva        CK#NOT
018200160809     C                   MOVEL     PXPLAN        NOTE2
018300160809     C                   MOVE      'X'           TRMFLG
018400160809     C                   MOVE      'X'           TRLFLG
018500160809     C                   MOVE      'N'           DTRFLG
018600160809     C                   MOVE      '  '          HDSEQ#
018700160809     C                   MOVEL     'EDTMCOVR'    HPRGNM
018800160809     C                   Z-ADD     0             RECVDT
018900160809     C                   eval      COVTDT = 20160901
019000160809     C                   MOVE      PXTRST        HSTRST
019100160809     C                   MOVE      PXSUB#        HSSUB#
019200160809     C                   MOVE      PXACCT        HSACCT
019300160810     C                   MOVEL     'SHELLY  '    HOPER
019400160809     C                   MOVEL     'A'           HSDLTD
019500160809     c                   eval      hstrtime = %time
019600160809     C                   WRITE     HISTR
019700160809      *
019800160809     C                   ENDSR
019900160725      *___________________________________________________________________
020000160725      * Key Lists
020100160725      *___________________________________________________________________
020200160725     C     KLIST         BEGSR
020300160809     C     PLNKEY        Klist
020400160809     C                   kfld                    PXTRST
020500160809     C                   kfld                    PXSUB#
020600160809     C                   kfld                    PXPLAN
020700160809     C     ACCKEY        Klist
020800160809     C                   kfld                    PXTRST
020900160809     C                   kfld                    PXSUB#
021000160809     C                   kfld                    PXACCT
021100160809     C     MEMKEY        Klist
021200160809     C                   kfld                    MBSSNO
021300160809     C                   kfld                    MDSEQ#
021400160809     C                   kfld                    PXTRST
021500160809     C                   kfld                    PXSUB#
021600160809     C                   kfld                    PXPLAN
021700160809     C     DEPKEY        Klist
021800160809     C                   kfld                    MBSSNO
021900160809     C                   kfld                    DPSEQ#
022000160809     C                   kfld                    PXTRST
022100160809     C                   kfld                    PXSUB#
022200160809     C                   kfld                    PXPLAN
022300160725     C                   ENDSR
022400000000      *___________________________________________________________________
022500000000      * Program open
022600000000      *___________________________________________________________________
022700000000     C     *INZSR        BEGSR
022800000000     C                   ENDSR
022900000000      *___________________________________________________________________
023000000000      * Program error handler
023100000000      *___________________________________________________________________
023200000000     C     *PSSR         BEGSR
023300000000     C                   CALL      'SNDRPGM'                            50
023400000000     C                   PARM                    WQPGMN
023500000000     C                   PARM                    WQSTSC
023600000000     C                   PARM                    WQRPGS
023700000000     C                   PARM                    WQMSG
023800000000     C                   ENDSR     '*CANCL'
