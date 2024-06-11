000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Check for existance of WEBPAYROLL in DASHBOARD
000400000000      *
000500000000      *  (c)Copyright 2015 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 21, 2015
000800000000      *_________________________________________________________________________
000900170210     FWEBPAYROLLuF A E           K DISK    EXTFILE('RPGSPDASH/WEBPAYROLL')
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
004400170210
004500170210     C     paykey        chain     webpayroll
004600161111
004700170210     C                   if        not %found(webpayroll)
004800161111     C                   clear                   webpayr
004900170210     C                   end
005000170210
005100161111     C                   eval      pytrs = MBTRST
005200161111     C                   eval      pysub = MBSUB#
005300161111     C                   eval      pyact = MBACCT
005400161111     C                   eval      PYSSN = MBSSNO
005500161111     C                   Eval      PYFST = %trim(MFNAME)
005600161111     C                   Eval      PYLST = %trim(MLNAME)
005700161111     C                   Eval      PYMID = %trim(MMI)
005800161111     C                   Eval      PYAD1 = %trim(ADDR1)
005900161111     C                   Eval      PYAD2 = %trim(ADDR2)
006000161111     C                   Eval      PYCTY = %trim(CITY)
006100161111     C                   Eval      PYSTT = %trim(STATE)
006200161111
006300161111     C                   Eval      wzip = ZIP
006400161111     C                   Eval      wph3 = AREA
006500161111     C                   Eval      wph7 = PHONE
006600161111
006700161111     C                   Movel     wzip          PYZP5
006800161111     C                   Move      wzip          PYZP4
006900161111
007000161111     C                   Movel     wph3          pyph1
007100161111     C                   Movel     wph7          pyph2
007200161111     C                   Move      wph7          pyph3
007300161111     C                   Eval      PYHDT = EMPDT
007400161111     C                   Eval      PYGEN = SEX
007500161111     C                   Eval      PYCCC = *blanks
007600161111     C                   Eval      PYSTS = 'A'
007700161111     C                   Eval      PYPST = 'F'
007800161111     C                   Eval      PYBTH = BIRTH
007900161111     C                   Eval      PYEEO = 'N'
008000161111     C                   Eval      PYSMK = 'N'
008100161111     C                   Eval      PYOTF = 'N'
008200161111     C                   Eval      PYRPE = 'N'
008300161111     C                   Eval      PYRAC = 'N'
008400161111     C                   Eval      PYSALDT = PYHDT
008500161111     C                   Eval      PYBPCEF = PYHDT
008600161111     C                   Eval      PYADDUS = 'PWPAYROL4R'
008700161111     C     *DATE         Mult      10000.0001    PYADDDT
008800161111
008900161111     C                   if        pybpc = *blanks
009000161111     C                   eval      PCGRPR = 'RULE'
009100161111     C     paychp        chain     WEBPAYCHP
009200161111     C                   if        %found(WEBPAYCHP)
009300161111     C                   eval      PYBPC = %trim(PCCODE)
009400161111     C                   eval      PYBPCEF= %int(%char(%date : *iso0))
009500161111     C                   end
009600161111     C                   end
009700161111
009800161111     C                   exsr      getpayfrq
009900161111
010000170501     C                   if        salary < 100000000
010100161111     C                   eval      pyans = salary
010200170501     C                   eval      PYSALDT= PYHDT
010300170501     C                   end
010400150721
010500170210     C                   if        not %found(webpayroll)
010600161111     C                   write     webpayr
010700170210     C                   else
010800170210     C                   update    webpayr
010900170210     C                   end
011000150721
011100161111     C     trskey        reade     MEMACC
011200150721     C                   enddo
011300150721
011400150721     C                   Return
011500151203      *___________________________________________________________________
011600151203      * Get payfreq
011700151203      *___________________________________________________________________
011800151203     C     GETPAYFRQ     BEGSR
011900151203
012000151203     C                   If        PYPFQ = *blanks
012100151203     C                   eval      PCGRPR = 'PAYFRQ'
012200151203     C     paychp        chain     WEBPAYCHP
012300151203     C                   if        %found(WEBPAYCHP)
012400161110     C                   eval      PYPFQ = %trim(PCCODE)
012500151203     C                   else
012600151203     C                   eval      PCGRPR = 'PAYFREQ'
012700151203     C     paychp        chain     WEBPAYCHP
012800151203     C                   if        %found(WEBPAYCHP)
012900151203     C                   eval      PYPFQ = %trim(PCCODE)
013000151203     C                   end
013100151203     C                   end
013200151203     C                   end
013300151203
013400151203     C                   ENDSR
013500000000      *___________________________________________________________________
013600000000      * Program open
013700000000      *___________________________________________________________________
013800000000     C     *INZSR        BEGSR
013900150721
014000161111     C     trskey        Klist
014100150721     C                   kfld                    PYTRS
014200150721     C                   kfld                    PYSUB
014300150721     C                   kfld                    PYACT
014400161111
014500161111     C     paykey        Klist
014600161111     C                   kfld                    MBTRST
014700161111     C                   kfld                    MBSUB#
014800161111     C                   kfld                    MBACCT
014900161111     C                   kfld                    MBSSNO
015000151203
015100151203     C     paychp        Klist
015200161111     C                   kfld                    MBTRST
015300161111     C                   kfld                    MBSUB#
015400161111     C                   kfld                    MBACCT
015500151203     C                   kfld                    PCGRPR
015600150721
015700000000     C                   ENDSR
015800000000      *___________________________________________________________________
015900000000      * Program error handler
016000000000      *___________________________________________________________________
016100000000     C     *PSSR         BEGSR
016200000000     C                   CALL      'SNDRPGM'                            50
016300000000     C                   PARM                    WQPGMN
016400000000     C                   PARM                    WQSTSC
016500000000     C                   PARM                    WQRPGS
016600000000     C                   PARM                    WQMSG
016700000000     C                   ENDSR     '*CANCL'
