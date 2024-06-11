000100110119     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200110119     H option(*SRCSTMT: *NODEBUGIO)
000300110119
000400000000      *_________________________________________________________________________
000500140521     FMEMACC    IF   E           K DISK    extfile('F.MEMACC')
000600100930
000700100930      /COPY *LIBL/QMODSRC,#PROTO
000800100930
000900120412     D wwrtn           s              1a   inz
001000110119     D w80date         s              8s 0 inz
001100120412     D zippy           s              9s 0 inz
001200120412     D phonearea       s              3s 0 inz
001300120412     D phonehome       s              7s 0 inz
001400110119
001500120412     D webnon        e ds                  extname(webpaynonp)
001600140521
001700140521     C     *entry        plist
001800140521     C                   parm                    webnon
001900120412
002000140521     C                   EVAL      MBTRST = pytrs
002100140521     C                   EVAL      MBSUB# = pysub
002200140521     C                   EVAL      MBACCT = pyact
002300120412     C                   eval      w80date = *date
002400120412
002500120412     C     MEMKEY        SETLL     MEMACC
002600120412     C     MEMKEY        READE     MEMACC
002700120412     C                   DOW       not %eof(MEMACC)
002800140521
002900140521      * only poplate if missing
003000140521     C                   Eval      webnon = #nchain(mbtrst:mbsub#:mbacct:
003100140521     C                                              mbssno)
003200140521     C                   If        %trim(PYLST) = *blanks
003300140521
003400120412     C                   Clear                   WEBNON
003500120412     C                   Eval      PYTRS = mbtrst
003600120412     C                   Eval      PYSUB = mbsub#
003700120412     C                   Eval      PYACT = mbacct
003800120412     C                   Eval      PYSSN = mbssno
003900120412     C                   Eval      PYFST = %trim(MFNAME)
004000120412     C                   Eval      PYMID = %trim(MMI)
004100120412     C                   Eval      PYLST = %trim(MLNAME)
004200120412     C                   Eval      PYAD1 = %trim(ADDR1)
004300120412     C                   Eval      PYAD2 = %trim(ADDR2)
004400120412     C                   Eval      PYCTY = %trim(CITY)
004500120412     C                   Eval      PYSTT = %trim(STATE)
004600120412     C                   z-add     ZIP           Zippy
004700120412     C                   Movel     Zippy         PYZP5
004800120412     C                   Move      Zippy         PYZP4
004900120412     C                   Eval      PhoneArea = Area
005000120412     C                   Eval      PhoneHome = Phone
005100120412     C                   Movel     PhoneArea     PYPH1
005200120412     C                   Movel     PhoneHome     PYPH2
005300120412     C                   Move      PhoneHome     PYPH3
005400120412
005500120412     C                   Eval      PYGEN = SEX
005600120412     C     BIRTH         Mult      10000.0001    PYBTH
005700120412     C     MARDT         Mult      10000.0001    PYMAR
005800120412     C     EMPDT         Mult      10000.0001    PYHDT
005900120412     C                   Eval      PYHRS = 40
006000140521     C                   z-add     Salary        pySAL
006100120412     C                   Eval      PYSALDT = w80date
006200120412
006300120412     C                   Eval      wwrtn = #nwrite(webnon)
006400140521     C                   end
006500120412     C     MEMKEY        READE     MEMACC
006600120412     C                   ENDDO
006700120412
006800120412     C     MEMKEY        KLIST
006900120412     C                   KFLD                    MBTRST
007000120412     C                   KFLD                    MBSUB#
007100120412     C                   KFLD                    MBACCT
007200120412
007300070228     C                   eval      *inlr = *on
007400070228     C                   return
