0001009211230002 F******************************************************************
0002009502070003 F* RPP020  GROUP BENEFIT SERVICES SOFTWARE           1995         *
0003009211230007 F*                                                                *
0004009409150005 F*            WRITTEN BY - G.L.C.                                 *
0005009502070006 F*            DATE - 2/07/95                                      *
0006009211230007 F*                                                                *
0007009502070006 F*  DESCRIPTION - THIS PROGRAM WILL PROVIDE UPDATE OF THE SGR     *
0008009502070007 F*                PROPOSAL MESSAGE FILE. THE MESSAGE INPUT        *
0009009502070008 F*                HERE WILL APPEAR ON THE BOTTOM OF THE PRO-      *
0010009502070008 F*                POSAL OR COMPARISON. THE PROPOSAL (RPP010)      *
0011009502070008 F*                IS RUN FOR EXISTING ACCOUNTS, AND THE PRO-      *
0012009502070008 F*                POSAL IS RUN FOR NEW GROUPS IN MARKETING.       *
0013009408030008 F*                                                                *
0014009211230009 F******************************************************************
0015009211230010 F*                                                                *
001600950208     FRPP020FM  CF   E             WORKSTN
001700950207     FPROMSG    UF A E           K DISK
001800940915     I*
001900950207     IPROMSR
002000941003     I*
002100940915     C************************************************
002200940915     C************************************************
002300950207     C* KEY PROPOSAL MESSAGE FILE
002400950207     C     KEYMSG        KLIST
002500950207     C                   KFLD                    KMSG              3
002600950207     C************************************************
002700940929     C*
002800950207     C* GET SELECTION - EITHER PROPOSAL OR COMPARISION
002900940929     C******************************************************
003000950208     C     BEGIN         TAG
003100950208     C*
003200950207     C                   EXFMT     SCRN02
003300950207     C* FUNCTION KEY 7 TO END PROGRAM
003400950207     C     *IN99         CABEQ     '1'           ENDPGM
003500950207     C*
003600950207     C******************************************************
003700950207     C* MOVE SELECTION TO KEY AND RETRIEVE RECORD
003800950207     C*
003900950207     C     SEL1          IFNE      ' '
004000950207     C                   MOVE      'CMP'         KMSG
004100950207     C                   ELSE
004200950207     C                   MOVE      'PRO'         KMSG
004300950207     C                   END
004400950207     C*
004500950207     C     KEYMSG        CHAIN     PROMSG                             10
004600950207     C   10              MOVE      KMSG          MSGKEY
004700950208     C   10              WRITE     PROMSR
004800940923     C*
004900950207     C******************************************************
005000950207     C* WRITE SCREEN FOR OPERATOR INPUT
005100950207     C******************************************************
005200950208     C   10KEYMSG        CHAIN     PROMSG                             10
005300950207     C                   EXFMT     SCRN01
005400950207     C*
005500950207     C* FUNCTION KEY 7 TO END PROGRAM
005600950207     C     *IN99         CABEQ     '1'           ENDPGM
005700950208     C*
005800950208     C* UPDATE NEW MESSAGE
005900950208     C                   UPDATE    PROMSR
006000950208     C*
006100950208     C                   GOTO      BEGIN
006200950208     C*
006300950208     C     ENDPGM        TAG
006400950208     C                   SETON                                        LR
