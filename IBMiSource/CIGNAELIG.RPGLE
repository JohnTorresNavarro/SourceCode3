000100120419     **** CIGNA FORMAT ELIGIBILITY EXPORT INTO THEIR CSV
000200120419     **** SSK
000300120419     **** 04/19/2012 REQUEST FROM STACEY HELBIG FOR THIS DATA FOR
000400120419     ****              FREEDOM FEDERAL CREDIT UNION
000500120419     ****
000600120419     ****
000700120419     ****
000800120419     ****
000900120419     ****
001000120419     ****
001100120419     FMEMAC#    IF   E           K DISK
001200120419     FDEPNDC    IF   E           K DISK
001300120419     FT2000     O  A F 2000        DISK
001400120419     ****
001500120419     **** CONTROL VALUES
001600120419     D KF@TRS          S                   LIKE(MBTRST) INZ(591)
001700120419     D KF@SUB          S                   LIKE(MBSUB#) INZ(005)
001800120419     D KF@ACC          S                   LIKE(MBACCT) INZ(0273)
001900120419    ***
002000120419     D @X              S           2000A   INZ
002100120419    ***
002200120419     D KF@SSN          S                   LIKE(MBSSNO) INZ
002300120419     D @EMP            S             10A
002400120419     D @DOB            S             10A
002500120419     D #ISO            S               D   DATFMT(*ISO)
002600120419     D #XSX            S              8S 0
002700120419     D #9              S              9S 0
002800120419     D @ZIP            S              9A
002900120419     ****
003000120419     ****
003100120419     ****
003200120419     C     KL#TSA        SETLL     MEMBR
003300120419     C                   DOU       %EOF(MEMAC#)
003400120419     C     KL#TSA        READE     MEMBR
003500120419     C                   IF        NOT %EOF(MEMAC#) AND
003600120419     C                             TERMDT = 0
003700120419    ***
003800120419     C                   EXSR      $WRTMBR
003900120419    ***
004000120419     C     MBSSNO        CHAIN     DEPENR
004100120419     C                   IF        NOT %FOUND(DEPNDC)
004200120419     C                   ITER
004300120419     C                   ENDIF
004400120419    ***
004500120419     C     MBSSNO        SETLL     DEPENR
004600120419     C                   DOU       %EOF(DEPNDC)
004700120419     C     MBSSNO        READE     DEPENR
004800120419     C                   IF        NOT %EOF(DEPNDC) AND
004900120419     C                             DPDLTD = 'A'
005000120419     C                   EXSR      $WRTDEP
005100120419     C                   ENDIF
005200120419     C                   ENDDO
005300120419    ***
005400120419     C                   ENDIF
005500120419     C                   ENDDO
005600120419    ***
005700120419     C                   EVAL      *INLR = *ON
005800120419     ****
005900120419     ****
006000120419     ****
006100120419     C     $WRTMBR       BEGSR
006200120419    ***
006300120419     C                   CLEAR                   @X
006400120419    ***
006500120419     C                   MOVE      BIRTH         #ISO
006600120419     C     *USA          MOVE      #ISO          #XSX
006700120419     C                   EVAL      @DOB = %EDITC(#XSX:'Y')
006800120419     C     ' ':'0'       XLATE     @DOB          @DOB
006900120419    ***
007000120419     C                   MOVE      EMPDT         #ISO
007100120419     C     *USA          MOVE      #ISO          #XSX
007200120419     C                   EVAL      @EMP = %EDITC(#XSX:'Y')
007300120419     C     ' ':'0'       XLATE     @EMP          @EMP
007400120419    ***
007500120419     C                   Z-ADD     ZIP           #9
007600120419     C                   MOVE      #9            @ZIP
007700120419    ***
007800120419     C                   EVAL      @X = ',,"' + %EDITC(MBSSNO:'X') + '",,"' +
007900120419     C                             %EDITC(MBSSNO:'X') + '","' +
008000120419     C                             %TRIM(MLNAME) + '","' +
008100120419     C                             %TRIM(MFNAME) + '","' +
008200120419     C                             %TRIM(@DOB) + '","' +
008300120419     C                             %TRIM(SEX) + '","EE",,"' +
008400120419     C                             %TRIM(ADDR1) + '","' +
008500120419     C                             %TRIM(ADDR2) + '","' +
008600120419     C                             %TRIM(CITY) + '","' +
008700120419     C                             %TRIM(STATE) + '","' +
008800120419     C                             %SUBST(@ZIP:1:5) + '","' +
008900120419     C                             %TRIM(@EMP) + '","' +
009000120419     C                             %EDITC(SALARY:'X') + '",,"' +
009100120419     C                             %EDITC(AREA:'X') +
009200120419     C                             %EDITC(PHONE:'X') + '"'
009300120419     C                   EXCEPT    OUTF
009400120419    ***
009500120419     C                   ENDSR
009600120419     ****
009700120419     ****
009800120419     ****
009900120419     C     $WRTDEP       BEGSR
010000120419    ***
010100120419     C                   CLEAR                   @X
010200120419    ***
010300120419     C                   IF        DRELCD = 'RDA' OR DRELCD = 'RSO'
010400120419     C                   MOVE      'CH'          @REL              2
010500120419     C                   ELSE
010600120419     C                   EVAL      @REL = 'SP'
010700120419     C                   ENDIF
010800120419    ***
010900120419     C                   MOVE      DBIRTH        #ISO
011000120419     C     *USA          MOVE      #ISO          #XSX
011100120419     C                   EVAL      @DOB = %EDITC(#XSX:'Y')
011200120419     C     ' ':'0'       XLATE     @DOB          @DOB
011300120419    ***
011400120419     C                   EVAL      @X = ',,"' + %EDITC(DSSNO:'X') + '",,"' +
011500120419     C                             %EDITC(DEPSS#:'X') + '","' +
011600120419     C                             %TRIM(DLNAME) + '","' +
011700120419     C                             %TRIM(DFNAME) + '","' +
011800120419     C                             %TRIM(@DOB) + '","' +
011900120419     C                             %TRIM(DSEX) + '","' +
012000120419     C                             %TRIM(@REL) + '","' +
012100120419     C                             %TRIM(DSTUDN) + '","' +
012200120419     C                             %TRIM(ADDR1) + '","' +
012300120419     C                             %TRIM(ADDR2) + '","' +
012400120419     C                             %TRIM(CITY) + '","' +
012500120419     C                             %TRIM(STATE) + '","' +
012600120419     C                             %SUBST(@ZIP:1:5) + '",,,,"' +
012700120419     C                             %EDITC(AREA:'X') +
012800120419     C                             %EDITC(PHONE:'X') + '"'
012900120419     C                   EXCEPT    OUTF
013000120419    ***
013100120419     C                   ENDSR
013200120419     ****
013300120419     ****
013400120419     ****
013500120419     C     *INZSR        BEGSR
013600120419     C     KL#TSA        KLIST
013700120419     C                   KFLD                    KF@TRS
013800120419     C                   KFLD                    KF@SUB
013900120419     C                   KFLD                    KF@ACC
014000120419     C                   ENDSR
014100120419     ****
014200120419     ****
014300120419     ****
014400120419     OT2000     EADD         OUTF
014500120419     O                       @X                2000
