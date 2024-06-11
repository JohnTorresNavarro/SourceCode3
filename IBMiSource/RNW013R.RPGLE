000100131031      *---------------------------------------------------------------------
000200131031      * Modifications:
000300131031      *---------------------------------------------------------------------
000400131031      * 10/31/13 dpb  Remove printing of HVSM as result of changes to RNW010R
000500131031      *---------------------------------------------------------------------
000600060727     FRNWP01WF  IF   E           K DISK
000700060809     FRNW013P   O    E             PRINTER OFLIND(*IN81)
000800060727   X***X
000900060727     D YR              S              9A   DIM(12) CTDATA PERRCD(1)             MONTHS
001000060727     D #2              S              2S 0
001100060727     D @NAME           S             50A
001200060727     D @2              S              2A
001300060727     D @8              S              8A
001400060727     D @9              S              9A
001500060727     D HOLD@NAME       S             50A
001600060727    ***
001700060727   X***X
001800060727     C                   DOU       %EOF(RNWP01WF)
001900060727     C                   READ      R01WF
002000060727     C                   IF        NOT %EOF(RNWP01WF)
002100060727    ***
002200060727     C                   EXSR      $NAME
002300060727     C                   EXSR      $DATES
002400060727    ***
002500060727     C                   IF        HOLD@NAME <> @NAME
002600061018     C                   MOVE      *BLANKS       H@DES            40
002700060727     C                   EVAL      HOLD@NAME = @NAME
002800060727     C                   EXSR      $LETTER
002900060727     C                   EXSR      $LISTHDR
003000060727     C                   ENDIF
003100060727    ***
003200060727     C                   EXSR      $LISTDTL
003300060727    ***
003400060727     C                   ENDIF
003500060727     C                   ENDDO
003600060727    ***
003700060727     C                   EVAL      *INLR = *ON
003800060727    ***
003900060727   S***S
004000060727     C     $DATES        BEGSR
004100060727    ***
004200060727     C                   MOVE      RFPD          @8
004300060727     C                   EVAL      @2 = %SUBST(@8:5:2)
004400060727     C                   MOVE      @2            #2
004500060727     C                   MOVEL     YR(#2)        @9
004600061030     C                   EVAL      @2 = %SUBST(@8:7:2)
004700060727     C                   EVAL      HV01 = %TRIMR(@9) + ' ' + %TRIM(@2)
004800060727     C                             + ', ' + %SUBST(@8:1:4)
004900060727    *C*
005000060727     C                   MOVE      RFRD          @8
005100060727     C                   EVAL      @2 = %SUBST(@8:5:2)
005200060727     C                   MOVE      @2            #2
005300060727     C                   MOVEL     YR(#2)        @9
005400060727     C                   EVAL      HV05 = %TRIMR(@9) + ' 01, ' +
005500060727     C                             %SUBST(@8:1:4)
005600060727    ***
005700060727     C                   ENDSR
005800060727   S***S
005900060727     C     $NAME         BEGSR
006000060727    ***
006100060727     C                   IF        RFMI = *BLANKS
006200060727     C                   EVAL      @NAME = %TRIM(RFFN) + ' ' + %TRIM(RFLN)
006300060727     C                   ELSE
006400060727     C                   EVAL      @NAME = %TRIM(RFFN) + ' ' + RFMI +
006500060727     C                             '. ' + %TRIM(RFLN)
006600060727     C                   ENDIF
006700060727    ***
006800060727     C                   ENDSR
006900060727   S***S
007000060727     C     $LETTER       BEGSR
007100060727    ***
007200060727     C                   EVAL      HV02 = %TRIM(HOLD@NAME)
007300101102     C                   EVAL      HV02A = %TRIM(RFAN)
007400060727     C                   MOVEL(P)  RFADR         HV03
007500060727     C                   EVAL      HV04 = %TRIM(RFCITY) + ', ' +
007600060727     C                             %TRIM(RFST) + '. ' + RFZIP
007700060727     C                   EVAL      HV06 = %TRIM(HOLD@NAME) + ':'
007800060727    ***
007900060727     C                   WRITE     LTRF01
008000060727     C                   WRITE     PAGES1
008100060727    ***
008200060727     C                   ENDSR
008300060727   S***S
008400060727     C     $LISTHDR      BEGSR
008500060727    ***
008600060727     C                   EVAL      HV11 = HV02
008700060727     C                   EVAL      HV12 = HV05
008800060727    ***
008900060727     C                   WRITE     HDGF11
009000060809     C                   WRITE     PAGES2
009100060727    ***
009200060727     C                   ENDSR
009300060727   S***S
009400060727     C     $LISTDTL      BEGSR
009500060727    ***
009600060727     C                   IF        RFACN <> HV112
009700060727     C                   EVAL      HV112 = RFACN
009800061018     C                   MOVE      RFTSA         #10S0            10 0
009900061018     C                   IF        %SUBST(RFTSA:1:3) = '000'
010000061018     C                   EVAL      HV122 = 'GA-' +
010100061018     C                             %TRIM(%EDITC(#10S0:'Z'))
010200061018     C                   ELSE
010300061018     C                   EVAL      HV122 = %EDITW(#10S0:'   -   -    ')
010400061018     C                   ENDIF
010500060727     C                   EVAL      HV132 = RFNOEMP
010600060727     C                   EVAL      HV142 = %TRIM(RFDES)
010700061018     C                   MOVEL(P)  RFDES         H@DES
010800060727     C                   IF        *IN81 = *ON
010900060727     C                   WRITE     HDGF11
011000060810     C                   WRITE     PAGES2
011100060727     C                   EVAL      *IN81 = *OFF
011200060727     C                   ENDIF
011300060727     C                   WRITE     HDGF12
011400061018     C                   LEAVESR
011500060727     C                   ENDIF
011600060727    ***
011700061018     C                   IF        RFDES = H@DES
011800061018     C                   LEAVESR
011900061018     C                   ENDIF
012000061018    ***
012100061018     C                   MOVEL(P)  RFDES         H@DES
012200060727     C                   EVAL      DV11 = %TRIM(RFDES)
012300060727     C                   IF        *IN81 = *ON
012400060727     C                   WRITE     HDGF11
012500060810     C                   WRITE     PAGES2
012600060727     C                   WRITE     HDGF12
012700060727     C                   EVAL      *IN81 = *OFF
012800060727     C                   ENDIF
012900060727     C                   WRITE     DTLF11
013000060727    ***
013100060727     C                   ENDSR
013200060727   S***S
013300060727**
013400060727January
013500060727February
013600060727March
013700060727April
013800060727May
013900060727June
014000060727July
014100060727August
014200060727September
014300060727October
014400060727November
014500060727December
