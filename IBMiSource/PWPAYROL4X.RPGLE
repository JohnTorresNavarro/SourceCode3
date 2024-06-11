000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800000000      *_________________________________________________________________________
000900161111     FWEBPAYROLLIF A E           K DISK    EXTFILE('RPGSPDASH/WEBPAYROLL')
001000151203     FACCMSP    UF   E           K DISK
001100161111     FMEMACC    IF   E           K DISK    EXTFILE('QS36F/F.MEMACC')
001200151203     FWEBPAYCHP IF   E           K DISK
001300150721
001400150721     d payfreq         s              2s 0 inz
001500161111
001600161111     D WZIP            s              9S 0 inz
001700161111     D WPH3            s              3S 0 inz
001800161111     D WPH7            s              7S 0 inz
001900150721
002000000000      * Program status data structure
002100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200150721
002300150721     C     *Entry        Plist
002400150721     C                   Parm                    TRS               3
002500150721     C                   Parm                    SUB               3
002600150721     C                   Parm                    ACC               4
002700150721
002800150721     C                   move      TRS           PYTRS
002900150721     C                   move      SUB           PYSUB
003000150721     C                   move      ACC           PYACT
003100150727
003200161111     C     trskey        chain     ACCMSP
003300150727     C                   if        %found(ACCMSP)
003400150727     C                   If        %trim(AMPAYR) = 'NPAY' or
003500150727     C                             %trim(AMPAYR) = 'PAYR'
003600150727     C                   eval      AMPAYR = *blanks
003700150727     C                   update    ACCMSPR
003800150727     C                   End
003900150727     C                   End
004000150721
004100161111     C     trskey        setll     MEMACC
004200161111     C     trskey        reade     MEMACC
004300161111     C                   dow       not %eof(memacc)
004400211006
004500211006     C                   if        mbssno <> 213130177
004600170222
004700170222     C                   if        termdt = 0
004800210824
004900210824     C     paykey        chain     webpayroll
005000210824     C                   if        not %found(webpayroll)
005100161111
005200161111     C                   clear                   webpayr
005300161111     C                   eval      pytrs = MBTRST
005400161111     C                   eval      pysub = MBSUB#
005500161111     C                   eval      pyact = MBACCT
005600161111     C                   eval      PYSSN = MBSSNO
005700161111     C                   Eval      PYFST = %trim(MFNAME)
005800161111     C                   Eval      PYLST = %trim(MLNAME)
005900161111     C                   Eval      PYMID = %trim(MMI)
006000161111     C                   Eval      PYAD1 = %trim(ADDR1)
006100161111     C                   Eval      PYAD2 = %trim(ADDR2)
006200161111     C                   Eval      PYCTY = %trim(CITY)
006300161111     C                   Eval      PYSTT = %trim(STATE)
006400161111
006500161111     C                   Eval      wzip = ZIP
006600161111     C                   Eval      wph3 = AREA
006700161111     C                   Eval      wph7 = PHONE
006800161111
006900161111     C                   Movel     wzip          PYZP5
007000161111     C                   Move      wzip          PYZP4
007100161111
007200161111     C                   Movel     wph3          pyph1
007300161111     C                   Movel     wph7          pyph2
007400161111     C                   Move      wph7          pyph3
007500161111     C                   Eval      PYHDT = EMPDT
007600161111     C                   Eval      PYGEN = SEX
007700161111     C                   Eval      PYCCC = *blanks
007800161111     C                   Eval      PYSTS = 'A'
007900161111     C                   Eval      PYPST = 'F'
008000161111     C                   Eval      PYBTH = BIRTH
008100161111     C                   Eval      PYEEO = 'N'
008200161111     C                   Eval      PYSMK = 'N'
008300161111     C                   Eval      PYOTF = 'N'
008400161111     C                   Eval      PYRPE = 'N'
008500161111     C                   Eval      PYRAC = 'N'
008600161111     C                   Eval      PYSALDT = PYHDT
008700161111     C                   Eval      PYBPCEF = PYHDT
008800161111     C                   Eval      PYADDUS = 'PWPAYROL4R'
008900161111     C     *DATE         Mult      10000.0001    PYADDDT
009000161111
009100161111     C                   if        pybpc = *blanks
009200161111     C                   eval      PCGRPR = 'RULE'
009300161111     C     paychp        chain     WEBPAYCHP
009400161111     C                   if        %found(WEBPAYCHP)
009500161111     C                   eval      PYBPC = %trim(PCCODE)
009600161111     C                   eval      PYBPCEF= %int(%char(%date : *iso0))
009700161111     C                   end
009800161111     C                   end
009900161111
010000161111     C                   exsr      getpayfrq
010100161111
010200221216           monitor;
010300221216           pyans = salary;
010400221216           PYSALDT= %int(%char(%date : *iso0));
010500221216           on-Error;
010600221216             pyans = 0;
010700221216             pysaldt = 0;
010800221216           EndMon;
010900150721
011000161111     C                   write     webpayr
011100170222
011200210824     C                   end
011300170222     C                   end
011400150721
011500211006     C                   end
011600211006
011700161111     C     trskey        reade     MEMACC
011800150721     C                   enddo
011900150721
012000150721     C                   Return
012100151203      *___________________________________________________________________
012200151203      * Get payfreq
012300151203      *___________________________________________________________________
012400151203     C     GETPAYFRQ     BEGSR
012500151203
012600151203     C                   If        PYPFQ = *blanks
012700151203     C                   eval      PCGRPR = 'PAYFRQ'
012800151203     C     paychp        chain     WEBPAYCHP
012900151203     C                   if        %found(WEBPAYCHP)
013000161110     C                   eval      PYPFQ = %trim(PCCODE)
013100151203     C                   else
013200151203     C                   eval      PCGRPR = 'PAYFREQ'
013300151203     C     paychp        chain     WEBPAYCHP
013400151203     C                   if        %found(WEBPAYCHP)
013500151203     C                   eval      PYPFQ = %trim(PCCODE)
013600151203     C                   end
013700151203     C                   end
013800151203     C                   end
013900151203
014000151203     C                   ENDSR
014100000000      *___________________________________________________________________
014200000000      * Program open
014300000000      *___________________________________________________________________
014400000000     C     *INZSR        BEGSR
014500150721
014600161111     C     trskey        Klist
014700150721     C                   kfld                    PYTRS
014800150721     C                   kfld                    PYSUB
014900150721     C                   kfld                    PYACT
015000161111
015100161111     C     paykey        Klist
015200161111     C                   kfld                    MBTRST
015300161111     C                   kfld                    MBSUB#
015400161111     C                   kfld                    MBACCT
015500161111     C                   kfld                    MBSSNO
015600151203
015700151203     C     paychp        Klist
015800161111     C                   kfld                    MBTRST
015900161111     C                   kfld                    MBSUB#
016000161111     C                   kfld                    MBACCT
016100151203     C                   kfld                    PCGRPR
016200150721
016300000000     C                   ENDSR
016400000000      *___________________________________________________________________
016500000000      * Program error handler
016600000000      *___________________________________________________________________
016700000000     C     *PSSR         BEGSR
016800000000     C                   CALL      'SNDRPGM'                            50
016900000000     C                   PARM                    WQPGMN
017000000000     C                   PARM                    WQSTSC
017100000000     C                   PARM                    WQRPGS
017200000000     C                   PARM                    WQMSG
017300000000     C                   ENDSR     '*CANCL'
