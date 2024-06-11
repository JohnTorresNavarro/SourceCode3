0001009408170002 F******************************************************************
0002001009220003 F* rpa410     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005001009220006 F*            DATE - 09/21/10                                     *
0006009408170007 F*                                                                *
0007009409210008 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE OF THE      *
0008001009220009 F*            COMOK file (commission ok for GBSACCESS)            *
0009009408170010 F*                                                                *
0009011201270010 F* 01/27/12 dlk - add actual commission paid date per request from
0009021201270010 F*                Mick so it can be shown on gbsaccess.           *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012001009220013 Frpa410d   CF   E             WORKSTN
001300970401     F                                     SFILE(SF01:RRN)
0014001009220015 Fcomokl1   UF A E           K DISK
0015020207010015 Fgbsecure  IF   E           K DISK
0015031009220002 D systemdate      S               d   datfmt(*ISO)
001504100922     dleavescrn02      s              1
001505020705     dY                s              1    inz('Y')
001506020702     dleave            s              1    inz('N')
001508100922     dmsg1             s             60    inz('PLEASE ENTER A VALID DATE IN -
001509100922     d                                     THE FORMAT MM01YYYY')
001510100922     dmsg2             s             60    inz('THIS RECORD IS ALREADY APPROVE-
001511100922     d                                     D                             ')
001512100922     dmsg3             s             60    inz('THIS RECORD HAS NOT BEEN -
001513100922     d                                     APPROVED YET                       ')
001514120127     dmsg4             s             60    inz('PLEASE ENTER A VALID ACTUAL -
001515120127     d                                     COMMISSION PAID DATE (MMDDYYYY)')
001600950126     D COMPAN          DS
001700940921     D*  DATA AREA - COMPANY NAME
001800940921     D  COMP                   1     55
002301100922     D                 DS
002302100922     D  effdt                  1      8  0
002303100922     D  effdd                  3      4  0
002305100922     D                uDS
002306100922     D  luser                  1     10
003800100922     C                   clear                   effdt
003801100922     C                   clear                   effdt2
004300020702
004301020702     c                   dou       leave = 'Y'
004302020702
004401020702     C                   EXFMT     SCRN01
004403020702     c                   clear                   msg
004404100922     c                   clear                   *in50
0047000207020077 C*  f7 END
0049000207020079 C                   if        *in07
0050009409210080 C                   SETON                                        LR
0051000207020080 C                   eval      leave = 'Y'
0051010207020080 C                   iter
005200940921     C                   END
0053009704010076 C*
0054001009220077 C*  f5 DISPLAY all dates
0055009704010078 C*
0056000207020079 C                   if        *in05
0057001009220080 C                   EXSR      #dspdt
0058000207020080 C                   iter
005900970401     C                   END
0059010207020078
0063001009220076 C* edit date
006301100922     C     *USA          TEST (DE)               effdt
006302100922     C                   IF        %ERROR or effdd <> 01
006303100922     c                   movel     msg1          msg
006304100922     c                   eval      *in50 = *on
006305100922     c                   iter
006306100922     C                   end
006307100922
006308100922     C                   MOVE      effdt         @DATIN
006309100922     C                   EXSR      #DATYM
006310100922     C                   MOVE      @DATOU        effymd            8 0
006400100922     C     effymd        CHAIN     comokl1
006504020702
006505100922     c                   if        %found(comokl1)
006507100922     C                   MOVE      coeffdat      @DATIN
006508100922     C                   EXSR      #DATYM
006509100922     C                   MOVE      @DATOU        effdt2
006510120127      * actual comm paid dt
006511120127     C                   MOVE      coacpdt       @DATIN
006512120127     C                   EXSR      #DATYM
006513120127     C                   MOVE      @DATOU        acpdto
006514120127
006515100922     C                   MOVE      cookdate      @DATIN
006516100922     C                   EXSR      #DATYM
006517100922     C                   MOVE      @DATOU        apdateo
006518100922
006519100922     c                   movel     cooktime      aptimeo
006520100922
006521100922     c     COOKUSER      chain     gbsecure
006522100922     c                   if        %found(gbsecure)
006523100922     c                   movel     scname        APUSERO
006524100922     c                   else
006525100922     c                   movel     cookuser      APUSERO
006526100922     c                   end
006527100922
006528100922      * not found
006529020702     c                   else
006530100922
006531100922     c                   clear                   comokr
006532100922     c                   clear                   COeffdat
006533120127     c                   clear                   COacpdt
006534100922     c                   clear                   COOKDATE
006535100922     c                   clear                   COOKTIME
006536100922     c                   clear                   COOKUSER
006537100922     C                   MOVE      effdt         effdt2
006538100922     c                   clear                   APDATEO
006539100922     c                   clear                   APTIMEO
006540100922     c                   clear                   APUSERO
006541120127     c                   clear                   acpdto
006542100922     c                   end
006543020701
006544020702     c                   eval      leavescrn02 = 'N'
006545020702
006546020702     c                   dou       leavescrn02 = 'Y'
006547020701     c                   exfmt     scrn02
006548020702     c                   clear                   msg
006549100922     c                   clear                   *in51
006550020702     c* f1 - return to 1st screen
006551020702     c                   if        *in01
006552020702     c                   leave
006553020702     c                   end
006554120127
006555120127      *****************************
0065561009220076 C* f9 remove approval
006557120127      *****************************
006558100922     C                   if        *in09
006559100922      * if the record has not been approved then this is an error
006560100922     C                   if        cookdate = 0 or not %found(comokl1)
006561100922     c                   movel     msg3          msg
006562100922     c                   eval      *in51 = *on
006563100922     c                   iter
006564100922     c                   end
006565100922
006566100922     c                   clear                   COOKDATE
006567100922     c                   clear                   COOKTIME
006568100922     c                   clear                   COOKUSER
006569120127      * validate actual comm paid date
006570120127
006571120127      * edit actual comm paid date if it is still entered
006572120127     c                   if        acpdto <> 0
006573120127     C     *USA          TEST (DE)               acpdto
006574120127     C                   IF        %ERROR
006575120127     c                   movel     msg4          msg
006576120127     c                   eval      *in51 = *on
006577120127     c                   iter
006578120127     c                   end
006579120127     c                   end
006580120127
006581120127      * convert screen field back to ymd in file field
006582120127     C                   MOVE      acpdto        @DATIN
006583120127     C                   EXSR      #DATYM
006584120127     C                   MOVE      @DATOU        coacpdt
006585120127
006586100922     C                   update    comokr
006587020702     c                   leave
006588100922     C                   END
006589020702
006590120127      *****************************
006591100922      * f6 - approve
006592120127      *****************************
006593100922     C                   if        *in06
006594100922      * if the record is already approved then this is an error
006595100922     C                   if        %found(comokl1) and cookdate <> 0
006596100922     c                   movel     msg2          msg
006597100922     c                   eval      *in51 = *on
006598100922     c                   iter
006599100922     c                   end
006600100922
006601120127      * edit actual comm paid date
006602120127     C     *USA          TEST (DE)               acpdto
006603120127     C                   IF        %ERROR
006604120127     c                   movel     msg4          msg
006605120127     c                   eval      *in51 = *on
006606120127     c                   iter
006607120127     c                   end
006608120127
006609100922      * get system date (*ISO = YYYYMMDD)
006610100922      /free
006611100922       systemdate = %date();
006612100922      /end-free
006613100922     C                   MOVE      systemdate    cookdate                                      COMPN
006614100922
006615100922     c                   time                    COOKTIME
006616100922     c                   move      luser         COOKUSER
006617100922
006618120127      * convert screen field back to ymd in file field
006619120127     C                   MOVE      acpdto        @DATIN
006620120127     C                   EXSR      #DATYM
006621120127     C                   MOVE      @DATOU        coacpdt
006622120127
006623120127      * update or add?
006624100922     C                   if        %found(comokl1)
006801100922     C                   update    comokr
006802100922     c                   leave
007000970401     C                   ELSE
007001100922     C                   MOVE      effdt2        @DATIN
007002100922     C                   EXSR      #DATYM
007003100922     C                   MOVE      @DATOU        coeffdat
007004120127
007200100922     C                   WRITE     comokr
007201100922     c                   leave
007300970401     C                   END
007301100922
007302100922     C                   END
007305020702
007306020702     c                   enddo
007801020702
0079000207020168 C                   enddo
008100970401     C************************************
008200100922     C* DISPLAY dates IN SUBFILE WINDOW  *
008300970401     C************************************
008400100922     C     #dspdt        BEGSR
008500970401     C*
008600970401     C* CLEAR SUBFILE
008700970401     C*
008800970401     C                   MOVEA     '001'         *IN(90)
008900970401     C                   WRITE     SF01CTL
009000970401     C                   MOVE      '0'           *IN92
009100970401     C*
009200100922     C* BUILD SUBFILE - comokl1 is in decending order
009300970401     C*
009400970401     C                   MOVE      *ZEROS        RRN               5 0
009500100922     C     *hival        SETLL     comokl1
009501020702
009600100922     C                   dou       %eof(comokl1)
009601020702
009700100922     C                   READ      comokl1                                91
009800020702     C                   if        *in91 = *off
010109020702
010110100922     c     COOKUSER      chain     gbsecure
010111020701     c                   if        %found(gbsecure)
010112100922     c                   movel     scname        sfokuser
010113020701     c                   else
010114100922     c                   clear                   sfokuser
010115020701     c                   end
010116020702
010117100922     C                   MOVE      cookdate      @DATIN
010118100922     C                   EXSR      #DATYM
010119100922     C                   MOVE      @DATOU        sfokdt
010120100922
010121100922     C                   MOVE      coeffdat      @DATIN
010122100922     C                   EXSR      #DATYM
010123100922     C                   MOVE      @DATOU        sfeff
010124100922
010125120127     C                   MOVE      coacpdt       @DATIN
010126120127     C                   EXSR      #DATYM
010127120127     C                   MOVE      @DATOU        sfacpdt
010128120127
010129100922     c                   move      COOKTIME      SFOKTM
010130100922
010200970401     C                   ADD       1             RRN
010300970401     C                   WRITE     SF01
010500970401     C                   END
010501020702
010502020702     c                   enddo
010600970401     C*
010700970401     C* DISPLAY SUBFILE IN WINDOW
010800970401     C*
011000020703     C                   if        rrn > 0
011100020703     C                   eval      *in90 = *on
011200020703     C                   end
011300970401     C*
011400970401     C                   WRITE     WINDOW
011500970401     C                   EXFMT     SF01CTL
011700970401     C*
011800970401     C                   ENDSR
011900020701
0119011009220103 C***************************************************
0119021009220104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY or      *
0119031009220104 C* MMDDYYYY TO YYYYMMDD                            *
0119041009220105 C***************************************************
0119051009220107 C*
0119061009220107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0119071009220107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0119081009220107 C*
0119091009220106 C     #DATYM        BEGSR
011910100922     C                   MOVE      @DATIN        @MD               4 0
011911100922     C                   MOVEL     @DATIN        @Y                4 0
011912100922     C                   MOVEL     @MD           @DATOU            8 0
011913100922     C                   MOVE      @Y            @DATOU
011914100922     C                   MOVE      *ZEROS        @DATIN            8 0
0119151009220120 C                   ENDSR
011958020701
011959020701
012000020701     C     *inzsr        BEGSR
012001020701     C*
012002020701     C* GET DATA AREA AND IMMEDIATELY RELEASE
012003020701     C*
012005020701     C     *DTAARA       DEFINE                  COMPAN
012006020701     C                   IN        COMPAN
012007020701     C                   MOVEL     COMP          COMPNY
012100020701     C                   ENDSR
