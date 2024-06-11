000200000000      *_________________________________________________________________________
000300000000      *
000400120320      *  Description:  Load Payroll screen 2
000401120320      *
000402120320      *   NOTES:
000404120320      *    1.  To test, crtdupobj WEBPAYROLL into your lib and put at top
000405120320      *        of your library list.  If all looks good, run in PAYR.
000407120320      *    2.  Hard coded TSA is located in two place, change both.
000408120320      *    3.  GUMPRAW DDS is located in GBSPGM/QDDSSRC
000409120320      *    4.  See ASK SHELLY questions in program below.
000500000000      *
000600120320      *  (c)Copyright 2012 by GBS, Inc.
000700000000      *
000800120320      *    Created by:  JALLEN - Jan 27, 2012
000900000000      *_________________________________________________________________________
000901120531     FHAIRAW    IP   E             Disk
001000120531     FWEBPAYROLLUF   E           K Disk
001001101217
001003110408     D Pos             s              3s 0 inz
001004110408     D Pos1            s              3s 0 inz
001005110408     D Pos2            s              3s 0 inz
001006111104     D left            s             13a   inz
001007101217     D right           s              2a   inz
001008101217     D zippy           s              9s 0 inz
001009101217     D phonearea       s              3s 0 inz
001010101217     D phonehome       s              7s 0 inz
001011110913     D hours           s              5s 0 inz
001012110913     D hrs$            s              5s 2 inz
001013110913     D rates           s              9s 0 inz
001014110913     D rate$           s              9s 2 inz
001015110525     D SalaryPP        s             11s 0 inz
001016101217     D Salary$         s             12s 2 inz
001017111104     D wksal           s             12s 3 inz
001018110217     D Nine            s              9a   inz
001019120531     D SSID            s             15s 0 inz(590007002400000)
001020120531     D DPT             s              1a   inz
001021110408     D S_SSN           s             12a   inz
001022110408     D KEYSSN          s              3a   inz
001023111104     D Two             s              2a   inz
001024120210     D TwoS            s              2s 0 inz
001025120210     D whrs            s              2s 0 inz
001026120111
001027120531     D webpay        e ds                  extname(webpayroll)
001028101217
001031120320      *********** Change TSA
001032120224     C                   Eval      PYTRS = 590
001033120531     C                   Eval      PYSUB = 007
001034120531     C                   Eval      PYACT = 0024
001035110408
001036110408     C                   Eval      S_SSN = %trim(SSN)
001037110408     C                   Eval      Pos1 = %Scan('-':S_SSN)
001038110408     C                   If        Pos1 > 0
001039110408     C                   Eval      Nine  = %subst(S_SSN:1:3)
001040110408     C                   Eval      S_SSN = %replace(' ':S_SSN:Pos1)
001041110408     C                   End
001042110408     C                   Eval      Pos2 = %Scan('-':S_SSN)
001043110408     C                   If        Pos2 > 0
001044110408     C                   Eval      Nine  = %trim(Nine) +
001045110408     C                             %subst(S_SSN:pos1+1:2) +
001046110408     C                             %subst(S_SSN:pos2+1)
001047110408     C                   End
001048110408     C                   Move      Nine          PYSSN
001049110913
001050110913     C     PYKEY         Klist
001051110913     C                   Kfld                    PYTRS
001052110913     C                   Kfld                    PYSUB
001053110913     C                   Kfld                    PYACT
001054110913     C                   Kfld                    PYSSN
001055110913
001056120531     C     PYKEY         Chain     WEBPAYROLL
001057120531     C                   if        %found(WEBPAYROLL)
001086120531     C                   Eval      PYCLK = %trim(EM#)
001087120531     C                   Eval      PYEMP = *blanks
001502111104     C                   Update    WEBPAYR
001503120531     C                   End
001508111104
001600101217    ? *___________________________________________________________________
001700101217    ? * format Date edit
001800101217    ? *___________________________________________________________________
001900101217    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
001901101217     C                   movel     'MM/DD/YY'    Input_Format
002000101217     C                   movel     'YYYYMMDD'    Output_Format
002100101217     C                   Call      'FMTDATE'
002200101217     C                   Parm                    Input_Date       32
002300101217     C                   Parm                    Input_Format     32
002400101217     C                   Parm                    Output_Format    32
002500101217     C                   Parm                    Output_Date      32
002600101217     C                   Parm                    Output_Error     10
002700101217    ?C                   Endsr                                                  END DLT RQST
