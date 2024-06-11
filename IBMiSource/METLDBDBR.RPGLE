0001000204020002  *****************************************************************************
000200190509      * METLDBDBR  Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400190509      *            DATE - 05/2019                                                 *
000500190509      *  DESCRIPTION - Build Base file for Met Life Death Match Process           *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900191002      *  mm.dd.yyyy xxx
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012001905090020 Fmetl04p   IF   E           K DISK
0013001905090020 F***** metl102p  IF   E           K DISK
0014001905090020 Fmetldthp  O    E             DISK
0015000204020029  *
0016000610240029  *
0017000610240250 D                 DS
0018001906130251 D  curkey                 1     39
0019001906250251 D    svssn                1      9S 0 INZ(0)
0020001906250251 D    svtyp               10     39    INZ(*blanks)
0021001906130029  *
0022001906130250 D                 DS
0023001906130251 D  inkey                  1     39
0024001906130251 D    mbssno               1      9S 0
0025001906130251 D    ldescr              10     39
0026001906130029  *
0027001906130250 D                 DS
0028001906130251 D  gbsdat                 1      8
0029001906130251 D    gbyy                 1      4
0030001906130251 D    gbmm                 5      6
0031001905090251 D    gbdd                 7      8
0032001905090029  *
0033001905090250 D                 DS
0034001905090251 D  metdat                 1     10
0035001905090251 D    mlyy                 1      4
0036001905090251 D    mld1                 5      5    INZ('-')
0037001905090251 D    mlmm                 6      7
0038001905090251 D    mld2                 8      8    INZ('-')
0039001905090251 D    mldd                 9     10
0040001905090029  *
0041001905090250 D                 DS
0042001905090251 D  zip                    1      9  0
0043001905090251 D    zip5                 1      5
0044001905090251 D    zip4                 6      9
0045001905090029  *
0046001905090250 D                 DS
0047001905090251 D  phon10                 1     10
0048001905090251 D   area                  1      3  0
0049001905090251 D   phone                 4     10  0
005000020517      *
005100020503      ******************************************************************************
005200020517      *      MainLine
0053001310290107  *
005400061024     C                   dou       *in23 = '1'
005500190509     C                   read      metl04p                                23
005600190611     C                   if        *in23 = '0'
0057001906110107  *
005800190625     C                   if        enrldt = candt
005900190625     C                   iter
006000190625     C                   endif
0061001906250107  *
006200190625     C                   if        curkey = inkey
0063001906250107  *
006400190625     C                   if        enrldt < mdpefn
006500190625     C                   eval      mdpefn = enrldt
006600190625     C                   endif
006700190625     C                   iter
006800190625     C                   else
0069001906250107  *
007000190625     C                   eval      curkey = inkey
0071001906250107  *
007200190625     C                   if        mdssn <> *blanks
0073001906250107  *        Write Record
007400190625     C                   movel     mdpefn        gbsdat
007500190627     C                   eval      mlyy = gbyy
007600190627     C                   eval      mlmm = gbmm
007700190625     C                   eval      mldd = gbdd
007800190627     C                   eval      mdpefd = metdat
0079001906270107  *
008000190627     C                   if        mdptmn = 0
008100190627     C                   eval      mdptmd = *blanks
008200190627     C                   else
0083001906270107  *
008400190627     C                   movel     mdptmn        gbsdat
008500190627     C                   eval      mlyy = gbyy
008600190627     C                   eval      mlmm = gbmm
008700190627     C                   eval      mldd = gbdd
008800190627     C                   eval      mdptmd = metdat
008900190627     C                   endif
0090001906270107  *
009100190625     C                   write     metldthr
009200190625     C                   endif
0093001906250107  *
009400190509     C                   clear                   metldthr
009500190509     C                   eval      mdsys = 'GBS'
009600190509     C                   movel     mbssno        mdssn
0097001905090107  *
009800190522     C                   eval      mdsex = 'MALE    '
009900190522     C                   if        sex = 'F'
010000190522     C                   eval      mdsex = 'FEMALE  '
010100190522     C                   endif
0102001905220107  *
010300190523     C                   movel     birth         gbsdat
010400190523     C                   eval      mlyy = gbyy
010500190523     C                   eval      mlmm = gbmm
010600190523     C                   eval      mldd = gbdd
010700190523     C                   eval      mddob = metdat
0108001905230107  *
010900190509     C                   eval      mdfnam = mfname
011000190509     C                   eval      mdlnam = mlname
011100190509     C                   eval      mdadr1 = addr1
011200190509     C                   eval      mdadr2 = addr2
011300190509     C                   eval      mdcity = city
011400190509     C                   eval      mdst = state
011500190509     C                   eval      mdzip = zip5
011600190509     C                   eval      mdzip4 = zip4
011700190509     C                   if        phone <> 0
011800190509     C                   eval      mdphon = phon10
011900190509     C                   endif
012000190509     C                   eval      mdplan = mcplan
012100190509     C                   eval      mdpltp = ldescr
0122001905090107  *
012300190625     C                   eval      mdpefn = enrldt
012400190625     C                   eval      mdptmn = candt
0125001906250107  *
012600020517     C                   endif
0127001906250107  *
012800190625     C                   endif
0129000205170111  *
013000190509     C                   enddo
013100190625      *     Write last record
0132001906250107  *
013300190625     C                   if        mdssn <> *blanks
0134001908080107  *        Write Record
013500190808     C                   movel     mdpefn        gbsdat
013600191004     C                   eval      mlyy = gbyy
013700191004     C                   eval      mlmm = gbmm
013800191004     C                   eval      mldd = gbdd
013900191004     C                   eval      mdpefd = metdat
0140001910040107  *
014100191004     C                   if        mdptmn = 0
014200191004     C                   eval      mdptmd = *blanks
014300191004     C                   else
0144001910040107  *
014500191004     C                   movel     mdptmn        gbsdat
014600191004     C                   eval      mlyy = gbyy
014700191004     C                   eval      mlmm = gbmm
014800191004     C                   eval      mldd = gbdd
014900191004     C                   eval      mdptmd = metdat
015000190625     C                   endif
0151001906250107  *
015200190625     C                   write     metldthr
015300190625     C                   endif
0154001906250107  *
015500190509     C                   movel     '1'           *inlr
015600190509     C                   return
