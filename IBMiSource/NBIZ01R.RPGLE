000100031229     ******** SSK 12/29/03 UTILITY TO GET NAMES FOR VALUES & VERIFY THEM
000200031229     ********
000300031229     FSMAN      IF   E           K DISK
000400031229     FSMANRLT   IF   E           K DISK
000500031229     FSPRAGXR2  IF   E           K DISK
000600031229     FAGENCY    IF   E           K DISK
000700031229     FSUPRAGCY  IF   E           K DISK
000800031229   X***X
000900031229     D                 DS
001000071026     D PRMS                    1    143A
001100031229     D P@SMAN                  1      3A
001200031229     D P@SNAME                 4     36A
001300031229     D P@AGCY                 37     39A
001400031229     D P@ANAME                40     79A
001500031229     D P@SUPER                80     82A
001600031229     D P@UNAME                83    132A
001700031229     D P@RELID               133    140A
001800031229     D P@RESULT              141    141A
001801071026     D P@REQUEST             142    142A
001900071026     D P@TERMED              143    143A
002000031229    ***
002100071026     D @@@PARMS        S            143A
002200031229   X***X
002300031229    * * V = VERIFY (REQUIRES RELID/SMAN/AGCY/SUPER)
002400031229    * * R = RETRIEVE NAMES (RELID ONLY)
002500031229    * *
002600031229    * *
002700031229    ***
002800031229     C     *ENTRY        PLIST
002900031229     C                   PARM                    @@@PARMS
003000031229     C                   EVAL      PRMS = @@@PARMS
003100031229    ***
003200031229     C     P@REQUEST     CASEQ     'V'           $VERIFY
003300031229     C     P@REQUEST     CASEQ     'R'           $RETRIEVE
003400031229     C                   ENDCS
003500031229    ***
003600031229     C                   EVAL      @@@PARMS = PRMS
003700031229     C                   EVAL      *INLR = *ON
003800031229     C                   RETURN
003900031229   S***S
004000031229     C     $RETRIEVE     BEGSR
004100031229    ***
004200031229     C                   EXSR      $CHN_REL
004300031229    * *
004400031229     C                   IF        P@RESULT = 'F'
004500031229     C                   LEAVESR
004600031229     C                   ENDIF
004700031229    * *
004800031229     C                   EVAL      P@SMAN = SRSMAN
004900031229    *** * * * * * * * * * * * * * *
005000031229     C                   EXSR      $CHN_SXR
005100031229    * *
005200031229     C                   IF        P@RESULT = 'F'
005300031229     C                   LEAVESR
005400031229     C                   ENDIF
005500031229    * *
005600031229     C                   EVAL      P@AGCY = SXAGCY
005700031229     C                   EVAL      P@SUPER = SXSUPER
005800031229    *** * * * * * * * * * * * * * *
005900031229     C                   EXSR      $CHN_AGY
006000031229    * *
006100031229     C                   IF        P@RESULT = 'F'
006200031229     C                   LEAVESR
006300031229     C                   ENDIF
006400031229    * *
006500031229     C                   MOVEL(P)  AGNAM1        P@ANAME
006600031229    *** * * * * * * * * * * * * * *
006700031229     C                   EXSR      $CHN_SUP
006800031229    * *
006900031229     C                   IF        P@RESULT = 'F'
007000031229     C                   LEAVESR
007100031229     C                   ENDIF
007200031229    * *
007300031229     C                   MOVEL(P)  SANAME1       P@UNAME
007400031229    *** * * * * * * * * * * * * * *
007500031229     C                   EXSR      $CHN_SMN
007600031229    * *
007700031229     C                   IF        P@RESULT = 'F'
007800031229     C                   LEAVESR
007900031229     C                   ENDIF
008000031229    * *
008100031229     C                   EXSR      $GETSNAME
008200031229     C                   MOVEL(P)  A@40          P@SNAME
008300031229    *** * * * * * * * * * * * * * *
008400031229     C                   EVAL      P@RESULT = 'P'
008500031229    ***
008600031229     C                   ENDSR
008700031229   S***S
008800040109     C     $CHN_REL      BEGSR
008900040109    ***
009000040109     C     P@RELID       CHAIN     SRF
009100040109     C                   IF        NOT %FOUND(SMANRLT)
009200040109     C                   EVAL      P@RESULT = 'F'
009300040109     C                   EVAL      P@UNAME = 'FAILED SMAN RELATN CHAIN'
009301071026     C                   ELSE
009302071026     C                   IF        SRTRMDTE <> 0
009303071026     C                   EVAL      P@TERMED = 'Y'
009304071026     C                   END
009400040109     C                   ENDIF
009500040109    ***
009600040109     C                   ENDSR
009700040109   S***S
009800040109     C     $CHN_SXR      BEGSR
009900040109    ***
010000040109     C     SRASID        CHAIN     SXF
010100040109     C                   IF        NOT %FOUND(SPRAGXR2)
010200040109     C                   EVAL      P@RESULT = 'F'
010300040109     C                   EVAL      P@UNAME = 'FAILED AGCY/SUPER CHAIN'
010400040109     C                   ENDIF
010500040109    ***
010600040109     C                   ENDSR
010700040109   S***S
010800040109     C     $CHN_AGY      BEGSR
010900040109    ***
011000040109     C     SXAGCY        CHAIN     AGENR
011100040109     C                   IF        NOT %FOUND(AGENCY)
011200040109     C                   EVAL      P@RESULT = 'F'
011300040109     C                   EVAL      P@UNAME = 'FAILED AGENCY CHAIN'
011400040109     C                   ENDIF
011500040109    ***
011600040109     C                   ENDSR
011700040109   S***S
011800040109     C     $CHN_SUP      BEGSR
011900040109    ***
012000040109     C     SXSUPER       CHAIN     SAF
012100040109     C                   IF        NOT %FOUND(SUPRAGCY)
012200040109     C                   EVAL      P@UNAME = 'FAILED SUPER AGENCY CHAIN'
012300040109     C                   EVAL      P@RESULT = 'F'
012400040109     C                   ENDIF
012500040109    ***
012600040109     C                   ENDSR
012700040109   S***S
012800040109     C     $CHN_SMN      BEGSR
012900040109    ***
013000040109     C     SRSMAN        CHAIN(N)  SMANR
013100040109     C                   IF        NOT %FOUND(SMAN)
013200040109     C                   EVAL      P@RESULT = 'F'
013300040109     C                   EVAL      P@UNAME = 'FAILED SALESMAN CHAIN'
013400040109     C                   ENDIF
013500040109    ***
013600040109     C                   ENDSR
013700040109   S***S
013800040517     C/COPY GALIB/QRPGLESRC,CR_FMTSMAN
013900031229   S***S
014000040109    *** * * * * * * * * * * * * * * * * * * * * * * * * * * * *
014100031229     C     $VERIFY       BEGSR
014200031229    ***
014300031229     C                   EXSR      $CHN_REL
014400031229    * *
014500040109     C                   IF        P@RESULT = 'F'
014600031229     C                   LEAVESR
014700031229     C                   ENDIF
014800031229    * *
014900031229     C                   EVAL      P@SNAME = SRSMAN
015000031229    * *
015100031229     C                   IF        P@SMAN <> SRSMAN
015200031229     C                   EVAL      P@RESULT = 'F'
015300031229     C                   LEAVESR
015400031229     C                   ENDIF
015500031229    *** * * * * * * * * * * * * * *
015600031229     C                   EXSR      $CHN_SXR
015700031229    * *
015800031229     C                   IF        P@RESULT = 'F'
015900031229     C                   LEAVESR
016000031229     C                   ENDIF
016100031229    * *
016200031229     C                   EVAL      P@ANAME = SXAGCY
016300031229     C                   EVAL      P@UNAME = SXSUPER
016400031229    * *
016500031229     C                   IF        P@AGCY <> SXAGCY OR SXSUPER <> P@SUPER
016600031229     C                   EVAL      P@RESULT = 'F'
016700031229     C                   LEAVESR
016800031229     C                   ENDIF
016900031229    *** * * * * * * * * * * * * * *
017000031229     C                   EVAL      P@RESULT = 'P'
017100031229    ***
017200031229     C                   ENDSR
017300031229   S***S
