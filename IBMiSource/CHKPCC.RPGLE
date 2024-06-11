000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300100520    ? *  Description:  Check Pay Choice Codes
000400000000    ? *
000500100520    ? *  (c)Copyright 2010 by GBS, Inc.
000600000000    ? *___________________________________________________________________
000601100610    ?FWEBPAYCHP IF   E           K DISK
000700100610    ?FWEBPAYGRP IF   E           K DISK
000800100521     FACCMST    IF   E           K DISK
000900000000    ? *
001000010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100060303    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500100520    ?D WUDTA         E DS                  EXTNAME(WEBPAYCHP)
001600000810    ? *
001700000000    ? * Program status data structure
001800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000    ? *___________________________________________________________________
002000000000    ? * Process check request
002100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002200000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002300000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002400000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002500000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002600000000    ?C                   Endcs                                                  END CASE
002700000000    ?C                   Return                                                 RETURN
002800000000    ? *___________________________________________________________________
002900000000    ? * Edit record
003000000000    ? *___________________________________________________________________
003100000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003200000810    ? *
003300000810    ? * Defualt Data
003400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003500020923    ? *
003600100521    ? * Check default
003700100609     C                   If        pctrst =  *zeros  and
003701100609     C                             %trim(PCGRPR) <> 'RULE'
003800020923    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003900070921    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004000020923    ?C                   Exsr      SNDMSG                                       SEND MSG
004100020923     C                   Endif
004101100610    ? *
004102100610    ? * Check valid grouper
004103100610     C     PCGRPR        Chain     WEBPAYGRP
004104100610     C                   If        not %found(WEBPAYGRP)
004105100610    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004106100610    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
004107100610    ?C                   Exsr      SNDMSG                                       SEND MSG
004108100610     C                   LeaveSR
004109100610     C                   Endif
004200100521    ? *
004300100521    ? * Check TSA
004301100609     C                   If        %trim(PCGRPR) <> 'RULE'
004400100521     C     KEYACC        Chain     ACCMST
004500100521     C                   if        not %found(ACCMST)
004600100521    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004700100521    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004800100521    ?C                   Exsr      SNDMSG                                       SEND MSG
004801100609     C                   End
004900100521     C                   End
005000100521    ? *
005100100521    ? * Check description
005101100914     C                   If        pccode <> *blanks and
005200100914     C                             pcdesc =  *blanks
005300100521    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005400100610    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
005500100521    ?C                   Exsr      SNDMSG                                       SEND MSG
005600100521     C                   Endif
005601100902    ? *
005602100902     C                   If        %trim(PCGRPR) = '401K PLAN'  and
005604100902     C                             %trim(PCCODE) <> '31'        and
005605100902     C                             %trim(PCGRPR) = '401K PLAN'  and
005606100902     C                             %trim(PCCODE) <> '33'
005607100913    ?C***                Move      'ERROR   '    WORTN                          REQUEST ERROR
005608100913    ?C***                Move      WTM(9)        WWMSG                          PASS MSG
005609100913    ?C***                Exsr      SNDMSG                                       SEND MSG
005610100902     C                   End
005611100902    ? *
005612100902     C                   If        %trim(PCGRPR) = 'FSA MED'  and
005613100902     C                             PCPPAY = *ZEROS
005614101018    ?C***                Move      'ERROR   '    WORTN                          REQUEST ERROR
005615101018    ?C***                Move      WTM(7)        WWMSG                          PASS MSG
005616101018    ?C***                Exsr      SNDMSG                                       SEND MSG
005617100902     C                   End
005618100902    ? *
005619100902     C                   If        %trim(PCGRPR) = 'FSA MED'  and
005620100902     C                             PCPYER = *ZEROS
005621101018    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005622100902    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
005623100902    ?C                   Exsr      SNDMSG                                       SEND MSG
005624100902     C                   End
005625101115    ? *
005626101115     C                   If        %trim(PCGRPR) = 'EMPSTAT'  and
005627101115     C                             PCEMPC = *BLANKS
005628101115    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005629101115    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
005630101115    ?C                   Exsr      SNDMSG                                       SEND MSG
005631101115     C                   End
005632100902    ? *
005633100902     C                   If        %trim(PCGRPR) = 'FSA DEP'  and
005634100902     C                             PCPPAY = *ZEROS
005635101018    ?C***                Move      'ERROR   '    WORTN                          REQUEST ERROR
005636101018    ?C***                Move      WTM(7)        WWMSG                          PASS MSG
005637101018    ?C***                Exsr      SNDMSG                                       SEND MSG
005638100902     C                   End
005639100902    ? *
005640100913     C                   If        %trim(PCGRPR) = '401K PLAN'  and
005641100913     C                             PCPPAY = *ZEROS              and
005642100913     C                             PCPYER = *ZEROS
005643100913    ?C***                Move      'ERROR   '    WORTN                          REQUEST ERROR
005644100913    ?C***                Move      WTM(8)        WWMSG                          PASS MSG
005645100913    ?C***                Exsr      SNDMSG                                       SEND MSG
005646100902     C                   End
005647100902    ? *
005648100902     C                   If        %trim(PCGRPR) = 'FSA PARK' and
005649100902     C                             PCPPAY = *ZEROS
005650101018    ?C***                Move      'ERROR   '    WORTN                          REQUEST ERROR
005651101018    ?C***                Move      WTM(7)        WWMSG                          PASS MSG
005652101018    ?C***                Exsr      SNDMSG                                       SEND MSG
005653100902     C                   End
005654100902    ? *
005655100902     C                   If        %trim(PCGRPR) = 'FSA PARK' and
005656100902     C                             PCPYER = *ZEROS
005657100902    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005658100902    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
005659100902    ?C                   Exsr      SNDMSG                                       SEND MSG
005660100902     C                   End
005661100902    ? *
005662100902     C                   If        %trim(PCGRPR) = 'FSA TRAN' and
005663100902     C                             PCPPAY = *ZEROS
005664101018    ?C***                Move      'ERROR   '    WORTN                          REQUEST ERROR
005665101018    ?C***                Move      WTM(7)        WWMSG                          PASS MSG
005666101018    ?C***                Exsr      SNDMSG                                       SEND MSG
005667100902     C                   End
005668100902    ? *
005669100902     C                   If        %trim(PCGRPR) = 'FSA TRAN' and
005670100902     C                             PCPYER = *ZEROS
005671100902    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005672100902    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
005673100902    ?C                   Exsr      SNDMSG                                       SEND MSG
005674100902     C                   End
005700031215    ? *
005800010913    ?C                   Endsr                                                  END DLT RQST
005900000000    ? *___________________________________________________________________
006000000000    ? * Edit delete request
006100000000    ? *___________________________________________________________________
006200000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
006201100609    ? *
006202100609    ? * Check default
006203100610     C                   If        pctrst =  *zeros
006205100609    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006206100609    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006207100609    ?C                   Exsr      SNDMSG                                       SEND MSG
006208100609     C                   Endif
006300000000    ?C                   Endsr                                                  END DLT RQST
006400000000    ? *___________________________________________________________________
006500000000    ? * Default data
006600000000    ? *___________________________________________________________________
006700000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
006800000000    ?C                   Endsr                                                  END DFT DATA
006900000000    ? *___________________________________________________________________
007000000000    ? * Send messages
007100000000    ? *___________________________________________________________________
007200000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
007300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
007400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
007500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
007600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
007700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
007800000000    ?C                   Endsr                                                  END SND ERRMSG
007900000000    ? *___________________________________________________________________
008000000000    ? * Process error
008100000000    ? *___________________________________________________________________
008200000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
008300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
008500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
008600000000    ?C                   Endsr                                                  END PRCERR
008700000000    ? *___________________________________________________________________
008800000000    ? * Parameter list
008900000000    ? *___________________________________________________________________
009000000000    ?C     PLIST         Begsr                                                  PARM LISTS
009100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
009200000000    ?C                   Parm                    WIRQS             8            REQUEST
009300000000    ?C                   Parm                    WORTN             8            RETURN CODE
009400000614    ?C                   Parm                    WUDTA                          DATA
009500000000    ?C                   Endsr                                                  END PLIST
009600000000    ? *___________________________________________________________________
009700000000    ? * Define Variables and Key Lists
009800000000    ? *___________________________________________________________________
009900000000    ?C     DEFN          Begsr                                                  PARM LISTS
010000000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
010100000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
010200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
010300000000    ?C                   Endsr                                                  END DEFN
010400010914    ? *___________________________________________________________________
010500010914    ? * Key lists
010600010914    ? *___________________________________________________________________
010700010914    ?C     KLIST         Begsr                                                  KEY LISTS
010800100521     C     KEYACC        Klist
010900100521     C                   kfld                    PCTRST
011000100521     C                   kfld                    PCSUB#
011100100521     C                   kfld                    PCACCT
011200010914    ?C                   Endsr
011300000000    ? *___________________________________________________________________
011400000000    ? * Program error handler
011500000000    ? *___________________________________________________________________
011600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
011700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
011800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
011900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012300031215      *-------------------------------------------------------------------*
012400031215      * Format Date
012500031215      *-------------------------------------------------------------------*
012600031215     C     FMTDATE       Begsr
012700031215     C                   Eval      Input_Format  = 'MMDDYYYY'
012800031215     C                   Eval      Output_Format = 'MMDDYYYY'
012900031215     C                   Call      'FMTDATE'
013000031215     C                   Parm                    Input_Date       32
013100031215     C                   Parm                    Input_Format     32
013200031215     C                   Parm                    Output_Format    32
013300031215     C                   Parm                    Output_Date      32
013400031215     C                   Parm                    Output_Error     10
013500031215     C                   Endsr
013600000000    ? *___________________________________________________________________
013700000112** WTMP
01380000000000T-Record is not eligible for deletion.
01390010052000Request not supported by program CHKPCC.
014000000117** WTM
01410010052161Please contact IS if you need to add or change a default code.
01420010052161Account Number is invalid.
01430010052162Code Value is required.
01440010052163Description is required
01440110061061Please contact IS if you need to delete a default code.
01440210090264Grouper Code must already exist (F4) prompt
01440310090265Plan Requires Per Pay contribution amount
01440410090266Plan Requires Per Year contribution amount
01440510111562401K PayChoice code must be 31 if $ or 33 if %
01450010111567Please enter an employee status code
