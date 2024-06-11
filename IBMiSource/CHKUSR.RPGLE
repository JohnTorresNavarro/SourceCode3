000100160810     H option(*noDebugIo)
000200000000      *_________________________________________________________________________
000300000000      *
000400070316      *  Description: Check Account OE Users
000500000000      *
000600070316      *  (C)COPYRIGHT 2007 BY GROUP BENEFIT SERVICES, INC.
000700160810      *
000800160810      *  B.Rees 8/10/2016 Check oeUser File for Duplicate User ID's
000900160810      *
001000000000      *___________________________________________________________________
001100070316     fOEUSER    if   e           k disk
001200120606     FOEREPOSLF IF   E           K Disk
001300120606     FOEREPOS2P IF   E           K Disk
001400160810br01 FoeUserL2  if   e           k disk    prefix(x) rename(oeUserr:Rcd1)
001500000000      *
001600070316    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001700200423    ?D WTM             S             80    DIM(13) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001800000000      *
001900000000      *___________________________________________________________________
002000000000      *
002100000000      * Data structure
002200070316    ?D WUDTA         E DS                  EXTNAME(OEUSER)
002300000000      *
002400000000      * Program status data structure
002500000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002600000000      *
002700061129      * RETREIVE JOB ATTRIBUTES API DATA STRUCTURE
002800061129     D WDJOBA          DS                  INZ
002900061129     D  WDJUSR                19     28
003000000000      *
003100061129     D                 DS
003200061129     D  WDRCVL                 1      4B 0 INZ(86)
003300061129      *
003400021008     D WIFKV           S             60A
003500021008     D WIFKY           S                   LIKE(WIFKV)
003600021008     D WIOPV           S                   LIKE(WIFKV)
003700021008     D WIRQS           S              8A
003800021008     D WORTN           S              8A
003900021008     D WUPGM           S             10A
004000021008     D WWCHG           S              1A
004100021008     D WWDLT           S              1A
004200021008     D WWDTAQ          S             10A
004300021008     D WWENDF          S              3A
004400021008     D WWENDO          S                   LIKE(WWENDF)
004500021008     D WWERR           S              1A
004600021008     D WWFIL           S             10A
004700021008     D WWFKA           S              8A
004800021008     D WWFKV           S                   LIKE(WIFKV)
004900021008     D WWFKY           S                   LIKE(WIFKV)
005000021008     D WWFLK           S            128A
005100021008     D WWFMTN          S              8A
005200021008     D WWFNC           S              8A
005300021008     D WWIJI           S             16A
005400021008     D WWIN            S             99A
005500021008     D WWLIB           S             10A
005600021008     D WWMSG           S             80A
005700021008     D WWMSGC          S              7A
005800021008     D WWOCD           S              8A
005900021008     D WWOPA           S              8A
006000021008     D WWOPN           S              1A
006100021008     D WWOPT           S              8A
006200021008     D WWOPV           S                   LIKE(WIFKV)
006300021008     D WWORQS          S                   LIKE(WIRQS)
006400021008     D WWPSNC          S              1A
006500021008     D WWQJN           S             26A
006600021008     D WWRQS           S                   LIKE(WIRQS)
006700021008     D WWRQSD          S                   LIKE(WIRQS)
006800021008     D WWRTN           S                   LIKE(WORTN)
006900021008     D WWRTND          S                   LIKE(WORTN)
007000021008     D WWRTNH          S                   LIKE(WORTN)
007100021008     D WWSFLE          S              1A
007200021008     D WWSTT           S              3A
007300021008     D WWTSK           S              8A
007400021008     D WWTXT           S             60A
007500021008     D WWUPD           S              1A
007600021008     D WWWRNF          S              1A
007700021008     D WWZERO          S             40A
007800021008     D WFRRN           S              4P 0
007900021008     D WW              S              3P 0
008000021008     D WWFKS           S              1P 0
008100021008     D WWFKSO          S                   LIKE(WWFKS)
008200021008     D WWLMT           S              2P 0
008300021008     D WWLNG           S             15P 5
008400021008     D WWLNGQ          S              5P 0
008500021008     D WWLOWR          S              4P 0
008600021008     D WWLSTS          S              2P 0
008700021008     D WWOPS           S              1P 0
008800021008     D WWOPSO          S                   LIKE(WWOPS)
008900021008     D WWPNL           S              1P 0
009000021008     D WWPNLN          S                   LIKE(WWPNL)
009100021008     D WWPNLO          S                   LIKE(WWPNL)
009200021008     D WWPSNI          S              2P 0
009300021008     D WWPSNN          S              1P 0
009400021008     D WWPSNP          S                   LIKE(WWPSNN)
009500021008     D WWRRN           S              4P 0
009600160810     D
009700200423br01 D UserErr         s              1a   inz
009800000000      *
009900200422     D PosL            S              2s 0
010000200422     D PosU            S              2s 0
010100200422     D PosS            S              2s 0
010200200422     D #len            S              2s 0
010300200422     D TestChar        S              1a
010400200422     D sp              c                   '!@#$%¢&*()_+{}¬¦\|'
010500200422     D lo              c                   'abcdefghijklmnopqrstuvwxyz'
010600200422     D up              c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
010700000000      *___________________________________________________________________
010800000000      * Process check request
010900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
011000040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
011100040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
011200000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
011300000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
011400000000     C                   Cas                     PRCERR                         REQUEST ERROR
011500000000     C                   Endcs                                                  END CASE
011600000000    ?C                   Return                                                 RETURN
011700000000      *___________________________________________________________________
011800040305      * Edit record - ADD
011900000000      *___________________________________________________________________
012000040305     C     EDTADD        Begsr                                                  EDIT RECORD
012100000000      *
012200200423br01 C                   eval      UserErr = 'N'
012300040305     C                   EXSR      $COMMON
012400040305      *
012500040305     C                   Endsr                                                  END DLT RQST
012600040305      *___________________________________________________________________
012700040305      * Edit record - COMMON EDITS
012800040305      *___________________________________________________________________
012900040305     C     $COMMON       Begsr                                                  EDIT RECORD
013000200423      *
013100200423      * validate email format
013200070316     C                   Z-add     *Zeros        PosDot            2 0
013300070316     C                   Z-add     *Zeros        Pos@              2 0
013400070316     C                   Eval      Pos@     = %Scan('@':OUEMAL)
013500070316     C                   Eval      PosDot   = %Scan('.':OUEMAL)
013600070316     C                   If        Pos@     = *Zeros   Or
013700070316     C                             PosDot   = *Zeros
013800040518    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013900040518    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
014000040518    ?C                   Exsr      SNDMSG                                       SEND MSG
014100120613     C                   LeaveSR
014200040518     C                   Endif
014300120613      *
014400120613      * If the email is valid, then it must contain no blanks.
014500120613     C                   If        %trim(OUEMAL) <> *blanks
014600120613     C                   Eval      Pos@     = %Scan(' ':%trim(OUEMAL))
014700120613     C                   If        Pos@     > *Zeros
014800120613    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014900120613    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
015000120613    ?C                   Exsr      SNDMSG                                       SEND MSG
015100120613     C                   LeaveSR
015200120613     C                   Endif
015300120613     C                   End
015400200423      *
015500200423      * Last Name
015600070316     C                   If        OULNAM   =    *Blanks
015700070313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015800070313    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
015900070313    ?C                   Exsr      SNDMSG                                       SEND MSG
016000070313     C                   Endif
016100200423
016200200423      * User ID is already in OEREPOSLF or OEREPOS2P file.
016300200423
016400200423br01 C                   if        UserErr = 'N'
016500200423     C                   If        %trim(OUUSER) <> *blanks
016600200423     C     OUUSER        Chain     OEREPOS2P
016700200423     C                   If        %Found(OEREPOS2P)
016800200423    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016900200423    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
017000200423    ?C                   Exsr      SNDMSG                                       SEND MSG
017100200423br01 C                   eval      UserErr = 'Y'
017200200423     C                   Endif
017300200423     C
017400200423br01 C                   if        UserErr = 'N'
017500200423     C     OUUSER        Chain     OEREPOSLF
017600200423     C                   If        %Found(OEREPOSLF)
017700200423    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017800200423    ?C                   Move      WTM(10)       WWMSG                          PASS MSG
017900200423    ?C                   Exsr      SNDMSG                                       SEND MSG
018000200423     C                   Endif
018100200423br01 C                   endif
018200200423
018300200423br01 C                   if        UserErr = 'N'
018400200423 |   C     OUUSER        Chain     OEUSERL2
018500200423 |   C                   If        %Found(OEUSERL2)
018600200423 |  ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018700200423 |  ?C                   Move      WTM(10)       WWMSG                          PASS MSG
018800200423 |  ?C                   Exsr      SNDMSG                                       SEND MSG
018900200423 |   C                   Endif
019000200423br01 C                   endif
019100200423br01 C                   endif
019200200423br01 C                   endif
019300200423      *
019400200423     C                   If         %trim(WIRQS) = 'EDTADD' and                 EDIT RECORD
019500200423     C                              %trim(OUUSER) <> *Blanks
019600200423     C                   eval      #len = %len(%TRIM(OUUSER))
019700200423     C                   if        #len < 8
019800200423    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019900200423    ?C                   Move      WTM(13)       WWMSG                          PASS MSG
020000200423    ?C                   Exsr      SNDMSG                                       SEND MSG
020100200423     C                   LeaveSR
020200200423     C                   end
020300200423     C                   end
020400200423    ? *
020500200423    ? * User ID & Password must both be filled in or both be blank
020600200423     C                   If        (OUUSER  =    *Blanks   And
020700200423     C                             OUUSPW  <>    *Blanks)   Or
020800200423     C                             (OUUSER  <>   *Blanks   And
020900200423     C                             OUUSPW  =     *Blanks)
021000200423    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
021100200423    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
021200200423    ?C                   Exsr      SNDMSG                                       SEND MSG
021300200423     C                   Endif
021400200423
021500200423      * check password
021600200423     C                   EXSR      $PASS
021700200423
021800070706      * Exclude Transaction Email must be Y, N or Blank.
021900070724     C                   If        OUEMEX  <>    'Y'       And
022000121012     C                             OUEMEX  <>    'N'       And
022100121012     C                             OUEMEX  <>    'B'       And
022200121012     C                             OUEMEX  <>    'A'
022300070706    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
022400070706    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
022500070706    ?C                   Exsr      SNDMSG                                       SEND MSG
022600070706     C                   Endif
022700070316    ? * Check Begin Date
022800070316     C                   If        OUBEDT <> 0
022900070316     C                   Movel     OUBEDT        Input_Date
023000070316     C                   Exsr      EDTDAT
023100070316     C                   If        Output_Error <> *Blanks
023200070316    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
023300070316    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
023400070316    ?C                   Exsr      SNDMSG                                       SEND MSG
023500070316     C                   Endif
023600070316     C                   Endif
023700070316     C                   If        OUBEDT =  0
023800070316    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
023900070316    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
024000070316    ?C                   Exsr      SNDMSG                                       SEND MSG
024100070316     C                   Endif
024200070316    ? *
024300070316    ? * Check TRM Date
024400070316     C                   If        OUENDT <> 0
024500070316     C                   Movel     OUENDT        Input_Date
024600070316     C                   Exsr      EDTDAT
024700080408     C     OUENDT        Mult      10000.0001    CmpTDT            8 0
024800080408     C                   If        Output_Error <> *Blanks   Or
024900080408     C                             CmpTDT < Today
025000070316    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
025100070316    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
025200070316    ?C                   Exsr      SNDMSG                                       SEND MSG
025300070316     C                   Endif
025400070316     C                   Endif
025500070316    ? *
025600070316    ? * Check EFF < TRM Date
025700070316     C                   If        OUBEDT <> 0    and
025800070316     C                             OUENDT <> 0
025900070316     C     OUBEDT        Mult      10000.0001    WWEFF             8 0
026000070316     C     OUENDT        Mult      10000.0001    WWTRM             8 0
026100070316     C                   If        WWEFF > WWTRM
026200070316    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
026300070320    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
026400070316    ?C                   Exsr      SNDMSG                                       SEND MSG
026500070316     C                   End
026600070316     C                   End
026700120523      *
026800000000     C                   Endsr                                                  END DLT RQST
026900040305      *___________________________________________________________________
027000040305      * Edit record - CHANGE
027100040305      *___________________________________________________________________
027200040305     C     EDTCHG        Begsr                                                  EDIT RECORD
027300040305      *
027400040305      *
027500200423br01 C                   eval      UserErr = 'Y'
027600200422     C                   EXSR      $COMMON
027700200422      *
027800200422     C                   Endsr
027900200422      *
028000200422     C     $PASS         Begsr                                                  EDIT RECORD
028100200423      *
028200200422    ? * User ID & Password must both be filled in or both be blank
028300200422     C                   If        (OUUSER  =    *Blanks   And
028400200422     C                             OUUSPW  <>    *Blanks)   Or
028500200422     C                             (OUUSER  <>   *Blanks   And
028600200422     C                             OUUSPW  =     *Blanks)
028700200422    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
028800200422    ?C                   Move      WTM(9)        WWMSG                          PASS MSG
028900200422    ?C                   Exsr      SNDMSG                                       SEND MSG
029000200422     C                   Endif
029100200422      *
029200200422     C                   if        %trim(OUUSER) <> *blanks
029300200422      *
029400200422     C                   clear                   posL
029500200422     C                   clear                   posU
029600200422     C                   clear                   posS
029700200422     c                   do        40            xxx               2 0
029800200422     c                   eval      testchar = %subst(OUUSPW:xxx:1)
029900200422     C                   if        testchar = *blanks
030000200422     C                   leave
030100200422     c                   end
030200200422     C                   if        PosL = 0
030300200422     c                   Eval      PosL = %scan(testchar:LO)
030400200422     c                   end
030500200422     C                   if        PosU = 0
030600200422     c                   Eval      PosU = %scan(testchar:UP)
030700200422     c                   end
030800200422     C                   if        PosS = 0
030900200422     c                   Eval      PosS = %scan(testchar:SP)
031000200422     c                   end
031100200422     C                   if        PosL <> 0 and
031200200422     C                             PosU <> 0 and
031300200422     C                             PosS <> 0
031400200422     C                   Leave
031500200422     C                   end
031600200422     c                   enddo
031700200422      *
031800200422     C                   if        PosL = 0
031900200422    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
032000200422    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
032100200422    ?C                   Exsr      SNDMSG                                       SEND MSG
032200200422     C                   LeaveSR
032300200422     C                   end
032400200422     C                   if        PosU = 0
032500200422    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
032600200422    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
032700200422    ?C                   Exsr      SNDMSG                                       SEND MSG
032800200422     C                   LeaveSR
032900200422     C                   end
033000200422     C                   if        PosS = 0
033100200422    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
033200200422    ?C                   Move      WTM(11)       WWMSG                          PASS MSG
033300200422    ?C                   Exsr      SNDMSG                                       SEND MSG
033400200422     C                   LeaveSR
033500200422     C                   end
033600200422      *
033700200422     C                   eval      #len = %len(%TRIM(OUUSPW))
033800200422     C                   if        #len < 8
033900200422    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
034000200422    ?C                   Move      WTM(12)       WWMSG                          PASS MSG
034100200422    ?C                   Exsr      SNDMSG                                       SEND MSG
034200200422     C                   LeaveSR
034300200422     C                   end
034400040305      *
034500200422     C                   end
034600200422      *
034700040305     C                   Endsr                                                  END DLT RQST
034800070316    ? *___________________________________________________________________
034900070316    ? * format Date edit
035000070316    ? *___________________________________________________________________
035100070316    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
035200070316     C                   movel     'MMDDYYYY'    Input_Format
035300070316     C                   Call      'FMTDATE'
035400070316     C                   Parm                    Input_Date       32
035500070316     C                   Parm                    Input_Format     32
035600070316     C                   Parm                    Output_Format    32
035700070316     C                   Parm                    Output_Date      32
035800070316     C                   Parm                    Output_Error     10
035900070316    ?C                   Endsr                                                  END DLT RQST
036000000000      *___________________________________________________________________
036100000000      * Edit delete request
036200000000      *___________________________________________________________________
036300000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
036400000000     C                   Endsr                                                  END DLT RQST
036500000000      *___________________________________________________________________
036600000000      * Default data
036700000000      *___________________________________________________________________
036800000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
036900061129      * RETRIEVE JOB ATTRIBUTES
037000061129     C                   Call      'QUSRJOBI'                                   RTV JOB INFO
037100061129     C                   Parm                    WDJOBA                         RECEIVER VAR
037200061129     C                   Parm                    WDRCVL                         RECEIVER LENGTH
037300061129     C                   Parm      'JOBI0100'    WWFMTN                         FORMAT NAME
037400061129     C                   Parm      '*'           WWQJN                          QUAL JOB NAME
037500061129     C                   Parm                    WWIJI                          INTERNAL JOB ID
037600061129      *
037700070316     c                   eval      OUCHDT    =   Today
037800070316     C                   Eval      OUCHGU    =   WDJUSR
037900000000     C                   Endsr                                                  END DFT DATA
038000000000      *___________________________________________________________________
038100000000      * Send messages
038200000000      *___________________________________________________________________
038300000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
038400000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
038500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
038600000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
038700000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
038800000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
038900000000     C                   Endsr                                                  END SND ERRMSG
039000000000      *___________________________________________________________________
039100000000      * Process error
039200000000      *___________________________________________________________________
039300000000     C     PRCERR        Begsr                                                  PROCESS ERROR
039400000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
039500000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
039600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
039700000000     C                   Endsr                                                  END PRCERR
039800000000      *___________________________________________________________________
039900000000      * Parameter list
040000000000      *___________________________________________________________________
040100000000     C     PLIST         Begsr                                                  PARM LISTS
040200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
040300000000    ?C                   Parm                    WIRQS                          REQUEST
040400000000    ?C                   Parm                    WORTN                          RETURN CODE
040500000000    ?C                   Parm                    WUDTA                          DATA
040600000000     C                   Endsr                                                  END PLIST
040700070316    ? *___________________________________________________________________
040800070316    ? * Key lists
040900070316    ? *___________________________________________________________________
041000070316    ?C     KLIST         Begsr                                                  KEY LISTS
041100070316    ?C                   Endsr                                                  END KLIST
041200000000      *___________________________________________________________________
041300000000      * Define Variables and Key Lists
041400000000      *___________________________________________________________________
041500000000     C     *INZSR        Begsr
041600000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
041700061129     C     *DATE         Mult      10000.0001    Today             8 0
041800000000     C                   Endsr                                                  END DEFN
041900000000      *___________________________________________________________________
042000000000      * Program error handler
042100000000      *___________________________________________________________________
042200000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
042300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
042400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
042500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
042600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
042700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
042800000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
042900020228      *___________________________________________________________________
043000000000** WTMP
04310000000000T-Record is not eligible for deletion.
04320007031600Request not supported by program CHKUSR.
043300000000** WTM
04340007031661User cannot be blank
04350007031662Email address must be entered in email-address format.
04360007031663User's last name must be entered.
04370007032064Account OLE user begin date must be a valid date.
04380008040865Account OLE user end date must be a valid future date.
04390007031665End date cannot be less than begin date.
04400012101266Email Notification must be Y, N, B, or A.
04410012052367User ID cannot contain invalid characters such as @.
04420020042268Both User ID and Password are required. Both blank is ok.
04430012060667This User ID is already taken.  Please try another one.
04440020042268Password must have 1 Upper, 1 Lower, and 1 Special Char.
04450020042368Password must be at least 8 characters.
04460020042367User Id must be at least 8 characters.
