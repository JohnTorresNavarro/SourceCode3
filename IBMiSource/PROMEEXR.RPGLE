000100001003    ? *_________________________________________________________________________
000200001003    ? *                                                                *
000300070226    ? *  Description:  PROMEEXR   Load Pro-Telligent Dental Coverages. *
000400001003    ? *                                                                *
000500070226    ? *  (c)Copyright 2007 by GBS, Inc.                                *
000600041220    ? *  This document contains restricted materials of GBS, Inc.      *
000700001003    ? *                                                                *
000800070227    ? *  Written by:   S. Zien                                         *
000900070227    ? *  Date Written: 02/27/07                                        *
001000001003    ? *                                                                *
001100070228    ? *  History:                                                      *
001200070227    ? *                                                                *
001300070226    ? *            Revised by -                                        *
001400070226    ? *            Date -                                              *
001500070226    ? *            Revision -                                          *
001600070921    ? * 09.21.2007.SSK.CANCELLATION LOGIC MODIFICATIONS PER MET LIFE   *
001700070924    ? *                CORRECTION OF DATE RANGES SENT                  *
001800070924    ? *                REMOVAL OF GETCOVCL [WHICH IS BROKE]            *
001900071106    ? * 11.05.2007.SSK.COBRA DATE OVERRIDE MODIFICATION PER MET LIFE   *
002000071106    ? *                OVERRIDE DEPENDENT EFF DATE PER MET LIFE        *
002100080117    ? *                                                                *
002200080117    ? *            Revised by -  szz                                   *
002300080117    ? *            Date -        01.17.2008                            *
002400080117    ? *            Revision -    Retrieve group from group master.     *
002500080501    ? *                                                                *
002600080501    ? *            Revised by -  szz                                   *
002700080501    ? *            Date -        05.01.2008                            *
002800080501    ? *            Revision -    Per Dave A. email of 5.1.08 8:36,     *
002900080501    ? *                           hard code for only two groups:       *
003000080501    ? *                           5469067 & 5722574.                   *
003100080618    ? *            Revised by -  szz                                   *
003200080618    ? *            Date -        06.18.2008                            *
003300080618    ? *            Revision -    Employees were being written out for  *
003400080618      *                           a group other than the hard-coded    *
003500080618      *                           groups above; inserted the two-group *
003600080618      *                           criteria for the employees.          *
003700080718    ? *            Revised by -  szz                                   *
003800080718    ? *            Date -        07.18.2008                            *
003900080718    ? *            Revision -    Hard coding removed for these two     *
004000080718    ? *                           groups per email 7.18.08:            *
004100080718    ? *                           5469067 & 5722574.                   *
004200080722    ? *            Revised by -  szz                                   *
004300080722    ? *            Date -        07.22.2008                            *
004400080722    ? *            Revision -    Hard code these 2 groups out per DaveA*
004500080722    ? *                           email 7.22.08 until future notice:   *
004600080722    ? *                           5469196 & 5566260.                   *
004700080919    ? *                                                                *
004800080919    ? *            Revised by -  szz                                   *
004900080919    ? *            Date -        09.19.2008                            *
005000080919    ? *            Revision -    Incorporate new coverage types LIFE   *
005100080919    ? *                           LTD, STD & AD&D into the new record  *
005200080919    ? *                           layout.                              *
005300090427    ? *            Revised by -  szz                                   *
005400090427    ? *            Date -        04.27.2009                            *
005500090427    ? *            Revision -    Requested by Carol Fab and suggested  *
005600090427    ? *                           by Danielle Pizzuto at Metlife that  *
005700090427    ? *                           we remove Enterprise Technologies    *
005800090427    ? *                           from the file because they are having*
005900090427    ? *                           payment issues which are preventing  *
006000090427    ? *                           our test file from being tested.     *
006100090428    ? *            Revised by -  szz                                   *
006200090428    ? *            Date -        04.28.2009                            *
006300090428    ? *            Revision -    Brandy at Metlife said that the issues*
006400090428    ? *                           about Enterprise Technology have been*
006500090428    ? *                           resolved so we may add them back in. *
006600090901    ? *            Revised by -  szz                                   *
006700090901    ? *            Date -        09.01.2009                            *
006800090901    ? *            Revision -    If there are more than one dependents and
006900090901    ? *                           more than one do not have a social security
007000090901    ? *                           number, an additional check is necessary
007100090901    ? *                           to make sure first dependent is not overwritten.
007200090921    ? *            Revised by -  szz                                   *
007300090921    ? *            Date -        09.21.2009                            *
007400090921    ? *            Revision -    Code for dependent twins which are different
007500090921    ? *                           than son and daughter.
007600100107    ? *            Revised by -  szz                                   *
007700100107    ? *            Date -        01.07.2010                            *
007800100107    ? *            Revision -    Add these two groups:                 *
007900100107    ? *                           594258  & 571049.                    *
008000100114    ? *            Revised by -  szz                                   *
008100100114    ? *            Date -        01.14.2010                            *
008200100114    ? *            Revision -    Add these groups:                     *
008300100114    ? *                           5326161, 5141296, 5750164            *
008400100121    ? *            Revised by -  szz                                   *
008500100121    ? *            Date -        01.21.2010                            *
008600100121    ? *            Revision -    Add these groups:                     *
008700100121    ? *                           5326158, 5326159                     *
008800100125    ? *            Revised by -  szz                                   *
008900100125    ? *            Date -        01.25.2010                            *
009000100125    ? *            Revision -    Add these groups:                     *
009100100125    ? *                           05725789                             *
009200100226    ? *            Revised by -  szz                                   *
009300100226    ? *            Date -        02.26.2010                            *
009400100226    ? *            Revision -    Jasmine wrote to Amy L. saying that   *
009500100226    ? *                           5732310 should have branch 0002 for  *
009600100226    ? *                           Dental.                              *
009700100322    ? *            Revised by -  szz                                   *
009800100322    ? *            Date -        03.22.2010                            *
009900100322    ? *            Revision -    Add these groups:                     *
010000100322    ? *                           5481248 Asher & 5594257 Canyon Cons. *
010100100401    ? *            Revised by -  szz                                   *
010200100401    ? *            Date -        04.01.2010                            *
010300100401    ? *            Revision -    Add Carrier Code MED for MetLife      *
010400100401    ? *                           Dental DAILY Proration.              *
010500100421    ? *            Revised by -  szz                                   *
010600100421    ? *            Date -        04.21.2010                            *
010700100421    ? *            Revision -    Add CODES file to determine the       *
010800100421    ? *                           'ACTION" field that groups plan      *
010900100421    ? *                           types together per Dave A: in case   *
011000100421    ? *                           other plan types are added.          *
011100100429    ? *            Revised by -  szz                                   *
011200100429    ? *            Date -        04.29.2010                            *
011300100429    ? *            Revision -    Add this group:                       *
011400100429    ? *                           5722568                              *
011500100503    ? *            Revised by -  szz                                   *
011600100503    ? *            Date -        05.03.2010                            *
011700100503    ? *            Revision -    New groups preceded by letters.       *
011800100511    ? *            Revised by -  szz                                   *
011900100511    ? *            Date -        05.11.2010                            *
012000100511    ? *            Revision -    Hard Code Account 591.4.349 so that   *
012100100511      *                          it does not get exported per Dave A   *
012200100511      *                          in email of 5/11/10 12:20 pm          *
012300100729    ? *            Revised by -  szz                                   *
012400100729    ? *            Date -        07.29.2010                            *
012500100729    ? *            Revision -    Add this group:                       *
012600100729    ? *                           5481101                             *
012700101118    ? *            Revised by -  szz                                   *
012800101118    ? *            Date -        11.18.2010                            *
012900101118    ? *            Revision -    Add this group:                       *
013000101118    ? *                           5469314                             *
013100101129    ? *            Revised by -  szz                                   *
013200101129    ? *            Date -        11.29.2010                            *
013300101129    ? *            Revision -    Hard Code Account 591.2.308 so that   *
013400101129      *                          it does not get exported per Dave A   *
013500101129      *                          in email of 10/28/10 4:07 pm (Exeter) *
013600110107      *
013700110107      * 01/07/11 dlk - add 1800 pack rat and moore & assoc
013800110107      *                to group # translation
013900110107      *
014000110110      * 01/10/11 szz - Add Bay State Medical, Inc. 5564824.
014100110110      *
014200110301    ? * 03/01/11 szz - Hard Code 591.1.406 out so that records will no *
014300110301    ? *                longer export per Dave A in email of 1/21/11    *
014400110301    ? *                3:29pm.                                         *
014500110110      *
014600110310      * 03/10/11 szz - Add Hanover Uniform Co.  5870901
014700110310      *
014800110329      * 03/29/11 szz - Add Ecology Services, Inc 3261700
014900110329      *
015000110706      * 07/06/11 szz - Add Independent Sector 5594287 with new branch info
015100110707      *                Per Dori VanFleet, for this group ONLY, we will use
015200110707      *                the STATUS field of 'C' to determine if they have
015300110707      *                COBRA.
015400110708      *
015500110708      * 07/08/11 szz - Add Helicopter Assoc. 5326173 with new branch info
015600110708      *                Per Dori VanFleet, for this group ONLY, we will use
015700110708      *                the STATUS field of 'C' to determine if they have
015800110708      *                COBRA.
015900110706      *
016000110710      * 07/10/11 szz - Per Margie M. remove group 574659 based on email
016100110710      *                sent from Lisa Sebro at Metlife. 591-4-338
016200110808      *
016300110808      * 08/08/11 szz - The format for DENTAL group# has changed to include
016400110808      *                 the subdivision and branch.  Hardcoding for the
016500110808      *                 44 groups will no longer be needed.
016600110809
016700110902      * 09/02/11 szz - Per Carol F. phone call 9/2/11 11:30am, temporarily
016800110902      *                 exclude account 590-7-23 from the export due to
016900110902      *                 kickouts caused to this group for nonpayment
017000110902      *                 (this is what Metlife told Carol F.)
017100110915
017200110915      * 09/15/11 szz - Per Carol F. email 9/14/11 5:10pm, remove exlusion
017300110915      *                 of 590-7-23.
017400110902
017500110921      * 09/21/11 szz - Per Kevin W. phone call 9/21/11 10am, only show the
017600110921      *                 current coverage.  If there is a future coverage,
017700110921      *                 only send that when it becomes current (not before).
017800110921
017900120216      *  2/16/12 szz - Branch was not being loaded to employee.
018000120216
018100120430      *  4/30/12 szz - Do not write terms to the term file if it's a future
018200120430      *                 term.
018300120430
018400120828      * 08/28/12 szz - Per Stacey H. remove group 573775 based on email
018500120828      *                sent from JPittman at Metlife on 8/14/12 re Kidd Intl
018600120828      *                this includes 12 accounts in 590-006.
018700120831
018800120831      * 08/31/12 szz - Per Stacey H. remove group 586265 based on email
018900120831      *                sent from JPittman at Metlife on 8/30/12 re Smyth.
019000120831      *                this includes 2 accounts in 600-005.
019100120828      *
019200120921      * 09/21/12 szz - Per Richard Thompson, email of 9/20/12, J&J Trash
019300120921      *                301.4.1 will no longer be sent.
019400121002      *
019500121002      * 10/02/12 dlk - add "or action = D" to dependent search at 185.03
019600121002      *                to fix dependents missing from file.
019700121010      *
019800121010      * 10/10/12 szz - comment out 600-5-18: per Carol F. email; this
019900121010      *                group has been reinstated.
020000121025      *
020100121025      * 10/25/12 szz - Per Richard Thomson 10/1/12 email, do not send
020200121025      *                Family League of Baltimore 591-7-475 anymore since
020300121025      *                they continue to be with Metlife but are no longer
020400121025      *                with GBS. (Group 5984505)
020500121203      *
020600121203      * 12/03/12 szz - Per Carol Fab based on phone call of same day at
020700121203      *                1:05 pm. Account 600-5-21 has been reinstated
020800121203      *                and therefore their exclusion should be removed.
020900121203      *
021000121231      * 12/31/12 szz - Per Megan Pierson forwarded by Stephen King do not
021100121231      *                send Team People 5469196 591-5-280 anymore.
021200121231      *
021300130307      *  3/07/13 szz - Per Deborah Clark:  Phase One Consulting group not
021400130307      *                with GBS anymore but still w/carrier:  591-4-286.
021500130307      *
021600130401      * 03/26/13 SSK - STACEY H. REQUEST TO SHUT PHASE ONE CONSULTING
021700130401      *                  AS OF 4/1/13; GRP# 5326181; 591-004-0286.
021800130401      *
021900130619      *  6/19/13 szz - Per Stacey H. Pack Rat not with GBS anymore but
022000130619      *                 still w/carrier:  590-1-30. Group# 5326164.
022100130619      *
022200130625      *  6/25/13 szz - Per Matt Kuhn 6/25/13 email, code RPA (Partner) as
022300130625      *                 03.
022400130401      *
022500130717      * 07/16/13 SSK - BRANDON S. REQUEST TO SHUTDOWN EXPERIMENTAL MACHINE
022600130716      *                  GRP# 5326185; 591-006-0035.
022700130401      *
022800130717      * 07/17/13 SSK - BRANDON S. REQUEST TO SHUTDOWN GREATER BALTIMORE COMMITTEE INC
022900130717      *                  GRP# 5326174; 502-007-0199.
023000130717      *
023100131211      * 12/11/2013 SSK DEFINED DS POSITIONS, SEE IF THAT HELPS.
023200131211      *
023300140320      * 03/20/2014 SSK STACEY HELBIG RQST TO SHUTDOWN ADVANCED TECH & RESRCH CORP
023400131211      *
023500140520      * 05/20/2014 SSK BRANDON S. REQUEST TO SHUTDOWN COUNCIL FOR PROFESSIONAL RECOGNITION
023600140520      *                770-008-0031
023700131211      *
023800140529      * 05/29/2014 SSK STACEY HELBIG REQUEST SHUTDOWN OF 591-007-0436
023900131211      *
023901140602      * 06/02/2014 SSK BRANDON S. REQUEST TO SHUTDOWN HELICOPTER ASS
023902140602      *                591-007-0399
023903140602      *
024000991207    ? *_________________________________________________________________________
024100070924     FPLNMSTN1  IF   E           K Disk
024200070227     FMCOV39    IF   E           K Disk
024300070228     FMEMBER    IF   E           K Disk
024400070925     FDEPNDC    IF   E           K Disk
024500070227     FDCOV22    IF   E           K Disk
024600080117     FGRATE     IF   E           K Disk
024700100421     FCODES     IF   E           K Disk
024800090313    ?FPROEXP    O  A E           K DISK
024900090313    ?FPROEXPLF  UF   E           K DISK    rename(proexpr:proupdr)
025000070924     FMETLIFTRM IF A E           K DISK
025100021004      *
025200100421     DPlanCat          DS             3
025300100421     D  Typ                           1
025400100421     D  Cod                           2
025500110808      *
025600131211     D                 DS
025700131211     D  GroupFmt               1     15A
025800131211     D  GroupGroup             1      7A
025900131211     D  GroupSubDiv            8     11A
026000131211     D  GroupBranch           12     15A
026100131211     D**GroupFmt         DS            15
026200131211     D**GroupGroup                    7
026300131211     D**GroupSubDiv                   4
026400131211     D**GroupBranch                   4
026500100421      *
026600090313     D Data            S              1A
026700070227     D No              S              1A   Inz('N')
026800070227     D Yes             S              1A   Inz('Y')
026900100401     D MetDenD         S              3A   Inz('MED')
027000070227     D MetLife         S              3A   Inz('MET')
027100090224     D LifeProds       S              3A   Inz('MEL')
027200070227     D Dental          S              3A   Inz('PDN')
027300100420     D DentalDC        S              3A   Inz('PDR')
027400080923     D Life            S              3A   Inz('PLF')
027500080923     D AD_D            S              3A   Inz('PAC')
027600080923     D LTD             S              3A   Inz('PLT')
027700080923     D STD             S              3A   Inz('PWD')
027800090313      *
027900090313      * Check for MEL - Life Products
028000090313     C     LifeProds     SETLL     PLNMSR
028100090313     C     LifeProds     ReadE     PLNMSR
028200090313     C                   DOW       not %EOF(PLNMSTN1)
028300090313     C                   If         PLNCAT    =   Life      Or
028400090313     C                              PLNCAT    =   AD_D      Or
028500090313     C                              PLNCAT    =   LTD       Or
028600090313     C                              PLNCAT    =   STD
028700090313     C                   EXSR      LOADRCD
028800090313     C                   End
028900090313     C     LifeProds     ReadE     PLNMSR
029000090313     C                   Enddo
029100100401      *
029200100401      * Check for MED - Metlife Dental - DAILY Proration
029300100401     C     MetDend       SETLL     PLNMSR
029400100401     C     MetDend       ReadE     PLNMSR
029500100401     C                   DOW       not %EOF(PLNMSTN1)
029600100421     C                   Movel     PLNCAT        PlanCat
029700100421     C     CodKey        Chain     CODES
029800100420     C                   If         PLNCAT    =   Dental  Or
029900100421     C                              PLNCAT    =   DentalDC  Or
030000100421     C                              ACTION    =   'D'
030100100401     C                   EXSR      LOADRCD
030200100401     C                   End
030300100423     C     MetDenD       ReadE     PLNMSR
030400100401     C                   Enddo
030500090313      *
030600100401      * Check for MET - Dental Products - Full Monthly  Billing
030700090313     C     MetLife       SETLL     PLNMSR
030800090313     C     MetLife       ReadE     PLNMSR
030900100423     C     CodKey        Chain     CODES
031000090313     C                   DOW       not %EOF(PLNMSTN1)
031100100423     C                   If         PLNCAT    =   Dental Or
031200100423     C                              PLNCAT    =   DentalDC  Or
031300100423     C                              ACTION    =   'D'
031400090313     C                   EXSR      LOADRCD
031500090313     C                   End
031600090313     C     MetLife       ReadE     PLNMSR
031700090313     C                   Enddo
031800090313      *
031900090313    ?C                   Move      *On           *inLR
032000090313      *
032100090313     C     LOADRCD       BEGSR
032200070921     **
032300070921     C                   MOVE      *ZEROS        H@SSN             9 0
032400070228     C     PlnKey        Setll     MCOV39
032500090313     C                   DOW       not %Eof(MCOV39)
032600090313     C     PlnKey        Reade     MCOV39
032700090313      **x
032800090313     C                   IF        ENRLDT <> CANDT
032900110921     C                                                And
033000110921     C                             ENRLDT <= Today
033100070924      **
033200070924      ** OLD TERMED ACCOUNT
033300070924     C                   IF        MCTRST = 600 AND MCSUB# = 003 AND ACC# = 18
033400100511     C                                OR
033500121231     C                             (MCTRST = 591 AND MCSUB# = 5 AND ACC# = 280)
033600121231     C                                OR
033700120921     C                             (MCTRST = 301 AND MCSUB# = 4 AND ACC# = 1)
033800120921     C                                OR
033801140602     C                             (MCTRST = 591 AND MCSUB# = 7 AND ACC# = 399)  HELICOPTER ASSOC
033802140602     C                                OR
033900100511     C                             (MCTRST = 591 AND MCSUB# = 4 AND ACC# = 349)
034000101129     C                                OR
034100101129     C                             (MCTRST = 591 AND MCSUB# = 2 AND ACC# = 308)
034200110301     C                                OR
034300110301     C                             (MCTRST = 591 AND MCSUB# = 1 AND ACC# = 406)
034400110710     C                                OR
034500140520     C                             (MCTRST = 770 AND MCSUB# = 8 AND ACC# = 31)    CNCL 4 PROF RECGN
034600140520     C                                OR
034700130401     C                             (MCTRST = 591 AND MCSUB# = 4 AND ACC# = 286)   PHASE 1 CONSULTNG
034800130619     C                                OR
034900130716     C                             (MCTRST = 591 AND MCSUB# = 6 AND ACC# = 35)    EXPRMNTL MACHINE
035000130716     C                                OR
035100130717     C                             (MCTRST = 502 AND MCSUB# = 7 AND ACC# = 199)   GREATER BALTIMORE
035200130717     C                                OR                                            COMM INC.
035300130828     C                             (MCTRST = 590 AND MCSUB# = 1 AND ACC# = 30)    1-800-PACK RAT
035400130828     C                                OR
035500130619     C                             (MCTRST = 591 AND MCSUB# = 4 AND ACC# = 338)
035600120828     C                                OR
035700140529     C                             (MCTRST = 591 AND MCSUB# = 7 AND ACC# = 436)
035800140529     C                                OR
035900121025     C                             (MCTRST = 591 AND MCSUB# = 7 AND ACC# = 475)
036000121025     C                                OR
036100130307     C                             (MCTRST = 591 AND MCSUB# = 4 AND ACC# = 286)
036200130307     C                                OR
036300140320     C                             (MCTRST = 905 AND MCSUB# = 1 AND ACC# = 1)
036400140320     C                                OR
036500130619     C                             (MCTRST = 590 AND MCSUB# = 1 AND ACC# = 30)
036600130619     C                                OR
036700120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 16)
036800120828     C                                OR
036900120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 17)
037000120828     C                                OR
037100120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 18)
037200120828     C                                OR
037300120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 19)
037400120828     C                                OR
037500120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 20)
037600120828     C                                OR
037700120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 21)
037800120828     C                                OR
037900120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 22)
038000120828     C                                OR
038100120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 23)
038200120828     C                                OR
038300120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 24)
038400120828     C                                OR
038500120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 25)
038600120828     C                                OR
038700120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 26)
038800120828     C                                OR
038900120828     C                             (MCTRST = 590 AND MCSUB# = 6 AND ACC# = 28)
039000070924     C                   ITER
039100070924     C                   ENDIF
039200070921      **
039300070921     C                   IF        CANDT = 0
039400070921     C                   EVAL      CANDT = 99999999
039500070921     C                   ENDIF
039600070921      **
039700070921     C                   IF        MCSSNO <> H@SSN
039800090313     C                   Exsr      PrepRecord
039900070227     C                   Exsr      Process
040000070924     C                   EVAL      H@SSN = MCSSNO
040100070921     C                   ENDIF
040200070921      **
040300070921     C                   ENDIF
040400070921     C                   ENDDO
040500991208      *
040600090313    ?C                   ENDSR
040700070924     **
040800021004    ? *________________________________________________________________
040900070227    ?C     Process       Begsr
041000070227    ? *________________________________________________________________
041100021004    ? *
041200070228     C     MCSSNO        Chain     MEMBER
041300070924    ? *
041400070924     C                   IF        CANDT <> 99999999
041500070924     C     CNLMBR        CHAIN     METLIFR
041600070924     C                   IF        %FOUND(METLIFTRM)
041700070924     C                   LEAVESR
041800070924     C                   ELSE
041900120430     C                   If        CANDT <= Today
042000070924     C                   CLEAR                   METLIFR
042100070924     C                   EVAL      NTSSNO = MCSSNO
042200070925     C                   EVAL      NTDEPNO = 00
042300070924     C                   EVAL      NTTERMDT = CANDT
042400070924     C                   EVAL      NTPLAN = MCPLAN
042500070924     C                   EVAL      NTCOVTP  = MCOVTP
042600070924     C                   EVAL      NTTRST   = MCTRST
042700070924     C                   EVAL      NTSUB#   = MCSUB#
042800070924     C                   EVAL      NTACCT   = ACC#
042900090527     C                   Eval      NTTRANSDT = Today
043000070924     C                   WRITE     METLIFR
043100120430     C                   End
043200070924     C                   ENDIF
043300070924     C                   ENDIF
043400070924    ? *
043500070227     C                   Eval      PTRANCD   =   'E'
043600070227     C                   Movel     '00'          PEMPSSN
043700070227     C                   Move      MCSSNO        PEMPSSN
043800070228     C                   Move      MCSSNO        PMEMSSN
043900070227     C                   Eval      PMEMLNA   =   MLNAME                         Member Last Name
044000070227     C                   Eval      PMEMFNA   =   MFNAME                         Member First Name
044100070227     C                   Eval      PMEMMID   =   MMI                            Member First Name
044200070228     C                   Eval      PMEMSEX   =   SEX                            Member Gender
044300070227     C                   If        SEX       <>  'M'    And
044400070227     C                             SEX       <>  'F'
044500070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
044600070227     C                   End
044700070228     C                   If        MARDT     =   *Zeros
044800070228     C                   Eval      PMEMMST   =   'S'
044900070227     C                   Else
045000070228     C                   Eval      PMEMMST   =   'M'
045100070227     C                   End
045200070227     C     BIRTH         Mult      10000.0001    DOB               8 0
045300070228     C                   Movel     DOB           PMEMBDT
045400070227     C     EMPDT         Mult      10000.0001    HIREDT            8 0
045500070228     C                   Movel     HIREDT        PEMPHDT
045600070227     C                   Eval      PEMPPIN   =   *Blanks
045700070227     C                   Eval      PSURIND   =   *Blanks
045800070227     C                   Eval      PSURSSN   =   *Blanks
045900070227     C                   Eval      PSURLNA   =   *Blanks
046000070227     C                   Eval      PSURFNA   =   *Blanks
046100070227     C                   Eval      PFADDIN   =   'D'
046200070227     C                   Eval      PSTRADD   =   ADDR1
046300070227     C                   Eval      PADDLI2   =   ADDR2
046400070227     C                   Eval      PCITY     =   CITY
046500070227     C                   Eval      PSTATE    =   STATE
046600090225     C                   Movel     ZIP           PZIPCOD
046700090225     C                   Movel     '00'          PRELACD
046800090225      *---
046900090225      * Determine which coverage and load the appropriate format block
047000090225      *---
047100100423     C                   If        PLNCAT    =   Dental   OR
047200100423     C                             PLNCAT    =   DentalDC OR
047300100423     C                             Action    =   'D'
047400090225     C                   Exsr      DentalSr
047500090312     C                   End
047600090312     C                   If        PLNCAT    =   Life
047700090225     C                   Exsr      LifeSr
047800090312     C                   End
047900090312     C                   If        PLNCAT    =   AD_D
048000090225     C                   Exsr      AD_DSr
048100090312     C                   End
048200090312     C                   If        PLNCAT    =   LTD
048300090225     C                   Exsr      LTDSr
048400090312     C                   End
048500090312     C                   If        PLNCAT    =   STD
048600090225     C                   Exsr      STDSr
048700090312     C                   End
048800090313      *
048900090313      * Process Dependents
049000100521     C                   If        PLNCAT    =   Dental   Or
049100121002     C                             PLNCAT    =   DentalDC or
049200121002     C                             Action    =   'D'
049300070925     C     MCSSNO        CHAIN     DEPENR
049400070925     C                   IF        %FOUND(DEPNDC)
049500070925     C                   EXSR      $DEPEND
049600070925     C                   ENDIF
049700090313     C                   End
049800070227      *
049900070227    ?C                   Endsr
050000070925   S***S
050100070925     C     $DEPEND       BEGSR
050200070925      *
050300070925     C     MCSSNO        Setll     DEPENR
050400070925     C                   DOU       %Eof(DEPNDC)
050500070925     C     MCSSNO        Reade     DEPENR
050600070925     C                   IF        NOT %EOF(DEPNDC)
050700070925      *
050800070925     C     DepKey        CHAIN     DCOVR
050900070925     C                   IF        %FOUND(DCOV22)
051000070925      *
051100090313     C                   Exsr      PrepRecordD
051200070925     C                   EXSR      $DCOV
051300070925      *
051400070925     C                   ENDIF
051500070925      *
051600070925     C                   ENDIF
051700070925     C                   Enddo
051800070925      *
051900070925     C                   ENDSR
052000070925   S***S
052100070925     C     $DCOV         BEGSR
052200070925      *
052300070925     C     DepKey        SETGT     DCOVR
052400070925     C                   DOU       %Eof(DCOV22)
052500070925     C     DepKey        READPE    DCOVR
052600070925     C                   IF        NOT %Eof(DCOV22) AND DENRDT <> CCANDT
052700070925      *
052800070925     C                   IF        CCANDT = 0
052900070925     C                   EVAL      CCANDT = 99999999
053000070925     C                   ENDIF
053100070925      *
053200090313     C                   Exsr      BuildDepRec
053300070925     C                   LEAVESR
053400070925      *
053500070925     C                   ENDIF
053600070925     C                   ENDDO
053700070925      *
053800070925     C                   ENDSR
053900070227    ? *________________________________________________________________
054000070227    ?C     BuildDepRec   Begsr
054100070227    ? *________________________________________________________________
054200070227    ? *
054300070924     C                   IF        CCANDT <> 99999999
054400070924     C     CNLDEP        CHAIN     METLIFR
054500070924     C                   IF        %FOUND(METLIFTRM)
054600070924     C                   LEAVESR
054700070924     C                   ELSE
054800070924     C                   CLEAR                   METLIFR
054900070924     C                   EVAL      NTSSNO = SSNO
055000070925     C                   EVAL      NTDEPNO = DSEQ#
055100070924     C                   EVAL      NTTERMDT = CCANDT
055200070924     C                   EVAL      NTPLAN = DVPLAN
055300070924     C                   EVAL      NTCOVTP  = MCOVTP
055400070924     C                   EVAL      NTTRST   = MCTRST
055500070924     C                   EVAL      NTSUB#   = MCSUB#
055600070924     C                   EVAL      NTACCT   = ACC#
055700070924     C                   WRITE     METLIFR
055800070924     C                   ENDIF
055900070924     C                   ENDIF
056000070924    ? *
056100070227     C                   Eval      PTRANCD   =   'D'
056200070227     C                   Movel     '00'          PEMPSSN
056300070227     C                   Move      MCSSNO        PEMPSSN
056400070228     C                   Move      DEPSS#        PMEMSSN
056500070227     C                   Eval      PMEMLNA   =   DLNAME                         Member Last Name
056600070227     C                   Eval      PMEMFNA   =   DFNAME                         Member First Name
056700070227     C                   Eval      PMEMMID   =   DMI                            Member First Name
056800070228     C                   Eval      PMEMSEX   =   DSEX                           Member Gender
056900070227     C                   If        DSEX       <>  'M'    And
057000070227     C                             DSEX       <>  'F'
057100070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
057200070227     C                   End
057300070227     C                   If        DRELCD    <>  'RHU'   And
057400070227     C                             DRELCD    <>  'RWI'
057500070228     C                   Eval      PMEMMST   =   'S'
057600070227     C                   Else
057700070228     C                   Eval      PMEMMST   =   'M'
057800070227     C                   End
057900070227     C     DBIRTH        Mult      10000.0001    DOB               8 0
058000070228     C                   Movel     DOB           PMEMBDT
058100070228     C                   Eval      PCOVTYP   =   'D '
058200071106      *--
058300070925     C                   Movel     DENRDT        PCOVBDT
058400080117     C                   Movel     DENRDT        PCOVBDTN
058500071106     C****** DEPENDENT OVERRIDE
058600071106     C                   IF        DENRDT < ENRLDT
058700071106     C                   MOVE      ENRLDT        PCOVBDT
058800080117     C                   MOVE      ENRLDT        PCOVBDTN
058900071106     C                   ENDIF
059000071106     C****** DEPENDENT OVERRIDE
059100071106      *--
059200070925     C                   IF        CCANDT = 99999999 OR CCANDT = 0
059300070925     C                   MOVE      '00000000'    PCOVEDT
059400070925     C                   ELSE
059500070925     C                   Movel     CCANDT        PCOVEDT
059600070925     C                   ENDIF
059700070227      *--
059800070227     C                   Eval      PEMPPIN   =   *Blanks
059900070227     C                   Eval      PSURIND   =   *Blanks
060000070227     C                   Eval      PSURSSN   =   *Blanks
060100070227     C                   Eval      PSURLNA   =   *Blanks
060200070227     C                   Eval      PSURFNA   =   *Blanks
060300070227     C                   Eval      PFADDIN   =   'D'
060400110808     C                   Exsr      GetGrp
060500110808     C                   Eval      PSUBDIV   =   GroupSubDiv
060600120216     C****************   Eval      PSUBDIV   =   GroupBranch
060700120216     C                   Eval      PBRANCH   =   GroupBranch
060800090313     C                   Eval      PGROUP#   =   PCUSTNO
060900070228     C                   Eval      PPLANCD   =   *Blanks
061000070227     C                   If        CEXPDT    <>  *Zeros
061100070228     C                   Eval      PCOBRAI   =   'CE'
061200090527     C                   Move      CEXPDT        PCOVEDT
061300070227     C                   End
061400070227      *---
061500070227     C                   Select
061600070228     C                   When      CEXPDT   <>   *Zeros
061700070313     C                   When      CEXPDT    =   *Zeros
061800100226     C                   EndSl
061900070227     C                   Select
062000070227     C                   When      EMPST     =   'J'
062100070228     C                   Eval      PSTATCD   =   'R'
062200070227     C                   When      HDCPDT    <>  *Zero
062300070228     C                   Eval      PSTATCD   =   'D'
062400070227     C                   Other
062500070228     C                   Eval      PSTATCD   =   'A'
062600070227     C                   EndSl
062700021007    ? *
062800070227     C                   Select
062900070227     C                   When      DRELCD    =   'RHU'  Or
063000070227     C                             DRELCD    =   'RWI'
063100070228     C                   Movel     '01'          PRELACD
063200070227     C                   When      DRELCD    =   'RSO'  Or
063300090921     C                             DRELCD    =   'RDA'  Or
063400090921     C                             DRELCD    =   'RA '  Or
063500090921     C                             DRELCD    =   'RB '
063600070228     C                   Movel     '02'          PRELACD
063700130625     C                   When      DRELCD    =   'RPA'
063800130625     C                   Movel     '03'          PRELACD
063900070227     C                   EndSl
064000041220     C                   Select
064100070228     C                   When      MCOVTP    =   'TPC'  Or
064200070228     C                             MCOVTP    =   'TP2'
064300070228     C                   Eval      PMEMCCD   =   '2'
064400070228     C                   When      MCOVTP    =   'THW'
064500070228     C                   Eval      PMEMCCD   =   '3'
064600070228     C                   When      MCOVTP    =   'TFA'
064700070228     C                   Eval      PMEMCCD   =   '4'
064800041220     C                   Endsl
064900070925    ? *
065000090313     C                   Exsr      WriteRec
065100021007    ? *
065200021007    ?C                   Endsr
065300090225      *___________________________________________________________________
065400090225      *
065500090225      * Fill DENTAL Block of Record Format
065600090225      *___________________________________________________________________
065700090225     C     DentalSr      BEGSR
065800090225     C                   Eval      PCOVTYP   =   'D '
065900090225     C                   Move      ENRLDT        PCOVBDT
066000090225     C                   Move      ENRLDT        PCOVBDTN          8 0
066100090225     C****** COBRA OVERRIDE
066200090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
066300090225     C                   MOVE      GBSCDT        PCOVBDT
066400090225     C                   Move      GBSCDT        PCOVBDTN
066500090225     C                   ENDIF
066600090225     C****** COBRA OVERRIDE
066700090225      *--
066800090225     C                   IF        CANDT = 99999999 OR CANDT = 0
066900090225     C                   MOVE      '00000000'    PCOVEDT
067000090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
067100090225     C                   ELSE
067200090225     C                   Move      CANDT         PCOVEDT
067300090225     C                   MOVE      CANDT         PCOVEDTN
067400090225     C                   ENDIF
067500090225     C                   Exsr      GetGrp
067600090527     C                   Eval      PGROUP#   =   PCUSTNO
067700110808     C                   Eval      PSUBDIV   =   GroupSubDiv
067800120216     C                   Eval      PBRANCH   =   GroupBranch
067900090227     C                   Select
068000090227     C                   When      CEXPDT   <>   *Zeros
068100090225     C                   When      CEXPDT    =   *Zeros
068200100226     C                   EndSl
068300090225     C                   Eval      PPLANCD   =   *Blanks
068400090225     C                   If        CEXPDT    <>  *Zeros
068500090225     C                   Eval      PCOBRAI   =   'CE'
068600090527     C                   Move      CEXPDT        PCOVEDT
068700090225     C                   End
068800090227     C                   Select
068900090225     C                   When      EMPST     =   'J'
069000090225     C                   Eval      PSTATCD   =   'R'
069100090225     C                   When      HDCPDT    <>  *Zero
069200090225     C                   Eval      PSTATCD   =   'D'
069300090225     C                   Other
069400090225     C                   Eval      PSTATCD   =   'A'
069500090225     C                   EndSl
069600090225      *
069700090225     C                   Select
069800090225     C                   When      MCOVTP    =   'TIN'
069900090225     C                   Eval      PMEMCCD   =   '1'
070000090225     C                   When      MCOVTP    =   'TPC'  Or
070100090225     C                             MCOVTP    =   'TP2'
070200090225     C                   Eval      PMEMCCD   =   '2'
070300090225     C                   When      MCOVTP    =   'THW'
070400090225     C                   Eval      PMEMCCD   =   '3'
070500090225     C                   When      MCOVTP    =   'TFA'
070600090225     C                   Eval      PMEMCCD   =   '4'
070700090225     C                   Endsl
070800090227     C                   Eval      PDEPCLS   =   *Blanks
070900090225      *
071000090312     C                   Exsr      WriteRec
071100090225    ?C                   Endsr
071200090225      *___________________________________________________________________
071300090225      *
071400090225      * Fill LIFE Block of Record Format
071500090225      *___________________________________________________________________
071600090225     C     LifeSr        BEGSR
071700090227     C                   Eval      PTYPCO2   =   'CP'
071800090304     C                   Move      ENRLDT        PCOSTD2
071900090225     C                   Move      ENRLDT        PCOVBDTN          8 0
072000090225     C****** COBRA OVERRIDE
072100090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
072200090304     C                   MOVE      GBSCDT        PCOSTD2
072300090225     C                   Move      GBSCDT        PCOVBDTN
072400090225     C                   ENDIF
072500090225     C****** COBRA OVERRIDE
072600090225      *--
072700090225     C                   IF        CANDT = 99999999 OR CANDT = 0
072800090304     C                   MOVE      '00000000'    PCOEND2
072900090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
073000090225     C                   ELSE
073100090304     C                   Move      CANDT         PCOEND2
073200090225     C                   MOVE      CANDT         PCOVEDTN
073300090225     C                   ENDIF
073400090225     C                   Exsr      GetGrp
073500090227     C                   Eval      PPLANC2   =   *Blanks
073600090225     C                   If        CEXPDT    <>  *Zeros
073700090227     C                   Eval      PCOBRA2   =   'CE'
073800090527     C                   Move      CEXPDT        PCOEND2
073900090225     C                   End
074000090227     C                   Select
074100090225     C                   When      EMPST     =   'J'
074200090227     C                   Eval      PSTATC2   =   'R'
074300090225     C                   When      HDCPDT    <>  *Zero
074400090227     C                   Eval      PSTATC2   =   'D'
074500090225     C                   Other
074600090227     C                   Eval      PSTATC2   =   'A'
074700090225     C                   EndSl
074800090225      *
074900090225     C                   Select
075000090225     C                   When      MCOVTP    =   'TIN'
075100090227     C                   Eval      PMEMCC2   =   '1'
075200090225     C                   When      MCOVTP    =   'TPC'  Or
075300090225     C                             MCOVTP    =   'TP2'
075400090227     C                   Eval      PMEMCC2   =   '2'
075500090225     C                   When      MCOVTP    =   'THW'
075600090227     C                   Eval      PMEMCC2   =   '3'
075700090225     C                   When      MCOVTP    =   'TFA'
075800090227     C                   Eval      PMEMCC2   =   '4'
075900090225     C                   Endsl
076000090227     C                   Eval      PDEPCL2   =   *Blanks
076100090304     C                   Move      BENAMT        PINSAM2
076200090320     C                   Movel     '0'           PINSAM2
076300090225      *
076400090312     C                   Movel     'A'           PSAMOD2
076500090312     C                   Move      SALARY        PSALAR2
076600090312     C                   Exsr      WriteRec
076700090225    ?C                   Endsr
076800090225      *___________________________________________________________________
076900090225      *
077000090225      * Fill AD&D Block of Record Format
077100090225      *___________________________________________________________________
077200090225     C     AD_DSr        BEGSR
077300090227     C                   Eval      PTYPCO3   =   'AD'
077400090304     C                   Move      ENRLDT        PCOSTD3
077500090225     C                   Move      ENRLDT        PCOVBDTN          8 0
077600090225     C****** COBRA OVERRIDE
077700090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
077800090304     C                   MOVE      GBSCDT        PCOSTD3
077900090225     C                   Move      GBSCDT        PCOVBDTN
078000090225     C                   ENDIF
078100090225     C****** COBRA OVERRIDE
078200090225      *--
078300090225     C                   IF        CANDT = 99999999 OR CANDT = 0
078400090304     C                   MOVE      '00000000'    PCOEND3
078500090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
078600090225     C                   ELSE
078700090304     C                   Move      CANDT         PCOEND3
078800090225     C                   MOVE      CANDT         PCOVEDTN
078900090225     C                   ENDIF
079000090225     C                   Exsr      GetGrp
079100090227     C                   Eval      PPLANC3   =   *Blanks
079200090225     C                   If        CEXPDT    <>  *Zeros
079300090227     C                   Eval      PCOBRA3   =   'CE'
079400090527     C                   Move      CEXPDT        PCOEND3
079500090225     C                   End
079600090227     C                   Select
079700090225     C                   When      EMPST     =   'J'
079800090227     C                   Eval      PSTATC3   =   'R'
079900090225     C                   When      HDCPDT    <>  *Zero
080000090227     C                   Eval      PSTATC3   =   'D'
080100090225     C                   Other
080200090227     C                   Eval      PSTATC3   =   'A'
080300090225     C                   EndSl
080400090225      *
080500090225     C                   Select
080600090225     C                   When      MCOVTP    =   'TIN'
080700090227     C                   Eval      PMEMCC3   =   '1'
080800090225     C                   When      MCOVTP    =   'TPC'  Or
080900090225     C                             MCOVTP    =   'TP2'
081000090227     C                   Eval      PMEMCC3   =   '2'
081100090225     C                   When      MCOVTP    =   'THW'
081200090227     C                   Eval      PMEMCC3   =   '3'
081300090225     C                   When      MCOVTP    =   'TFA'
081400090227     C                   Eval      PMEMCC3   =   '4'
081500090225     C                   Endsl
081600090227     C                   Eval      PDEPCL3   =   *Blanks
081700090304     C                   Move      BENAMT        PINSAM3
081800090320     C                   Movel     '0'           PINSAM3
081900090225      *
082000090312     C                   Movel     'A'           PSAMOD3
082100090312     C                   Move      SALARY        PSALAR3
082200090312     C                   Exsr      WriteRec
082300090225    ?C                   Endsr
082400090225      *___________________________________________________________________
082500090225      *
082600090225      * Fill LTD Block of Record Format
082700090225      *___________________________________________________________________
082800090225     C     LTDSr         BEGSR
082900090312     C                   Eval      PTYPCO5   =   'LT'
083000090313     C                   Move      ENRLDT        PCOSTD5
083100090225     C                   Move      ENRLDT        PCOVBDTN          8 0
083200090225     C****** COBRA OVERRIDE
083300090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
083400090312     C                   MOVE      GBSCDT        PCOSTD5
083500090225     C                   Move      GBSCDT        PCOVBDTN
083600090225     C                   ENDIF
083700090225     C****** COBRA OVERRIDE
083800090225      *--
083900090225     C                   IF        CANDT = 99999999 OR CANDT = 0
084000090312     C                   MOVE      '00000000'    PCOEND5
084100090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
084200090225     C                   ELSE
084300090312     C                   Move      CANDT         PCOEND5
084400090225     C                   MOVE      CANDT         PCOVEDTN
084500090225     C                   ENDIF
084600090225     C                   Exsr      GetGrp
084700090312     C                   Eval      PPLANC5   =   *Blanks
084800090225     C                   If        CEXPDT    <>  *Zeros
084900090312     C                   Eval      PCOBRA5   =   'CE'
085000090527     C                   Move      CEXPDT        PCOEND5
085100090225     C                   End
085200090227     C                   Select
085300090225     C                   When      EMPST     =   'J'
085400090312     C                   Eval      PSTATC5   =   'R'
085500090225     C                   When      HDCPDT    <>  *Zero
085600090312     C                   Eval      PSTATC5   =   'D'
085700090225     C                   Other
085800090312     C                   Eval      PSTATC5   =   'A'
085900090225     C                   EndSl
086000090225      *
086100090225     C                   Select
086200090225     C                   When      MCOVTP    =   'TIN'
086300090312     C                   Eval      PMEMCC5   =   '1'
086400090225     C                   When      MCOVTP    =   'TPC'  Or
086500090225     C                             MCOVTP    =   'TP2'
086600090312     C                   Eval      PMEMCC5   =   '2'
086700090225     C                   When      MCOVTP    =   'THW'
086800090312     C                   Eval      PMEMCC5   =   '3'
086900090225     C                   When      MCOVTP    =   'TFA'
087000090312     C                   Eval      PMEMCC5   =   '4'
087100090225     C                   Endsl
087200090312     C                   Eval      PDEPCL5   =   *Blanks
087300090313     C                   Move      BENAMT        PINSAM5
087400090320     C                   Movel     '0'           PINSAM5
087500090225      *
087600090312     C                   Movel     'A'           PMOSAL5
087700090312     C                   Move      SALARY        PSALAM5
087800090312     C                   Exsr      WriteRec
087900090225    ?C                   Endsr
088000090225      *___________________________________________________________________
088100090225      *
088200090225      * Fill STD Block of Record Format
088300090225      *___________________________________________________________________
088400090225     C     STDSr         BEGSR
088500090312     C                   Eval      PTYPCO4   =   'AS'
088600090312     C                   Move      ENRLDT        PCOSTD4
088700090225     C                   Move      ENRLDT        PCOVBDTN          8 0
088800090225     C****** COBRA OVERRIDE
088900090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
089000090312     C                   MOVE      GBSCDT        PCOSTD4
089100090225     C                   Move      GBSCDT        PCOVBDTN
089200090225     C                   ENDIF
089300090225     C****** COBRA OVERRIDE
089400090225      *--
089500090225     C                   IF        CANDT = 99999999 OR CANDT = 0
089600090312     C                   MOVE      '00000000'    PCOEND4
089700090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
089800090225     C                   ELSE
089900090312     C                   Move      CANDT         PCOEND4
090000090225     C                   MOVE      CANDT         PCOVEDTN
090100090225     C                   ENDIF
090200090225     C                   Exsr      GetGrp
090300090312     C                   Eval      PPLANC4   =   *Blanks
090400090225     C                   If        CEXPDT    <>  *Zeros
090500090312     C                   Eval      PCOBRA4   =   'CE'
090600090527     C                   Move      CEXPDT        PCOEND4
090700090225     C                   End
090800090227     C                   Select
090900090225     C                   When      EMPST     =   'J'
091000090312     C                   Eval      PSTATC4   =   'R'
091100090225     C                   When      HDCPDT    <>  *Zero
091200090312     C                   Eval      PSTATC4   =   'D'
091300090225     C                   Other
091400090312     C                   Eval      PSTATC4   =   'A'
091500090225     C                   EndSl
091600090225      *
091700090225     C                   Select
091800090225     C                   When      MCOVTP    =   'TIN'
091900090312     C                   Eval      PMEMCC4   =   '1'
092000090227     C                   When      MCOVTP    =   'TPC'  Or
092100090225     C                             MCOVTP    =   'TP2'
092200090312     C                   Eval      PMEMCC4   =   '2'
092300090225     C                   When      MCOVTP    =   'THW'
092400090312     C                   Eval      PMEMCC4   =   '3'
092500090225     C                   When      MCOVTP    =   'TFA'
092600090312     C                   Eval      PMEMCC4   =   '4'
092700090225     C                   Endsl
092800090312     C                   Eval      PDEPCL4   =   *Blanks
092900090312     C                   Move      BENAMT        PINSAM4
093000090320     C                   Movel     '0'           PINSAM4
093100090225      *
093200090312     C                   Movel     'A'           PMOSAL4
093300090312     C                   Move      SALARY        PSALAM4
093400090312     C                   Exsr      WriteRec
093500090225    ?C                   Endsr
093600080117      *___________________________________________________________________
093700080117      * Retrieve the group number from the GRATE file.
093800080117      *___________________________________________________________________
093900080117     C     Getgrp        BEGSR
094000080117      *
094100080117     c     RatKey        Setll     GRATE
094200080903     c     RatKey        Reade     GRATE
094300080903     c                   Dow       not %eof(GRATE)
094400080117     C                   If        (PCOVBDTN >=  FRMDAT) and
094500110818     C                             (PCOVEDTN <=  TODAT)
094600110818      **** TEST ****
094700110818     C                                                   Or
094800110818      * Member's coverage is Active
094900110818     C                             (PCOVEDTN  =  *Zeros  Or
095000110818     C                              PCOVEDTN >=  Today)  And
095100110818      * Rate may begin after member's coverage but is still active.
095200110818     C                             (Today    <=  TODAT)
095300110818      **** TEST ****
095400090312     C                   Exsr      FmtGrp
095500080117     C                   End
095600080903     c     RatKey        Reade     GRATE
095700080117     C                   EndDo
095800090312      *When coverage is termed, there may be no current rate; still need grp
095900110808     C                   If        PCUSTNO    =  *Blanks
096000090312     C                   Exsr      FmtGrp
096100090312     C                   End
096200080117      *
096300080117    ?C                   Endsr
096400090312      *___________________________________________________________________
096500090312      * Format the group number.
096600090312      *___________________________________________________________________
096700090312     C     Fmtgrp        BEGSR
096800110808      *---
096900110808      *  The 1st 7 digits of group# are moved into group, next 4 subd, next 4 branch
097000110808      *---
097100110808     C                   Clear                   GroupFmt
097200110808     C                   Eval      GroupFmt   =  GROUP#
097300110815     C                   Select
097400110815     C                   When       PLNCAT    =   Dental  Or
097500110815     C                              PLNCAT    =   DentalDC  Or
097600110815     C                              ACTION    =   'D'
097700110815     C                   Eval      PCUSTNO    =  GroupGroup
097800110808     C                   Eval      PSUBDIV    =  GroupSubDiv
097900110808     C                   Eval      PBRANCH    =  GroupBranch
098000110815      *
098100110815     C                   When      PLNCAT     =  Life
098200110818     C                   Eval      PCUSTNO    =  GroupGroup
098300110815     C                   Eval      PGROUP2    =  GroupGroup
098400110815     C                   Eval      PSUBDI2    =  GroupSubDiv
098500110815     C                   Eval      PBRANC2    =  GroupBranch
098600110815      *
098700110815     C                   When      PLNCAT    =   AD_D
098800110818     C                   Eval      PCUSTNO    =  GroupGroup
098900110815     C                   Eval      PGROUP3    =  GroupGroup
099000110815     C                   Eval      PSUBDI3    =  GroupSubDiv
099100110815     C                   Eval      PBRANC3    =  GroupBranch
099200110815      *
099300110815     C                   When      PLNCAT    =   LTD
099400110818     C                   Eval      PCUSTNO    =  GroupGroup
099500110815     C                   Eval      PGROUP5    =  GroupGroup
099600110815     C                   Eval      PSUBDI5    =  GroupSubDiv
099700110815     C                   Eval      PBRANC5    =  GroupBranch
099800110815      *
099900110815     C                   When      PLNCAT    =   STD
100000110818     C                   Eval      PCUSTNO    =  GroupGroup
100100110815     C                   Eval      PGROUP4    =  GroupGroup
100200110815     C                   Eval      PSUBDI4    =  GroupSubDiv
100300110815     C                   Eval      PBRANC4    =  GroupBranch
100400110815     C                   EndSl
100500110329      *
100600090312    ?C                   Endsr
100700090312      *___________________________________________________________________
100800090313      * Prepare Dependent Record for Update
100900090312      *___________________________________________________________________
101000090313     C     PrepRecordD   BEGSR
101100090312      *
101200090312     C                   Move      MCSSNO        Kssno            11
101300090312     C                   Movel     '00'          Kssno
101400090313     C                   Move      DEPSS#        Mssno             9
101500090313     C     PKey          chain     PROEXPLF
101600090313     C                   If        Not %found(PROEXPLF)
101700090313     C                   Clear                   PROEXPR
101800090313     C                   Clear                   PROUPDR
101900090313     C                   Eval      Data = 'A'
102000090313     C                   Else
102100090901     C                   If        DFNAME   =    PMEMFNA     And
102200090901     C                             DMI      =    PMEMMID
102300090313     C                   Eval      Data = 'U'
102400090901     C                   Else
102500090901     C                   Clear                   PROEXPR
102600090901     C                   Clear                   PROUPDR
102700090901     C                   Eval      Data = 'A'
102800090312     C                   End
102900090901     C                   End
103000090313      *
103100090312    ?C                   Endsr
103200090313      *___________________________________________________________________
103300090313      * Prepare Record for Update
103400090313      *___________________________________________________________________
103500090313     C     PrepRecord    BEGSR
103600090313      *
103700090313     C                   Move      MCSSNO        Kssno            11
103800090313     C                   Movel     '00'          Kssno
103900090313     C                   Move      MCSSNO        Mssno             9
104000090313     C     PKey          chain     PROEXPLF
104100090313     C                   If        Not %found(PROEXPLF)
104200090313     C                   Clear                   PROEXPR
104300090313     C                   Clear                   PROUPDR
104400090313     C                   Eval      Data = 'A'
104500090313     C                   Else
104600090313     C                   Eval      Data = 'U'
104700090313     C                   End
104800090313      *
104900090313    ?C                   Endsr
105000090313      *___________________________________________________________________
105100090313      * Write or update a record
105200090313      *___________________________________________________________________
105300090313     C     WriteRec      BEGSR
105400090313      *
105500090313     C                   Select
105600090313     C                   When      Data = 'A'
105700090313     C                   Write     PROEXPR
105800090313     C                   When      Data = 'U'
105900090313     C                   Update    PROUPDR
106000090313     C                   Endsl
106100090313      *
106200090313     C                   Clear                   Data
106300090313     C                   Clear                   PROEXPR
106400090313     C                   Clear                   PROUPDR
106500090313      *
106600090313    ?C                   Endsr
106700070226    ? *___________________________________________________________________
106800070226    ? * Key lists
106900070226    ? *___________________________________________________________________
107000070226    ?C     Klist         Begsr                                                  KEY LISTS
107100100421      *
107200100421     C     CodKey        Klist
107300100421     C                   Kfld                    Typ
107400100421     C                   Kfld                    Cod
107500070924      *
107600070227     C     PlnKey        Klist
107700070227     C                   Kfld                    PLTRST
107800070227     C                   Kfld                    PLSUB#
107900070227     C                   Kfld                    PLPLAN
108000070924    ? *
108100070924     C     CNLMBR        Klist
108200070924     C                   Kfld                    MCSSNO
108300070924     C                   Kfld                    MDSEQ#
108400070924     C                   Kfld                    CANDT
108500070924     C                   Kfld                    MCPLAN
108600070924     C                   Kfld                    MCOVTP
108700070924     C                   Kfld                    MCTRST
108800070924     C                   Kfld                    MCSUB#
108900070924     C                   Kfld                    ACC#
109000070227    ? *
109100070227     C     DepKey        Klist
109200070227     C                   Kfld                    MCTRST
109300070227     C                   Kfld                    MCSUB#
109400070227     C                   Kfld                    MCPLAN
109500070227     C                   Kfld                    DSSNO
109600070227     C                   Kfld                    DPSEQ#
109700070227    ? *
109800070924     C     CNLDEP        Klist
109900070924     C                   Kfld                    SSNO
110000070924     C                   Kfld                    DSEQ#
110100070924     C                   Kfld                    CCANDT
110200070924     C                   Kfld                    DVPLAN
110300070924     C                   Kfld                    MCOVTP
110400070924     C                   Kfld                    MCTRST
110500070924     C                   Kfld                    MCSUB#
110600070924     C                   Kfld                    ACC#
110700070924    ? *
110800080117     C     RATKEY        KLIST
110900080117     C                   KFLD                    MCTRST
111000080117     C                   KFLD                    MCSUB#
111100080117     C                   KFLD                    MCPLAN
111200080117     C                   KFLD                    MCAGEB
111300080117     C                   KFLD                    MCOVTP
111400080117      *
111500090312     C     PKey          Klist
111600090312     C                   Kfld                    Kssno
111700090312     C                   Kfld                    Mssno
111800070228    ?C                   Endsr
111900020726    ? *________________________________________________________________
112000020726    ? * Initialization
112100020726    ? *________________________________________________________________
112200001003    ?C     *INZSR        Begsr
112300070924      *
112400021007     C     *DATE         Mult      10000.0001    Today             8 0
112500041220     C                   Eval      FILLER1    =  *Blanks
112600041220     C                   Eval      FILLER2    =  *Blanks
112700070227      *
112800001003    ?C                   Endsr
112900070924
113000070924
113100070924
113200070924
