000100130918      *---------------------------------------------------------------------
000200151216    * * IRS95SELR - Select Acct for IRS 1095C
000300151216    * *
000400151216    * *           BY Rick Jones
000500151216    * *           ON 12/16/2015
000600151216    * *
000700151216    * *  mm/dd/yyyy xxx -
000800151216   X* *
000900151217      **********************************************************************
001000151217   X* *
001100151217     FIRS95SELD CF   E             WORKSTN INFDS(WSDS)
001200151216     FACCMST    IF   E           K DISK
001300151216     FAC2MSTL2  IF   E           K Disk
001400130918
001500151216    * * LOCAL DATA AREA
001600000102     D                UDS
001700050317     D  FSFund                20     20
001800131029     D  @USER                100    109
001900000102     D  CONAME               201    240
002000151216    * *
002100151216    ***
002200151216     D WSDS            DS
002300151216     D  FKEY                 369    369A
002400151216    * *       FUNCTION KEYS
002500151216     D  F1             C                   CONST(X'31')
002600151216     D  F2             C                   CONST(X'32')
002700151216     D  F3             C                   CONST(X'33')
002800151216     D  F4             C                   CONST(X'34')
002900151216     D  F5             C                   CONST(X'35')
003000151216     D  F6             C                   CONST(X'36')
003100151216     D  F7             C                   CONST(X'37')
003200151216     D  F8             C                   CONST(X'38')
003300151216     D  F9             C                   CONST(X'39')
003400151216     D  F10            C                   CONST(X'3A')
003500151216     D  F11            C                   CONST(X'3B')
003600151216     D  F12            C                   CONST(X'3C')
003700151216     D  F13            C                   CONST(X'B1')
003800151216     D  F14            C                   CONST(X'B2')
003900151216     D  F15            C                   CONST(X'B3')
004000151216     D  F16            C                   CONST(X'B4')
004100151216     D  F17            C                   CONST(X'B5')
004200151216     D  F18            C                   CONST(X'B6')
004300151216     D  F19            C                   CONST(X'B7')
004400151216     D  F20            C                   CONST(X'B8')
004500151216     D  F21            C                   CONST(X'B9')
004600151216     D  F22            C                   CONST(X'BA')
004700151216     D  F23            C                   CONST(X'BB')
004800151216     D  F24            C                   CONST(X'BC')
004900151216    * *
005000151216     D                 DS
005100151216     D  @TSA                   1     10A
005200151216     D  I_TRST                 1      3S 0
005300151216     D  I_SUB#                 4      6S 0
005400151216     D  I_ACCT                 7     10S 0
005500151216    * *
005600151216    ?D invacc          C                   'Invalid Account Number'
005700151216    ?D invac2          C                   'Invalid Account(2) Number'
005800151216      *
005900000102     C     ACCKEY        KLIST
006000010103     C                   KFLD                    I_TRST
006100010103     C                   KFLD                    I_SUB#
006200010103     C                   KFLD                    I_ACCT
006300151216    * *
006400151216    * *        Mainline
006500151216    * *
006600010104     C                   MOVE      *ZEROS        I_TRST
006700010104     C                   MOVE      *ZEROS        I_SUB#
006800010104     C                   MOVE      *ZEROS        I_ACCT
006900151216   S* *
007000151216    1C                   dou       FKEY = F7
007100151216   S* *
007200010103     C                   EXFMT     IO01
007300151216    * * END APP
007400010103    1C                   IF        FKEY = F7
007500151216     C                   move      '1'           *inlr
007600151216     C                   return
007700151216    1C                   endif
007800151216   S* *
007900151216     C     ACCKEY        chain     accmst
008000151216     C                   if        NOT %FOUND(ACCMST)
008100151216     C                   movel(P)  invacc        r1msg
008200151216     C                   iter
008300010207     C                   ENDIF
008400151216   S* *
008500151216     C                   movel(P)  acnam1        sacnam1
008600151216   S* *
008700151216     C     ACCKEY        chain     ac2mstl2
008800151216     C                   If        Not %Found(AC2MSTl2)
008900151216     C                   movel(P)  invac2        r1msg
009000151216     C                   iter
009100151216     C                   ENDIF
009200151216   S* *
009300151216     C                   eval      sactin = a2tax_id#
009400151216   S* *
009500170110     C                   eval      *IN52 = '0'
009600170110     C                   If        atrmdt <> 0
009700170110     C                   eval      *IN52 = '1'
009800170110     C                   ENDIF
009900151216   S* *
010000151216     C                   EXFMT     IO02
010100151216    * * END APP
010200151216    1C                   IF        FKEY = F1
010300151216     C                   move      '1'           *inlr
010400151216     C                   return
010500151216    1C                   endif
010600151216   S* *
010700151216     C                   CALL      'IRS95CCL'
010800151216     C                   PARM                    @TSA
010900151216     C                   leave
011000151216    S *
011100151216    1C                   enddo
011200151216   S* *
011300151216     C                   move      '1'           *inlr
011400151216     C                   return
