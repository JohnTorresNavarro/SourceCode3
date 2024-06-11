000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800221216      *
000900221216      *    12.16.2022  JVA Monitor for Salary
001000000000      *_________________________________________________________________________
001100161111     FWEBPAYROLLIF A E           K DISK    EXTFILE('RPGSPDASH/WEBPAYROLL')
001200151203     FACCMSP    UF   E           K DISK
001300161111     FMEMACC    IF   E           K DISK    EXTFILE('QS36F/F.MEMACC')
001400151203     FWEBPAYCHP IF   E           K DISK
001500150721
001600150721     d payfreq         s              2s 0 inz
001700161111
001800161111     D WZIP            s              9S 0 inz
001900161111     D WPH3            s              3S 0 inz
002000161111     D WPH7            s              7S 0 inz
002100150721
002200000000      * Program status data structure
002300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002400150721
002500150721     C     *Entry        Plist
002600150721     C                   Parm                    TRS               3
002700150721     C                   Parm                    SUB               3
002800150721     C                   Parm                    ACC               4
002900150721
003000150721     C                   move      TRS           PYTRS
003100150721     C                   move      SUB           PYSUB
003200150721     C                   move      ACC           PYACT
003300150727
003400161111     C     trskey        chain     ACCMSP
003500150727     C                   if        %found(ACCMSP)
003600150727     C                   If        %trim(AMPAYR) = 'NPAY' or
003700150727     C                             %trim(AMPAYR) = 'PAYR'
003800150727     C                   eval      AMPAYR = *blanks
003900150727     C                   update    ACCMSPR
004000150727     C                   End
004100150727     C                   End
004200150721
004300161111     C     trskey        setll     MEMACC
004400161111     C     trskey        reade     MEMACC
004500161111     C                   dow       not %eof(memacc)
004600170222
004700170222     C                   if        termdt = 0
004800161111
004900161111     C                   clear                   webpayr
005000161111     C                   eval      pytrs = MBTRST
005100161111     C                   eval      pysub = MBSUB#
005200161111     C                   eval      pyact = MBACCT
005300161111     C                   eval      PYSSN = MBSSNO
005400161111     C                   Eval      PYFST = %trim(MFNAME)
005500161111     C                   Eval      PYLST = %trim(MLNAME)
005600161111     C                   Eval      PYMID = %trim(MMI)
005700161111     C                   Eval      PYAD1 = %trim(ADDR1)
005800161111     C                   Eval      PYAD2 = %trim(ADDR2)
005900161111     C                   Eval      PYCTY = %trim(CITY)
006000161111     C                   Eval      PYSTT = %trim(STATE)
006100161111
006200161111     C                   Eval      wzip = ZIP
006300161111     C                   Eval      wph3 = AREA
006400161111     C                   Eval      wph7 = PHONE
006500161111
006600161111     C                   Movel     wzip          PYZP5
006700161111     C                   Move      wzip          PYZP4
006800161111
006900161111     C                   Movel     wph3          pyph1
007000161111     C                   Movel     wph7          pyph2
007100161111     C                   Move      wph7          pyph3
007200161111     C                   Eval      PYHDT = EMPDT
007300161111     C                   Eval      PYGEN = SEX
007400161111     C                   Eval      PYCCC = *blanks
007500161111     C                   Eval      PYSTS = 'A'
007600161111     C                   Eval      PYPST = 'F'
007700161111     C                   Eval      PYBTH = BIRTH
007800161111     C                   Eval      PYEEO = 'N'
007900161111     C                   Eval      PYSMK = 'N'
008000161111     C                   Eval      PYOTF = 'N'
008100161111     C                   Eval      PYRPE = 'N'
008200161111     C                   Eval      PYRAC = 'N'
008300161111     C                   Eval      PYSALDT = PYHDT
008400161111     C                   Eval      PYBPCEF = PYHDT
008500161111     C                   Eval      PYADDUS = 'PWPAYROL4R'
008600161111     C     *DATE         Mult      10000.0001    PYADDDT
008700161111
008800161111     C                   if        pybpc = *blanks
008900161111     C                   eval      PCGRPR = 'RULE'
009000161111     C     paychp        chain     WEBPAYCHP
009100161111     C                   if        %found(WEBPAYCHP)
009200161111     C                   eval      PYBPC = %trim(PCCODE)
009300161111     C                   eval      PYBPCEF= %int(%char(%date : *iso0))
009400161111     C                   end
009500161111     C                   end
009600161111
009700161111     C                   exsr      getpayfrq
009800161111
009900221216           monitor;
010000221216           pyans = salary;
010100221216           PYSALDT= %int(%char(%date : *iso0));
010200221216           on-Error;
010300221216             pyans = 0;
010400221216             pysaldt = 0;
010500221216           EndMon;
010600221216
010700150721
010800230606           monitor;
010900161111     C                   write     webpayr
011000230606           on-Error;
011100230606           // skip it
011200230606           EndMon;
011300170222
011400170222     C                   end
011500150721
011600161111     C     trskey        reade     MEMACC
011700150721     C                   enddo
011800150721
011900150721     C                   Return
012000151203      *___________________________________________________________________
012100151203      * Get payfreq
012200151203      *___________________________________________________________________
012300151203     C     GETPAYFRQ     BEGSR
012400151203
012500151203     C                   If        PYPFQ = *blanks
012600151203     C                   eval      PCGRPR = 'PAYFRQ'
012700151203     C     paychp        chain     WEBPAYCHP
012800151203     C                   if        %found(WEBPAYCHP)
012900161110     C                   eval      PYPFQ = %trim(PCCODE)
013000151203     C                   else
013100151203     C                   eval      PCGRPR = 'PAYFREQ'
013200151203     C     paychp        chain     WEBPAYCHP
013300151203     C                   if        %found(WEBPAYCHP)
013400151203     C                   eval      PYPFQ = %trim(PCCODE)
013500151203     C                   end
013600151203     C                   end
013700151203     C                   end
013800151203
013900151203     C                   ENDSR
014000000000      *___________________________________________________________________
014100000000      * Program open
014200000000      *___________________________________________________________________
014300000000     C     *INZSR        BEGSR
014400150721
014500161111     C     trskey        Klist
014600150721     C                   kfld                    PYTRS
014700150721     C                   kfld                    PYSUB
014800150721     C                   kfld                    PYACT
014900161111
015000161111     C     paykey        Klist
015100161111     C                   kfld                    MBTRST
015200161111     C                   kfld                    MBSUB#
015300161111     C                   kfld                    MBACCT
015400161111     C                   kfld                    MBSSNO
015500151203
015600151203     C     paychp        Klist
015700161111     C                   kfld                    MBTRST
015800161111     C                   kfld                    MBSUB#
015900161111     C                   kfld                    MBACCT
016000151203     C                   kfld                    PCGRPR
016100150721
016200000000     C                   ENDSR
016300000000      *___________________________________________________________________
016400000000      * Program error handler
016500000000      *___________________________________________________________________
016600000000     C     *PSSR         BEGSR
016700000000     C                   CALL      'SNDRPGM'                            50
016800000000     C                   PARM                    WQPGMN
016900000000     C                   PARM                    WQSTSC
017000000000     C                   PARM                    WQRPGS
017100000000     C                   PARM                    WQMSG
017200000000     C                   ENDSR     '*CANCL'
