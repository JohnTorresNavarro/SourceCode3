000100000000      *_________________________________________________________________________
000200000000      *
000300150227      *  Description:
000400000000      *
000500110525      *  (c)Copyright 2011 by GBS, Inc.
000600000000      *
000700110525      *    Created by:  JALLEN - May 25, 2011
000800000000      *_________________________________________________________________________
000900151016     FMEMACC    uf   E           K Disk    extfile('F.MEMACC')
001000151019     FWEBPAYROLLif A E           K Disk    EXTFILE('RPGSPDASH/WEBPAYROLL')
001100151019     FWEBPAYCHP If   E           K Disk
001200101217
001300110408     D Pos             s              3s 0 inz
001400110408     D Pos1            s              3s 0 inz
001500110408     D Pos2            s              3s 0 inz
001600111104     D left            s             13a   inz
001700101217     D right           s              2a   inz
001800101217     D zippy           s              9s 0 inz
001900101217     D phonearea       s              3s 0 inz
002000101217     D phonehome       s              7s 0 inz
002100110913     D hours           s              5s 0 inz
002200110913     D hrs$            s              5s 2 inz
002300121108     D rates           s              7s 0 inz
002400121108     D rate$           s              7s 2 inz
002500121108     D SalaryPP        s              9s 0 inz
002600101217     D Salary$         s             12s 2 inz
002700111104     D wksal           s             12s 3 inz
002800121108     D AnnualPP        s             11s 0 inz
002900121108     D Annual$         s             12s 2 inz
003000121108     D wkanl           s             12s 3 inz
003100110217     D Nine            s              9a   inz
003200110408     D S_SSN           s             12a   inz
003300110408     D KEYSSN          s              3a   inz
003400111104     D Two             s              2a   inz
003500110408     D TwoS            s              2s 0 inz
003600151016
003700151016     D w0trs           s              3s 0 inz
003800151016     D w0sub           s              3s 0 inz
003900151016     D w0act           s              4s 0 inz
004000151016
004100151016     D witrs           s              3a
004200151016     D wisub           s              3a
004300151016     D wiact           s              4a
004400170207
004500170207     C                   move      witrs         w0trs
004600170207     C                   move      wisub         w0sub
004700170207     C                   move      wiact         w0act
004800151016
004900151016     C     MBKEY         Setll     Memacc
005000151016     C     MBKEY         Reade     Memacc
005100151016     C                   dow       not %eof(Memacc)
005200160329     C                   If        TERMDT = 0
005300151016
005400151016     C     PYKEY         Chain     webpayROLL
005500151016     C                   if        not %found(webpayroll)
005600151016
005700151019     C                   eval      pytrs = w0trs
005800151019     C                   eval      pysub = w0sub
005900151019     C                   eval      pyact = w0act
006000151019     C                   eval      pyssn = mbssno
006100151016     C                   Eval      PYFST = %trim(MFNAME)
006200151016     C                   Eval      PYLST = %trim(MLNAME)
006300151016     C                   Eval      PYMID = %trim(MMI)
006400151016     C                   Eval      PYAD1 = %trim(ADDR1)
006500151016     C                   Eval      PYAD2 = %trim(ADDR2)
006600151016     C                   Eval      PYCTY = %trim(CITY)
006700151016     C                   Eval      PYSTT = %trim(STATE)
006800151016     C                   Movel     Zip           PYZP5
006900151016     C                   Move      Zip           PYZP4
007000151016     C                   eval      pyph1 = %char(area)
007100151030     C                   if        phone <> 0
007200151016     C                   eval      pyph2 = %subst(%char(phone):1:3)
007300151016     C                   eval      pyph3 = %subst(%char(phone):1:4)
007400151030     C                   End
007500151016     C                   If        PYPH1 = '000'
007600151016     C                   Eval      PYPH1 = '000'
007700151016     C                   Eval      PYPH2 = '000'
007800151016     C                   Eval      PYPH3 = '0000'
007900151016     C                   End
008000151016
008100151016     C                   Eval      PYBTH = BIRTH
008200151016     C                   Eval      PYHDT = EMPDT
008300151016     C                   Eval      PYMAR = MARDT
008400151016     C                   If        MARDT <> 0
008500151016     C                   eval      PYMGS = 'M'
008600151016     C                   else
008700151016     C                   eval      PYMGS = 'S'
008800151016     C                   end
008900151019     C                   Eval      PYGEN = %trim(SEX)
009000151019     C                   Eval      PYCCC = %trim(CCFLG)
009100151016     C                   Eval      PYSTS = 'A'
009200151019     C                   Eval      PYRAC = 'N'
009300151019     C                   Eval      PYSMK = 'N'
009400151016     C                   Eval      PYSALDT = PYHDT
009500151019     C                   Eval      PYBPCEF = PYHDT
009600161005      * bug - PYANS is too small to hold million or more
009700161005     C                   if        SALARY < 100000000
009800151019     C                   Eval      PYANS   = SALARY
009900161005     C                   end
010000151016
010100151016     C                   eval      pcgrpr = 'RULE'
010200151016     C     PYCHP         Chain     webpaychp
010300151016     C                   If        %found(webpaychp)
010400151016     C                   Eval      PYBPC = %trim(PCCODE)
010500151016     C                   end
010600151016
010700151016     C                   eval      pcgrpr = 'PAYFRQ'
010800151016     C     PYCHP         Chain     webpaychp
010900151016     C                   If        %found(webpaychp)
011000151016     C                   Eval      PYPFQ = %trim(PCCODE)
011100151016     C                   else
011200151016     C                   eval      pcgrpr = 'PAYFREQ'
011300151016     C     PYCHP         Chain     webpaychp
011400151016     C                   If        %found(webpaychp)
011500151016     C                   Eval      PYPFQ = %trim(PCCODE)
011600151016     C                   end
011700151016     C                   end
011800151016
011900151016     C                   Eval      PYADDUS = 'BLDDASHR'
012000151016     C     *DATE         Mult      10000.0001    PYADDDT
012100151016     C                   Time                    PYADDTM
012200151016     C                   write     webpayr
012300151016     C                   clear                   webpayr
012400160329     C                   end
012500151016     C                   end
012600151016     C     MBKEY         Reade     Memacc
012700151016     C                   enddo
012800151016
012900151016     C                   return
013000151016      *-------------------------------------------------------------------*
013100151016     C     *inzsr        Begsr
013200151016      *-------------------------------------------------------------------*
013300151016     C     *Entry        Plist
013400151016     C                   Parm                    WiTRS
013500151016     C                   Parm                    WiSUB
013600151016     C                   Parm                    WiACT
013700151016
013800151016     C     MBKEY         Klist
013900151016     C                   Kfld                    w0TRS
014000151016     C                   Kfld                    w0SUB
014100151016     C                   Kfld                    w0ACT
014200151016
014300151016     C     PYKEY         Klist
014400151016     C                   Kfld                    w0TRS
014500151016     C                   Kfld                    w0SUB
014600151016     C                   Kfld                    w0ACT
014700151016     C                   Kfld                    mbssno
014800151016
014900151016     C     PYCHP         Klist
015000151016     C                   Kfld                    PYTRS
015100151016     C                   Kfld                    PYSUB
015200151016     C                   Kfld                    PYACT
015300151016     C                   Kfld                    PCGRPR
015400151016     C                   Endsr
