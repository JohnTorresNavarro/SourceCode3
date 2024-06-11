000100000000      *_________________________________________________________________________
000200000000      *
000300091202      *  Description:  Create DT/MT DA/MA records for TR050 MD records
000400000000      *
000500000000      *  (c)Copyright 2009 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - December 02, 2009
000800000000      *_________________________________________________________________________
000900091202     FDW310JF   IP   E           K DISK    Infds(DBFD)
001000091202     FTRNMIT    UF A E             DISK    Rename(TRNMIR:TRNOUT)
001100091202     FDEPNDC    IF   E           K DISK
001200091202     FDCOVC     IF   E           K DISK
001300091202     FMCOVC     IF   E           K DISK    prefix(M_)
001400091202
001500091203     D OLDP#           S              4A   INZ
001600091203     D NEWP#           S              4A   INZ
001700091203     D EFFDT           S              8S 0 INZ
001800091202
001900000000      * Program status data structure
002000091202     D DBFD          E DS                  EXTNAME(IODBFD)
002100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200091202
002300091202      *
002400091202     IJOINR         01
002500091202
002600091202      *
002700091202     C   01              EXSR      PROCESS
002800091202      *___________________________________________________________________
002900091202     C     PROCESS       BEGSR
003000091202      *___________________________________________________________________
003100091202      * Driver: If TR050 and "MD" then we need the following:
003200091202      *      MA change trnmit from MD to MA.
003300091202      *      MT add member term coverage.
003400091202      *      DA add dependents new coverage.
003500091202      *      DT add dependents termed coverage.
003600091202
003700091203      * Set NEW/OLD Plan
003800091203     C                   EVAL      NEWP# = PLAN#
003900091202     C                   EVAL      OLDP# = OLDT79
004000091202     C                   EVAL      M_MDSEQ# = *ZEROS
004100091203     C                   EVAL      EFFDT = ENRLDT
004200091202      *
004300091202      * Create Member MT for OLD Plan
004400091202     C     KEYMEM        SETGT     MCOVC
004500091202     C     KEYMEM        READPE    MCOVC
004600091202     C                   DOW       not %eof(MCOVC)
004700091202     C                   IF        M_CANDT = ENRLDT
004800091202     C                   Eval      ACTCOD = 'MT'
004900091202     C                   Eval      ENRLDT = M_ENRLDT
005000091202     C                   Eval      CANCDT = M_CANDT
005100091202     C                   Eval      PLAN# = M_MCPLAN
005200091217     C                   Eval      QQPGNM = 'DW311T51R'
005300091217     C                   Eval      TRNSRC = '1T51R'
005400091202     C                   Write     TRNOUT
005500091202     C                   Leave
005600091202     C                   END
005700091202     C     KEYMEM        READPE    MCOVC
005800091202     C                   ENDDO
005900091202      *
006000091202      * Create Dep DT for OLD Plan
006100091202     C     SOCSOC        SETGT     DEPNDC
006200091202     C     SOCSOC        READPE    DEPNDC
006300091202     C                   DOW       not %eof(DEPNDC)
006400091202      *
006500091202     C     KEYDEPO       SETGT     DCOVC
006600091202     C     KEYDEPO       READPE    DCOVC
006700091202     C                   DOW       not %eof(DCOVC)
006800091202     C                   IF        CANCDT = CCANDT
006900091202     C     KEYDEPD       CHAIN     DEPNDC
007000091202     C                   Eval      ACTCOD = 'DT'
007100091202     C                   Move      DPSEQ#        DEPSEQ
007200091202     C                   Eval      DENRLD = DENRDT
007300091202     C                   Eval      DCANDT = CCANDT
007400091202     C                   Eval      DPLAN# = DVPLAN
007500091217     C                   Eval      QQPGNM = 'DW311T51R'
007600091217     C                   Eval      TRNSRC = '1T51R'
007700091202     C                   Write     TRNOUT
007800091202     C                   Leave
007900091202     C                   END
008000091202     C     KEYDEPO       READPE    DCOVC
008100091202     C                   ENDDO
008200091202      *
008300091202     C     SOCSOC        READPE    DEPNDC
008400091202     C                   ENDDO
008500091202      *
008600091202      * Create Dep DA for NEW Plan
008700091202     C     SOCSOC        SETGT     DEPNDC
008800091202     C     SOCSOC        READPE    DEPNDC
008900091202     C                   DOW       not %eof(DEPNDC)
009000091202      *
009100091202     C     KEYDEP        SETGT     DCOVC
009200091202     C     KEYDEP        READPE    DCOVC
009300091202     C                   DOW       not %eof(DCOVC)
009400091203     C                   IF        EFFDT  = DENRDT
009500091202     C     KEYDEPD       CHAIN     DEPNDC
009600091202     C                   Eval      ACTCOD = 'DA'
009700091202     C                   Move      DPSEQ#        DEPSEQ
009800091202     C                   Eval      DENRLD = DENRDT
009900091202     C                   Eval      DCANDT = CCANDT
010000091203     C                   Eval      DPLAN# = DVPLAN
010100091203     C                   Eval      PLAN#  = DVPLAN
010200091217     C                   Eval      QQPGNM = 'DW311T51R'
010300091217     C                   Eval      TRNSRC = '1T51R'
010400091202     C                   Write     TRNOUT
010500091202     C                   Leave
010600091202     C                   END
010700091202     C     KEYDEP        READPE    DCOVC
010800091202     C                   ENDDO
010900091202      *
011000091202     C     SOCSOC        READPE    DEPNDC
011100091202     C                   ENDDO
011200091202      *
011300091202      * Last, UPDATE MD to MA.
011400091202     C     WQRELR        Chain     TRNMIT
011500091202     C                   If        %found(TRNMIT)
011600091202     C                   If        ACTCOD = 'MD'
011700091202     C                   Eval      ACTCOD = 'MA'
011800091217     C                   Eval      QQPGNM = 'DW311T51R'
011900091202     C                   Update    TRNOUT
012000091202     C                   End
012100091202     C                   End
012200091202      *
012300091202     C                   ENDSR
012400000000      *___________________________________________________________________
012500000000      * Key Lists
012600000000      *___________________________________________________________________
012700000000     C     KLIST         BEGSR
012800091202     C     KEYMEM        KLIST
012900091202     C                   KFLD                    SOCSOC
013000091202     C                   KFLD                    M_MDSEQ#
013100091202     C                   KFLD                    TRUST
013200091202     C                   KFLD                    SUBNO
013300091202     C                   KFLD                    OLDP#
013400091202     C     KEYDEPO       KLIST
013500091202     C                   KFLD                    DSSNO
013600091202     C                   KFLD                    DPSEQ#
013700091202     C                   KFLD                    TRUST
013800091202     C                   KFLD                    SUBNO
013900091202     C                   KFLD                    OLDP#
014000091202     C     KEYDEP        KLIST
014100091202     C                   KFLD                    DSSNO
014200091202     C                   KFLD                    DPSEQ#
014300091202     C                   KFLD                    TRUST
014400091202     C                   KFLD                    SUBNO
014500091203     C                   KFLD                    NEWP#
014600091202     C     KEYDEPD       KLIST
014700091202     C                   KFLD                    DSSNO
014800091202     C                   KFLD                    DPSEQ#
014900000000     C                   ENDSR
015000000000      *___________________________________________________________________
015100000000      * Program open
015200000000      *___________________________________________________________________
015300000000     C     *INZSR        BEGSR
015400000000     C                   ENDSR
