0001000204020002  **************************************************************************
000200240319      * HRCV20R    Group Benefit Services
000300240326      *            WRITTEN BY - R.L.J.
000400240326      *            DATE - 03/2024
000500240326      *  DESCRIPTION - Use HRA current file to find coverage file
000600240326      *                discrepencies with MM or CM plans
0007000204020002  **************************************************************************
0008001702130015  * Changes: 02/13/2017 rlj Ignore mbrs in acct 3-1-497 per LI/DC
0009009102150018 F******************************************************************
0010002403190020 FHRCVCURP  IP   E           K DISK
0011002403260020 FMCOV      IF   E           K DISK
0012002403260020 FACCMST    IF   E           K DISK    PREFIX(A_)
0013002403260020 FAACODE    IF   E           K DISK
0014002403260020 FPLNMST    IF   E           K DISK
0015002403260020 FCMCT14    IF   E           K DISK
0016002403260020 FHRCVDP    O  A E             DISK
0017001103210029  *
0018000910140029  *
0019000809040250 D                 DS
002000140506     D  mcovtp                 1      3
002100140506     D   covt2                 2      3
0022001405060029  *
0023001405060250 D                 DS
002400140506     D  ISOToday       S               d   DATFMT(*ISO)
002500140506     D  Today          S              8p 0   inz
0026001405060037 D mmfnd           S              1
0027001405220037 D mmpln           S              1
0028000809040029  *
002900110315      *
003000140506     C     plnky         klist
003100110315     C                   kfld                    mctrust
003200091014     C                   kfld                    mcsub
003300140506     C                   kfld                    mcplan
003400140522      *
003500140522     C     plnky2        klist
003600240314     C                   kfld                    cmtrst
003700240314     C                   kfld                    csubdv
003800240314     C                   kfld                    cmplan
003900240314      *
004000240314     C     cmtky         klist
004100240314     C                   kfld                    mctrust
004200240314     C                   kfld                    mcsub
004300240314     C                   kfld                    mcacct
004400240314      *
004500240314      *
0046002403190291  *   Debug Shit
0047002403190296 C                   if        mcmid# = 213926615
0047012403190296 C                   eval      mcmid# = mcmid#
0047022403190296 C                   endif
0047032403190291  * Main Line - Look for MM or CM plan for Member
0047042403190296 C                   if        mcseq# = 0 and mcefdt <= today
0048002403140296 C                   if        mctfdt = 0 or mctfdt > today
0049002403140107  *      Bypass acct 3-1-497                                            ****
0050002403190296 C                   If        mctrust <> 3 or mcsub <> 1 or
0051002403140296 C                             mcacct <> 497
005200140506      *
0053001405060296 C                   eval      mmfnd = 'N'
0054001405060297 C     mcmid#        setll     mcov
0055001405060296 C                   dou       *in21 = '1'
0056001405060297 C     mcmid#        reade     mcov                                   21
005700020403      *
0058001405060296 C                   if        *in21 = '0' and candt <> enrldt
0059001405060296 C                   If        candt = 0 or candt > today
0060001405070296 C                   If        enrldt <= today
006100140506      *
0062001405060297 C     plnky         chain     plnmst                             22
0063001405220296 C                   if        *in22 = '0'
0064001405220296 C                   if        plncat = 'PMM' or plncat = 'PCM'
0065001405060296 C                   eval      mmfnd = 'Y'
0066001405060296 C                   leave
0067000807210296 C                   endif
0068001405220296 C                   endif
006900140506      *
0070000807210296 C                   endif
0071001405060296 C                   endif
0072001405070296 C                   endif
007300140506      *
0074001405060296 C                   enddo
007500140506      *
0076001405060296 C                   If        mmfnd = 'N'
0077001405220291  *       See if a Medical plan is offerred for TSA
007800140522      *
0079001405220296 C                   eval      mmpln = 'N'
0080001405220297 C     cmtky         setll     cmct14
0081001405220296 C                   dou       *in28 = '1'
0082001405220297 C     cmtky         reade     cmct14                                 28
008300140522      *
0084001405220296 C                   if        *in28 = '0' and cmdltd = 'A'
0085001405220297 C     plnky2        chain     plnmst                             29
0086001405220296 C                   if        *in29 = '0'
0087001405220296 C                   if        plncat = 'PMM' or plncat = 'PCM'
0088001405220296 C                   eval      mmpln = 'Y'
0089001405220296 C                   leave
0090001405220296 C                   endif
0091001405220296 C                   endif
0092001405220296 C                   endif
009300140522      *
0094001405220296 C                   enddo
009500140522      *
0096001405220296 C                   If        mmpln = 'Y'
009700140522      *
009800240319      *         No MM found for member - write HRCVDP rec
0099001405060107  *                                                                     ****
0100001504200296 C                   If        mctrust <> 591 and mcsub <> 12 and
0101001504200296 C                             mcacct <> 356 and mcpln <> 'LPL4'
0102001702130107  *                                                                     ****
010300240319     C                   clear                   HRCVDR
010400240326     C                   eval      hclnme = mclnme
010401240326     C                   eval      hcfnme = mcfnme
010403240326     C                   eval      hcmid# = mcmid#
010404240326     C                   eval      hctrust = mctrust
010500240326     C                   eval      hcsub = mcsub
010600240326     C                   eval      hcacct = mcacct
010601240326     C                   eval      hcacnm = mcacnm
010900240326     C                   eval      hcfpln = mcpln
011000240326     C                   eval      hcfcvt = mccovt
011100240326     C                   eval      hcfeff = mcefdt
011101240326     C                   eval      hcmpln = *blanks
011102240326     C                   eval      hcmcvt = *blanks
011103240326     C                   eval      hcmeff = 0
011300240326     C                   write     HRCVDR
011400240326      *
0115001405220296 C                   endif
011600140522      *
0117001504200296 C                   endif
011800150420      *
0119001405060296 C                   else
012000080721      *
0121001405060296 C                   if        mccovt <> covt2
012700240319      *         Cov Typ Mismatch - write HRCVDP rec
0128001405060107  *                                                                     ****
012900240319     C                   clear                   HRCVDR
012901240319     C                   eval      hclnme = mclnme
012902240319     C                   eval      hcfnme = mcfnme
012903240319     C                   eval      hcmid# = mcmid#
012904240319     C                   eval      hctrust = mctrust
012905240319     C                   eval      hcsub = mcsub
012906240319     C                   eval      hcacct = mcacct
012907240319     C                   eval      hcacnm = mcacnm
012908240319     C                   eval      hcfpln = mcpln
012909240319     C                   eval      hcfcvt = mccovt
012910240319     C                   eval      hcfeff = mcefdt
012911240319     C                   eval      hcmpln = mcplan
012912240319     C                   eval      hcmcvt = covt2
012913240319     C                   eval      hcmeff = enrldt
014200240319     C                   write     HRCVDR
014300140522      *
0144001405220296 C                   endif
015100140506      *
0152000910140296 C                   endif
015300140522      *
0154001405220296 C                   endif
0155001702130296 C                   endif
0156001405060296 C                   endif
0174001405290107  ********************************************************************************
0175001405290107  *
0176001405290107  *     INZSR - Preprocessing
0177001405290107  *
0178001405290107  ********************************************************************************
017900140529     C     *Inzsr        Begsr
018000140529    ***   Pre-processing
0181001405290297 C                   movel     UDATE         isotoday
0182001405290297 C                   movel     isotoday      today
018300140529     C                   Endsr
