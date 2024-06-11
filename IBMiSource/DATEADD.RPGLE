0001009908180002 F******************************************************************
0002002102230003 F* dateadd    GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0004009908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005002102230006 F*            DATE - 02/23/21                                     *
0006009908190007 F*                                                                *
0007002102230013 F*  DESCRIPTION - Add x days or months from passed date. used from *
0008000011070004 F*                cl for robot jobs.                              *
0009000011070007 F*                                                                *
0010000011070004 F*                parameters to pass:                             *
0011000011070007 F*                -------------------                             *
0012000011070004 F*                1. starting date YYYYMMDD                       *
0013000011070004 F*                2. # of days as 999                             *
0014000503110004 F*                3. (D)ays or (M)onths                           *
0015000503100004 F*                4. returned date YYYYMMDD (pass as 00000000)    *
0016000011070004 F*                                                                *
0017000503100004 F* 03/10/05 dlk - add months option                               *
0018000503100004 F*                                                                *
0019009908180016 F******************************************************************
0020000011070037 D datewk          S               d   datfmt(*iso)                         last day of month
002100001107     c     *entry        plist
002200001107     c                   parm                    datein            8
002300050311     c                   parm                    value             3
002400050311     c                   parm                    dm                1
002500001107     c                   parm                    dateout           8
002600001107
002700001107     c                   move      datein        dateinn           8 0
002800050311     c                   move      value         valuen            3 0
002900990825     C*
003000210223     C* Add x days or months from passed date
003100990825     C*
003200001107     C                   MOVE      dateinn       datewk
003300050311     c                   if        dm = 'D'
003400210223     c                   adddur    valuen:*d     datewk
003500050310     c                   else
003600210223     c                   adddur    valuen:*m     datewk
003700050310     c                   end
003800050310
003900001107     C                   MOVE      datewk        dateoutn          8 0
004000001107     C                   MOVE      dateoutn      dateout
004100001107
004200001107     c                   eval      *inlr = *on
