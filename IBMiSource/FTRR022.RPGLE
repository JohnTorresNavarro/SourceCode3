000100100719     F*-------------------------------------------------------------------------
000200100719     ** MODIFICATION HISTORY                                              **
000300100719     ** ###  UUU  MMDDCCYY  X---->                                        **
000400100719     ** 000  SSK  07192010  ORIGINAL SOURCE                               **
000500100719     **                                                                   **
000600100719     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
000700100719     FFTRW020   IF   E           K DISK
000800100719     FFRMTRKP   IF   E           K DISK    RENAME(FRMTRKR:FUNQ) PREFIX(ZZ:2)
000900100719     FFRMTRKL4  UF   E           K DISK
001000100719     FFTRD022   CF   E             WORKSTN INFDS(WSDS)
001100100719   X***X
001200100719    ***
001300100719     D WSDS            DS
001400100719     D  FKEY                 369    369A
001500100719    ***
001600100719     D  F1             C                   CONST(X'31')
001700100719     D  F2             C                   CONST(X'32')
001800100719     D  F3             C                   CONST(X'33')
001900100719     D  F4             C                   CONST(X'34')
002000100719     D  F5             C                   CONST(X'35')
002100100719     D  F6             C                   CONST(X'36')
002200100719     D  F7             C                   CONST(X'37')
002300100719     D  F8             C                   CONST(X'38')
002400100719     D  F9             C                   CONST(X'39')
002500100719     D  F10            C                   CONST(X'3A')
002600100719     D  F11            C                   CONST(X'3B')
002700100719     D  F12            C                   CONST(X'3C')
002800100719     D  F13            C                   CONST(X'B1')
002900100719     D  F14            C                   CONST(X'B2')
003000100719     D  F15            C                   CONST(X'B3')
003100100719     D  F16            C                   CONST(X'B4')
003200100719     D  F17            C                   CONST(X'B5')
003300100719     D  F18            C                   CONST(X'B6')
003400100719     D  F19            C                   CONST(X'B7')
003500100719     D  F20            C                   CONST(X'B8')
003600100719     D  F21            C                   CONST(X'B9')
003700100719     D  F22            C                   CONST(X'BA')
003800100719     D  F23            C                   CONST(X'BB')
003900100719     D  F24            C                   CONST(X'BC')
004000100719    ***
004100100719     D @TIMESTAMP      DS
004200100719     D  #TSCYMD                1      8S 0
004300100719     D  #TSTIME                9     14S 0
004400100719     D  @TSJOB                15     24
004500100719     D  @TSUSER               25     34
004600100719     D  #TSNBR                35     40S 0
004700100719    * *
004800100719     D @TS40           S             40A
004900100719    ***
005000100719   X***X
005100100719     C     *ENTRY        PLIST
005200100719     C                   PARM                    @PARM            15
005300100719     C                   MOVE      @PARM         KF@UNQ           15
005400100719     C* MAINLINE
005500100719    ***
005600100719     C                   EXSR      ONCE
005700100719     C*
005800100719     C                   DOU       @EXIT = '1'
005900100719     C*
006000100719     C                   IF        FKEY = F1
006100100719     C                   MOVE      '1'           @EXIT
006200100719     C                   LEAVE
006300100719     C                   ELSE
006400100719     C                   EXSR      $PROCESS
006500100719     C                   ENDIF
006600100719     C*
006700100719     C                   IF        @EXIT = '0'
006800100719     C*
006900100719     C                   WRITE     JUNK
007000100719     C                   EXFMT     WDWSCR
007100100719     C*
007200100719     C                   ENDIF
007300100719     C*
007400100719     C                   ENDDO
007500100719     C*
007600100719     C                   MOVE      *ON           *INLR
007700100719     C                   RETURN
007800100719   S***S
007900100719     C* ONETIME ROUTINE
008000100719    ***
008100100719     C     ONCE          BEGSR
008200100719    ***
008300100719     C                   MOVE      '0'           @EXIT             1
008400100719    ***
008500100719     C                   EVAL      SCCODE = *BLANKS
008600100719     C                   EVAL      SCDESC = *BLANKS
008700100719     C                   WRITE     JUNK
008800100719     C                   EXFMT     WDWSCR
008900100719    ***
009000100719     C                   ENDSR
009100100719   S***S
009200100719     C     $PROCESS      BEGSR
009300100719     C*
009400100719     C                   IF        FKEY = F1
009500100719     C                   MOVE      '1'           @EXIT
009600100719     C                   LEAVESR
009700100719     C                   ENDIF
009800100719     C*
009900100719     C                   IF        SCCODE = *BLANKS
010000100719     C                   EVAL      SCDESC = 'NO CODE SPECIFIED, RETRY'
010100100719     C                   LEAVESR
010200100719     C                   ENDIF
010300100719     C*
010400100719     C     SCCODE        CHAIN     FTRW020R
010500100719     C                   IF        NOT %FOUND(FTRW020)
010600100719     C                   EVAL      SCDESC = 'BAD CODE SPECIFIED, RETRY'
010700100719     C                   LEAVESR
010800100719     C                   ENDIF
010900100719     C                   EVAL      SCDESC = %TRIM(F2DESC)
011000100719     C*
011100100719     C     KF@UNQ        CHAIN     FUNQ
011200100719     C                   IF        NOT %FOUND(FRMTRKP)
011300100719     C                   EVAL      SCDESC = 'T/S/A FAILURE, EXIT APP'
011400100719     C                   LEAVESR
011500100719     C                   ENDIF
011600100719     C*
011700100719     C     KL#TSA        KLIST
011800100719     C                   KFLD                    ZZTRST
011900100719     C                   KFLD                    ZZSUB#
012000100719     C                   KFLD                    ZZACCT
012100100719     C*
012200100719     C     KL#TSA        SETLL     FRMTRKR
012300100719     C                   DOU       %EOF(FRMTRKL4)
012400100719     C     KL#TSA        READE     FRMTRKR
012500100719     C                   IF        NOT %EOF(FRMTRKL4) AND
012600100726     C                             FTGROUP = ZZGROUP AND
012700100719     C                             FTCLSCOD = *BLANKS AND
012800100719     C                             FTCLSDT = D'0001-01-01'
012900100719     C                   EVAL      FTCLSCOD = SCCODE
013000100719    *C                   CLEAR                   @TIMESTAMP
013100100719    *C                   MOVE      *BLANKS       @TS40
013200100719    *C                   CALL      'TIMESTMP'
013300100719    *C                   PARM                    @TS40
013400100719    *C                   MOVEL     @TS40         @TIMESTAMP
013500100719    *C                   EVAL      FTCLSUSR = @TSUSER
013600100719    *C                   MOVE      #TSCYMD       FTCLSDT
013700100719    *C                   MOVE      #TSTIME       FTCLSTM
013800100719     C                   UPDATE    FRMTRKR
013900100719     C                   ENDIF
014000100719     C                   ENDDO
014100100719     C                   MOVE      '1'           @EXIT
014200100719     C*
014300100719     C                   ENDSR
