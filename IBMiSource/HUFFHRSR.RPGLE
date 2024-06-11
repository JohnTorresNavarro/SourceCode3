000200000000      *_________________________________________________________________________
000300000000      *
000400111227      *  Description:  BROOKS HUFF Payroll screen 2
000500000000      *
000600110525      *  (c)Copyright 2011 by GBS, Inc.
000700000000      *
000800111227      *    Created by:  JALLEN - Dec 27, 2011
000900000000      *_________________________________________________________________________
000901120210     FHUFFRAW1  IP   E             Disk
001000111104     FWEBPAYROLLUF A E           K Disk
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
001019110912     D SSID            s             15s 0 inz(590012001600000)
001020110408     D S_SSN           s             12a   inz
001021110408     D KEYSSN          s              3a   inz
001022111104     D Two             s              2a   inz
001023110408     D TwoS            s              2s 0 inz
001024120210     D whrs            s              2s 0 inz
001025120111
001026120111     D webpay        e ds                  extname(webpayroll)
001027101217
001028111227     C                   Eval      PYTRS = 591
001029111227     C                   Eval      PYSUB = 011
001030111227     C                   Eval      PYACT = 0335
001031110408
001032110408     C                   Eval      S_SSN = %trim(SSN)
001033110408     C                   Eval      Pos1 = %Scan('-':S_SSN)
001034110408     C                   If        Pos1 > 0
001035110408     C                   Eval      Nine  = %subst(S_SSN:1:3)
001036110408     C                   Eval      S_SSN = %replace(' ':S_SSN:Pos1)
001037110408     C                   End
001038110408     C                   Eval      Pos2 = %Scan('-':S_SSN)
001039110408     C                   If        Pos2 > 0
001040110408     C                   Eval      Nine  = %trim(Nine) +
001041110408     C                             %subst(S_SSN:pos1+1:2) +
001042110408     C                             %subst(S_SSN:pos2+1)
001043110408     C                   End
001044110408     C                   Move      Nine          PYSSN
001045110913
001046110913     C     PYKEY         Klist
001047110913     C                   Kfld                    PYTRS
001048110913     C                   Kfld                    PYSUB
001049110913     C                   Kfld                    PYACT
001050110913     C                   Kfld                    PYSSN
001051110913
001052110913     C     PYKEY         Chain     WEBPAYROLL
001053120209     C                   if        %found(WEBPAYROLL)
001054111104
001055120210     C                   movel     HRS           whrs
001056120210     C                   z-add     WHRS          pyhrs
001270110420
001502111104     C                   Update    WEBPAYR
001503111104     C                   End
001510110913
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
