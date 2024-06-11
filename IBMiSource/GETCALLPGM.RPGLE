000100170825      *----------------------------------------------------------------
000200170825      *
000300170825      *   Program Name: GetCallPgm
000400170825      *
000500170825      *   Description:  Get the Name of the Calling Program.
000600170825      *    ** Used for Triggers.
000700170825      *
000800170825      *   Author/Date:  B.Rees   11/07/2014
000900170825      *
001000170825      *----------------------------------------------------------------
001100170825      * System API error code
001200170825
001300170825     D Qusec           DS
001400170825     D  QusBPrv                1      4B 0
001500170825     D  QusBAvl                5      8B 0
001600170825     D  Qusei                  9     15
001700170825     D  Quserved              16     16
001800170825
001900170825      * Type definition for the RCVM0200 format
002000170825     D RCVM0200        DS           120
002100170825     D  Program              111    120
002200170825
002300170825
002400170825      *----------------------------------------------------------------
002500170825      * Standalone Field Definitions                                 *
002600170825      *----------------------------------------------------------------
002700170825
002800170825      * Program message parameters
002900170825     D Pm_MsgId        S              7    Inz(*BLANKS)
003000170825     D Pm_MsgF         S             20    Inz(*BLANKS)
003100170825     D Pm_MsgDta       S             12    Inz('Who are you?')
003200170825     D Pm_Length       S              9B 0
003300170825     D Pm_MType        S             10    Inz('*INFO')
003400170825     D Pm_MKey         S              4    Inz(*BLANKS)
003500170825     D Pm_CSEntry      S             10    Inz('*')
003600170825     D Pm_Counter      S              9B 0 Inz(5)
003700170825
003800170825     D Pm_Format       S              8    Inz('RCVM0200')
003900170825     D Pm_Wait         S              9B 0 Inz(0)
004000170825     D Pm_Action       S             10    Inz('*REMOVE')
004100170825
004200170825
004300170825      *----------------------------------------------------------------
004400170825      * Parameter Lists                                              *
004500170825      *----------------------------------------------------------------
004600170825     C     *Entry        PList
004700170825     C                   Parm                    Caller           10
004800170825
004900170825
005000170825      *----------------------------------------------------------------
005100170825      * Main Program                                                 *
005200170825      *----------------------------------------------------------------
005300170825      * Set error code structure not to use exceptions
005400170825      * Set length of message data
005500170825     C                   Z-Add     12            Pm_Length
005600170825
005700170825      * Send program message
005800170825     C                   Call      'QMHSNDPM'
005900170825     C                   Parm                    Pm_MsgId
006000170825     C                   Parm                    Pm_MsgF
006100170825     C                   Parm                    Pm_MsgDta
006200170825     C                   Parm                    Pm_Length
006300170825     C                   Parm                    Pm_MType
006400170825     C                   Parm                    Pm_CSEntry
006500170825     C                   Parm                    Pm_Counter
006600170825     C                   Parm                    Pm_MKey
006700170825     C                   Parm                    Qusec
006800170825
006900170825      * Check for errors
007000170825     C                   If        QusBAvl > 0
007100170825     C
007200170825     C                   Exsr      *PSSR
007300170825     C                   EndIf
007400170825
007500170825
007600170825      * Clear return data structure
007700170825     C                   Clear                   RCVM0200
007800170825
007900170825      * Set length of message information
008000170825     C                   Z-Add     120           Pm_Length
008100170825
008200170825
008300170825      * Receive program message
008400170825     C                   Call      'QMHRCVPM'
008500170825     C                   Parm                    RCVM0200
008600170825     C                   Parm                    Pm_Length
008700170825     C                   Parm                    Pm_Format
008800170825     C                   Parm                    Pm_CSEntry
008900170825     C                   Parm                    Pm_Counter
009000170825     C                   Parm                    Pm_MType
009100170825     C                   Parm                    Pm_MKey
009200170825     C                   Parm                    Pm_Wait
009300170825     C                   Parm                    Pm_Action
009400170825     C                   Parm                    Qusec
009500170825
009600170825      * Check for errors
009700170825     C                   If        QusBAvl > 0
009800170825     C                   Exsr      *PSSR
009900170825     C                   EndIf
010000170825
010100170825     C                   Move      Program       Caller
010200170825     C                   Return
010300170825
010400170825      *----------------------------------------------------------------
010500170825      * *PSSR - Error Handling Subroutine                            *
010600170825      *----------------------------------------------------------------
010700170825     C     *PSSR         Begsr
010800170825     C                   Return
010900170825     C                   Endsr
