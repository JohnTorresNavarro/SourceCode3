000100160226     H option(*noDebugIo)
000200001003      *_________________________________________________________________________
000300001003      *                                                                *
000400070226      *  Description:  PROMEEXR   Load Pro-Telligent Dental Coverages. *
000500001003      *                                                                *
000600070226      *  (c)Copyright 2007 by GBS, Inc.                                *
000700041220      *  This document contains restricted materials of GBS, Inc.      *
000800001003      *                                                                *
000900070227      *  Written by:   S. Zien                                         *
001000070227      *  Date Written: 02/27/07                                        *
001100001003      *                                                                *
001200070228      *  History:                                                      *
001300070227      *                                                                *
001400070226      *            Revised by -                                        *
001500070226      *            Date -                                              *
001600070226      *            Revision -                                          *
001700070921      * 09.21.2007.SSK.CANCELLATION LOGIC MODIFICATIONS PER MET LIFE   *
001800070924      *                CORRECTION OF DATE RANGES SENT                  *
001900070924      *                REMOVAL OF GETCOVCL [WHICH IS BROKE]            *
002000071106      * 11.05.2007.SSK.COBRA DATE OVERRIDE MODIFICATION PER MET LIFE   *
002100071106      *                OVERRIDE DEPENDENT EFF DATE PER MET LIFE        *
002200080117      *                                                                *
002300080117      *            Revised by -  szz                                   *
002400080117      *            Date -        01.17.2008                            *
002500080117      *            Revision -    Retrieve group from group master.     *
002600080501      *                                                                *
002700080501      *            Revised by -  szz                                   *
002800080501      *            Date -        05.01.2008                            *
002900080501      *            Revision -    Per Dave A. email of 5.1.08 8:36,     *
003000080501      *                           hard code for only two groups:       *
003100080501      *                           5469067 & 5722574.                   *
003200080618      *            Revised by -  szz                                   *
003300080618      *            Date -        06.18.2008                            *
003400080618      *            Revision -    Employees were being written out for  *
003500080618      *                           a group other than the hard-coded    *
003600080618      *                           groups above; inserted the two-group *
003700080618      *                           criteria for the employees.          *
003800080718      *            Revised by -  szz                                   *
003900080718      *            Date -        07.18.2008                            *
004000080718      *            Revision -    Hard coding removed for these two     *
004100080718      *                           groups per email 7.18.08:            *
004200080718      *                           5469067 & 5722574.                   *
004300080722      *            Revised by -  szz                                   *
004400080722      *            Date -        07.22.2008                            *
004500080722      *            Revision -    Hard code these 2 groups out per DaveA*
004600080722      *                           email 7.22.08 until future notice:   *
004700080722      *                           5469196 & 5566260.                   *
004800080919      *                                                                *
004900080919      *            Revised by -  szz                                   *
005000080919      *            Date -        09.19.2008                            *
005100080919      *            Revision -    Incorporate new coverage types LIFE   *
005200080919      *                           LTD, STD & AD&D into the new record  *
005300080919      *                           layout.                              *
005400090427      *            Revised by -  szz                                   *
005500090427      *            Date -        04.27.2009                            *
005600090427      *            Revision -    Requested by Carol Fab and suggested  *
005700090427      *                           by Danielle Pizzuto at Metlife that  *
005800090427      *                           we remove Enterprise Technologies    *
005900090427      *                           from the file because they are having*
006000090427      *                           payment issues which are preventing  *
006100090427      *                           our test file from being tested.     *
006200090428      *            Revised by -  szz                                   *
006300090428      *            Date -        04.28.2009                            *
006400090428      *            Revision -    Brandy at Metlife said that the issues*
006500090428      *                           about Enterprise Technology have been*
006600090428      *                           resolved so we may add them back in. *
006700090901      *            Revised by -  szz                                   *
006800090901      *            Date -        09.01.2009                            *
006900090901      *            Revision -    If there are more than one dependents and
007000090901      *                           more than one do not have a social security
007100090901      *                           number, an additional check is necessary
007200090901      *                           to make sure first dependent is not overwritten.
007300090921      *            Revised by -  szz                                   *
007400090921      *            Date -        09.21.2009                            *
007500090921      *            Revision -    Code for dependent twins which are different
007600090921      *                           than son and daughter.
007700100107      *            Revised by -  szz                                   *
007800100107      *            Date -        01.07.2010                            *
007900100107      *            Revision -    Add these two groups:                 *
008000100107      *                           594258  & 571049.                    *
008100100114      *            Revised by -  szz                                   *
008200100114      *            Date -        01.14.2010                            *
008300100114      *            Revision -    Add these groups:                     *
008400100114      *                           5326161, 5141296, 5750164            *
008500100121      *            Revised by -  szz                                   *
008600100121      *            Date -        01.21.2010                            *
008700100121      *            Revision -    Add these groups:                     *
008800100121      *                           5326158, 5326159                     *
008900100125      *            Revised by -  szz                                   *
009000100125      *            Date -        01.25.2010                            *
009100100125      *            Revision -    Add these groups:                     *
009200100125      *                           05725789                             *
009300100226      *            Revised by -  szz                                   *
009400100226      *            Date -        02.26.2010                            *
009500100226      *            Revision -    Jasmine wrote to Amy L. saying that   *
009600100226      *                           5732310 should have branch 0002 for  *
009700100226      *                           Dental.                              *
009800100322      *            Revised by -  szz                                   *
009900100322      *            Date -        03.22.2010                            *
010000100322      *            Revision -    Add these groups:                     *
010100100322      *                           5481248 Asher & 5594257 Canyon Cons. *
010200100401      *            Revised by -  szz                                   *
010300100401      *            Date -        04.01.2010                            *
010400100401      *            Revision -    Add Carrier Code MED for MetLife      *
010500100401      *                           Dental DAILY Proration.              *
010600100421      *            Revised by -  szz                                   *
010700100421      *            Date -        04.21.2010                            *
010800100421      *            Revision -    Add CODES file to determine the       *
010900100421      *                           'ACTION" field that groups plan      *
011000100421      *                           types together per Dave A: in case   *
011100100421      *                           other plan types are added.          *
011200100429      *            Revised by -  szz                                   *
011300100429      *            Date -        04.29.2010                            *
011400100429      *            Revision -    Add this group:                       *
011500100429      *                           5722568                              *
011600100503      *            Revised by -  szz                                   *
011700100503      *            Date -        05.03.2010                            *
011800100503      *            Revision -    New groups preceded by letters.       *
011900100511      *            Revised by -  szz                                   *
012000100511      *            Date -        05.11.2010                            *
012100100511      *            Revision -    Hard Code Account 591.4.349 so that   *
012200100511      *                          it does not get exported per Dave A   *
012300100511      *                          in email of 5/11/10 12:20 pm          *
012400100729      *            Revised by -  szz                                   *
012500100729      *            Date -        07.29.2010                            *
012600100729      *            Revision -    Add this group:                       *
012700100729      *                           5481101                             *
012800101118      *            Revised by -  szz                                   *
012900101118      *            Date -        11.18.2010                            *
013000101118      *            Revision -    Add this group:                       *
013100101118      *                           5469314                             *
013200101129      *            Revised by -  szz                                   *
013300101129      *            Date -        11.29.2010                            *
013400101129      *            Revision -    Hard Code Account 591.2.308 so that   *
013500101129      *                          it does not get exported per Dave A   *
013600101129      *                          in email of 10/28/10 4:07 pm (Exeter) *
013700110107      *
013800110107      * 01/07/11 dlk - add 1800 pack rat and moore & assoc
013900110107      *                to group # translation
014000110107      *
014100110110      * 01/10/11 szz - Add Bay State Medical, Inc. 5564824.
014200110110      *
014300110301      * 03/01/11 szz - Hard Code 591.1.406 out so that records will no *
014400110301      *                longer export per Dave A in email of 1/21/11    *
014500110301      *                3:29pm.                                         *
014600110110      *
014700110310      * 03/10/11 szz - Add Hanover Uniform Co.  5870901
014800110310      *
014900110329      * 03/29/11 szz - Add Ecology Services, Inc 3261700
015000110329      *
015100110706      * 07/06/11 szz - Add Independent Sector 5594287 with new branch info
015200110707      *                Per Dori VanFleet, for this group ONLY, we will use
015300110707      *                the STATUS field of 'C' to determine if they have
015400110707      *                COBRA.
015500110708      *
015600110708      * 07/08/11 szz - Add Helicopter Assoc. 5326173 with new branch info
015700110708      *                Per Dori VanFleet, for this group ONLY, we will use
015800110708      *                the STATUS field of 'C' to determine if they have
015900110708      *                COBRA.
016000110706      *
016100110710      * 07/10/11 szz - Per Margie M. remove group 574659 based on email
016200110710      *                sent from Lisa Sebro at Metlife. 591-4-338
016300110808      *
016400110808      * 08/08/11 szz - The format for DENTAL group# has changed to include
016500110808      *                 the subdivision and branch.  Hardcoding for the
016600110808      *                 44 groups will no longer be needed.
016700110809
016800110902      * 09/02/11 szz - Per Carol F. phone call 9/2/11 11:30am, temporarily
016900110902      *                 exclude account 590-7-23 from the export due to
017000110902      *                 kickouts caused to this group for nonpayment
017100110902      *                 (this is what Metlife told Carol F.)
017200110915
017300110915      * 09/15/11 szz - Per Carol F. email 9/14/11 5:10pm, remove exlusion
017400110915      *                 of 590-7-23.
017500110902
017600110921      * 09/21/11 szz - Per Kevin W. phone call 9/21/11 10am, only show the
017700110921      *                 current coverage.  If there is a future coverage,
017800110921      *                 only send that when it becomes current (not before).
017900110921
018000120216      *  2/16/12 szz - Branch was not being loaded to employee.
018100120216
018200120430      *  4/30/12 szz - Do not write terms to the term file if it's a future
018300120430      *                 term.
018400120430
018500120828      * 08/28/12 szz - Per Stacey H. remove group 573775 based on email
018600120828      *                sent from JPittman at Metlife on 8/14/12 re Kidd Intl
018700120828      *                this includes 12 accounts in 590-006.
018800120831
018900120831      * 08/31/12 szz - Per Stacey H. remove group 586265 based on email
019000120831      *                sent from JPittman at Metlife on 8/30/12 re Smyth.
019100120831      *                this includes 2 accounts in 600-005.
019200120828      *
019300120921      * 09/21/12 szz - Per Richard Thompson, email of 9/20/12, J&J Trash
019400120921      *                301.4.1 will no longer be sent.
019500121002      *
019600121002      * 10/02/12 dlk - add "or action = D" to dependent search at 185.03
019700121002      *                to fix dependents missing from file.
019800121010      *
019900121010      * 10/10/12 szz - comment out 600-5-18: per Carol F. email; this
020000121010      *                group has been reinstated.
020100121025      *
020200121025      * 10/25/12 szz - Per Richard Thomson 10/1/12 email, do not send
020300121025      *                Family League of Baltimore 591-7-475 anymore since
020400121025      *                they continue to be with Metlife but are no longer
020500121025      *                with GBS. (Group 5984505)
020600121203      *
020700121203      * 12/03/12 szz - Per Carol Fab based on phone call of same day at
020800121203      *                1:05 pm. Account 600-5-21 has been reinstated
020900121203      *                and therefore their exclusion should be removed.
021000121203      *
021100121231      * 12/31/12 szz - Per Megan Pierson forwarded by Stephen King do not
021200121231      *                send Team People 5469196 591-5-280 anymore.
021300121231      *
021400130307      *  3/07/13 szz - Per Deborah Clark:  Phase One Consulting group not
021500130307      *                with GBS anymore but still w/carrier:  591-4-286.
021600130307      *
021700130401      * 03/26/13 SSK - STACEY H. REQUEST TO SHUT PHASE ONE CONSULTING
021800130401      *                  AS OF 4/1/13; GRP# 5326181; 591-004-0286.
021900130401      *
022000130619      *  6/19/13 szz - Per Stacey H. Pack Rat not with GBS anymore but
022100130619      *                 still w/carrier:  590-1-30. Group# 5326164.
022200130619      *
022300130625      *  6/25/13 szz - Per Matt Kuhn 6/25/13 email, code RPA (Partner) as
022400130625      *                 03.
022500130401      *
022600130717      * 07/16/13 SSK - BRANDON S. REQUEST TO SHUTDOWN EXPERIMENTAL MACHINE
022700130716      *                  GRP# 5326185; 591-006-0035.
022800130401      *
022900130717      * 07/17/13 SSK - BRANDON S. REQUEST TO SHUTDOWN GREATER BALTIMORE COMMITTEE INC
023000130717      *                  GRP# 5326174; 502-007-0199.
023100130717      *
023200131211      * 12/11/2013 SSK DEFINED DS POSITIONS, SEE IF THAT HELPS.
023300131211      *
023400140320      * 03/20/2014 SSK STACEY HELBIG RQST TO SHUTDOWN ADVANCED TECH & RESRCH CORP
023500131211      *
023600140520      * 05/20/2014 SSK BRANDON S. REQUEST TO SHUTDOWN COUNCIL FOR PROFESSIONAL RECOGNITION
023700140520      *                770-008-0031
023800131211      *
023900140529      * 05/29/2014 SSK STACEY HELBIG REQUEST SHUTDOWN OF 591-007-0436
024000131211      *
024100140602      * 06/02/2014 SSK BRANDON S. REQUEST TO SHUTDOWN HELICOPTER ASS
024200140602      *                591-007-0399
024300140602      *
024400140616      * 06/16/2014 SSK ADDING LAST TRANSMISSION OVERRIDE FILE
024500140616      *
024600140616      *
024700150224      * 02.24.2015 DMA per deborah remove 590.1.35
024800140616      *
024900991207      *_________________________________________________________________________
025000070924     FPLNMSTN1  IF   E           K Disk
025100070227     FMCOV39    IF   E           K Disk
025200070228     FMEMBER    IF   E           K Disk
025300070925     FDEPNDC    IF   E           K Disk
025400070227     FDCOV22    IF   E           K Disk
025500080117     FGRATE     IF   E           K Disk
025600100421     FCODES     IF   E           K Disk
025700140616     FMETRANSOFFIF   E           K Disk
025800140616     FMETLIFEWF O  A E           K DISK
025900140616     FMETLIFEWL UF   E           K DISK    rename(proexpr:proupdr)
026000070924     FMETLIFTRM IF A E           K DISK
026100021004      *
026200100421     DPlanCat          DS             3
026300100421     D  Typ                           1
026400100421     D  Cod                           2
026500110808      *
026600131211     D                 DS
026700131211     D  GroupFmt               1     15A
026800131211     D  GroupGroup             1      7A
026900131211     D  GroupSubDiv            8     11A
027000131211     D  GroupBranch           12     15A
027100100421      *
027200140616     D #ISO            S               D   DATFMT(*ISO)
027300090313     D Data            S              1A
027400070227     D No              S              1A   Inz('N')
027500070227     D Yes             S              1A   Inz('Y')
027600100401     D MetDenD         S              3A   Inz('MED')
027700070227     D MetLife         S              3A   Inz('MET')
027800090224     D LifeProds       S              3A   Inz('MEL')
027900070227     D Dental          S              3A   Inz('PDN')
028000100420     D DentalDC        S              3A   Inz('PDR')
028100080923     D Life            S              3A   Inz('PLF')
028200080923     D AD_D            S              3A   Inz('PAC')
028300080923     D LTD             S              3A   Inz('PLT')
028400080923     D STD             S              3A   Inz('PWD')
028500090313      *
028600090313      * Check for MEL - Life Products
028700090313     C     LifeProds     SETLL     PLNMSR
028800090313     C     LifeProds     ReadE     PLNMSR
028900090313     C                   DOW       not %EOF(PLNMSTN1)
029000090313     C                   If         PLNCAT    =   Life      Or
029100090313     C                              PLNCAT    =   AD_D      Or
029200090313     C                              PLNCAT    =   LTD       Or
029300090313     C                              PLNCAT    =   STD
029400090313     C                   EXSR      LOADRCD
029500090313     C                   End
029600090313     C     LifeProds     ReadE     PLNMSR
029700090313     C                   Enddo
029800100401      *
029900100401      * Check for MED - Metlife Dental - DAILY Proration
030000100401     C     MetDend       SETLL     PLNMSR
030100100401     C     MetDend       ReadE     PLNMSR
030200100401     C                   DOW       not %EOF(PLNMSTN1)
030300100421     C                   Movel     PLNCAT        PlanCat
030400100421     C     CodKey        Chain     CODES
030500100420     C                   If         PLNCAT    =   Dental  Or
030600100421     C                              PLNCAT    =   DentalDC  Or
030700100421     C                              ACTION    =   'D'
030800100401     C                   EXSR      LOADRCD
030900100401     C                   End
031000100423     C     MetDenD       ReadE     PLNMSR
031100100401     C                   Enddo
031200090313      *
031300100401      * Check for MET - Dental Products - Full Monthly  Billing
031400090313     C     MetLife       SETLL     PLNMSR
031500090313     C     MetLife       ReadE     PLNMSR
031600100423     C     CodKey        Chain     CODES
031700090313     C                   DOW       not %EOF(PLNMSTN1)
031800100423     C                   If         PLNCAT    =   Dental Or
031900100423     C                              PLNCAT    =   DentalDC  Or
032000100423     C                              ACTION    =   'D'
032100090313     C                   EXSR      LOADRCD
032200090313     C                   End
032300090313     C     MetLife       ReadE     PLNMSR
032400090313     C                   Enddo
032500090313      *
032600090313     C                   Move      *On           *inLR
032700090313      *
032800090313     C     LOADRCD       BEGSR
032900070921     **
033000070921     C                   MOVE      *ZEROS        H@SSN             9 0
033100070228     C     PlnKey        Setll     MCOV39
033200090313     C                   DOW       not %Eof(MCOV39)
033300090313     C     PlnKey        Reade     MCOV39
033400090313      **x
033500090313     C                   IF        ENRLDT <> CANDT
033600110921     C                                                And
033700110921     C                             ENRLDT <= Today
033800070924      **
033900140616      ** OLD TERMED ACCOUNT
034000140616      **
034100140616    ***
034200140616     C     KL#TSA        KLIST
034300140616     C                   KFLD                    MCTRST
034400140616     C                   KFLD                    MCSUB#
034500140616     C                   KFLD                    ACC#
034600140616    ***
034700140616     C     KL#TSA        CHAIN     MTOF
034800140616     C                   IF        %FOUND(METRANSOFF) AND TODAY > MTOLASDTE
034900140616     C                             AND MTOLASDTE <> 0
035000140616     C                   ITER
035100140616     C                   ENDIF
035200070921      **
035300070921     C                   IF        CANDT = 0
035400070921     C                   EVAL      CANDT = 99999999
035500070921     C                   ENDIF
035600070921      **
035700070921     C                   IF        MCSSNO <> H@SSN
035800090313     C                   Exsr      PrepRecord
035900070227     C                   Exsr      Process
036000070924     C                   EVAL      H@SSN = MCSSNO
036100070921     C                   ENDIF
036200070921      **
036300070921     C                   ENDIF
036400070921     C                   ENDDO
036500991208      *
036600090313     C                   ENDSR
036700070924     **
036800021004      *________________________________________________________________
036900070227     C     Process       Begsr
037000070227      *________________________________________________________________
037100021004      *
037200070228     C     MCSSNO        Chain     MEMBER
037300070924      *
037400070924     C                   IF        CANDT <> 99999999
037500070924     C     CNLMBR        CHAIN     METLIFR
037600070924     C                   IF        %FOUND(METLIFTRM)
037700070924     C                   LEAVESR
037800070924     C                   ELSE
037900120430     C                   If        CANDT <= Today
038000070924     C                   CLEAR                   METLIFR
038100070924     C                   EVAL      NTSSNO = MCSSNO
038200070925     C                   EVAL      NTDEPNO = 00
038300070924     C                   EVAL      NTTERMDT = CANDT
038400070924     C                   EVAL      NTPLAN = MCPLAN
038500070924     C                   EVAL      NTCOVTP  = MCOVTP
038600070924     C                   EVAL      NTTRST   = MCTRST
038700070924     C                   EVAL      NTSUB#   = MCSUB#
038800070924     C                   EVAL      NTACCT   = ACC#
038900090527     C                   Eval      NTTRANSDT = Today
039000070924     C                   WRITE     METLIFR
039100120430     C                   End
039200070924     C                   ENDIF
039300070924     C                   ENDIF
039400070924      *
039500070227     C                   Eval      PTRANCD   =   'E'
039600070227     C                   Movel     '00'          PEMPSSN
039700070227     C                   Move      MCSSNO        PEMPSSN
039800070228     C                   Move      MCSSNO        PMEMSSN
039900070227     C                   Eval      PMEMLNA   =   MLNAME                         Member Last Name
040000070227     C                   Eval      PMEMFNA   =   MFNAME                         Member First Name
040100070227     C                   Eval      PMEMMID   =   MMI                            Member First Name
040200070228     C                   Eval      PMEMSEX   =   SEX                            Member Gender
040300070227     C                   If        SEX       <>  'M'    And
040400070227     C                             SEX       <>  'F'
040500070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
040600070227     C                   End
040700070228     C                   If        MARDT     =   *Zeros
040800070228     C                   Eval      PMEMMST   =   'S'
040900070227     C                   Else
041000070228     C                   Eval      PMEMMST   =   'M'
041100070227     C                   End
041200070227     C     BIRTH         Mult      10000.0001    DOB               8 0
041300070228     C                   Movel     DOB           PMEMBDT
041400070227     C     EMPDT         Mult      10000.0001    HIREDT            8 0
041500070228     C                   Movel     HIREDT        PEMPHDT
041600070227     C                   Eval      PEMPPIN   =   *Blanks
041700070227     C                   Eval      PSURIND   =   *Blanks
041800070227     C                   Eval      PSURSSN   =   *Blanks
041900070227     C                   Eval      PSURLNA   =   *Blanks
042000070227     C                   Eval      PSURFNA   =   *Blanks
042100070227     C                   Eval      PFADDIN   =   'D'
042200070227     C                   Eval      PSTRADD   =   ADDR1
042300070227     C                   Eval      PADDLI2   =   ADDR2
042400070227     C                   Eval      PCITY     =   CITY
042500070227     C                   Eval      PSTATE    =   STATE
042600090225     C                   Movel     ZIP           PZIPCOD
042700090225     C                   Movel     '00'          PRELACD
042800090225      *---
042900090225      * Determine which coverage and load the appropriate format block
043000090225      *---
043100100423     C                   If        PLNCAT    =   Dental   OR
043200100423     C                             PLNCAT    =   DentalDC OR
043300100423     C                             Action    =   'D'
043400090225     C                   Exsr      DentalSr
043500090312     C                   End
043600090312     C                   If        PLNCAT    =   Life
043700090225     C                   Exsr      LifeSr
043800090312     C                   End
043900090312     C                   If        PLNCAT    =   AD_D
044000090225     C                   Exsr      AD_DSr
044100090312     C                   End
044200090312     C                   If        PLNCAT    =   LTD
044300090225     C                   Exsr      LTDSr
044400090312     C                   End
044500090312     C                   If        PLNCAT    =   STD
044600090225     C                   Exsr      STDSr
044700090312     C                   End
044800090313      *
044900090313      * Process Dependents
045000100521     C                   If        PLNCAT    =   Dental   Or
045100121002     C                             PLNCAT    =   DentalDC or
045200121002     C                             Action    =   'D'
045300070925     C     MCSSNO        CHAIN     DEPENR
045400070925     C                   IF        %FOUND(DEPNDC)
045500070925     C                   EXSR      $DEPEND
045600070925     C                   ENDIF
045700090313     C                   End
045800070227      *
045900070227     C                   Endsr
046000070925   S***S
046100070925     C     $DEPEND       BEGSR
046200070925      *
046300070925     C     MCSSNO        Setll     DEPENR
046400070925     C                   DOU       %Eof(DEPNDC)
046500070925     C     MCSSNO        Reade     DEPENR
046600070925     C                   IF        NOT %EOF(DEPNDC)
046700070925      *
046800070925     C     DepKey        CHAIN     DCOVR
046900070925     C                   IF        %FOUND(DCOV22)
047000070925      *
047100090313     C                   Exsr      PrepRecordD
047200070925     C                   EXSR      $DCOV
047300070925      *
047400070925     C                   ENDIF
047500070925      *
047600070925     C                   ENDIF
047700070925     C                   Enddo
047800070925      *
047900070925     C                   ENDSR
048000070925   S***S
048100070925     C     $DCOV         BEGSR
048200070925      *
048300070925     C     DepKey        SETGT     DCOVR
048400070925     C                   DOU       %Eof(DCOV22)
048500070925     C     DepKey        READPE    DCOVR
048600070925     C                   IF        NOT %Eof(DCOV22) AND DENRDT <> CCANDT
048700070925      *
048800070925     C                   IF        CCANDT = 0
048900070925     C                   EVAL      CCANDT = 99999999
049000070925     C                   ENDIF
049100070925      *
049200090313     C                   Exsr      BuildDepRec
049300070925     C                   LEAVESR
049400070925      *
049500070925     C                   ENDIF
049600070925     C                   ENDDO
049700070925      *
049800070925     C                   ENDSR
049900070227      *________________________________________________________________
050000070227     C     BuildDepRec   Begsr
050100070227      *________________________________________________________________
050200070227      *
050300070924     C                   IF        CCANDT <> 99999999
050400070924     C     CNLDEP        CHAIN     METLIFR
050500070924     C                   IF        %FOUND(METLIFTRM)
050600070924     C                   LEAVESR
050700070924     C                   ELSE
050800070924     C                   CLEAR                   METLIFR
050900070924     C                   EVAL      NTSSNO = SSNO
051000070925     C                   EVAL      NTDEPNO = DSEQ#
051100070924     C                   EVAL      NTTERMDT = CCANDT
051200070924     C                   EVAL      NTPLAN = DVPLAN
051300070924     C                   EVAL      NTCOVTP  = MCOVTP
051400070924     C                   EVAL      NTTRST   = MCTRST
051500070924     C                   EVAL      NTSUB#   = MCSUB#
051600070924     C                   EVAL      NTACCT   = ACC#
051700070924     C                   WRITE     METLIFR
051800070924     C                   ENDIF
051900070924     C                   ENDIF
052000070924      *
052100070227     C                   Eval      PTRANCD   =   'D'
052200070227     C                   Movel     '00'          PEMPSSN
052300070227     C                   Move      MCSSNO        PEMPSSN
052400070228     C                   Move      DEPSS#        PMEMSSN
052500070227     C                   Eval      PMEMLNA   =   DLNAME                         Member Last Name
052600070227     C                   Eval      PMEMFNA   =   DFNAME                         Member First Name
052700070227     C                   Eval      PMEMMID   =   DMI                            Member First Name
052800070228     C                   Eval      PMEMSEX   =   DSEX                           Member Gender
052900070227     C                   If        DSEX       <>  'M'    And
053000070227     C                             DSEX       <>  'F'
053100070228     C                   Eval      PMEMSEX   =   'U'                            Unknown
053200070227     C                   End
053300070227     C                   If        DRELCD    <>  'RHU'   And
053400070227     C                             DRELCD    <>  'RWI'
053500070228     C                   Eval      PMEMMST   =   'S'
053600070227     C                   Else
053700070228     C                   Eval      PMEMMST   =   'M'
053800070227     C                   End
053900070227     C     DBIRTH        Mult      10000.0001    DOB               8 0
054000070228     C                   Movel     DOB           PMEMBDT
054100070228     C                   Eval      PCOVTYP   =   'D '
054200071106      *--
054300070925     C                   Movel     DENRDT        PCOVBDT
054400080117     C                   Movel     DENRDT        PCOVBDTN
054500071106     C****** DEPENDENT OVERRIDE
054600071106     C                   IF        DENRDT < ENRLDT
054700071106     C                   MOVE      ENRLDT        PCOVBDT
054800080117     C                   MOVE      ENRLDT        PCOVBDTN
054900071106     C                   ENDIF
055000071106     C****** DEPENDENT OVERRIDE
055100071106      *--
055200070925     C                   IF        CCANDT = 99999999 OR CCANDT = 0
055300070925     C                   MOVE      '00000000'    PCOVEDT
055400070925     C                   ELSE
055500070925     C                   Movel     CCANDT        PCOVEDT
055600070925     C                   ENDIF
055700070227      *--
055800070227     C                   Eval      PEMPPIN   =   *Blanks
055900070227     C                   Eval      PSURIND   =   *Blanks
056000070227     C                   Eval      PSURSSN   =   *Blanks
056100070227     C                   Eval      PSURLNA   =   *Blanks
056200070227     C                   Eval      PSURFNA   =   *Blanks
056300070227     C                   Eval      PFADDIN   =   'D'
056400110808     C                   Exsr      GetGrp
056500110808     C                   Eval      PSUBDIV   =   GroupSubDiv
056600120216     C                   Eval      PBRANCH   =   GroupBranch
056700090313     C                   Eval      PGROUP#   =   PCUSTNO
056800070228     C                   Eval      PPLANCD   =   *Blanks
056900070227     C                   If        CEXPDT    <>  *Zeros
057000070228     C                   Eval      PCOBRAI   =   'CE'
057100090527     C                   Move      CEXPDT        PCOVEDT
057200070227     C                   End
057300070227      *---
057400070227     C                   Select
057500070228     C                   When      CEXPDT   <>   *Zeros
057600070313     C                   When      CEXPDT    =   *Zeros
057700100226     C                   EndSl
057800070227     C                   Select
057900070227     C                   When      EMPST     =   'J'
058000070228     C                   Eval      PSTATCD   =   'R'
058100070227     C                   When      HDCPDT    <>  *Zero
058200070228     C                   Eval      PSTATCD   =   'D'
058300070227     C                   Other
058400070228     C                   Eval      PSTATCD   =   'A'
058500070227     C                   EndSl
058600021007      *
058700070227     C                   Select
058800070227     C                   When      DRELCD    =   'RHU'  Or
058900070227     C                             DRELCD    =   'RWI'
059000070228     C                   Movel     '01'          PRELACD
059100070227     C                   When      DRELCD    =   'RSO'  Or
059200090921     C                             DRELCD    =   'RDA'  Or
059300090921     C                             DRELCD    =   'RA '  Or
059400090921     C                             DRELCD    =   'RB '
059500070228     C                   Movel     '02'          PRELACD
059600130625     C                   When      DRELCD    =   'RPA'
059700130625     C                   Movel     '03'          PRELACD
059800070227     C                   EndSl
059900041220     C                   Select
060000070228     C                   When      MCOVTP    =   'TPC'  Or
060100070228     C                             MCOVTP    =   'TP2'
060200070228     C                   Eval      PMEMCCD   =   '2'
060300070228     C                   When      MCOVTP    =   'THW'
060400070228     C                   Eval      PMEMCCD   =   '3'
060500070228     C                   When      MCOVTP    =   'TFA'
060600070228     C                   Eval      PMEMCCD   =   '4'
060700041220     C                   Endsl
060800070925      *
060900090313     C                   Exsr      WriteRec
061000021007      *
061100021007     C                   Endsr
061200090225      *___________________________________________________________________
061300090225      *
061400090225      * Fill DENTAL Block of Record Format
061500090225      *___________________________________________________________________
061600090225     C     DentalSr      BEGSR
061700090225     C                   Eval      PCOVTYP   =   'D '
061800090225     C                   Move      ENRLDT        PCOVBDT
061900090225     C                   Move      ENRLDT        PCOVBDTN          8 0
062000090225     C****** COBRA OVERRIDE
062100090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
062200090225     C                   MOVE      GBSCDT        PCOVBDT
062300090225     C                   Move      GBSCDT        PCOVBDTN
062400090225     C                   ENDIF
062500090225     C****** COBRA OVERRIDE
062600090225      *--
062700090225     C                   IF        CANDT = 99999999 OR CANDT = 0
062800090225     C                   MOVE      '00000000'    PCOVEDT
062900090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
063000090225     C                   ELSE
063100090225     C                   Move      CANDT         PCOVEDT
063200090225     C                   MOVE      CANDT         PCOVEDTN
063300090225     C                   ENDIF
063400090225     C                   Exsr      GetGrp
063500090527     C                   Eval      PGROUP#   =   PCUSTNO
063600110808     C                   Eval      PSUBDIV   =   GroupSubDiv
063700120216     C                   Eval      PBRANCH   =   GroupBranch
063800090227     C                   Select
063900090227     C                   When      CEXPDT   <>   *Zeros
064000090225     C                   When      CEXPDT    =   *Zeros
064100100226     C                   EndSl
064200090225     C                   Eval      PPLANCD   =   *Blanks
064300090225     C                   If        CEXPDT    <>  *Zeros
064400090225     C                   Eval      PCOBRAI   =   'CE'
064500090527     C                   Move      CEXPDT        PCOVEDT
064600090225     C                   End
064700090227     C                   Select
064800090225     C                   When      EMPST     =   'J'
064900090225     C                   Eval      PSTATCD   =   'R'
065000090225     C                   When      HDCPDT    <>  *Zero
065100090225     C                   Eval      PSTATCD   =   'D'
065200090225     C                   Other
065300090225     C                   Eval      PSTATCD   =   'A'
065400090225     C                   EndSl
065500090225      *
065600090225     C                   Select
065700090225     C                   When      MCOVTP    =   'TIN'
065800090225     C                   Eval      PMEMCCD   =   '1'
065900090225     C                   When      MCOVTP    =   'TPC'  Or
066000090225     C                             MCOVTP    =   'TP2'
066100090225     C                   Eval      PMEMCCD   =   '2'
066200090225     C                   When      MCOVTP    =   'THW'
066300090225     C                   Eval      PMEMCCD   =   '3'
066400090225     C                   When      MCOVTP    =   'TFA'
066500090225     C                   Eval      PMEMCCD   =   '4'
066600090225     C                   Endsl
066700090227     C                   Eval      PDEPCLS   =   *Blanks
066800090225      *
066900090312     C                   Exsr      WriteRec
067000090225     C                   Endsr
067100090225      *___________________________________________________________________
067200090225      *
067300090225      * Fill LIFE Block of Record Format
067400090225      *___________________________________________________________________
067500090225     C     LifeSr        BEGSR
067600090227     C                   Eval      PTYPCO2   =   'CP'
067700090304     C                   Move      ENRLDT        PCOSTD2
067800090225     C                   Move      ENRLDT        PCOVBDTN          8 0
067900090225     C****** COBRA OVERRIDE
068000090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
068100090304     C                   MOVE      GBSCDT        PCOSTD2
068200090225     C                   Move      GBSCDT        PCOVBDTN
068300090225     C                   ENDIF
068400090225     C****** COBRA OVERRIDE
068500090225      *--
068600090225     C                   IF        CANDT = 99999999 OR CANDT = 0
068700090304     C                   MOVE      '00000000'    PCOEND2
068800090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
068900090225     C                   ELSE
069000090304     C                   Move      CANDT         PCOEND2
069100090225     C                   MOVE      CANDT         PCOVEDTN
069200090225     C                   ENDIF
069300090225     C                   Exsr      GetGrp
069400090227     C                   Eval      PPLANC2   =   *Blanks
069500090225     C                   If        CEXPDT    <>  *Zeros
069600090227     C                   Eval      PCOBRA2   =   'CE'
069700090527     C                   Move      CEXPDT        PCOEND2
069800090225     C                   End
069900090227     C                   Select
070000090225     C                   When      EMPST     =   'J'
070100090227     C                   Eval      PSTATC2   =   'R'
070200090225     C                   When      HDCPDT    <>  *Zero
070300090227     C                   Eval      PSTATC2   =   'D'
070400090225     C                   Other
070500090227     C                   Eval      PSTATC2   =   'A'
070600090225     C                   EndSl
070700090225      *
070800090225     C                   Select
070900090225     C                   When      MCOVTP    =   'TIN'
071000090227     C                   Eval      PMEMCC2   =   '1'
071100090225     C                   When      MCOVTP    =   'TPC'  Or
071200090225     C                             MCOVTP    =   'TP2'
071300090227     C                   Eval      PMEMCC2   =   '2'
071400090225     C                   When      MCOVTP    =   'THW'
071500090227     C                   Eval      PMEMCC2   =   '3'
071600090225     C                   When      MCOVTP    =   'TFA'
071700090227     C                   Eval      PMEMCC2   =   '4'
071800090225     C                   Endsl
071900090227     C                   Eval      PDEPCL2   =   *Blanks
072000090304     C                   Move      BENAMT        PINSAM2
072100090320     C                   Movel     '0'           PINSAM2
072200090225      *
072300090312     C                   Movel     'A'           PSAMOD2
072400090312     C                   Move      SALARY        PSALAR2
072500090312     C                   Exsr      WriteRec
072600090225     C                   Endsr
072700090225      *___________________________________________________________________
072800090225      *
072900090225      * Fill AD&D Block of Record Format
073000090225      *___________________________________________________________________
073100090225     C     AD_DSr        BEGSR
073200090227     C                   Eval      PTYPCO3   =   'AD'
073300090304     C                   Move      ENRLDT        PCOSTD3
073400090225     C                   Move      ENRLDT        PCOVBDTN          8 0
073500090225     C****** COBRA OVERRIDE
073600090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
073700090304     C                   MOVE      GBSCDT        PCOSTD3
073800090225     C                   Move      GBSCDT        PCOVBDTN
073900090225     C                   ENDIF
074000090225     C****** COBRA OVERRIDE
074100090225      *--
074200090225     C                   IF        CANDT = 99999999 OR CANDT = 0
074300090304     C                   MOVE      '00000000'    PCOEND3
074400090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
074500090225     C                   ELSE
074600090304     C                   Move      CANDT         PCOEND3
074700090225     C                   MOVE      CANDT         PCOVEDTN
074800090225     C                   ENDIF
074900090225     C                   Exsr      GetGrp
075000090227     C                   Eval      PPLANC3   =   *Blanks
075100090225     C                   If        CEXPDT    <>  *Zeros
075200090227     C                   Eval      PCOBRA3   =   'CE'
075300090527     C                   Move      CEXPDT        PCOEND3
075400090225     C                   End
075500090227     C                   Select
075600090225     C                   When      EMPST     =   'J'
075700090227     C                   Eval      PSTATC3   =   'R'
075800090225     C                   When      HDCPDT    <>  *Zero
075900090227     C                   Eval      PSTATC3   =   'D'
076000090225     C                   Other
076100090227     C                   Eval      PSTATC3   =   'A'
076200090225     C                   EndSl
076300090225      *
076400090225     C                   Select
076500090225     C                   When      MCOVTP    =   'TIN'
076600090227     C                   Eval      PMEMCC3   =   '1'
076700090225     C                   When      MCOVTP    =   'TPC'  Or
076800090225     C                             MCOVTP    =   'TP2'
076900090227     C                   Eval      PMEMCC3   =   '2'
077000090225     C                   When      MCOVTP    =   'THW'
077100090227     C                   Eval      PMEMCC3   =   '3'
077200090225     C                   When      MCOVTP    =   'TFA'
077300090227     C                   Eval      PMEMCC3   =   '4'
077400090225     C                   Endsl
077500090227     C                   Eval      PDEPCL3   =   *Blanks
077600090304     C                   Move      BENAMT        PINSAM3
077700090320     C                   Movel     '0'           PINSAM3
077800090225      *
077900090312     C                   Movel     'A'           PSAMOD3
078000090312     C                   Move      SALARY        PSALAR3
078100090312     C                   Exsr      WriteRec
078200090225     C                   Endsr
078300090225      *___________________________________________________________________
078400090225      *
078500090225      * Fill LTD Block of Record Format
078600090225      *___________________________________________________________________
078700090225     C     LTDSr         BEGSR
078800090312     C                   Eval      PTYPCO5   =   'LT'
078900090313     C                   Move      ENRLDT        PCOSTD5
079000090225     C                   Move      ENRLDT        PCOVBDTN          8 0
079100090225     C****** COBRA OVERRIDE
079200090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
079300090312     C                   MOVE      GBSCDT        PCOSTD5
079400090225     C                   Move      GBSCDT        PCOVBDTN
079500090225     C                   ENDIF
079600090225     C****** COBRA OVERRIDE
079700090225      *--
079800090225     C                   IF        CANDT = 99999999 OR CANDT = 0
079900090312     C                   MOVE      '00000000'    PCOEND5
080000090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
080100090225     C                   ELSE
080200090312     C                   Move      CANDT         PCOEND5
080300090225     C                   MOVE      CANDT         PCOVEDTN
080400090225     C                   ENDIF
080500090225     C                   Exsr      GetGrp
080600090312     C                   Eval      PPLANC5   =   *Blanks
080700090225     C                   If        CEXPDT    <>  *Zeros
080800090312     C                   Eval      PCOBRA5   =   'CE'
080900090527     C                   Move      CEXPDT        PCOEND5
081000090225     C                   End
081100090227     C                   Select
081200090225     C                   When      EMPST     =   'J'
081300090312     C                   Eval      PSTATC5   =   'R'
081400090225     C                   When      HDCPDT    <>  *Zero
081500090312     C                   Eval      PSTATC5   =   'D'
081600090225     C                   Other
081700090312     C                   Eval      PSTATC5   =   'A'
081800090225     C                   EndSl
081900090225      *
082000090225     C                   Select
082100090225     C                   When      MCOVTP    =   'TIN'
082200090312     C                   Eval      PMEMCC5   =   '1'
082300090225     C                   When      MCOVTP    =   'TPC'  Or
082400090225     C                             MCOVTP    =   'TP2'
082500090312     C                   Eval      PMEMCC5   =   '2'
082600090225     C                   When      MCOVTP    =   'THW'
082700090312     C                   Eval      PMEMCC5   =   '3'
082800090225     C                   When      MCOVTP    =   'TFA'
082900090312     C                   Eval      PMEMCC5   =   '4'
083000090225     C                   Endsl
083100090312     C                   Eval      PDEPCL5   =   *Blanks
083200090313     C                   Move      BENAMT        PINSAM5
083300090320     C                   Movel     '0'           PINSAM5
083400090225      *
083500090312     C                   Movel     'A'           PMOSAL5
083600090312     C                   Move      SALARY        PSALAM5
083700090312     C                   Exsr      WriteRec
083800090225     C                   Endsr
083900090225      *___________________________________________________________________
084000090225      *
084100090225      * Fill STD Block of Record Format
084200090225      *___________________________________________________________________
084300090225     C     STDSr         BEGSR
084400090312     C                   Eval      PTYPCO4   =   'AS'
084500090312     C                   Move      ENRLDT        PCOSTD4
084600090225     C                   Move      ENRLDT        PCOVBDTN          8 0
084700090225     C****** COBRA OVERRIDE
084800090225     C                   IF        EMPST = 'C' AND GBSCDT > ENRLDT
084900090312     C                   MOVE      GBSCDT        PCOSTD4
085000090225     C                   Move      GBSCDT        PCOVBDTN
085100090225     C                   ENDIF
085200090225     C****** COBRA OVERRIDE
085300090225      *--
085400090225     C                   IF        CANDT = 99999999 OR CANDT = 0
085500090312     C                   MOVE      '00000000'    PCOEND4
085600090225     C                   MOVE      '00000000'    PCOVEDTN          8 0
085700090225     C                   ELSE
085800090312     C                   Move      CANDT         PCOEND4
085900090225     C                   MOVE      CANDT         PCOVEDTN
086000090225     C                   ENDIF
086100090225     C                   Exsr      GetGrp
086200090312     C                   Eval      PPLANC4   =   *Blanks
086300090225     C                   If        CEXPDT    <>  *Zeros
086400090312     C                   Eval      PCOBRA4   =   'CE'
086500090527     C                   Move      CEXPDT        PCOEND4
086600090225     C                   End
086700090227     C                   Select
086800090225     C                   When      EMPST     =   'J'
086900090312     C                   Eval      PSTATC4   =   'R'
087000090225     C                   When      HDCPDT    <>  *Zero
087100090312     C                   Eval      PSTATC4   =   'D'
087200090225     C                   Other
087300090312     C                   Eval      PSTATC4   =   'A'
087400090225     C                   EndSl
087500090225      *
087600090225     C                   Select
087700090225     C                   When      MCOVTP    =   'TIN'
087800090312     C                   Eval      PMEMCC4   =   '1'
087900090227     C                   When      MCOVTP    =   'TPC'  Or
088000090225     C                             MCOVTP    =   'TP2'
088100090312     C                   Eval      PMEMCC4   =   '2'
088200090225     C                   When      MCOVTP    =   'THW'
088300090312     C                   Eval      PMEMCC4   =   '3'
088400090225     C                   When      MCOVTP    =   'TFA'
088500090312     C                   Eval      PMEMCC4   =   '4'
088600090225     C                   Endsl
088700090312     C                   Eval      PDEPCL4   =   *Blanks
088800090312     C                   Move      BENAMT        PINSAM4
088900090320     C                   Movel     '0'           PINSAM4
089000090225      *
089100090312     C                   Movel     'A'           PMOSAL4
089200090312     C                   Move      SALARY        PSALAM4
089300090312     C                   Exsr      WriteRec
089400090225     C                   Endsr
089500080117      *___________________________________________________________________
089600080117      * Retrieve the group number from the GRATE file.
089700080117      *___________________________________________________________________
089800080117     C     Getgrp        BEGSR
089900080117      *
090000080117     c     RatKey        Setll     GRATE
090100080903     c     RatKey        Reade     GRATE
090200080903     c                   Dow       not %eof(GRATE)
090300080117     C                   If        (PCOVBDTN >=  FRMDAT) and
090400110818     C                             (PCOVEDTN <=  TODAT)
090500110818      **** TEST ****
090600110818     C                                                   Or
090700110818      * Member's coverage is Active
090800110818     C                             (PCOVEDTN  =  *Zeros  Or
090900110818     C                              PCOVEDTN >=  Today)  And
091000110818      * Rate may begin after member's coverage but is still active.
091100110818     C                             (Today    <=  TODAT)
091200110818      **** TEST ****
091300090312     C                   Exsr      FmtGrp
091400080117     C                   End
091500080903     c     RatKey        Reade     GRATE
091600080117     C                   EndDo
091700090312      *When coverage is termed, there may be no current rate; still need grp
091800110808     C                   If        PCUSTNO    =  *Blanks
091900090312     C                   Exsr      FmtGrp
092000090312     C                   End
092100080117      *
092200080117     C                   Endsr
092300090312      *___________________________________________________________________
092400090312      * Format the group number.
092500090312      *___________________________________________________________________
092600090312     C     Fmtgrp        BEGSR
092700110808      *---
092800110808      *  The 1st 7 digits of group# are moved into group, next 4 subd, next 4 branch
092900110808      *---
093000110808     C                   Clear                   GroupFmt
093100110808     C                   Eval      GroupFmt   =  GROUP#
093200110815     C                   Select
093300110815     C                   When       PLNCAT    =   Dental  Or
093400110815     C                              PLNCAT    =   DentalDC  Or
093500110815     C                              ACTION    =   'D'
093600110815     C                   Eval      PCUSTNO    =  GroupGroup
093700110808     C                   Eval      PSUBDIV    =  GroupSubDiv
093800110808     C                   Eval      PBRANCH    =  GroupBranch
093900110815      *
094000110815     C                   When      PLNCAT     =  Life
094100110818     C                   Eval      PCUSTNO    =  GroupGroup
094200110815     C                   Eval      PGROUP2    =  GroupGroup
094300110815     C                   Eval      PSUBDI2    =  GroupSubDiv
094400110815     C                   Eval      PBRANC2    =  GroupBranch
094500110815      *
094600110815     C                   When      PLNCAT    =   AD_D
094700110818     C                   Eval      PCUSTNO    =  GroupGroup
094800110815     C                   Eval      PGROUP3    =  GroupGroup
094900110815     C                   Eval      PSUBDI3    =  GroupSubDiv
095000110815     C                   Eval      PBRANC3    =  GroupBranch
095100110815      *
095200110815     C                   When      PLNCAT    =   LTD
095300110818     C                   Eval      PCUSTNO    =  GroupGroup
095400110815     C                   Eval      PGROUP5    =  GroupGroup
095500110815     C                   Eval      PSUBDI5    =  GroupSubDiv
095600110815     C                   Eval      PBRANC5    =  GroupBranch
095700110815      *
095800110815     C                   When      PLNCAT    =   STD
095900110818     C                   Eval      PCUSTNO    =  GroupGroup
096000110815     C                   Eval      PGROUP4    =  GroupGroup
096100110815     C                   Eval      PSUBDI4    =  GroupSubDiv
096200110815     C                   Eval      PBRANC4    =  GroupBranch
096300110815     C                   EndSl
096400110329      *
096500140616     C                   Endsr
096600090312      *___________________________________________________________________
096700090313      * Prepare Dependent Record for Update
096800090312      *___________________________________________________________________
096900090313     C     PrepRecordD   BEGSR
097000090312      *
097100090312     C                   Move      MCSSNO        Kssno            11
097200090312     C                   Movel     '00'          Kssno
097300090313     C                   Move      DEPSS#        Mssno             9
097400140616     C     PKey          chain     METLIFEWL
097500140616     C                   If        Not %found(METLIFEWL)
097600090313     C                   Clear                   PROEXPR
097700090313     C                   Clear                   PROUPDR
097800090313     C                   Eval      Data = 'A'
097900090313     C                   Else
098000090901     C                   If        DFNAME   =    PMEMFNA     And
098100090901     C                             DMI      =    PMEMMID
098200160226     C****               Eval      Data = 'U'
098300090901     C                   Else
098400090901     C                   Clear                   PROEXPR
098500090901     C                   Clear                   PROUPDR
098600090901     C                   Eval      Data = 'A'
098700090312     C                   End
098800090901     C                   End
098900090313      *
099000140616     C                   Endsr
099100090313      *___________________________________________________________________
099200090313      * Prepare Record for Update
099300090313      *___________________________________________________________________
099400090313     C     PrepRecord    BEGSR
099500090313      *
099600090313     C                   Move      MCSSNO        Kssno            11
099700090313     C                   Movel     '00'          Kssno
099800090313     C                   Move      MCSSNO        Mssno             9
099900140616     C     PKey          chain     METLIFEWL
100000140616     C                   If        Not %found(METLIFEWL)
100100090313     C                   Clear                   PROEXPR
100200090313     C                   Clear                   PROUPDR
100300090313     C                   Eval      Data = 'A'
100400090313     C                   Else
100500160226     C****               Eval      Data = 'U'
100600090313     C                   End
100700090313      *
100800140616     C                   Endsr
100900090313      *___________________________________________________________________
101000090313      * Write or update a record
101100090313      *___________________________________________________________________
101200090313     C     WriteRec      BEGSR
101300090313      *
101400090313     C                   Select
101500090313     C                   When      Data = 'A'
101600090313     C                   Write     PROEXPR
101700160226     C****               When      Data = 'U'
101800160226     C****               Update    PROUPDR
101900090313     C                   Endsl
102000090313      *
102100090313     C                   Clear                   Data
102200090313     C                   Clear                   PROEXPR
102300090313     C                   Clear                   PROUPDR
102400090313      *
102500140616     C                   Endsr
102600140616      *___________________________________________________________________
102700140616      * Key lists
102800140616      *___________________________________________________________________
102900140616     C     Klist         Begsr                                                  KEY LISTS
103000100421      *
103100100421     C     CodKey        Klist
103200100421     C                   Kfld                    Typ
103300100421     C                   Kfld                    Cod
103400070924      *
103500070227     C     PlnKey        Klist
103600070227     C                   Kfld                    PLTRST
103700070227     C                   Kfld                    PLSUB#
103800070227     C                   Kfld                    PLPLAN
103900070924      *
104000070924     C     CNLMBR        Klist
104100070924     C                   Kfld                    MCSSNO
104200070924     C                   Kfld                    MDSEQ#
104300070924     C                   Kfld                    CANDT
104400070924     C                   Kfld                    MCPLAN
104500070924     C                   Kfld                    MCOVTP
104600070924     C                   Kfld                    MCTRST
104700070924     C                   Kfld                    MCSUB#
104800070924     C                   Kfld                    ACC#
104900070227      *
105000070227     C     DepKey        Klist
105100070227     C                   Kfld                    MCTRST
105200070227     C                   Kfld                    MCSUB#
105300070227     C                   Kfld                    MCPLAN
105400070227     C                   Kfld                    DSSNO
105500070227     C                   Kfld                    DPSEQ#
105600070227      *
105700070924     C     CNLDEP        Klist
105800070924     C                   Kfld                    SSNO
105900070924     C                   Kfld                    DSEQ#
106000070924     C                   Kfld                    CCANDT
106100070924     C                   Kfld                    DVPLAN
106200070924     C                   Kfld                    MCOVTP
106300070924     C                   Kfld                    MCTRST
106400070924     C                   Kfld                    MCSUB#
106500070924     C                   Kfld                    ACC#
106600070924      *
106700080117     C     RATKEY        KLIST
106800080117     C                   KFLD                    MCTRST
106900080117     C                   KFLD                    MCSUB#
107000080117     C                   KFLD                    MCPLAN
107100080117     C                   KFLD                    MCAGEB
107200080117     C                   KFLD                    MCOVTP
107300080117      *
107400090312     C     PKey          Klist
107500090312     C                   Kfld                    Kssno
107600090312     C                   Kfld                    Mssno
107700140616     C                   Endsr
107800020726      *________________________________________________________________
107900020726      * Initialization
108000020726      *________________________________________________________________
108100140616     C     *INZSR        Begsr
108200070924      *
108300140616     C                   EVAL      #ISO = %DATE
108400140616     C                   MOVE      #ISO          TODAY             8 0
108500041220     C                   Eval      FILLER1    =  *Blanks
108600041220     C                   Eval      FILLER2    =  *Blanks
108700070227      *
108800140616     C                   Endsr
