0001009908180002 F******************************************************************
0002000011070003 F* DATEDUR    GROUP BENEFIT SERVICES SOFTWARE                     *
0003009908180004 F*                                                                *
0003019908190005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0003020011070006 F*            DATE - 11/07/00                                     *
0003039908190007 F*                                                                *
0004000011070013 F*  DESCRIPTION - subtract x days from passed date. used from     *
0005000011070004 F*                cl for robot jobs.                              *
0005010011070007 F*                                                                *
0009040011070004 F*                parameters to pass:                             *
0009050011070007 F*                -------------------                             *
0009060011070004 F*                1. starting date YYYYMMDD                       *
0009070011070004 F*                2. # of days as 999                             *
0009080503110004 F*                3. (D)ays or (M)onths                           *
0009090503100004 F*                4. returned date YYYYMMDD (pass as 00000000)    *
0009100011070004 F*                                                                *
0009110503100004 F* 03/10/05 dlk - add months option                               *
0009120503100004 F*                                                                *
0010009908180016 F******************************************************************
0020020011070037 D datewk          S               d   datfmt(*iso)                         last day of month
002003001107     c     *entry        plist
002004001107     c                   parm                    datein            8
002005050311     c                   parm                    value             3
002006050311     c                   parm                    dm                1
002007001107     c                   parm                    dateout           8
002008001107
002009001107     c                   move      datein        dateinn           8 0
002010050311     c                   move      value         valuen            3 0
025601990825     C*
025602050311     C* sub x days or months from passed date
025603990825     C*
025604001107     C                   MOVE      dateinn       datewk
025605050311     c                   if        dm = 'D'
025606050311     c                   subdur    valuen:*d     datewk
025607050310     c                   else
025608050311     c                   subdur    valuen:*m     datewk
025609050310     c                   end
025610050310
025611001107     C                   MOVE      datewk        dateoutn          8 0
025612001107     C                   MOVE      dateoutn      dateout
025613001107
025700001107     c                   eval      *inlr = *on
