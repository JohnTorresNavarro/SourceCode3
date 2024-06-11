0000060204050002 F******************************************************************
0000070204050003 F* IQ012      GROUP BENEFIT SERVICES SOFTWARE                     *
0000080204050004 F*                                                                *
0000090204050005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0000100204050006 F*            DATE - 04/02/02                                     *
0000110204050007 F*                                                                *
0000120204050007 F* Find an acount with the name containing a selcted value.       *
0000130204050007 F* This program will be called from IQ010 when the "Account       *
0000140204050007 F* Name Contains" search is used.                                 *
0000150205010007 F* All database IO is handeld by SQL embedded in this SQLRPGLE    *
0000160204050007 F* source.                                                        *
0000170204050007 F*                                                                *
0000180204050013 F******************************************************************
001200020327     Fiq012d    CF   E             WORKSTN
001300961031     F                                     SFILE(SF01:RRN)
002712010330
0027130204030484 D                 DS
0027140204030485 D  tsaout                 1     10  0
0027150204030486 D  t                      1      3  0
0027160204030487 D  S                      4      6  0
0027170204030488 D  A                      7     10  0
002718020404
002719020404     D* TRUST SECURITY ARRAY
0027200204040189 D                 DS
0027210204040217 D  ST                     1     30  0
002722020404     D                                     DIM(10)                              TRUST SECURITYRRAY
002723020404     D  OSCT1                  1      3  0
002724020404     D  OSCT2                  4      6  0
002725020404     D  OSCT3                  7      9  0
002726020404     D  OSCT4                 10     12  0
002727020404     D  OSCT5                 13     15  0
002728020404     D  OSCT6                 16     18  0
002729020404     D  OSCT7                 19     21  0
002730020404     D  OSCT8                 22     24  0
002731020404     D  OSCT9                 25     27  0
002732020404     D  OSCT10                28     30  0
0027330204040600 D                UDS
0027340204040601 D  $USER                  1     10
0027350204040601 D  CONAME               201    240
0027360204040601 D  prefix               241    241
002737020403
002738020405      * SQL statement fields
002739020405
0027400204030040 D selectone       S            500a   inz('SELECT ACNAM1, actrst, acsub#, -
0027410204040040 D                                     acacct, acity, astate, contac, -
0027420204040040 D                                     atrmdt from ')
0027430204040040 D whereclause     s             30    inz('where acnam1 like ')
0027440204090040 D activeclause    s             30    inz('and atrmdt = 0')
0027450204020040 D orderclause     S            500a   inz('ORDER BY ACNAM1')
0027460204020040 D selecttwo       S            500a   inz(' ')
0027470204020040 D likeclause      S             50a   inz(' ')
0027480204020040 D quote           S              1a   inz('''')
0027490204040040 D filename        S              8a
002750020405
002751020404     c     *entry        plist
002752020404     c                   parm                    parmtsa          10
002753020404     c                   parm                    parmname         30
002754020409     c                   parm                    parmactive        1
002769020404
002771020405     c                   movel     parmname      sname
002772020405     c                   eval      *in01 = *off
002773020404
002774020402     C* CLEAR SUBFILE
002775020405
002776020402     C                   MOVEA     '001'         *IN(90)
002777020402     C                   WRITE     SF01CTL
002778020402     C                   MOVE      '0'           *IN92
002779020402     C                   MOVE      *ZEROS        RRN               5 0
002780020327
002781020408     c* connect to LOCAL DB2 database - not needed?
002786020408      *c/exec sql
002787020408      *c+ connect reset
002788020408      *c/end-exec
002791020408
002792020402     c                   exsr      #prep
002793020402
002794020402     c                   exsr      #loadsf
012200020404
012300020226     C* DISPLAY SUBFILE
012400020404
012804020226     C                   if        rrn = 0
012805020226     c                   clear                   sf01
012806020402     c                   eval      acnamout = '* NOT FOUND *'
012807020226     c                   add       1             rrn
012808020226     c                   write     sf01
012809020226     C                   end
012810020402
012811020402     c                   exsr      #closecsr
012814020226
012815020226     C                   eval      *in90 = *on
012816020402     C                   eval      *in91 = *on
012817020226
012900010402     C* display subfile with text at bottom
012902010402
012903020404     c                   dow       *in01 = *off
013001010402     C                   WRITE     Sf01CMDKY
013100961031     C                   EXFMT     SF01CTL
013101020404
013102020405     c* find which account (if any) has been selected
013103020404
013104020404     c                   eval      *in33 = *off
013105020404     c                   dow       *in33 = *off
013106020404     c                   readc     sf01                                   33
013107020404     c                   if        *in33 = *off and select <> *blank
013108020404     c                   move      tsaout        parmtsa
013109020404     c                   leave
013110020404     c                   end
013111020404     c                   enddo
013112020404
013113020404     c* if acct was selected, pass it back to calling pgm
013116020404
013117020404     c                   if        parmtsa <> *blanks
013118020404     c                   return
013119020404     c                   end
013120020404
013121020404     c                   enddo
013122020404
013123020405     c* when cmd1 and no acct selected - return to calling pgm
013126020404
013128020404     c                   return
013201020402
013202020404     c************************************************************
013203020404     c* prepare the SQL in the format :                          *
013204020404     c*                                                          *
013205020404     c*    select acnam1, actrst, acsub#, acacct, acity, astate, *
013206020404     c*    contac, atrmdt from "F.ACCNAM" where acnam1 like      *
013207020404     c*    '%WHAT EVER THEY SELECT%' order by acnam1             *
013208020404     c*                                                          *
013209020404     c************************************************************
013300020402     c     #prep         begsr
013301020402
013603020404     C                   eval      likeclause = quote + '%' + %trimr(sname) +
013604020404     c                                          '%' + quote
013605020409     c                   if        parmactive = 'Y'
013606020402     C                   eval      selecttwo = %trimr(selectone) +
013607020404     c                                         '"' + filename + '"' +
013608020404     c                                         whereclause +
013609020404     c                                         %trimr(likeclause) +
013610020409     c                                         activeclause +
013611020402     c                                         %trimr(orderclause)
013612020409     c                   else
013613020409     C                   eval      selecttwo = %trimr(selectone) +
013614020409     c                                         '"' + filename + '"' +
013615020409     c                                         whereclause +
013616020409     c                                         %trimr(likeclause) +
013617020409     c                                         %trimr(orderclause)
013618020409     c                   end
013619020402
013620020409      * prepare the select statemnt
013621020409
013700020402     c/exec sql
013800020402     c+ prepare sel from :selecttwo
013801020409     c/end-exec
013802020409
013902020402      * declare the SQL cursor to hold the data retrieved from the select
013904020402      * *NOTE: The declare cursor statement MUST be before any other SQL
013905020402      *        statements that reference the cursor
013906020409
013907020409     c/exec sql
013908020409     c+ declare mycsr scroll cursor for sel
013909020409     c/end-exec
013910020409
013911020409      * open the SQL cursor
013912020409
013913020409     c/exec sql
014400020402     c+ open MYCSR
014500020402     c/end-exec
014600020402
014700020402     c                   endsr
014701020402
014800020402     c******************************************
014900020402     c* load subfile                           *
015000020402     c******************************************
015200020402     c     #loadsf       begsr
015201020402
015203020403      * process records in the SQL cursor while the return code is 0
015204020409      * and subfile does not reach max 9999 records
015205020403
015206020409     c                   dow       sqlcod = 0 and rrn < 9998
015207020402
015209020402      * get the next row from the SQL cursor
015210020402
015211020402     c/exec sql
015212020402     c+ fetch next from MYCSR
015213020404     c+  into :acnamout,
015214020404     c+       :t,
015215020404     c+       :s,
015216020404     c+       :a,
015217020404     c+       :cityout,
015218020404     c+       :stateout,
015219020404     c+       :contout,
015220020404     c+       :termdtout
015224020402     c/end-exec
015225020402
0152260204041062 C***************************************************************
015227020404     C* TRUST SECURITY
015228020404     C     T##           IFNE      0
015230020404     C     T             LOOKUP    ST                                     34
015233020404     C  n34              iter
015234020404     C                   END
0152350204041062 C***************************************************************
015236020404
015237020404     C                   MOVE      termdtout     @DATIN
015238020404     C                   EXSR      #DATYM
015239020404     C                   MOVE      @DATOU        termdtout
015240020417
015241020417     c                   if        termdtout <> 0
015242020417     c                   eval      statusout = 'CANCEL'
015243020417     c                   else
015244020417     c                   eval      statusout = 'ACTIVE'
015245020417     c                   end
015246020404
015247020402     C* BUILD SUBFILE - if return code = 0 (no errors) then add to subfile
015248020403     c                   if        sqlcod = 0
015249020404     C                   clear                   select
015250020404     C                   ADD       1             RRN
015251020402     C                   WRITE     SF01
015252020403     c                   end
015253020403     c                   enddo
015254020402
015300020402     c                   endsr
015400020402     c******************************************
015500020405     c* close SQL cursor                       *
015600020402     c******************************************
015700020402     c     #closecsr     begsr
015702020402
015703020402     c/exec sql
015704020402     c+ close MYCSR
015705020402     c/end-exec
015706020402
015707020402     c                   endsr
0158000204040103 C***************************************************
0159000204040104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0160000204040105 C***************************************************
0161000204040107
0162000204040107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0163000204040107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0164000204040107
0165000204040106 C     #DATYM        BEGSR
016600020404     C                   MOVE      @DATIN        @MD               4 0
016700020404     C                   MOVEL     @DATIN        @Y                4 0
016800020404     C                   MOVEL     @MD           @DATOU            8 0
016900020404     C                   MOVE      @Y            @DATOU
017000020404     C                   MOVE      *ZEROS        @DATIN            8 0
0171000204040120 C                   ENDSR
017200020404
017202020404     C****************************************************************
017203020404     C* CALL SECURITY PROGRAM FOR TRUST SECURITY
017204020404     C****************************************************************
017205020404     C     $SECAL        BEGSR
017206020404     C                   MOVEL     $USER         ISCUSR
017207020404     C                   CALL      'SC020'
017208020404     C                   PARM                    ISCUSR           10            USERID
017209020404     C                   PARM                    ISCALL            3            ALL SEC.
017210020404     C                   PARM                    ISCT1             3 0          TRUST1
017211020404     C                   PARM                    ISCT2             3 0          TRUST2
017212020404     C                   PARM                    ISCT3             3 0          TRUST3
017213020404     C                   PARM                    ISCT4             3 0          TRUST4
017214020404     C                   PARM                    ISCT5             3 0          TRUST5
017215020404     C                   PARM                    ISCT6             3 0          TRUST6
017216020404     C                   PARM                    ISCT7             3 0          TRUST7
017217020404     C                   PARM                    ISCT8             3 0          TRUST8
017218020404     C                   PARM                    ISCT9             3 0          TRUST9
017219020404     C                   PARM                    ISCT10            3 0          TRUST10
017220020404     C                   PARM                    ISCS1             3 0          SUB 1
017221020404     C                   PARM                    ISCS2             3 0          SUB 2
017222020404     C                   PARM                    ISCS3             3 0          SUB 3
017223020404     C                   PARM                    ISCS4             3 0          SUB 4
017224020404     C                   PARM                    ISCS5             3 0          SUB 5
017225020404     C                   PARM                    ISCS6             3 0          SUB 6
017226020404     C                   PARM                    ISCS7             3 0          SUB 7
017227020404     C                   PARM                    ISCS8             3 0          SUB 8
017228020404     C                   PARM                    ISCS9             3 0          SUB 9
017229020404     C                   PARM                    ISCS10            3 0          SUB 10
017230020404     C                   PARM                    ISCA1             4 0          ACT 1
017231020404     C                   PARM                    ISCA2             4 0          ACT 2
017232020404     C                   PARM                    ISCA3             4 0          ACT 3
017233020404     C                   PARM                    ISCA4             4 0          ACT 4
017234020404     C                   PARM                    ISCA5             4 0          ACT 5
017235020404     C                   PARM                    ISCA6             4 0          ACT 6
017236020404     C                   PARM                    ISCA7             4 0          ACT 7
017237020404     C                   PARM                    ISCA8             4 0          ACT 8
017238020404     C                   PARM                    ISCA9             4 0          ACT 9
017239020404     C                   PARM                    ISCA10            4 0          ACT 10
017240020404     C                   PARM                    ISAA1             3            AGN 1AGENCY
017241020404     C                   PARM                    ISAA2             3            AGN 2
017242020404     C                   PARM                    ISAA3             3            AGN 3
017243020404     C                   PARM                    ISAA4             3            AGN 4
017244020404     C                   PARM                    ISAA5             3            AGN 5
017245020404     C                   PARM                    ISAA6             3            AGN 6
017246020404     C                   PARM                    ISAA7             3            AGN 7
017247020404     C                   PARM                    ISAA8             3            AGN 8
017248020404     C                   PARM                    ISAA9             3            AGN 9
017249020404     C                   PARM                    ISAA10            3            AGN 10
017250020404     C                   PARM                    ISCBRK            3            BROKER
017251020404     C                   PARM                    ISCDSP            1            DISPLAY ONLY
017252020404     C                   PARM                    ISSUPD            1            UPDATE SEC.
017253020404     C                   PARM                    ISCNAM           40            NAME
017254020404     C                   PARM                    ISCBUS           40            BUSINESS
017255020404     C                   PARM                    ISCADD           40            ADDRESS
017256020404     C                   PARM                    ISCITY           40            CITY
017257020404     C                   PARM                    ISCST             2            STATE
017258020404     C                   PARM                    ISCPHO           10            PHONE
017259020404     C                   PARM                    ISCFAX           10            FAX
017260020404     C                   PARM                    NOS               1            NO USER
017261020404     C***                FREE      'SC020'
017262020404     C                   MOVE      ISCT1         OSCT1                          TRUST1
017263020404     C                   MOVE      ISCT2         OSCT2                          TRUST2
017264020404     C                   MOVE      ISCT3         OSCT3                          TRUST3
017265020404     C                   MOVE      ISCT4         OSCT4                          TRUST4
017266020404     C                   MOVE      ISCT5         OSCT5                          TRUST5
017267020404     C                   MOVE      ISCT6         OSCT6                          TRUST6
017268020404     C                   MOVE      ISCT7         OSCT7                          TRUST7
017269020404     C                   MOVE      ISCT8         OSCT8                          TRUST8
017270020404     C                   MOVE      ISCT9         OSCT9                          TRUST9
017271020404     C                   MOVE      ISCT10        OSCT10                         TRUST10
017272020404     C                   ENDSR
017273020404     C*
0173000204040106 C     *inzsr        BEGSR
017301020404
017302020404     c* prepare prefixed file name
017403020404     c                   eval      filename = prefix + '.ACCNAM'
017404020404
017405020404     c* get display access security for the current user
017411020404     C                   MOVE      *ZEROS        ST
017412020404     c                   exsr      $secal
017413020404     C                   XFOOT     ST            T##              10 0
017414020404
0175000204040120 C                   ENDSR
