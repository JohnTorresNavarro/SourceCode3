000100030613     FHIST      IPE  E             DISK
000200131011     FRP410WF   O  A F  216        DISK
000300030613   X***X
000400030613     D @WRITE          S              1A
000500131011     D @216            S            216A
000600030613    ***
000700030613     D DS@HIST       E DS                  EXTNAME(HIST)
000800030613     D  I_T                   45     47A
000900030613     D  I_S                   48     50A
001000030613     D  I_A                   51     54A
001100030613     D  I_EY                 153    156A
001200030613     D  I_EM                 157    158A
001300030613    ***
001400030613     D                 DS
001500030613     D @PARM                         32A
001600030613     D  SC_TRST                1      3A
001700030613     D  SC_SUB#                4      6A
001800030613     D  SC_ACCT                7     10A
001900030613     D  FRMISO                11     18A
002000030613     D  TOISO                 19     26A
002100030613     D  EFISO                 27     32A
002200030613    ***
002300030613     D @P              S             32A
002400030613     D #T              S              3S 0
002500030613     D #S              S              3S 0
002600030613     D #A              S              4S 0
002700030613     D #TRS            S              3S 0
002800030613     D #SUB            S              3S 0
002900030613     D #ACC            S              4S 0
003000030613     D #FRDT           S              8S 0
003100030613     D #TODT           S              8S 0
003200030613     D @EM             S              2A
003300030613     D @EY             S              4A
003400030613   X***X
003500030613     C                   EXSR      $FILTER
003600030613    ***
003700030613     C                   IF        @WRITE = 'Y'
003800131011     C                   EVAL      @216 = DS@HIST
003900030613     C                   EXCEPT    WRTF
004000030613     C                   ENDIF
004100030613   S***S
004200030613     C     *INZSR        BEGSR
004300030613    ***
004400030613     C     *ENTRY        PLIST
004500030613     C                   PARM                    @P
004600030613     C                   MOVEL     @P            @PARM
004700030613    ***
004800030613     C                   IF        SC_TRST <> 'ALL'
004900030613     C                   MOVE      SC_TRST       #TRS
005000030613     C                   ENDIF
005100030613    ***
005200030613     C                   IF        SC_SUB# <> 'ALL'
005300030613     C                   MOVE      SC_SUB#       #SUB
005400030613     C                   ENDIF
005500030613    ***
005600030613     C                   IF        SC_ACCT <> 'ALL '
005700030613     C                   MOVE      SC_ACCT       #ACC
005800030613     C                   ENDIF
005900030613    ***
006000030613     C                   MOVE      FRMISO        #FRDT
006100030613    * *
006200030613     C                   IF        TOISO = '00000000'
006300030613     C                   MOVE      99999999      #TODT
006400030613     C                   ELSE
006500030613     C                   MOVE      TOISO         #TODT
006600030613     C                   ENDIF
006700030613    ***
006800030613     C                   MOVEL     EFISO         @EM
006900030613     C                   MOVE      EFISO         @EY
007000030613    ***
007100030613     C                   ENDSR
007200030613   S***S
007300030613     C     $FILTER       BEGSR
007400030613    ***
007500030613     C                   MOVE      'N'           @WRITE
007600030613    ***
007700030613     C                   IF        HSDLTD <> 'A'
007800030613     C                   LEAVESR
007900030613     C                   ENDIF
008000030613    ***
008100030613     C                   IF        TRCODE <> 'GTA'
008200030613     C                   LEAVESR
008300030613     C                   ENDIF
008400030613    ***
008500030613     C                   IF        TRDATE < #FRDT OR TRDATE > #TODT
008600030613     C                   LEAVESR
008700030613     C                   ENDIF
008800030613    ***
008900030613     C                   MOVE      I_T           #T
009000030613     C                   MOVE      I_S           #S
009100030613     C                   MOVE      I_A           #A
009200030613    ***
009300030613     C                   IF        SC_TRST <> 'ALL' AND #TRS <> #T
009400030613     C                   LEAVESR
009500030613     C                   ENDIF
009600030613    ***
009700030613     C                   IF        SC_SUB# <> 'ALL' AND #SUB <> #S
009800030613     C                   LEAVESR
009900030613     C                   ENDIF
010000030613    ***
010100030613     C                   IF        SC_ACCT <> 'ALL' AND #ACC <> #A
010200030613     C                   LEAVESR
010300030613     C                   ENDIF
010400030613    ***
010500030613     C                   IF        EFISO <> '000000'
010600050217     C                   IF        @EY <> I_EY OR @EM <> I_EM
010700030613     C                   LEAVESR
010800030613     C                   ENDIF
010900030613     C                   ENDIF
011000030613    ***
011100030613     C                   MOVE      'Y'           @WRITE
011200030613    ***
011300030613     C                   ENDSR
011400030613   S***S
011500030613     ORP410WF   EADD         WRTF
011600131011     O                       @216               216
