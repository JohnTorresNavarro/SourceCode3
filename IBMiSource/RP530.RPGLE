0001001610270048  * Eligibility listing
0001011610270048  *
000102161027      * 10/27/16 dlk - convert to xls (Shelly R request for EDT use)
0001031610270048  *
000200931123     FMEMBER    IP   E           K DISK
000300161027     Fmcov38    IF   E           K DISK
000400940324     FACCMST    IF   E           K DISK
000500950103     FDEPNDC    IF   E           K DISK
000600161027     FDCOVc     IF   E           K DISK
000700931123     FPLNMST    IF   E           K DISK
0008011610270005 Frp530xl   o  a e             disk
0008021610270125 Dcsv              c                   const('","')
0008031610270037 D sysdateymd      S               d   datfmt(*iso)
0008041610270125 D ud8ymd          s              8  0
0008051610270125 D acc#_o          s             13a
0008061610270125 D mname_o         s             40a
0009011610270024 D acnam_o         S                   like(acnam1)
0009021610270125 D addr_o          s                   like(addr1)
0009031610270125 D csz_o           s             40a
0009041610270125 D depnam_o        s             40a
0009051610270125 D sex_o           s              1a
0009061610270125 D plan_o          s                   like(mcplan)
0009071610270125 D cov_o           s              2a
0009081610270125 D lifevol_o       s                   like(benamt)
001500931130     IMEMBR
001600931130     I                                          MBTRST        L1
001700931130     I                                          MBSUB#        L1
001800931130     I                                          MBACCT        L1
002000161027
003401161027     c                   if        *inl1
003500161027     C                   clear                   acnam_o
003501161027     C                   clear                   acc#_o
003502161027       acc#_o =  %editc(mbtrst:'X') + '-' + %editc(mbsub#:'X') + '-' +
003503161027                 %editc(mbacct:'X');
003600161027     C     tsakey        CHAIN     ACCMST
003601161027     c                   if        %found(accmst)
003800161027     C                   MOVEL     ACNAM1        acnam_o
003801161027     c                   end
005401161027     c                   end
005402161027
006201161027     c                   clear                   mname_o
006202161027     c                   eval      mname_o  = %trim(mlname) + ', ' +
006203161027     c                             %trim(mfname) + ' ' + %trim(mmi)
006204161027
006500981118     C                   MOVE      MBENRL        @DATIN
006600981118     C                   EXSR      #DATYM
006700981118     C                   MOVE      @DATOU        MBEMDY            8 0
006701161027
006703161027     C                   MOVE      BIRTH         @DATIN
006704161027     C                   EXSR      #DATYM
006705161027     C                   MOVE      @DATOU        BIRMDY            8 0
006706161027     C                   MOVE      birmdy        birth_o           8 0
006707161027      * address
006708161027     C                   MOVEl     addr1         addr_o
006709161027     C                   MOVEl     zip           zip5              5
006710161027     C                   MOVE      zip           zip4              4
006711161027       csz_o =  %trim(city) + ', ' + (state) + ' ' +
006712161027                 zip5;
006713161027       if zip4 <> '0000';
006714161027       csz_o = %trim(csz_o) + '-' + zip4;
006715161027       endif;
006716161027
006717161027     C                   clear                   depnam_o
006718161027     C                   MOVEl     'SELF'        depnam_o
006719161027     C                   clear                   sex_o
006720161027     C                   MOVEl     sex           sex_o
007500931123     C*
007501161027     C* get member coverages
007502161027     C*
007600161027     C     MBSSNO        SETLL     mcov38
007901161027     c                   dou       %eof(mcov38)
008300161027     C     MBSSNO        READE     mcov38
008301161027     c                   if        not %eof(mcov38) and
008302161027     c                             (candt = 0 or candt > ud8ymd) and
008303161027     c                             (candt <> enrldt)
008304161027
010100981118     C                   MOVE      ENRLDT        @DATIN
010200981118     C                   EXSR      #DATYM
010300161027     C                   MOVE      @DATOU        enrmdy            8 0
010301161027
010600981118     C                   MOVE      CANDT         @DATIN
010700981118     C                   EXSR      #DATYM
010800161027     C                   MOVE      @DATOU        canmdy            8 0
010801161027
010802161027     c                   clear                   plan_o
010803161027       plan_o = mcplan;
010804161027     c                   clear                   cov_o
010805161027       cov_o = %subst(mcovtp:2:2);
010806161027
010807161027     c                   clear                   lifevol_o
010808161027     c                   move      benamt        lifevol_o
010809161027     C                   exsr      writexldet
011200161027     C                   end
011201161027     C                   enddo
011900931123     C*
011901161027     C* get dependents
011902161027     C*
012000161027     C     mbssno        SETLL     DEPNDC
012001161027     c                   dou       %eof(depndc)
012300161027     C     mbssno        READE     DEPNDC
012301161027     c                   if        not %eof(depndc)
012303161027
012304161027     C                   MOVE      DBIRTH        @DATIN
012305161027     C                   EXSR      #DATYM
012306161027     C                   MOVE      @DATOU        dbirmdy           8 0
012307161027     C                   MOVE      dbirmdy       birth_o
012900161027
012901161027     c                   clear                   depnam_o
012902161027     c                   eval      depnam_o  = %trim(dfname)
012903161027     c                   clear                   sex_o
012904161027     C                   MOVEl     dsex          sex_o
012905161027     c                   clear                   lifevol_o
012906161027
012907161027      * get dependent coverages
013100161027     C     dckey         SETLL     DCOVc
013101161027     c                   dou       %eof(dcovc)
013200161027     C     dckey         reade     DCOVc
013201161027     c                   if        not %eof(dcovc) and
013202161027     c                             (ccandt = 0 or ccandt > ud8ymd) and
013203161027     c                             (ccandt <> denrdt)
013204161027
013205161027     c                   clear                   cov_o
013206161027     c                   clear                   plan_o
013207161027       plan_o = dvplan;
013208161027
013209161027     C                   MOVE      DENRDT        @DATIN
013210161027     C                   EXSR      #DATYM
013211161027     C                   MOVE      @DATOU        enrmdy
013212161027     C*
013213161027     C                   MOVE      CCANDT        @DATIN
013214161027     C                   EXSR      #DATYM
013215161027     C                   MOVE      @DATOU        canmdy
013216161027
013217161027     C                   exsr      writexldet
014201161027     c                   end
014203161027     c                   enddo
014204161027
014205161027     c                   end
017202161027     c                   enddo
017301161027
017303161027
018400931123     C     #ENDD         TAG
018500931123     C*
0216009311300112 C*
0220009811180103 C***************************************************
0221009811180104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0222009811180105 C***************************************************
0223009811180107 C*
0224009811180107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0225009811180107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0226009811180107 C*
0227009811180106 C     #DATYM        BEGSR
022800981118     C                   MOVE      @DATIN        @MD               4 0
022900981118     C                   MOVEL     @DATIN        @Y                4 0
023000981118     C                   MOVEL     @MD           @DATOU            8 0
023100981118     C                   MOVE      @Y            @DATOU
023200981118     C                   MOVE      *ZEROS        @DATIN            8 0
0233009811180120 C                   ENDSR
023301161027
0234511610270164  *************************************************************
0234521610270164  * Write Spreadsheet Detail                                  *
0234531610270164  *************************************************************
023454161027       begsr writexldet;
023455161027
023456161027       clear rp530fld;
023457161027       rp530fld  = '"' +
023458161027         acc#_o                                 + csv +
023459161027         %trim(acnam_o)                         + csv +
023460161027         %trim(mname_o)                         + csv +
023461161027         %trim(%editw(mbssno:'0   -  -    '))   + csv +
023462161027         %trim(%editw(mbemdy:'0  /  /    '))    + csv +
023463161027         %trim(addr_o)                          + csv +
023464161027         %trim(csz_o)                           + csv +
023465161027         %trim(%editc(salary:'K'))              + csv +
023466161027         %trim(depnam_o)                        + csv +
023467161027         %trim(sex_o)                           + csv +
023468161027         %trim(%editw(birth_o:'0  /  /    '))   + csv +
023469161027         plan_o                                 + csv +
023470161027         cov_o                                  + csv +
023471161027         %trim(%editw(enrmdy:'  /  /    '))     + csv +
023472161027         %trim(%editw(canmdy:'  /  /    '))     + csv +
023473161027         %trim(%editc(lifevol_o:'K'))           +
023485161027         '"';
023486161027
023487161027       Write rp530r;
0234881610270320   endsr;
023489161027
023490161027      *************************************************************
023491161027      * Write Spreadsheet heading                                 *
023492161027      *************************************************************
023493161027       begsr Writexlhead;
023494161027
023495161027       clear rp530fld;
023496161027       rp530fld = '"' +
023497161027         'ACCOUNT #'             + csv +
023498161027         'NAME'                  + csv +
023499161027         'MEMBER NAME'           + csv +
023500161027         'SSN'                   + csv +
023501161027         'ENROLL DATE'           + csv +
023502161027         'ADDRESS'               + csv +
023503161027         'CITY/ST/ZIP'           + csv +
023504161027         'SALARY'                + csv +
023505161027         'DEP NAME'              + csv +
023506161027         'SEX'                   + csv +
023507161027         'BIRTH'                 + csv +
023508161027         'PLAN'                  + csv +
023509161027         'COV TYPE'              + csv +
023510161027         'EFFECTIVE'             + csv +
023511161027         'CANCEL'                + csv +
023512161027         'LIFE VOL'              +
023513161027         '"';
023514161027
023515161027       Write rp530r;
0235161610270320   endsr;
023517161027
023518161027      ****************************************************
023519161027      * first cycle
023520161027      ****************************************************
023521161027     C     *INZSR        BEGSR
023522161027     C     tsakey        KLIST
023523161027     C                   KFLD                    MBTRST
023524161027     C                   KFLD                    MBSUB#
023525161027     C                   KFLD                    MBACCT
023526161027
023527161027     C     PLNKEY        KLIST
023528161027     C                   KFLD                    MBTRST
023529161027     C                   KFLD                    MBSUB#
023530161027     C                   KFLD                    MCPLAN
023531161027     C*
023532161027     C     dckey         KLIST
023533161027     C                   KFLD                    mbssno
023534161027     C                   KFLD                    dpseq#
023535161027
023536161027     C                   Exsr      Writexlhead
023537161027
023538161027      * get current date
023539161027     C                   eval      sysdateymd = %date
023540161027     C                   MOVE      sysdateymd    ud8ymd
023541161027
023542161027     C                   ENDSR
