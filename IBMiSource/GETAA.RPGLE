000100140120   X***X SSK MAKE A FUNTCION LATER
000200140120   X***X     PROGRAM IS QUICKER
000300140120   X***X     01/20/2014  AA CODE RETRIEVAL
000400140120   X***X
000500140120   X***X PARAMETER IS 69 BYTES
000600140120   X***X POS 1-3 IS TRUST; 4-6 IS SUBDIVISION; 7-10 IS ACCOUNT;
000700140120   X***X POS 11-15 IS YOUR REQUEST AS DEFINED BELOW;
000800140120   X***X POS 16-65 IS THE REQUESTED VALUE OR FAILURE REASON [50 BYTES];
000900140120   X***X POS 66-68 IS THE AACODE; POS 69-69 IS PASS/FAIL RETURN FLAG.
001000140120   X***X
001100140120   X***X
001200140120     FACMUNIQUE IF   E           K DISK    PREFIX(A_)
001300140120     FAACODE    IF   E           K DISK
001400140120   X***X
001500140120     D                 DS
001600140120     D PARM@DS                 1     69A
001700140120     D KF@TRS                  1      3S 0
001800140120     D KF@SUB                  4      6S 0
001900140120     D KF@ACC                  7     10S 0
002000140120     D PRM_REQ                11     15A
002100140120    ***  'NAME ' RETURNS "FIRST LAST"      'EMAIL' RETURNS EMAIL ADDRESS
002200140120    ***  'NAME,' RETURNS "LAST, FIRST"     'PHONE' RETURNS DIRECT DIAL
002300140120     D PRM_DTA                16     65A
002400140120    ***
002500140120     D PRM_AA                 66     68
002600140120    ***
002700140120     D PRM_RES                69     69A
002800140120    ***  P=PASS F=FAIL
002900140120   X***X
003000140120     C     *ENTRY        PLIST
003100140120     C                   PARM                    PARM@IN          69
003200140120    ***
003300140120     C                   EXSR      $PROC
003400140120    ***
003500140120     C                   EVAL      PARM@IN = PARM@DS
003600140120    ***
003700140120     C                   EVAL      *INLR = *ON
003800140120     C                   RETURN
003900140120    ***
004000140120   S***S
004100140120     C     $PROC         BEGSR
004200140120    ***
004300140120     C                   CLEAR                   PARM@DS
004400140120    ***
004500140120     C                   EVAL      PARM@DS = PARM@IN
004600140120     C                   EVAL      PRM_RES = 'F'
004700140120    ***
004800140120     C     KL#TSA        KLIST
004900140120     C                   KFLD                    KF@TRS
005000140120     C                   KFLD                    KF@SUB
005100140120     C                   KFLD                    KF@ACC
005200140120    ***
005300140120     C     KL#TSA        CHAIN     ACCMSR
005400140120    ***
005500140120     C                   IF        NOT %FOUND(ACMUNIQUE)
005600140120     C                   EVAL      PRM_DTA = 'ACCOUNT NOT FOUND'
005700140120     C                   LEAVESR
005800140120     C                   ENDIF
005900140120    ***
006000140120     C                   IF        A_AACODE = *BLANKS
006100140120     C                   EVAL      PRM_DTA = 'ACCT W/O AA CODE'
006200140120     C                   LEAVESR
006300140120     C                   ENDIF
006400140120    ***
006500140120     C                   EVAL      PRM_AA = A_AACODE
006600140120    ***
006700140120     C     A_AACODE      CHAIN     AACODR
006800140120    ***
006900140120     C                   IF        NOT %FOUND(AACODE)
007000140120     C                   EVAL      PRM_DTA = 'AA CODE NOT FOUND'
007100140120     C                   LEAVESR
007200140120     C                   ENDIF
007300140120    ***
007400140120     C                   SELECT
007500140120     C                   WHEN      PRM_REQ = 'NAME '
007600140120     C                   EVAL      PRM_DTA = %TRIM(AFNAM) + ' ' +
007700140120     C                               %TRIM(ALNAM)
007800140120     C                   WHEN      PRM_REQ = 'NAME,'
007900140120     C                   EVAL      PRM_DTA = %TRIM(ALNAM) + ', ' +
008000140120     C                               %TRIM(AFNAM)
008100140120     C                   WHEN      PRM_REQ = 'EMAIL'
008200140120     C                   EVAL      PRM_DTA = %TRIM(AEMLA)
008300140120     C                   WHEN      PRM_REQ = 'PHONE'
008400140120     C                   EVAL      PRM_DTA = %EDITC(ADDIAL:'X')
008500140120     C                   OTHER
008600140120     C                   EVAL      PRM_DTA = 'INVALID REQ CODE'
008700140120     C                   LEAVESR
008800140120     C                   ENDSL
008900140120    ***
009000140120     C                   EVAL      PRM_RES = 'P'
009100140120    ***
009200140120     C                   ENDSR
