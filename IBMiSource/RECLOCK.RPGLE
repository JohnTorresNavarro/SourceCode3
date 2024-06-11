0000011007260002  ******************************************************************
0000021007260003  * reclock    GROUP BENEFIT SERVICES SOFTWARE                     *
0000031007260004  *                                                                *
0000041007260005  *            WRITTEN BY - DAVID KETTERMAN                        *
0000051007260006  *            DATE - 07/22/10                                     *
0000061007260007  *                                                                *
0000071007260008  * DESCRIPTION: This program will respond to a record lock by     *
000009100726      *              notifying both the user holding the record and    *
000010100726      *              the user atempting to update the file. This RPG   *
000011100726      *              should be called from a production pgm and it     *
000012100726      *              will call the cl to send the messages. This       *
000013100726      *              program was originally developed because of record*
000014100726      *              locks on the account master file that prevented   *
000015100726      *              the auto adjustments from completing.             *
000016100726      *                                                                *
000017100726      * If you want the record lock to immediately notify the users    *
000018100726      * then the file needs to be overriden with "WAITRCD(*IMMED)"     *
000020100726      * so the default 1 minute wait time is ignored.                  *
000021100726      *                                                                *
000022100726      *                                                                *
0000231007260013  ******************************************************************
0001011007220005 Femailaddr if   e           k disk
000107100722     D count           S              2  0 inz(0)                               HOLD AMOUNT (20 X 10
000108100722     D len             S              2  0 inz(0)                               HOLD AMOUNT (20 X 10
000109100726     D start           S              2  0 inz(0)                               HOLD AMOUNT (20 X 10
000110100726     D end             S              2  0 inz(0)                               HOLD AMOUNT (20 X 10
000111100726     D decimal         S              2  0 inz(0)                               HOLD AMOUNT (20 X 10
000112100726     D x               S              2  0 inz(0)                               HOLD AMOUNT (20 X 10
000113100722     D lockuser        S             10                                         HOLD AMOUNT (20 X 10
000114100723     D lockuserjob     S             10                                         HOLD AMOUNT (20 X 10
000115100726     D lockuseradr     S             30                                         HOLD AMOUNT (20 X 10
000138100722
000305100722     c                   exsr      #getuser
000332100722
000333100722     c                   call      'RECLOCKCL'
000335100723     c                   parm                    parmerr
000336100723     c                   parm                    parmjob
000337100723     c                   parm                    parmuser
000338100726     c                   parm                    parmfile
000339100727     c                   parm                    parmkey
000340100722     c                   parm                    lockuser
000341100722     c                   parm                    lockuseradr
000342100723     c                   parm                    lockuserjob
000348100722
000352100722     c                   eval      *inlr = *on
000353100722      ******************************************
000354100722      * grab userID from Error msg
000355100723      * example: Record 32224 in use by job 955143/DLK/QPADEV001P
000356100722      ******************************************
000357100722     c     #getuser      begsr
000358100722
000600100722     c                   eval      x = 1
000701100722     c                   clear                   start
000702100722     c                   clear                   end
000703100726     c                   clear                   decimal
000704100722
000800100722     c                   dou       x > 85
000801100723
000900100723     c                   if        %subst(parmerr:x:1) = '/'
001100100722     c                   if        start = *zeros
001200100726     c                   move      x             start
001300100726     c                   add       1             x
001500100722     c                   iter
001600100722     c                   end
001800100722     c                   if        end = *zeros
001900100726     c                   move      x             end
001901100723     c                   add       1             x
001902100723     c                   iter
002100100722     c                   end
002101100723     c                   end
002200100722
002201100723      * record first decimal point after jobid (end of msg)
002202100723     c                   if        start <> 0 and end <> 0 and decimal = 0
002203100723     c                             and %subst(parmerr:x:1) = '.'
002205100726     c                   move      x             decimal
002206100723     c                   leave
002207100723     c                   end
002301100722
002302100722     c                   add       1             x
002400100722     c                   enddo
002401100722
002402100722      * extract user using start and end postions of field
002403100722
002404100722     c                   clear                   lockuser
002405100726     c                   clear                   lockuseradr
002406100722     c                   if        start <> 0 and end <> 0
002407100722     c                   add       1             start
002408100722     c                   eval      len = end - start
002409100723     c                   eval      lockuser = %subst(parmerr:start:len)
002410100722     c     lockuser      chain     emailaddr
002411100722     c                   if        %found(emailaddr)
002412100722     c                   move      EAEMAIL       lockuseradr
002413100722     c                   end
002414100722     c                   end
002415100723
002416100723      * extract job (workstation ID) from error msg
002417100723
002418100723     c                   clear                   lockuserjob
002420100723     c                   if        start <> 0 and end <> 0 and decimal <> 0
002421100723     c                   add       1             end
002422100723     c                   eval      len = decimal - end
002423100723     c                   eval      lockuserjob = %subst(parmerr:end:len)
002428100723     c                   end
002500100722
002800100722     c                   endsr
002801100723
002900100723     c     *inzsr        begsr
003000100723     c     *entry        plist
003100100723     c                   parm                    parmerr          80
003200100723     c                   parm                    parmjob          10
003300100723     c                   parm                    parmuser         10
003301100726     c                   parm                    parmfile         10
003302100727     c                   parm                    parmkey          20
003400100723     c                   endsr
003500100723
