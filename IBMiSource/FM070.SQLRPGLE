000100140314    *H OPTION(*NODEBUGIO) DFTACTGRP(*NO) ACTGRP(*CALLER)
000200140611    *H BNDDIR('GBSBDIR') ALWNULL(*USRCTL)
000300141110     Hbnddir('ALLSRVPGMN')
000400110913     F* J.Allen:       Added BNDDIR in H-Spec for use with subprocedures
000500110913     F* 09/02/2011     required by payroll programs. (still compile 14)
000600110913     F*                You must have a RPGSP**** Library on your LIBL.
000700220111     F*                Examples: GBSPGMT RPGSPBETA
000800220111     F*                          GBSPGM  GBSMOD RPGSPDASH
0009009901270002 F******************************************************************
0010000004140003 F* FM070      GROUP BENEFIT SERVICES SOFTWARE           1988      *
0011009102150004 F*                                                                *
0012009102150005 F*            WRITTEN BY - MICHAEL C. DUNPHY                      *
0013009102150006 F*            DATE - 12/27/88                                     *
0014009102150010 F*                                                                *
0015001911260011 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW ENTRY OF MEMBERS,       *
0016009102150014 F*                                                                *
0017009102150015 F*  REVISION DESCRIPTION: CREATE NEW FILE "TRNMIT".               *
0018009102150016 F*  FOR CARRIERS DEEMED "TRANSMITTABLE",(FILE:CARMST FIELD:       *
0019009102150017 F*  TXMTYN = Y) RECORDS WILL BE CREATED FOR FOLLOWING             *
0020009102150018 F*  TRANSACTIONS:                                                 *
0021009102150019 F*                                                                *
0022009102150020 F*       ACTION CODE           DESCRIPTION                        *
0023009102150021 F*       -----------           -----------                        *
0024009102150023 F*           MA        MEMBER COVERAGE: ADDITION                  *
0025009102150024 F*           ME        MEMBER COVERAGE: ENROLLMENT DATE CHANGE    *
0026009102150025 F*           MC        MEMBER COVERAGE: COVERAGE TYPE CHANGE      *
0027009102150026 F*           MB        MEMBER COVERAGE: BENEFIT AMOUNT CHANGE     *
0028009102150027 F*           MT        MEMBER COVERAGE: TERMINATION               *
0029009102150028 F*           MR        MEMBER COVERAGE: REINSTATEMENT             *
0030009102150029 F*           MD        MEMBER DEMOGRAPHIC CHANGE                  *
0031009102150030 F*           DA        DEPENDENT COVERAGE: ADDITION               *
0032009102150031 F*           DC        DEPENDENT COVERAGE: ENROLLMENT DATE CHANGE *
0033009102150032 F*           DT        DEPENDENT COVERAGE: TERMINATION            *
0034009102150033 F*           DR        DEPENDENT COVERAGE: REINSTATEMENT          *
0035009102150034 F*           DD        DEPENDENT DEMOGRAPHIC CHANGE               *
0036009102150035 F*                                                                *
0037009710100020 F*  10/97  - ADD SCREENS 78 & 79 FOR PCP AND COB ENTRY (FOR PHN   *
0038009710070020 F*           CARRIER CODE ONLY)                                   *
0039009102150042 F*                                                                *
004000981125      *       11/09/98 GSP  The following changes are a result of Y2K update.
004100981125      *                     Changed PLAN fields from numberic to alphanumeric.
004200981125      *                     Changed ADJUST recl from 128 to 160 bytes.
004300981125      *                     Changed ACCMST recl from 512 to 560 bytes.
004400981125      *                     Changed DEPEND recl from 320 to 360 bytes.
004500981125      *                     Changed DCOV recl from 48 to 64 bytes.
004600981125      *                     Changed GRATE recl from 64 to 80 bytes.
004700981125      *                     Changed HIST recl from 128 to 160 bytes.
004800981125      *                     Changed MCOV recl from 64 to 88 bytes.
004900981125      *                     Changed MEMBER recl from 512 to 648 bytes.
005000981125      *                     Changed PLNMST recl from 192 to 200 bytes.
005100981125      *                     Changed TRSMST recl from 256 to 264 bytes.
005200981125      *                     Changed TRSMIT recl from 1168 to 1384 bytes.
005300990129     F*
0054009911100020 F*     1/99 DLK - FIX Y2K CHANGES                                 *
005500990701     F*   DMA  7.1.99  -  Changed plan line array from 50 to 99
0056009911100020 F* 11/09/99 DLK - ADD EDIT TO PREVENT CHANGE ENROLLMENT DATE      *
005700991110     F*                OF CANCELLED MCOV. THIS WAS NEEDED TO MAKE
005800991110     F*                "MCE" WORK PROPERLY WITH NEW PRO-RATION
005900000218     F*                RULES.
006000000218     F*   DMA 2.10.00  -  No changes to COBRA members unless done by
006100000218     F*                   specific user hard coded in OCL
0062000003230020 F* 03/23/00 DLK - FIX MCOV RECORD LOCK AT 2561.01                 *
006300000424     F*  DMA  04.24.00 Removed dependent phone# edit per Wendy
006400991110     F*
006500000621     F* 06/21/00 KSJ - INCLUDE PCP ENTRY FOR PHN AND MAM
006600000818     F* 08/18/00 KSJ - INCLUDE PCP ENTRY FOR JD
006700000821     F* 08.18.00 DMA - Eliminate Zip = zeros edit  (due to Canada)
006800000828     F* 08/23/00 KSJ - INCLUDE PCP ENTRY FOR JD
006900000913     F* 09/13/00 DLK - CORRECT DEP SEQ# IN HIST POS 90
007000001013     F* 10/02/00 JVA - CORRECT INVALID DECIMAL DATA BEING WRITTEN OUT.
007100001017     F* 10/17/00 SZZ - Add proration description to MCOV for each line/plan.
007200001117     F* 11/16/00 KSJ - Added an additional one byte field to PCP screen
007300001117     F*                (PCRPAT - Current Patient)
007400001129     F* 11/29/00 DLK - FIX RECORD LOCK AFTER ERROR MSG
007500010215     F*                                                                *
007600010215     F* JVA 2.14.01 CREATE ADJUSTMENT THROUGH DATA QUEUE.              *
007700010426     F* DMA 4.26.01 hard code for trust 403 (CHE)- couldn't be helped!
007800010510     F* SZZ 5.9.01  PTF for benefit amount:  Remove last two zeros if  *
007900010510     F*             there's a declining life record or a corresponding *
008000010510     F*             age band range in the plan master file.            *
008100010817     F* 08/15/01 DLK - Fix benefit amount calc
008200010817     F* 08/17/01 DLK - remove DQ
008300010823      *                Skip call to TR261 on non adjustable            *
008400010823      *                transactions                                    *
008500010824     F* 08/24/01 DLK - add edit to prohibit termination of a cancelled *
008600011101     F*                DCOV record with the same cancel date.          *
008700011012     F* 10/12/01 DLK - allow maintenance to cobra member in cancelled  *
008800011012     F*                account but do not allow reinstate of cobra     *
008900011012     F*                member in cancelled account since that would    *
009000011012     F*                blank out cobra info. The reinstate will have   *
009100011012     F*                to be done with the special COBRA reinstate pgm *
009200011101     F* 11/01/01 DLK - Fix dec data error. Fix another dec data error  *
009300011101     F*                on the depend pcp screen - do not display pcp   *
009400011101     F*                for dep if dcov screen was blank.               *
009500011105     F* 11/02/01 KSJ - Added code to write "MDD" (Delete Dependent     *
009600011105     F*                Coverage) in HIST when member coverage is       *
009700011105     F*                cancelled with MDC when needed.                 *
009800011112     F* 11/12/01 DLK - add declife check when bday change and pabfl=N  *
009900020419     F* 12/06/01 KSJ - INCLUDE PCP ENTRY FOR CDC
010000011105     F*                                                                *
010100020204     F* 02/04/02 JVA - Allow demographic changes in Inquiry Mode.      *
010200020204     F*                                                                *
010300020307     F*  3/07/02 SZZ - Do not send dependent-over-18 warning for a     *
010400020307     F*                domestic partner.                               *
010500020315     F* 03/15/02 DLK - fix 2 fields in trnmit                          *
010600020520     F* 05/20/02 KSJ - Added TCARR & TKEY fields to keep track of      *
010700020520     F*                carried code of plan just termed.  Will be      *
010800191107     F*                used to allow user to manually term PCP.        *
010900020520     F*                Added Consumer Dental Carrier Codes             *
011000020520     F*                (CDC, CDE, CDA, CCD) that required PCP info     *
011100020520     F*                to be entered.  Modified PGM to bypass PCP      *
011200020520     F*                subroutine (#PCP) and call PCP file maintenance *
011300020520     F*                program (FM330).  Modified to cancel PCP when   *
011400020520     F*                member and/or dependent is termed.  PCPL1       *
011500020520     F*                added to be used when terming member PCP's.     *
011600020520     F*                Depkey used to find and term dependent PCP's.   *
011700020724     F* 07/24/02 DLK - fix dec life calc on add mcov                   *
011800021018     F* 10/17/02 KSJ - Added Effective Date (DSEFFD) and School        *
011900021017     F*                Name (DSSCHL) to dependent data screen (IO04)   *
012000021018     F*                in FM070FM.  Both fields must be entered or     *
012100021018     F*                left blank.  These two fields are stored in     *
012200021017     F*                first 35 positions of FILL37 in DEPEND.         *
012300021017     F*                Removed hard coded carrier that require a PCP.  *
012400021017     F*                Instead, if PCP_REQ field in PLNMST is "Y",     *
012500021017     F*                #PCP subroutine is executed.                    *
012600021017     F*                Replace TCARR with TPCPR to accommodate the     *
012700021017     F*                removal of hard coded carriers.                 *
012800030117     F* 01/17/03 DLK - fix record lock on mcovc                        *
012900030121     F* 01/21/03 DLK - fix salary change and bday change bug that      *
013000030121     F*                caused the effective date entered to be lost    *
013100030121     F*                after the first plan was changed with an effdt  *
013200030121     F*                after the effdt of the change.                  *
013300030520     F* 05/20/03 DLK - perform another grate search with today's date  *
013400030521     F*                if no rate found in member term or dep term.    *
013500030609     F* 06/09/03 KSJ - Added Term Reason Code to 'Subcriber Coverages' *
013600030609     F*                screen (IO03).  If the plan to be termed is a   *
013700030624     F*                BC carrier (ie CARBC = '1', '2', '3', '4' or    *
013800030624     F*                'D'), the Term Reason Code has to be entered    *
013900030701     F*                and validated.                                  *
014000030624     F* 06/24/03 KSJ - (In conjunction with above modification)        *
014100030624     F*                When a Term Reason Code is entered for a        *
014200030624     F*                BC Carrier (ie CARBC = '1', '2', '3', '4' or    *
014300030624     F*                'D'), the term code is written to HIST in       *
014400030701     F*                Note2 (TC=XX)                                   *
014500030922     F* 09/22/03 DLK - remove member phone # edit per Linda Biermann   *
014600040528     F* 05/28/04 DLK - On mcov reinstate, put mcov enrldt in OENRDT    *
014700040528     F*                (1368 end) in trnmit record. This is needed for *
0148000405280048 F*                coventry transmission which wants to see the    *
0149000405280048 F*                mcov effective date instead of the "as of" date *
0150000405280048 F*                which is put in ENRLDT field in trnmit (1336    *
0151000405280048 F*                end).                                           *
015200040528     F* 05/28/04 DLK - On member demographic changes, put mcov enrldt  *
015300040528     F*                in oenrdt (1368 end) in trnmit record. Coventry *
0154000405280048 F*                needs orig effdt.                               *
015500040616     F* 06/16/04 DLK - fix dcov cancel date in trnmit on dcov add...   *
015600040616     F*                should be zero.                                 *
015700040806     F* 08/16/04 DLK - fix depend cancel trnmit (was writing 1 trnmit  *
0158000408060048 F*                rec per mcov incorrectly)                       *
015900040901     F*  9/01/04 SZZ - Show Cmd8 for Special Handling Notes if that    *
016000040901     F*                flag in the account master is Y.                *
016100041012     F* 10/05/04 DLK - add cobra service field to member display and   *
0162000410120048 F*                add choice on member reinstate to not clear     *
0163000410120048 F*                cobra info.                                     *
016400041015     F* 10/15/04 DLK - prevent dup ssn                                 *
016500041202     F* 12/02/04 DLK - prevent record lock in #dterm routine           *
016600041215     F* 12/15/04 DLK - convert codes display for member reinstate and  *
0167000412150048 F*                member term to call external program in order   *
0168000412170048 F*                to fix errors.                                  *
016900050321     F* 03/21/05 JON - add pcp len(20)                                 *
017000050627     F*  6/20/05 SZZ - Add non-employee field.                         *
017100050928     F*  9/28/05 SZZ - Add ineligible LIFE & AD&D fields.              *
017200051221     F* 12/21/05 SZZ - If user enters SAME for dependent last name or  *
017300051221     F*                 dependent address, move the appropriate values *
017400051221     F*                 in from the member's record.                   *
017500060221     F*  2/21/06 SZZ - Add cost center to screen.                      *
017600060413      * 04/12/06 DLK - if no GRATE is found on a plan term or reinstate*
017700060413      *                then do a second search for the prior month to  *
017800060413      *                find the group#.                                *
017900060413      * 04/13/06 DLK - Add trnmit to "Change mcov cancel date"         *
018000060421     F*  4/21/06 szz-  Replace indicator for cost center field.        *
018100060629      * 06/29/06 DLK - clear trandt before writing demographic change  *
0182000606290048 F*                hist rec                                        *
018300060630      * 06/30/06 DLK - change f8 - plan window to call seperate pgm    *
0184000606300048 F*                and only show plans available to this account   *
018500070314      * 03/14/07 DLK - do not write trnmit when only the salary changes*
018600070525      * 05/25/07 DLK - remove hidden F13 (KM) to bypass edits on member*
0187000705250048 F*                and depend screen                               *
018800071003      * 10/03/07 DLK - clean up grate search and add check for grdltd  *
018900080108      * 01/08/08 DLK - fix bug in rate - 1 month search                *
019000081110      * 11/07/08 DLK - do not write trnmit when only cost center changes*
019100090211      * 02/04/09 DLK - add debit card screen                           *
019200090929      * 09/29/09 DLK - add code in trnmit for dcov rec that will tell  *
019300090930      *                the 834 pgm when a "DT" is a term or change     *
0194000909300048  *                cancel date. Use OLDT93 field in trnmit.        *
019500091012      * 10/08/09 DLK - create unique hist transaction codes for dcov   *
019600091012      *                change cancel date and reinstate.               *
019700091103      * 11/03/09 JVA - Fix Screen 2(SCR2) Array loading when more than *
019800091103      *                one page of plans.                              *
019900091204      * 12/04/09 DLK - add edit to prevent member term prior to other  *
020000091204      *                mcov term dates.                                *
020100100527      * 05/27/10 DLK - fix debcard delivery field                      *
020200100715      * 07/15/10 DLK - fix plan category dup check                     *
020300100929      * 09/29/10 DLK - add cobra elect form expiration date            *
020400101217      * 12/02/10 DLK - remove morbidity fields; add nonssn and email   *
020500101215      *                address. Due to time constraints these fields   *
020600101215      *                will be stored in fill66 until the next         *
020700101220      *                time member is changed. Also add variable       *
020800101221      *                benefit amount feature and fix the coverage     *
020900101221      *                type display window.                            *
021000110429     F* 03/16/11 dlk - update user, trdate and trtime on debit card update
021100110429     F* 03/25/11 dlk - pass the effective date parm to FM072
021200110506     F* 04/29/11 dlk - fix a few error messages
021300110506     F* 05/06/11 jva - Reinstate payroll deductions
021400110621     F* 06/21/11 dlk - add PA to list of codes not to consider for an
021500110621     F*                overage dependent
021600110622     F* 06/22/11 dlk - change rate search to keep looking backwards in
021700110622     F*                time until a valid rate is found for the group #
0218001107060048 F*                needed in trnmit. Also add a warning message
0219001107060048 F*                (with the ability to continue) when an add is
0220001107060048 F*                attempted without rates more than 60 days in the
0221001107060048 F*                future.
022200110719     F* 07/19/11 dlk - add depend email address
022300110726     F* 07/26/11 dlk - add warning msg for future activity w/o rates > 60
022400110726     F*                days to other coverage transactions (term, rein, chg)
022500110727     F*                and add term code display window to IO03
022600110824     F* 08/24/11 dlk - add original benefit amount to mcov to support
0227001108240048 F*                the variable benefit amount feature when dec life
0228001108240048 F*                reduces the amount chosen by the member
0229001108240048 F*                                                                *
023000110913     F* 09/02/11 jva - GBS Payroll Deductions (start,stop)
023100110913     F*                Added BNDDIR in H-Spec for use with subprocedures
023200110913     F*                required by payroll programs. (still compile 14)
023300110913     F*                You must have a RPGSP**** Library on your LIBL.
023400110914     F* 09/14/11 dlk - convert codes display for depend relation
0235001109140048 F*                to call external program in order to fix errors.
023600110916     F* 09/16/11 dlk - add additional edit for cost center. Acct uses or
0237001109160048 F*                does not use cost centers
023800111024     F* 10/23/11 jva - update payroll with (R)ehire status on reinstate
023900111025     F* 10/25/11 dlk - add edit for special characters in name & addr
024000111206     F* 12/06/11 dlk - add display of invalid special characters in the
024100111206     F*                name / address field per request from Cindy.
024200111207     F* 12/07/11 jva - auto-term payroll record on term
024300111228     F* 12/28/11 jva - no tranmit if demograph change for termed coverages
024400111228     F*                but allow future term coverages
024500120308     F* 03/07/12 dlk - add dcov cancel date to trnmit in filler field on
0246001203080048 F*                dcov reinstate - needed for dbe transmission.
024700120816     F* 08/16/12 dlk - add full month pro rate rule to text
024800120919     F* 09/19/12 dlk - fix #fillpct subroutine for plan cat dup check
024900121126     F* 11/26/12 dlk - fix io03 output end positions
025000121127     F* 11/27/12 dlk - add edit to mcov add that checks for an active
025100121127     F*                comctx. Request from admin.
025200130509     F* 05/09/13 dlk - change to calc age as of last plan renewal month
025300130509     F*                and add logic for BOR accounts. ALso remove code
025400130509     F*                for composite age banded plans since it was disco
025500130517     F*                a long time ago. Also add history records for
025600130520     F*                depend add/term/rein transactions. Also remove COB
025700130520     F*                code since it was a PHN only feature.
025800130912     F* 09/12/13 dlk - add edit - VB plan cannot have increment = 0
025900130927      * 09/27/13 dlk - hist file expansion project
026000131212     F* 12/2013 SSK - LABEL EXCEPTS AND PUT ACA LOGIC IN
026100131212     F*               GETTING SERIOUSLY LOST IN THIS THING
026200131216     F*               ADDED MESSAGE 104 FOR ACA ONLY, THAT DCOV EFF CANNOT BE <
026300140411      * 1/14-4/14 dlk - Massive changes to support ACA adjustments and other
026400140411     F*                 clean up / fix issues.
026500140314     F* 03/2014 SSK - REMOVE ACA LOGIC ASSOCIATED TO *C2V PROGRAMS
026600140611      * 06/11/14 dlk - add handicap code of 3 - permanent - total disability
026700140611     F*                to match Care First system
026800140627      * 06/27/14 dlk - fix line # entry field return from error display
026900140627      *                on mcov screen and add plan description to mcov screen
027000140714      * 07/14/14 dlk - fix depend max age edit
027100141110      * 11/10/14 dlk - change to use value returned from checkacaplan
027200141110      *                function instead of field pxacar in plnauxp because
027300141110      *                there are now other values with different meanings
027400141110      *                but the value returned will be "Y" for individual
027500141110      *                rating and "N" for group rating.
027600141110      *                Binding directory "ALLSRVPGMN" added for chkacaplan
027700141110      *                function.
027800141112      * 11/12/14 dlk - fix member enroll vs mcov enroll edit
027900141203      * 12/03/14 dlk - depend indicator (in25) was being left on after one
028000141203      *                hstadj was run, needed to set it off so future
028100141203      *                transactions do not have an incorrect D#- shown.
028200141203      *                (line 3481.01)
028300150325      * 03/25/15 JVA - pysts rehire should be a "A"
028400160621      * 06/21/16 dlk - do not allow acct level term codes to be used or
028500160621      *                displayed. Also remove unused code for old code
028600160622      *                display windows and other misc unused code
028700160706      * 07/06/16 dlk - change term code window from f11 to f12 due to
028800160706      *                fkey conflict with other code in same window
028900160706      *                for f11-accept no rates future effdt.
029000160720      * 07/20/16 JVA - highlight F/L Names if a longer name record exists
029100160720      *                in the longer names file CFS100P.  Both Mem/Depns.
029200180417      * 04/17/18 dlk - add change member enroll date hist rec
029300180713      * 07/13/18 dlk - change medicare from P,S,N to Y,N. Candace request
029400191107      * 11/07/2019  B.Rees   When the salary changes, update OLE.
029500191107     F*  Modid: Br01
029600220110      * 01/06/22 JVA - During Reinstate, retire any TRM_EMP records. - RFG1
029700220307      * 03/08/22 RLJ - Added call to MBREXT file maint pgm, GBS0073
029800220412      * 04/12/22 jt  - During Reinstate, write record to new file to be use as
029900220412      *                override in EDI files.
030000220505      * 05/05/22 dlk - write zeros to nodpnd field on member add (155-156)
030100220720      * 07/20/22 dlk - add edit for variable benefit plan max or increment
030200220720      *                being negative. This happend on 7/20/22 and caused
030300220720      *                the validation logic to get stuck in a loop.
030400220922      * 09/22/22 jon - error invalid dates - j001
030500221019      * 10/19/22 dlk - change line # on IO03 from 2 to 3 long so line #'s
030600221019      *                over 99 can be accessed on the coverage screen.
030700221019      *                Also change line # on io05 to 3 because the same
030800221019      *                field name is shared on both screens.
030900221023      *                Also add edit for invalid line # selected (one
031000221023      *                without a plan) to change, term, reinstate mcov
031100221023      *                routines so this correct error would show instead
031200221023      *                of another error that resulted from trying to
031300221023      *                work on a line that does not have a plan. This
031400221023      *                will probably happen more with a larger line #
031500221103      *                field if user tries to use tab key instead of field+
031600221023      *                or typing in the full 3 digit number (i.e. 005)
031700221023      *                since Genie screen will not right adjust and zero
031800221023      *                fill with tab key, an entry of 5 tab becomes 500
031900221023      *                instead of 005.
032000230414      * 04/14/23 rlj - When building the Active Cat Code array, PCT check
032100230414      *                for same day terms.
032200240109      * 01/09/24 jon - Auto-Retire Delcined plans J002  (397804)
032300240109      * 01/09/24 jon - fix logic on return EDTDAT error.  J003
032400230414      *
0325009102150047 F******************************************************************
0326009102150048 F*                                                                *
032700221019y2k  FFM070FM   CP   F 1151        WORKSTN
032800060220y2k  FMEMBER    UF A F  648     9AIDISK    KEYLOC(1)
032900010214y2k  FDEPEND    UF A F  360     9AIDISK    KEYLOC(1)
033000010214y2k  FMCOVC     UF A F   88    21AIDISK    KEYLOC(1)
033100010214y2k  FMCOV      UF   F   88     9AIDISK    KEYLOC(1)
033200010214y2k  FDCOVC     UF A F   64    21AIDISK    KEYLOC(1)
033300010214y2k  FDCOV      UF   F   64     9AIDISK    KEYLOC(1)
033400010214y2k  FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
033500010214y2k  FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
033600010214y2k  FACCMST    IF   F  560    10AIDISK    KEYLOC(1)
033700010214y2k  FACCMST#   UF   F  560    10AIDISK    KEYLOC(1)
033800010214y2k  FGRATE     IF   F   80    15AIDISK    KEYLOC(1)
0339000602170063 FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
0340000102140064 FCODES     IF   F   64     3AIDISK    KEYLOC(1)
0341000102140065 FDECLIF    IF   F  256    10AIDISK    KEYLOC(1)
034200020520     FPCPL1     UF   E           K DISK
034300081117     FTRNCFSP   IF   E           K DISK
034400090211     Fdebcard   uf a E           K DISK
034500220608     Fmemextp   uf a E           K DISK
034600110506     Fwebnotl1  IF   E           K DISK
034700110506     FACCMSP    IF   E           K DISK
034800110719     Fdepend2   uf a E           K DISK
034900110916     Fac2mstl2  IF   E           K DISK
035000121127     Fcmct14    if   E           K DISK    prefix(cm_)
035100141110     F**plnauxp   if   e           K DISK
035200160720     FCFS100P   IF   E           K Disk
035300981125y2k  FMCOV2     O  A F   88        DISK
035400130927y2k  FHIST      O  A F  216    10AIDISK    KEYLOC(1)
035500081105y2k  FTRNMIT    O  A F 1474        DISK
0356000503170036 FPCP       O  A F   43        DISK
035700191107
035800220412     freinstate uf a e           k disk    rename(reinsr:reinstFile)
035900220412
036000191126br01
036100220111       Dcl-f AccOspl2 keyed infds(OSP_FDS);
036200191107
03630011091300    * Payroll Prototypes
036400111024      /copy *libl/qmodsrc,#pchainpr
036500111024      /copy *libl/qmodsrc,#pwritepr
036600220111
036700220111      /include GBSPGM/QMODSRC,#CommandPr
036800141110
036900141118      * Check ACA Function (#chk_aca_plan)
037000141110      /define chk_ACA_plan_pr
037100141110      /define chk_ACA_plan_fields
037200141110      /copy qcpysrc,acasrvpgmp
037300141110      /undefine chk_ACA_plan_pr
037400141110      /undefine chk_ACA_plan_fields
037500141110
037600141110      *
037700191108
037800220111br01   dcl-ds OSP_FDS Ext Extname('IODBFD') end-ds;
037900191108
038000191126br01   dcl-s PayFreq Zoned(3);
038100191126br01   dcl-s wpyPfq   Char(3);
038200191126br01   dcl-s wPySal   Zoned(10:2);
038300220111       //----------------------------------------------------
038400220111       //
038500220111       //   Following is used for the Library List
038600220111       //
038700220111       //----------------------------------------------------
038800220111       dcl-pr RtvJobInf ExtPgm('QUSRJOBI');
038900220111         RcvVar Char(32766) options(*varsize);
039000220111         RcvVarLen int(10) Const;
039100220111         Format Char(8) Const;
039200220111         JobName Char(26) Const;
039300220111         IntJobId Char(16) Const;
039400220111       End-Pr;
039500220111
039600220111       dcl-s IntJobId Char(16) Inz( *Blank );
039700220111       dcl-s Format Char(8) inz( 'JOBI0700' );
039800220111       dcl-s LibsToSkip Int(10);
039900220111       dcl-s pos int(10);
040000220111       dcl-s QualJobName Char(26) inz( '*' );
040100220111       dcl-s RcvVarLen Int(10) inz( %Len( RcvVar ));
040200220111
040300220111       dcl-ds RcvVar len(32767) ;
040400220111         misc Char(64) Inz(*Blank);
040500220111         NbrSysLibs Int(10) Inz(0);
040600220111         NbrPrdLibs Int(10) Inz(0);
040700220111         NbrCurLibs Int(10) Inz(0);
040800220111         NbrUsrLibs Int(10) Inz(0);
040900220111       End-Ds;
041000220111
041100220111       dcl-ds UsrLibs Len(550);
041200220111         TheLibs Char(11) Dim(50);
041300220111       End-Ds;
041400220111
041500191108
0416001312060067 D FA              S              3  0 DIM(20)
0417001312060068 D TA              S              3  0 DIM(20)
0418001312060069 D CD              S              2    DIM(31)
0419001312060070 D DS              S             10    DIM(31)
0420001312060069 D CX              S              2    DIM(31)
0421001312060070 D DX              S             30    DIM(31)
0422001312060073 D AB              S              2  0 DIM(10)
0423001312060073 D ABX             S              2    DIM(10)
0424001312060074 D CT              S              2    DIM(10)
0425001312060074 D RB              S              3    DIM(10)
042600131206y2k  D ED              S              8  0 DIM(10)
042700131206y2k  D P#              S              4    DIM(13)
0428001312060076 D LL              S              3  0 DIM(10)
0429001312060076 D DC              S              1    DIM(10)
0430001312060077 D #AG             S              2  0 DIM(13)
0431001312060078 D #CT             S              3    DIM(13)
043200131206y2k  D #ED             S              8  0 DIM(13)
043300131206y2k  D #CD             S              8  0 DIM(13)
0434001312060081 D #AC             S              1    DIM(13)
0435001312060082 D #BA             S              7  0 DIM(13)
0436001312060083 D #GP             S             15    DIM(13)
0437001312060084 D #TX             S              1    DIM(13)
0438001312060084 D #CR             S              3    DIM(13)
0439001312060085 D BA              S              7  0 DIM(10)
044000131206y2k  D TD              S              8  0 DIM(10)
044100131206     D PR              S              9    DIM(10)
0442001406270087 D p#des           S             40    DIM(10)
0443001406270087 D PDS             S             39    DIM(13)
044400131206     D DCV             S              1    DIM(13)
044500131206y2k  D DEF             S              8  0 DIM(13)
044600131206y2k  D DTD             S              8  0 DIM(13)
0447001406180093 D MSG             S             75    DIM(107) CTDATA PERRCD(1)
0448009102150095 D DOM             S              2  0 DIM(12) CTDATA PERRCD(12)
0449009102150096 D SN              S             18    DIM(1) CTDATA PERRCD(1)
0450000102140097 D SA              S             30    DIM(1) CTDATA PERRCD(1)
0451009102150101 D ABF             S              3  0 DIM(20)
0452009102150102 D ABT             S              3  0 DIM(20)
0453000108150103 D DRT             S              5  5 DIM(20)
045400990701     D PCT             S              2    DIM(99)
045500100715     D pct#            S              2  0
045600220922     d len             s              2  0
045700020419
045800240125j002 D DCLFLG          S              1
0459000210170067 D* TCARR           S              3
0460000210170067 D TPCPR           S              1
046100021017     D DFNHLD          S             12
046200021017     D N               S             31
0463000410050023 D srvdes          S              6
0464001305160037 D workdtmdy       S               d   datfmt(*usa)
0465001305160037 D workdt          S               d   datfmt(*iso)
0466001107010037 D workdt2         S               d   datfmt(*iso)
0467000703140023 D f17hold         S                   like(f17)
0468000909180023 D f39hold         S                   like(f39)
0469000909180023 D f40hold         S                   like(f40)
0470000811100023 D f41hold         S                   like(f41)
0471000902040023 D debitcard       S              1
0472000902110023 D fm430ssn        S              9
0473000902110023 D key00           S                   like(dbseq) inz
0474000909290023 D trcode834       S              2
0475001012200023 D wkvalid         S                   like(cnmax)
0476001012200023 D wkmax           S                   like(cnmax)
0477001012200023 D validben        S              1
0478001211270023 D validcom        S              1
0479001012200023 D varbenpln       S              1
0480001108250023 D benamtwk        S                   like(benamt)
0481001109090023 D benamtwkHOLD    S                   like(benamt)
0482001108300023 D horgben         S                   like(mcorgben)
0483001012200023 D MH6             S              8
0484001109130023 D mcuniq          S             12
048500111025     D badcharfnd      S              1
048600111025     D chartstfld      S             30
048700111025     D whattstfld      S              4
048800111025     D posfnd          S              2s 0
048900111025     D testchar        S              1
049000111025     D X               S              3s 0
049100111025     D validchar_name  C                   CONST(' ABCDEFGHIJKLMNOPQRSTUVWXYZ +
049200111025     D                                     -.''')
049300111025     D validchar_addr  C                   CONST(' ABCDEFGHIJKLMNOPQRSTUVWXYZ +
049400111025     D                                     /-.''#1234567890')
049500111206     D badcharswk      S             30
049600111206     D badcharsout     S             30
049700130517     D his_covtdt      S              8s 0
049800130927     D thispgmname     S             10a   inz('FM070     ')
0499001309270037 D sysdateymd      S               d   datfmt(*iso)
0500001309270037 D systime         S               t
050100140317     D acarelchg       S              1
050200141118     D acairat         S              1
050300140318     D bage            S              5s 0
050400140318     D maxvalidage     S              3s 0 inz(150)
050500110509
050600110509     D PayChoice       S              1a   inz
050700110509     D PayPln          S              4a   inz
050800110509     D PayEff          S              8s 0 inz
050900110509     D PaySSN          S              9s 0 inz
051000111024     D wwrtn           S              1a   inz
051100220111RFG1 D dash            S              2s 0 inz
051200220111RFG1 D payr            S              2s 0 inz
051300220111RFG1 D beta            S              2s 0 inz
051400220111RFG1 D pgmr            S              2s 0 inz
051500020419
051600010215DTAQ D WDHIST        E DS                  EXTNAME(HIST) PREFIX(Q_)
051700010215DTAQ D*
051800981202     D/EJECT
0519009102150481 D*  MEMBER CHANGE COMPARISON DATA STRUCTURES
0520009102150482 D                 DS
0521009102150483 D  DS02A                  3    258
0522000602200484 D  DS02B                259    281
0523009102150485 D  LNAME                  3     20
0524009102150486 D  FNAME                 21     32
0525009102150487 D  MI                    33     33
0526009102150488 D  ADDR1                 34     63
0527009102150489 D  ADDR2                 64     93
0528009102150490 D  CITY                  94    108
0529009102150491 D  STATE                109    110
0530009102150492 D  ZIP                  111    119  0
0531009102150493 D  SEX                  120    120
053200981202c494 D* Y2K                                 121 1260BIRTH
0533009102150495 D  AREA                 127    129  0
0534009102150496 D  PHONE                130    136  0
0535009102150497 D  TRUST                137    139  0
0536009102150498 D  SUBNO                140    142  0
0537009102150499 D  ACCNO                143    146  0
0538009102150500 D  DTSA                 137    146  0
0539009812020501 D* Y2K                                 147 1520EMPDT
0540009102150502 D  SALARY               153    161  0
0541009102150503 D  EMPST                162    162
0542009812020504 D* Y2K                                 163 1680MARDT
0543009102150505 D  MEDICR               169    169
0544009102150506 D  MED#                 170    182
0545009812020507 D* Y2K                                 183 1880MEDADT
0546009812020508 D* Y2K                                 189 1940MEDBDT
0547009102150509 D  HNDICP               195    195
0548009812020510 D* Y2K                                 196 2010HDCPDT
0549000102140511 D  COBX                 202    202
0550009102150512 D  COBENM               203    222
0551009102150513 D  COBPNM               223    237
0552009102150514 D  COBP#                238    247
0553009102150515 D  COBBCF               248    248
0554009102150516 D  COBCTY               249    258
0555009102150517 D  COBST                259    260
0556001012020518 D**MORB1                261    263
0557001012020519 D**MORB2                264    266
0558001012020520 D**MORB3                267    269
0559001012020521 D**MORB4                270    272
0560001012020522 D**MORB5                273    275
056100050628     D  NONEMP               276    276
056200050930     D  INLIF                277    277
056300050930     D  INADD                278    278
056400060220     D  CCFLG                279    281
056500981202y2k   * Dates formerly in DS02A
056600010223y2k  D                 DS                  Inz
056700981204y2k  D  DS02D                  1     48
056800981202y2k  D  BIRTH                  1      8  0
056900981202y2k  D  EMPDT                  9     16  0
057000981202y2k  D  MARDT                 17     24  0
057100981202y2k  D  MEDADT                25     32  0
057200981202y2k  D  MEDBDT                33     40  0
057300981202y2k  D  HDCPDT                41     48  0
057400101215
057500101215      *******************************************************
057600101215      * fields on member screen 2 that are not in trnmit
057700101215y2k  D                 DS                  Inz
057800180417y2k  D  DS02E                  1     74
057900101215y2k  D  memail                 1     65
058000101215y2k  D  mnonssn               66     66
058100180417y2k  D  menrdt                67     74  0
058200101215
058300101215      * fields on member screen 2 that are not in trnmit
058400101215y2k  D                 DS                  Inz
058500180417y2k  D  DS02EH                 1     74
058600101215y2k  D  f42                    1     65
058700101215y2k  D  f43                   66     66
058800180417y2k  D  f44                   67     74  0
058900101215      *******************************************************
059000101215
059100010223     D                 DS                  Inz
0592009102150524 D  DS02AH                 3    258
0593000602200525 D  DS02BH               259    281
0594009102150526 D  F1                     3     20
0595009102150527 D  F2                    21     32
0596009102150528 D  F3                    33     33
0597009102150529 D  F4                    34     63
0598009102150530 D  F5                    64     93
0599009102150531 D  F6                    94    108
0600009102150532 D  F7                   109    110
0601009102150533 D  F8                   111    119  0
0602009102150534 D  F9                   120    120
0603009812020535 D* Y2K                                 121 1260F10
0604009102150536 D  F11                  127    129  0
0605009102150537 D  F12                  130    136  0
0606009102150538 D  F13                  137    139  0
0607009102150539 D  F14                  140    142  0
0608009102150540 D  F15                  143    146  0
0609009102150541 D  FTSA                 137    146  0
0610009812020542 D* Y2K                                 147 1520F16
0611009102150543 D  F17                  153    161  0
0612009102150544 D  F18                  162    162
0613009812020545 D* Y2K                                 163 1680F19
0614009102150546 D  F20                  169    169
0615009102150547 D  F21                  170    182
0616009812020548 D* Y2K                                 183 1880F22
0617009812020549 D* Y2K                                 189 1940F23
0618009102150550 D  F24                  195    195
0619009812020551 D* Y2K                                 196 2010F25
0620009102150552 D  F26                  202    202
0621009102150553 D  F27                  203    222
0622009102150554 D  F28                  223    237
0623009102150555 D  F29                  238    247
0624009102150556 D  F30                  248    248
0625009102150557 D  F31                  249    258
0626009102150558 D  F32                  259    260
0627001012150559 D* F33                  261    263
0628001012150560 D* F34                  264    266
0629001012150561 D* F35                  267    269
0630001012150562 D* F36                  270    272
0631001012150563 D* F37                  273    275
063200050628     D  F38                  276    276
063300050930     D  F39                  277    277
063400050930     D  F40                  278    278
063500060220     D  F41                  279    281
063600981202y2k   * Dates formerly in DS02AH
063700010223y2k  D                 DS                  Inz
063800981204y2k  D  DS02DH                 1     48
063900981202y2k  D  F10                    1      8  0
064000981202y2k  D  F16                    9     16  0
064100981202y2k  D  F19                   17     24  0
064200981202y2k  D  F22                   25     32  0
064300981202y2k  D  F23                   33     40  0
064400981202y2k  D  F25                   41     48  0
0645000002180564 D* DATA STRUCTURE FOR DEPENDENT CHANGE
0646000102260565 D                 DS
0647009102150566 D  DS04A                  3    258
0648009102150567 D  DS04B                259    260
0649009102150568 D  DRELC2                 3      4
0650009102150569 D  DLNAME                 5     22
0651009102150570 D  DFNAME                23     34
0652009102150571 D  DMI                   35     35
0653009102150572 D  DADDR1                36     65
0654009102150573 D  DADDR2                66     95
0655009102150574 D  DCITY                 96    110
0656009102150575 D  DSTATE               111    112
0657000102260576 D  DZIP                 113    121  0 Inz(0)
0658009102150577 D  DSEX                 122    122
0659000102260579 D  DAREA                129    131  0 Inz(0)
0660000102260580 D  DPHONE               132    138  0 Inz(0)
0661000102260581 D  DEPSS#               139    147  0 Inz(0)
0662009102150582 D  DSTUDN               148    148
0663009102150583 D  DMEDCR               149    149
0664009102150584 D  DMED#                150    162
0665009102150587 D  DHNDCP               175    175
0666009102150589 D  DCOB                 182    182
0667009102150590 D  DCOBEN               183    202
0668009102150591 D  DCOBPN               203    217
0669009102150592 D  DCOBP#               218    232
0670009102150593 D  DCOBBC               233    233
0671009102150594 D  DCOBCT               234    243
0672009102150595 D  DCOBST               244    245
0673001012020596 D**DMORB1               246    248
0674001012020597 D**DMORB2               249    251
0675001012020598 D**DMORB3               252    254
0676001012020599 D**DMORB4               255    257
0677001012020600 D**DMORB5               258    260
0678000210140600 D  DSEFFD               271    278
0679000210140600 D  DSSCHL               279    305
068000981204y2k   * Dates formerly in DS04A
068100010226y2k  D                 DS
068200981204y2k  D  DS04D                  1     32
068300010226y2k  D  DBIRTH                 1      8  0 Inz(0)
068400010226y2k  D  DMEDAD                 9     16  0 Inz(0)
068500010226y2k  D  DMEDBD                17     24  0 Inz(0)
068600010226y2k  D  DHDDT                 25     32  0 Inz(0)
0687000102230601 D                 DS                  Inz
0688009102150602 D  DS04AH                 3    258
0689009102150603 D  DS04BH               259    260
0690009102150604 D  D1                     3      4
0691009102150605 D  D2                     5     22
0692009102150606 D  D3                    23     34
0693009102150607 D  D4                    35     35
0694009102150608 D  D5                    36     65
0695009102150609 D  D6                    66     95
0696009102150610 D  D7                    96    110
0697009102150611 D  D8                   111    112
0698009102150612 D  D9                   113    121  0
0699009102150613 D  D10                  122    122
070000981204     D* y2k                                 123 1280D11
0701009102150615 D  D12                  129    131  0
0702009102150616 D  D13                  132    138  0
0703009102150617 D  D14                  139    147  0
0704009102150618 D  D15                  148    148
0705009102150619 D  D16                  149    149
0706009102150620 D  D17                  150    162
070700981204     D* y2k                                 163 1680D18
0708009812040622 D* y2k                                 169 1740D19
0709009102150623 D  D20                  175    175
071000981204     D* y2k                                 176 1810D21
0711009102150625 D  D22                  182    182
0712009102150626 D  D23                  183    202
0713009102150627 D  D24                  203    217
0714009102150628 D  D25                  218    232
0715009102150629 D  D26                  233    233
0716009102150630 D  D27                  234    243
0717009102150631 D  D28                  244    245
0718001012150632 D* D29                  246    248
0719001012150633 D* D30                  249    251
0720001012150634 D* D31                  252    254
0721001012150635 D* D32                  255    257
072200981204y2k   * Dates formerly in DS04AH
072300010226y2k  D                 DS
072400981204y2k  D  DS04DH                 1     32
072500010226y2k  D  D11                    1      8  0 Inz(0)
072600010226y2k  D  D18                    9     16  0 Inz(0)
072700010226y2k  D  D19                   17     24  0 Inz(0)
072800010226y2k  D  D21                   25     32  0 Inz(0)
072900110719
073000110719      *******************************************************
073100110719      * fields on depend screen 4 that are not in trnmit
073200110719y2k  D                 DS                  Inz
073300110719y2k  D  DS04E                  1     65
073400110719y2k  D  d2email                1     65
073500110719
073600110719      * fields on depend screen 4 that are not in trnmit
073700110719y2k  D                 DS                  Inz
073800110719y2k  D  DS04EH                 1     65
073900110719y2k  D  D33                    1     65
0740009812020451 D* KEY FIELD DATA STRUCTURE
0741009812020452 D                 DS
0742000110310454 D  COVKEY                 1     21
0743009812020455 D  RATE                  12     26
0744009812020456 D  PLAN                  12     21
0745009812020457 D  CTRSUB                12     17  0
0746009812020458 D  CLEAR                 10     26
0747009812020459 D  CSSNO                  1      9  0
0748009812020460 D  CSEQ#                 10     11  0
0749009812020461 D  CTRUST                12     14  0
0750009812020462 D  CSUB                  15     17  0
075100981202y2k  D  CPLAN                 18     21
075200020419     D  TKEY                  12     21
0753009812020464 D  CAGEBD                22     23  0
0754009812020465 D  CCOVTP                24     26
075500981218y2k  D  CEFFDT                27     34  0
075600981218y2k  D  CCANDT                35     42  0
075700981218     D  CBENAM                43     49  0
075800981202     D/EJECT
0759000102230466 D                 DS                  Inz
0760009812020467 D  CDKEY                  1      3
0761009812020468 D  CDTYPE                 1      1
076200981202     D  CD3                    3      3
0763000102230469 D                 DS                  Inz
0764009812070470 D  DATECK                 1      8  0
0765009812020471 D  MM                     1      2  0
0766009812020472 D  DD                     3      4  0
076700981202y2k  D  YY                     5      8  0
076800981202      * Used in GRATE file record/date range comparison
0769000102230474 D                 DS                  Inz
0770009812020475 D  CYMD                   1      8  0
0771009812020477 D  HCYMD                  1      8  0
077200981208y2k  D  HCOVYY                 1      4  0
0773009812020479 D  HCOVMM                 5      6  0
0774000102230675 D                 DS                  Inz
077500981201y2k  D  MDDATE                 1      8  0
0776009812010679 D  MDDD                   7      8  0
0777000102230680 D                 DS                  Inz
077800981201y2k  D  ASDT                   1      8  0
0779009812010683 D  MM01                   7      8  0
0780000102230049 D                 DS                  Inz
078100130515y2k  D  lastprenewwk           1      8  0
0782001305150052 D  lastprenmm             5      6  0
078300010223     D                 DS                  Inz
078400981130     D  ZERO7                  1      7  0
078500981130     D  ZERO8                  1      8  0
078600981130     D  ZERO9                  1      9  0
078700010223     D                 DS                  Inz
078800010226     D  $RA                           1  0 DIM(5)
078900010214     D  @RA                    1      5
079000010223     D                 DS                  Inz
079100010226     D  $BA                           1  0 DIM(9)
079200010214     D  @BA                    1      9
079300010223     D                 DS                  Inz
079400010226     D  $BR                           1  0 DIM(9)
079500010214     D  @BR                    1      9
079600010216DTAQ  * DATA STRUCTURE FOR REDEFINING CK#NOT FLD FROM ADJUST REC
079700010223DTAQ D                 DS                  Inz
079800010216DTAQ D  H_CK#NOT               1     30
079900010221DTAQ D   QCKMH1                1      4
080000010216DTAQ D   QCKAB                 7     14
080100010216DTAQ D   QCKABD               15     16S 0
080200010223DTAQ D   QCKCT                19     26
080300010216DTAQ D   QCKCTP               27     28
080400010216DTAQ  * DATA STRUCTURE FOR REDEFINING NOTE2 FLD FROM ADJUST REC
080500010223DTAQ D                 DS                  Inz
080600010216DTAQ D  H_NOTE2                1     30
080700010912DTAQ D   QNT2DSC               1      6
080800010226DTAQ D   QNT8AMT               7     14
080900010216DTAQ D   QNT2DAT              23     30
081000081114
0811000811140651 D                 DS                  Inz
081200081114     D  QQTIME                 1      6S 0
0813000811140651 D                 DS                  Inz
081400081114     D  QQDATE                 1      8S 0
0815000811140651 D                 DS                  Inz
081600081114     D  QQUSER                 1     10
0817000811140651 D                 DS                  Inz
081800081114     D  QQFLAG                 1      1
0819000811140651 D                 DS                  Inz
082000081114     D  QQPGNM                 1     10
0821000811140651 D                 DS                  Inz
082200081114     D  QQFIXF                 1      1
0823000811140651 D                 DS                  Inz
082400081114     D  QQPCPE                 1      8S 0
0825000811140651 D                 DS                  Inz
082600081114     D  QQPCPC                 1      8S 0
0827000811140651 D                 DS                  Inz
082800081114     D  QQRVWR                 1     10
082900081114
083000130509DTAQ D                 DS
083100130509      * date for age calculation YYYYMMDD
083200130509DTAQ D  agedatwk               1      8  0
083300130509DTAQ D  agedatyr               1      4  0
083400130509DTAQ D  agedatmo               5      6  0
083500220309
083600220309DTAQ D                 DS
083700220329      *   Data Structure for call to GBS0073
083800220309DTAQ D  A73TSA                 1     10
083900220309DTAQ D   A73TRST               1      3
084000220309DTAQ D   A73SUB#               4      6
084100220309DTAQ D   A73ACCT               7     10
084200220608DTAQ D  A73SSNO               11     19  0
084300220608DTAQ D  A73BACK               20     20
084400130509
084500130509     D                 DS
084600130509     D  chgdtymd_wk            1      8  0
084700130509     D  chgy                   1      4  0
084800130509     D  chgm                   5      6  0
084900130509     D  chgd                   7      8  0
085000130509
085100130509     D                 DS
085200130509     D  prenew                 1      8  0
085300130509     D  prenewmm               7      8  0
085400240109
085500240109J002 D webdcl        e ds                  extname(webdclds)
085600130509
0857009102150690 D* LDA OPERATOR ID
0858009102150691 D                UDS
0859001309270692 D  luser8                 1      8
0860001309270692 D  luser                  1     10
0861009102150693 D  CONAME               201    240
086200010215DTAQ D  PREFIX               241    241
086300981201Y2K  D  LDADTE               248    255  0
086400981202Y2K  D  UDCY                 248    251  0
086500981202Y2K  D  UDMM                 252    253  0
0866001105060025
086700110506      * Payroll Deduction File
086800110506     D WEBDED        E DS                  EXTNAME(WEBPAYDED)
086900110913    ?D WUDTA         E DS                  EXTNAME(WEBPAYOND)
087000110913     D WEBPAY        E DS                  EXTNAME(WEBPAYROLL)
0871000810290025
087200081029      * Program status data structure
087300081029     D PGMD          ESDS                  EXTNAME(IOPGMD)
087400191111
087500191111
087600191111
087700191111
087800131211    ***
0879000102140105 IFM070FM   NS  01    1 C0    2 C1
0880009102150106 I* FORMAT-IO01
0881009102150107 I                                  3   11 0SSNO
0882009102150108 I          NS  02    1 C0    2 C2
0883009102150109 I* FORMAT-IO02
088400101215y2k  I                                  3    3  mnonssn
088500101214y2k  I                                  4   11 0MENRDT
088600101214     I                                 12   29  LNAME
088700101214     I                                 30   41  FNAME
088800101214     I                                 42   42  MI
088900101214     I                                 43   72  ADDR1
089000101214     I                                 73  102  ADDR2
089100101214     I                                103  117  CITY
089200101214     I                                118  119  STATE
089300101214     I                                120  128 0ZIP
089400101214     I                                129  129  SEX
089500101214y2k  I                                130  137 0BIRTH
089600101214     I                                130  131 0BMO
089700101214     I                                134  137 0BCY
089800101214     I                                138  140 0AREA
089900101214     I                                141  147 0PHONE
090000101215     I                                148  212  memail
090100101215     I                                213  222 0TSA
090200101215     I                                213  218 0TR#SUB
090300101215     I                                213  215 0TRUST
090400101215     I                                216  218 0SUBNO
090500101215     I                                219  222 0ACCNO
090600101215Y2K  I                                223  230 0EMPDT
090700101215     I                                231  239 0SALARY
090800101215928  I                                240  240  INLIF
090900101215928  I                                241  241  INADD
091000101215     I                                242  242  EMPST
091100101215     I                                243  245  CCFLG
091200101215     I                                246  246  NONEMP
091300101215y2k  I                                247  254 0MARDT
091400101215     I                                255  255  MEDICR
091500101215     I                                256  268  MED#
091600101215y2k  I                                269  276 0MEDADT
091700101215y2k  I                                277  284 0MEDBDT
091800101215     I                                285  285  HNDICP
091900101215y2k  I                                286  293 0HDCPDT
092000101215     I                                294  294  COBX
092100101215     I                                295  314  COBENM
092200101215     I                                315  329  COBPNM
092300101215     I                                330  339  COBP#
092400101215     I                                340  340  COBBCF
092500101215     I                                341  350  COBCTY
092600101215     I                                351  352  COBST
0927009102150151 I          NS  03    1 C0    2 C3
0928009102150152 I* FORMAT-IO03
092900981125y2k  I                                  3    6  SPLAN#
0930009102150154 I                                  7    8  SCVTYP
093100981130y2k  I                                  9   16 0SENRLD
0932009811300158 I                                 17   23 0SBENAM
093300981130y2k  I                                 24   31 0SCAND1
0934009811300159 I                                 32   32  SACTCD
0935002210190160 I                                 33   35 0L#
0936002210190160 I                                 33   34 0L2#
093700221019y2k  I                                 36   43 0ASOFDT
093800221019     I                                 44   45  TRMRCD
0939009102150162 I          NS  04    1 C0    2 C4
0940009102150163 I* FORMAT-IO04
0941009102150164 I                                  3    4  DRELC2
0942009102150165 I                                  5   22  DLNAME
0943009102150166 I                                 23   34  DFNAME
0944009102150167 I                                 35   35  DMI
0945009102150168 I                                 36   65  DADDR1
0946009102150169 I                                 66   95  DADDR2
0947009102150170 I                                 96  110  DCITY
0948009102150171 I                                111  112  DSTATE
0949009102150172 I                                113  121 0DZIP
0950009102150173 I                                122  122  DSEX
095100981130y2k  I                                123  130 0DBIRTH
0952009811300175 I                                131  133 0DAREA
0953009811300176 I                                134  140 0DPHONE
0954009811300177 I                                141  149 0DEPSS#
0955009811300178 I                                150  150  DSTUDN
0956001107190600 I                                151  158  DSEFFD
0957001107190600 I                                159  185  DSSCHL
0958001107190600 I                                186  250  D2email
095900110719
0960001107190179 I                                251  251  DMEDCR
0961001107190180 I                                252  264  DMED#
096200110719y2k  I                                265  272 0DMEDAD
096300110719y2k  I                                273  280 0DMEDBD
0964001107190183 I                                281  281  DHNDCP
096500110719y2k  I                                282  289 0DHDDT
0966001107190185 I                                290  290  DCOB
0967001107190186 I                                291  310  DCOBEN
0968001107190187 I                                311  325  DCOBPN
0969001107190188 I                                326  340  DCOBP#
0970001107190189 I                                341  341  DCOBBC
0971001107190190 I                                342  351  DCOBCT
0972001107190191 I                                352  353  DCOBST
0973009102150197 I          NS  05    1 C0    2 C5
0974009102150198 I* FORMAT-IO05
0975009509260201 I                                  3    3  SACTCD
0976002210190202 I                                  4    6 0L#
097700221019y2k  I                                  7   14 0SENRLD
097800221019y2k  I                                 15   22 0SCANDT
0979009102150203 I          NS  06    1 C0    2 C6
0980009102150204 I* FORMAT-IO06
0981009102150205 I                                  3    4  TCODE
098200981130y2k  I                                  5   12 0TERMDT
0983009102150207 I          NS  07    1 C0    2 C7
0984009102150208 I* FORMAT-IO07
0985009102150209 I                                  3    4  RCODE
098600981130y2k  I                                  5   12 0REINDT
098700041005y2k  I                                 13   13  retainc
0988009102150211 I          NS  08    1 C0    2 C8
0989009102150212 I* FORMAT-IO08
0990009102150213 I                                  3    4  TCODE
099100981130y2k  I                                  5   12 0TERMDT
0992009102150215 I          NS  09    1 C0    2 C9
0993009102150216 I* FORMAT-IO09
0994009102150217 I                                  3    4  RCODE
099500981130y2k  I                                  5   12 0REINDT
0996009105220215 I          NS  10    1 C1    2 C0
099700910522     I* FORMAT-IO10
099800981130y2k  I                                  3   10 0SCHDT
0999009105230215 I          NS  37    1 C3    2 C7
100000910523     I* FORMAT-IO37
100100981130y2k  I                                  3   10 0BCHDT
1002009710070074 I          NS  78    1 C7    2 C8
1003009710070075 I* FORMAT-IO78 : PCP ADD
1004000503210076 I                                  3   22  PCID#
1005000503210076 I                                 23   27  PCSPCD
1006000503210076 I                                 28   35 0PCEFF
1007000503210076 I*                                36   36  PCRPAT
1008009102150219 I          NS  99
1009009812233759 I/EJECT
1010009102150220 IMEMBER    NS
1011009102150221 I*  MEMBER FILE
1012009102150222 I                                 10   27  LNAME
1013009102150223 I                                 28   39  FNAME
1014009102150224 I                                 40   40  MI
1015009102150225 I                                 41   70  ADDR1
1016009102150226 I                                 71  100  ADDR2
1017009102150227 I                                101  115  CITY
1018009102150228 I                                116  117  STATE
1019009102150229 I                             P  118  122 0ZIP
1020009102150230 I                             P  123  124 0AREA
1021009102150231 I                             P  125  128 0PHONE
1022009102150232 I                                129  129  SEX
102300040902     I                                136  145 0ATSAN
1024009102150234 I                                136  138 0TRUST
1025009102150235 I                                139  141 0SUBNO
1026009102150236 I                                142  145 0ACCNO
1027009102150238 I                                148  148  EMPST
1028009102150242 I********************* CLAIMS PAYMENT INFO **********************
1029000102140245 I                                166  166  COBX
1030009102150246 I                                167  186  COBENM
1031009102150247 I                                187  201  COBPNM
1032009102150248 I                                202  211  COBP#
1033009102150249 I                                212  212  MEDICR
1034009102150250 I                                213  225  MED#
103500050628     I                                158  158  NONEMP
103600140611mm43 I                                159  159  HNDICP
1037000602200260 I                             P  261  265 0SALARY
1038000602200261 I                                266  266  COBBCF
1039000602200262 I                                267  276  COBCTY
1040000602200263 I                                277  278  COBST
104100060220     I                                279  279  INLIF
104200060220     I                                280  280  INADD
1043009102150265 I********************* DATES AND EVENTS *************************
1044000602200274 I                                329  331  TERMCD
1045000602200275 I                                332  334  QECD
1046000602200276 I                                335  337  NTFYCD
1047000602200277 I                                338  340  CANCD
1048000603240286 I                             P  373  376 2PRVBAL
1049000602200287 I                             P  377  380 2CURBAL
105000101215
105100101215      * 12/15/10
105200101215      * fill66 field pos 429 - 494 temporarily used to store email and
105300101215      * nonssn until next member file change
105400101215     I                                429  493  memail
105500101215     I                                494  494  mnonssn
105600101215      *
105700101215     I                                495  497  CCFLG
1058000602200292 I                                498  498  AUTCAN
1059000602200295 I                                511  512  STATUS
106000981215      * Member Dates
106100060220y2k  I                                513  520 0BIRTH
106200060220y2k  I                                521  528 0MARDT
106300060220y2k  I                                529  536 0HDCPDT
106400060220y2k  I                                537  544 0MEDADT
106500060220y2k  I                                545  552 0MEDBDT
106600060220y2k  I                                553  560 0EMPDT
106700060220y2k  I                                561  568 0MENRDT
106800981211y2k  I*                                     569 5760CVTHDT
106900060220y2k  I                                577  584 0TERMDT
107000060220y2k  I                                585  592 0QEDT
107100060220y2k  I                                593  600 0NTFYDT
107200060220y2k  I                                609  616 0EEXPDT
107300060220y2k  I                                617  624 0PEXPDT
107400060220y2k  I                                625  632 0CEXPDT
107500060220y2k  I                                633  640 0PARPDT
1076009102150296 IMCOVC     NS
1077009102150298 I*  MEMBER COVERAGE FILE  ALT INDEX USED TO PREVENT DUP COVERAGES
1078009102150299 I                                  1    9 0MCSSNO
1079009102150301 I                                 12   14 0TRUST#
1080000409010302 I                                 15   17 0SUB#
108100981125y2k  I                                 18   21  PLAN#
1082009102150304 I                                 22   23 0AGEBND
1083009102150305 I                                 24   26  COVTYP
108400001017     I                                 12   21  PK
1085009102150306 I                                 12   26  GRTKEY
1086009102150310 I                                 43   43 0CACTFL
1087009102150311 I                             P   44   47 0BENAMT
1088001109130311 I                             P   56   59 0mcorgben
1089009102150313 I                                 64   64  DLTC1
109000981130y2k  I                                  1   88  ALLC
109100981130      * dates
109200981130y2k  I                                 65   72 0ENRLDT
109300981130y2k  I                                 73   80 0CANDT
1094009102150314 IMCOV      NS
1095009102150317 I                                  1    9 0MCSSNO
1096009102150319 I                                 12   14 0TRUST#
1097009105220320 I                                 12   26  GRTKEY
1098009102150321 I                                 15   17 0SUB#
109900981125y2k  I                                 18   21  PLAN#
110000981125y2k  I                                 12   21  MPLKEY
1101009102150324 I                                 22   23 0AGEBND
1102009102150325 I                                 24   26  COVTYP
1103009102150329 I                                 43   43 0CACTFL
1104009102150330 I                             P   44   47 0BENAMT
1105001108250311 I                             P   56   59 0mcorgben
1106009102150332 I                                 64   64  DLTC2
110700981130y2k  I                                  1   88  ALL
110800981130      * dates
110900981130y2k  I                                 65   72 0ENRLDT
111000981130y2k  I                                 73   80 0CANDT
111100981130y2k  I                                 65   72 0EDATE
111200981130y2k  I                                 73   80 0TDATE
1113009102150333 IDEPEND    NS
1114000002180334 I*  DEPENDENTS FILE
1115009102150336 I                                 10   11 0DSEQ#
1116009102150337 I                                 12   29  DLNAME
1117009102150338 I                                 30   41  DFNAME
1118009102150339 I                                 42   42  DMI
1119009102150340 I                                 43   72  DADDR1
1120009102150341 I                                 73  102  DADDR2
1121009102150342 I                                103  117  DCITY
1122009102150343 I                                118  119  DSTATE
1123009102150344 I                             P  120  124 0DZIP
1124009102150345 I                             P  125  126 0DAREA
1125009102150346 I                             P  127  130 0DPHONE
1126009102150347 I                                131  131  DSEX
1127009102150349 I                                138  140  DRELCD
1128009102150350 I                             P  141  145 0DEPSS#
1129009102150351 I                                146  146  DSTUDN
1130009102150352 I                                147  147  DHNDCP
1131009102150354 I                                154  154  DCOB
1132009102150355 I                                155  174  DCOBEN
1133009102150356 I                                175  189  DCOBPN
1134009102150357 I                                190  204  DCOBP#
1135009102150358 I                                205  205  DMEDCR
1136009102150359 I                                206  218  DMED#
1137009102150370 I                                257  257  DCOBBC
1138009102150371 I                                258  267  DCOBCT
1139009102150372 I                                268  269  DCOBST
1140000210140600 I                                271  278  DSEFFD
1141000210140600 I                                279  305  DSSCHL
1142009102150376 I                                320  320  DLTC3
114300981130      * dates
114400981130y2k  I                                321  328 0DBIRTH
114500981130y2k  I                                329  336 0DHDDT
114600981130y2k  I                                337  344 0DMEDAD
114700981130y2k  I                                345  352 0DMEDBD
1148009102150377 IDCOVC     NS
1149000002180378 I*  DEPENDENT COVERAGE FILE
1150009102150380 I                                 10   11 0DSEQ#C
1151009102150381 I                                 12   14 0TRUST#
1152009102150382 I                                 15   17 0SUB#
115300981125y2k  I                                 18   21  DPLAN#
1154009102150391 I                                 48   48  DLTC4
115500981130y2k  I                                 49   56 0DENRDT
115600981130y2k  I                                 57   64 0DCANDT
1157009102150392 IDCOV      NS
115800981125y2k  I                                 12   21  DCVPLK
1159009102150395 I                                 10   11 0DSEQ#C
116000981125y2k  I                                 18   21  DPLAN#
1161009102150399 I                                 48   48  DLTC5
116200981130y2k  I                                 49   56 0DEDATE
116300981208y2k  I                                 57   64 0TDATE
1164009102150400 ICODES     NS
1165009102150405 I                                 44   44  ACTION
1166001606210405 I                                 45   45  ACTN2
1167009102150406 I                                 64   64  DLTC6
1168009102150407 ICARMST    NS  01
1169009102150408 I*  CARRIER MASTER FILE
1170009102150409 I                                202  202  TXMTYN
1171009807230148 I                                214  214  CARBC
117200001017     I                                215  216  CPRRUL
1173009102150410 IPLNMST    NS
1174009102150411 I*  PLAN MASTER
1175009102150414 I                                  1    6 0PTRSUB
1176001402150414 I                                  1    3 0PLTRUST
1177001402150414 I                                  4    6 0PLSUB#
117800981125y2k  I                                  7   10  PPLAN
1179009102150416 I                                 11   50  PDESCR
1180000210160416 I                                 51   51  PCP_REQ
1181009102150417 I                                 53   55  PCARR
1182009102150419 I                                 57   57  PABFL
1183009102150420 I                             P   58   97  FA
1184009102150421 I                             P   98  137  TA
1185009110100070 I                                164  165  PLNCAT
1186009102150424 I                                166  171 5MULT
1187009102150425 I                                172  176 0ROUND
1188009102150426 I                                177  177  RNDFLG
1189009102150427 I                             P  178  181 0MAXBEN
1190000902040429 I                                190  190  pdebit
1191000902040429 I                                192  192  DLTC7
1192001305090429 I                                193  200  prenew
1193009102150430 ITRSMST    NS
1194009102150431 I                                255  255  TSCODE
1195009102150432 IACCMST    NS
119600040901     I                                  1   10  TSA@@
1197009102150433 I                                 11   50  ACNAM1
119800040901     I                                247  247  ASPHFL
119900041005     I                                248  248  acobsrv
120000981130y2k  I                                513  520 0ACVTDT
120100981130y2k  I                                537  544 0ATERM
1202009901260079 I                                545  552 0AENROL
1203009102150435 IACCMST#   NS
1204009102150436 I                             P  210  213 0NOEMPL
1205009102150438 IGRATE     NS
120600071003y2k  I                                 65   72 0frmdat
120700071003y2k  I                                 73   80 0todat
1208009102150442 I                                 24   38  GROUP#
1209000710030442 I                                 64   64  grdltd
1210009102150443 IDECLIF    NS
1211009102150444 I                             P   11   50 0ABF
1212009102150445 I                             P   71  110 0ABT
1213000108150446 I                             P  131  190 5DRT
1214009102150447 I                                221  221  DROUND
1215009102150448 I                             P  222  224 0DRNDAM
1216009102150708 C*
121700191108
121800191108
121900191126br01   Exec Sql
122000191126         Set Option Commit = *None, Naming = *Sys;
122100191108
1222009102150709 C   99              SETON                                        11
1223009102150710 C   99              GOTO      END
1224009102150711 C*
1225009102150712 C*  SET OF OUTPUT INDICATORS
1226009102150713 C*
1227009102150714 C                   EXSR      #SETOF
1228009102150715 C*
1229009102150716 C*  ON CMD 7 FROM SCREEN-IO01   END
1230009102150717 C*
1231000102140718 C   KG              SETOFF                                       01
1232000102140719 C   KG              SETON                                        LR
1233009102150720 C*
1234000002180721 C*  EXECUTE RETRIEVE, UPDATE OR DEPENDENT SUBROUTINE BASED IN INPUT
1235009102150722 C*
1236009102150723 C   01              EXSR      #RTRV
1237009102150724 C   02              EXSR      #MEM
1238009102150725 C   03              EXSR      #MEMC
1239009102150726 C   04              EXSR      #DPND
1240009102150727 C   05              EXSR      #DPNDC
1241009102150728 C   06              EXSR      #TERM
1242009102150729 C   07              EXSR      #REIN
1243009102150730 C   08              EXSR      #DTERM
1244009102150731 C   09              EXSR      #DREIN
1245001305160731 C   10              EXSR      #dspsalchdt
1246001305160731 C   37              EXSR      #dspbdchdt
124700000621     C   78              EXSR      #PCP
1248009102150732 C*
124900981215     C   31
125000981215Y2K  CANN12              EXSR      #FLMBR
1251009102150733 C     END           TAG
1252009102150735 C****************************************************************
1253009102150736 C*  END OF MAINLINE CALCULATIONS                                *
1254009102150737 C****************************************************************
1255009102150738 C/EJECT
1256009102150739 C****************************************************************
1257009102150741 C*----------------------- RETRIEVE -----------------------------*
1258009102150742 C*
1259009102150743 C     #RTRV         BEGSR
1260009102150744 C*
126100910919     C                   SETON                                            48
126200980130     C                   SETOFF                                       80
126300090204     c                   clear                   debitcard
126400100730     c                   clear                   pct
126500090204
1266009811250745 C*  CHECK TO SEE IF SS # IS BLANK
1267009801300746 C*
1268009102150747 C     SSNO          COMP      *ZEROS                                 50
1269001110250748 C   50              Z-ADD     1             X                    11
1270009102150749 C   11              GOTO      #ENDRV
1271009102150750 C*
1272009102150751 C*  GET RECORD IF IT IS ON FILE  - BLANK FIELDS IF NOT ON FILE
1273009102150752 C*
1274009102150753 C     SSNO          CHAIN     MEMBER                             41
127500220112RFG1 C   41              clear                   TRUST
127600220112RFG1 C   41              clear                   SUBNO
127700220112RFG1 C   41              clear                   ACCNO
127800040923     C  N41ATSAN         CHAIN     ACCMST                             87
127900220111
128000220111RFG1 C                   Exsr      SETLIBL
128100220111
128200040903      *---
128300040903      * If Special Handling Flag is Yes, then show Cmd8 to see notes.
128400040903      *---
128500040903     C                   Eval      *In88  = *Off
128600040923     C                   If        *In87  = *Off
128700040903     C                   If        ASPHFL = 'Y'
128800040903     C                   Eval      *In88  = *On
128900040903     C                   End
129000040903     C                   End
129100160720
129200160720     C* check for longer names and highlight
129300160720     C     CFSKEY        Chain     CFS100P
129400160720     C                   if        %found(CFS100P)
129500160720     C                   eval      *in51 = *on
129600160720     C                   eval      *in52 = *on
129700160720     C                   end
129800160720     C     CFSKEY        klist
129900160720    ?C                   kfld                    SSNO
130000160720    ?C                   kfld                    CFSEQ
130100041005
1302000410050235  * cobra service description
130300041005     c                   eval      *in92 = *off
130400041005
130500041005     c                   if        *in41 = *off and *in87 = *off
130600041005     c                   clear                   srvdes
130700041005     c                   eval      *in92 = *on
130800041005     c                   select
130900041005     c                   when      acobsrv = 'L'
131000041005     c                   eval      srvdes = 'LETTER'
131100041005     c                   when      acobsrv = 'B'
131200041005     c                   eval      srvdes = 'BILL  '
131300041005     c                   when      acobsrv = 'F'
131400041005     c                   eval      srvdes = 'FULL  '
131500041005     c                   when      acobsrv = ' '
131600041005     c                   eval      srvdes = 'NONE  '
131700041005     c                   endsl
131800041005     c                   endif
131900021114
1320009102150754 C   41              SETOFF                                           35
1321009102150755 C   41              EXSR      #CLEAR
1322009102150756 C*
1323009801300757 C*  CHECK FOR COBRA MEMBER
1324009801300758 C*
132500000218     C                   SETOFF                                       50
132600000218     C  NU1CEXPDT        IFNE      0
132700000218     C                   SETON                                        50
132800000218     C                   Z-ADD     69            X                    11
132900000218     C                   GOTO      #ENDRV
133000000218     C                   END
1331000002180758 C*
133200980130     C     CEXPDT        IFNE      0
133300980130     C                   SETON                                        80
133400980130     C                   END
1335009801300756 C*
1336009801300757 C*  CHECK FOR NOTIFIED RECORD     - 89 ON BLOCKS UPDATE OF
1337009801300758 C*                                  DELETED OR NOTIFIED RECORD
1338009102150759 C                   SETOFF                                       89
1339009102150760 C  N41              SETON                                            35
1340009102150761 C  N41              MOVE      STATUS        SCHECK            1
1341009102150762 C  N41SCHECK        IFNE      'A'
1342009102150763 C                   SETON                                        8950
134300910919     C                   SETOFF                                       48
1344009102150764 C                   Z-ADD     2             X                    50
1345009102150765 C                   END
1346009102150766 C*
1347009102150767 C*  HOLD DATA STRUCTURE FOR CHANGE COMPARISON
1348009102150768 C*
1349009102150769 C                   MOVE      DS02A         DS02AH
1350009102150770 C                   MOVE      DS02B         DS02BH
135100981202y2k  C                   MOVE      DS02D         DS02DH
135200101215y2k  C                   MOVE      DS02E         DS02EH
1353009102150771 C*
1354009812030772 C*  SETON 12 to output IO02 & format dates for scrn display
1355009102150773 C*
1356009102150774 C                   SETON                                        12
135700981215y2k  C  N41              EXSR      #KIMBR
1358009102150775 C*
135900920316     C                   MOVE      *ZEROS        SCHDT
136000920316     C                   MOVE      'N'           SKPSAL            1
136100910522     C                   MOVE      'N'           SKIP1
136200041015
1363009102150776 C     #ENDRV        ENDSR
136400131213   S***S
1365009102150778 C****************************************************************
1366009102150780 C*----------------------- MEMBER  ------------------------------*
1367009102150781 C*
1368009102150782 C     #MEM          BEGSR
136900040901     C*
137000040903     C* If *In88 is on (special handling flag = 'Y') allow Cmd20.
137100040903      * Call Member Account Diary Note Maintenance Program if special handling.
137200040903      * P11 is - byte 1 = S = Stand Alone Call  OR I for Interface.
137300040901      *        Bytes 2 to 11 are TRS/SUBD/ACC
137400040903     C                   If        *In88   =     *On
137500040903     C                   Movel     'I'           P11              11
137600040903     C                   Move      TSA@@         P11
137700040903     C*
137800040903     C                   IF        *InKU = *On
137900040915     C                   CALL      'TR121R'
138000040903     C                   PARM                    P11
138100040903     C                   SETON                                        12
138200160928
138300160928     C* check for longer names and highlight
138400160928     C     CFSKEY        Chain     CFS100P
138500160928     C                   if        %found(CFS100P)
138600160928     C                   eval      *in51 = *on
138700160928     C                   eval      *in52 = *on
138800160928     C                   end
138900160928
139000040903     C                   Leavesr
139100040903     C                   End
139200040901     C                   End
1393009102150783 C*
1394009102150784 C* IF CMD6 INITIATE REINSTATE ROUTINE IF STATUS IS CANCELLED
1395009910280785 C* ELSE IF NOT CANCELLED CMD6 IS NOT VALID
1396009910280785 C*
1397009102150786 C     SCHECK        IFEQ      'C'
139800041214
139900041214     c                   if        *inkf
140000041214     C                   SETON                                        17
140100041214      * retain cobra notification?
140200041214     c                   if        acobsrv = 'L'
140300041214     c                   eval      *in94 = *on
140400041217     c                   eval      retainc = ' '
140500041214     c                   else
140600041214     c                   eval      *in94 = *off
140700041214     c                   eval      retainc = 'N'
140800041214     c                   end
140900041214     C                   GOTO      #ENDM
141000041214     c                   end
141100041214
141200991028     C                   ELSE
1413009910282682 C   KF              Z-ADD     66            X                    50
1414009910282682 C   KF              SETON                                        12
141500991028     C   KF              GOTO      #ENDM
1416009102150789 C                   END
1417009102150790 C*
1418009102150791 C* IF CMD1 OR NOT ACTIVE EXIT WITH NO UPDATE
1419009102150792 C*
1420009102150793 C   KA              SETON                                        89
1421009109180794 C   KA              EXSR      #CLEAR
1422009109180795 C   KA              SETON                                        1130
1423009109180796 C   KA              GOTO      #ENDM
1424009102150797 C*
1425009102150798 C* IF CMD4 INITIATE TERMINATION ROUTINE IF STATUS IS ACTIVE
1426009911040785 C* ELSE IF CANCELLED CMD4 IS NOT VALID
1427009102150799 C*
1428009102150800 C     SCHECK        IFEQ      'A'
1429009102150801 C   KD              SETON                                        16
1430001606220801 C   KD              clear                   tcode
1431009102150802 C   KD              GOTO      #ENDM
143200991104     C                   ELSE
1433009911042682 C   KD              Z-ADD     67            X                    50
1434009911042682 C   KD              SETON                                        12
143500991104     C   KD              GOTO      #ENDM
1436009102150803 C                   END
1437009102150804 C*
1438009102150805 C* EXECUTE EDIT ROUTINE, REDISPLAY IF FAILED  - ELSE GO TO COVERAGE
1439009102150807 C*
1440000705250808 C                   EXSR      #EDIT
1441009102150809 C*
1442009102150810 C   50              SETON                                        12
1443009102150811 C   50              GOTO      #ENDM
1444009102150812 C*
1445009812020813 C* CHECK FOR CHANGE IF NOT ADD
1446009102150814 C*
1447009102150815 C                   MOVE      'NO '         CHANGE            3
1448000703140815 C                   MOVE      'NO '         CHANGE2b          3
1449000703140815 C                   MOVE      'NO '         CHANGE2d          3
1450001012150815 C                   MOVE      'NO '         CHANGE2e          3
1451000703140815 C                   MOVE      'NO '         CHANGEwosal       3
1452000811100815 C                   MOVE      'NO '         CHANGE2bwocc      3
1453000909180815 C                   MOVE      'NO '         CHANGE2lif        3
1454000909180815 C                   MOVE      'NO '         CHANGE2add        3
145500070314
145600070314     c                   if        *in41 = *off
1457000703140816 C     DS02A         IFNE      DS02AH
1458009102150817 C                   MOVE      'YES'         CHANGE
1459009102150818 C                   END
146000070314      * did something change other than salary?
146100070314      * 1. hold salary
146200070314      * 2. make salary the same in both data structures
146300070314      * 3. do compare again
146400070314      * 4. put salary back
146500070314     c                   move      f17           f17hold
146600070314     c                   move      salary        f17
1467000703140816 C                   if        ds02a <> ds02ah
1468000703140817 C                   MOVE      'YES'         CHANGEwosal
1469000703140818 C                   END
147000070314     c                   move      f17hold       f17
147100081110
1472000703140819 C     DS02B         IFNE      DS02BH
1473009102150820 C                   MOVE      'YES'         CHANGE
1474000703140820 C                   MOVE      'YES'         CHANGE2b
1475009102150821 C                   END
147600081110
147700081110      * did something change other than cost center?
147800081110      * 1. hold cost center
147900081110      * 2. make cost center the same in both data structures
148000081110      * 3. do compare again
148100081110      * 4. put cost center back
148200081110     c                   move      f41           f41hold
148300081110     c                   move      ccflg         f41
148400090921     c                   move      f39           f39hold
148500090921     c                   move      INLIF         f39
148600090921     c                   move      f40           f40hold
148700090921     c                   move      INADD         f40
1488000811100816 C                   if        ds02b <> ds02bh
1489000811100817 C                   MOVE      'YES'         CHANGE2bwocc
1490000811100818 C                   END
149100081110     c                   move      f41hold       f41
149200090921     c                   move      f40hold       f40
149300090921     c                   move      f39hold       f39
149400090918
149500070314     c                   end
149600070314
149700981216      * Reverse format of io02 dates
149800981216     C                   EXSR      #FLMBR
149900981216      *
1500009812020819 C  N41DS02D         IFNE      DS02DH
1501009812020820 C                   MOVE      'YES'         CHANGE
1502000703140820 C                   MOVE      'YES'         CHANGE2d
1503009812020821 C                   END
150400101215
1505001012150819 C  N41DS02E         IFNE      DS02EH
1506001012150820 C                   MOVE      'YES'         CHANGE
1507001012150820 C                   MOVE      'YES'         CHANGE2e
1508001012150821 C                   END
1509009102150823 C*
1510009105210823 C* WRITE HISTORY RECORDS FOR CHANGED FIELDS
1511009105210823 C*
1512000703140822 C     CHANGE        IFEQ      'YES'
151300910522     C                   MOVE      'N'           SKIP1             1
151400910522     C*
1515009105210877 C                   EXSR      #MCHNG
151600910522     C*
151700910522     C     SKIP1         IFEQ      'Y'
151800910522     C                   GOTO      #ENDM
151900910522     C                   END
1520001312130823 C*
1521009102150824 C* IF CHANGE IN DEMOGRAPHIC INFO. DETECTED, SPIN THRU MCOV FILE.
1522009102150825 C*      CHAIN PLNMST. GET CARRIER ID. CHAIN CARMST. IF TRANSMISSION
1523009102150826 C*      Y OR N ? = Y, CREATE A TRNMIT RECORD FOR PLAN.
1524009102150828 C*
1525009102150829 C                   SETOFF                                           60
1526009102150830 C     SSNO          SETLL     MCOV
1527009102150831 C     MRLOOP        TAG
1528009102150832 C                   MOVE      *BLANKS       CANFLG
1529009102150833 C*
1530009102150834 C     SSNO          READE     MCOV                                   60
153100140121     C   60              EXCEPT    relmcov
1532009102150835 C   60              GOTO      SKIPMR
1533009102150836 C*
1534009102150837 C     DLTC2         IFEQ      'D'
1535009102150838 C                   GOTO      MRLOOP
1536009102150839 C                   END
1537009102150840 C*
1538009904050841 C     CANDT         IFNE      0
153900981204y2k  C                   Z-ADD     CANDT         HCANDT            8 0
154000990115y2k  C                   Z-ADD     UDCYMD        HUDATE
154100981201      *
1542009812040844 C     HCANDT        IFLE      HUDATE
1543009102150845 C                   GOTO      MRLOOP
1544009102150846 C                   ELSE
1545009812040847 C                   Z-ADD     HCANDT        HCYMD
1546009102150848 C                   MOVE      'Y'           CANFLG            1
1547009102150849 C                   END
1548009102150850 C                   END
1549009102150851 C*
155000070314      * write trnmit rec for demographic change when something changes.
155100070314      *
155200081110      * skip trnmit if the only thing that changed was the salary or
155300081110      * cost center
155400070314     c                   if        changewosal = 'NO ' and
155500090918     c                             change2bwocc = 'NO ' and
155600101215     c                             change2d = 'NO ' and
155700101215     c                             change2e = 'NO '
1558000703140845 C                   GOTO      MRLOOP
155900070314     c                   end
156000111228
156100111228      * skip trnmit if something (demograph) changed and cov is termed past
156200111228      * Allow future terms
1563001112280841 C                   If        CANDT <> 0  and
1564001112280841 C                             CANDT <  LDADTE
1565001112280845 C                   Goto      MRLOOP
156600111228     c                   End
156700070314
1568009102150852 C     MPLKEY        CHAIN     PLNMST                             69
1569009102150853 C  N69PCARR         CHAIN     CARMST                             68
1570000304100854 C  N68TXMTYN        IFEQ      'Y'
1571009102150855 C                   MOVE      TRUST#        CTRUST
1572009102150856 C                   MOVE      SUB#          CSUB
1573009102150857 C                   MOVE      PLAN#         CPLAN
1574009102150858 C                   MOVE      AGEBND        CAGEBD
1575009102150859 C                   MOVE      COVTYP        CCOVTP
1576009102150861 C                   MOVE      RATE          HRATE            15
157700981204      *
1578009102150862 C     CANFLG        IFNE      'Y'
157900981201y2k  C                   Z-ADD     ASDT          HCYMD
1580009102150864 C                   END
1581009102150865 C*
1582009102150866 C                   EXSR      #GRATE
1583009102150867 C*
1584009602280867 C* IF NO RATE REC FOUND, USE ENROLLMENT DATE
1585009602280867 C*
1586009602280862 C     NOGRAT        IFEQ      'Y'
158700981214y2k  C                   Z-ADD     ENRLDT        HCYMD
1588009602280866 C                   EXSR      #GRATE
1589009602280864 C                   END
1590000305210867 C*
1591000305210867 C* IF NO RATE REC FOUND, USE today's date to find group #
1592000305210867 C*
1593000305210862 C     NOGRAT        IFEQ      'Y'
159400030521y2k  C                   Z-ADD     udcymd        HCYMD
1595000305210866 C                   EXSR      #GRATE
1596000305210864 C                   END
159700030521
1598009812010867 C* MDDATE/DS
159900981204y2k  C                   Z-ADD     LDADTE        MDDATE
160000981204y2k  C                   Z-ADD     01            MDDD
160100990128     C*
160200040528     C* coventry transmission needs EFFDT OF COVERAGE FOR DEMOGRAPHIC CHANGE
160300040528     C* put it in OENRDT field.
160400040528     C*
160500040528y2k  C                   Z-ADD     ENRLDT        oenrdtymd
160600040528     C*
160700081029      * Set defaults
160800081117     C                   Exsr      TRNCFS
160900081029
1610009102150870 C                   MOVE      'MD'          ACTCOD
1611001312120871 C                   EXCEPT    MADD1
161200040528     c                   clear                   oenrdtymd
1613009102150872 C                   END
161400070314
1615009102150873 C                   GOTO      MRLOOP
1616009102150874 C*
1617009102150875 C     SKIPMR        TAG
1618009102150876 C*
1619009102150878 C                   END
1620009102150879 C*
1621009102150880 C* EXECUTE ROUTINE TO FILL COVERAGE SCREEN
1622009102150881 C*
1623009102150882 C                   EXSR      #DSPMC
1624009102150883 C*
1625009102150884 C* GET TRUST TYPE CODE
1626009102150885 C*
1627009102150886 C     TRUST         CHAIN     TRSMST                             H4
162800130927
162900130927     c* put menrdt in hist rec effective date
163000130927y2k  C                   MOVE      MENRDT        ADDDT             8 0
163100130927
1632001309270889 C* 41 = SSN was not found (new member add)
1633001309270888 C* UPDATE MEMBER COUNT IN ACCMST#
1634001309270894 C* and write hist and member record for new member
163500130927     c                   if        *in41
1636001309270890 C     TSA           CHAIN     ACCMST#
163700130927     c                   if        %found(accmst#)
1638001309270891 C                   ADD       1             NOEMPL
1639001312120892 C                   EXCEPT    ACCU
164000130927     c                   end
1641001312120892 C                   EXCEPT    memberadd
164200130927     c                   exsr      #getsystime
1643001312120892 C                   EXCEPT    histmemadd
164400130927     c                   else
1645001309270894 C* *in41=off - just update member record
1646001312120892 C                   EXCEPT    memberup
164700140123
164800140123      * if there was a birth date change and the member has an aca plan
164900140123      * then write adjustments for all aca plans the member has (had to be
165000140123      * done here AFTER the member was updated.
165100140123
165200140123     c                   if        acabdaychg = 'Y'
165300140217     c                   clear                   acabdaychg
1654001401232987 C     SSNO          SETLL     MCOV
1655001401232988 C                   dou       %eof(mcov)
1656001401232989 C     SSNO          READE(n)  MCOV
165700140123     c                   if        not %eof(mcov) and candt = 0
1658001401232996 C     MPLKEY        CHAIN     PLNMST
165900140123     c                   if        %found(plnmst)
166000141110      * if individually rated aca plan write bday chg adjust rec
1661001411102996 C***  mcplankey     CHAIN     plnauxp
166200141110     c***                if        %found(plnauxp) and pxacar = 'Y'
166300141118     c                   clear                   acairat
166400141120
166500141120     c                   monitor
166600141118     c                   eval      acairat = #chk_aca_plan(trust#:sub#:plan#)
166700141120      * trap anything that goes wrong with the check aca function
166800141120     c                   on-error
166900141120      * error handling code here
167000141120     c                   endmon
167100141120
167200141118     c                   if        acairat = 'Y'
1673001401232975 C                   MOVE      'M10'         TRCODE
1674001401232977 C                   MOVE      plan#         mh1
1675001401232977 C                   MOVE      agebnd        mh2
1676001401232977 C                   MOVE      covtyp        mh3
1677001401232977 C                   clear                   mh4
1678001401232977 C                   move      *zeros        mh6
167900140123     C                   move      bchymdhold    TRANDT
168000140123     c                   eval      *in47 = *off
168100140123     c                   eval      *in46 = *off
168200140123     c                   eval      *in26 = *off
168300140123     c                   eval      *in25 = *off
168400140123     c                   exsr      #getsystime
168500140123      * adjust
168600140123     C                   EXSR      #hstadj
1687001402172975 C                   clear                   trcode
1688001402172975 C                   clear                   trandt
1689001402252975 C                   clear                   mh6
169000140123     c                   end
169100140123     c                   end
169200140123     c                   end
169300140123     c                   enddo
169400140123     c                   end
169500140123
169600140314     c                   end
169700220309      *
1698002203090895  * Call Member Extension Maintenance pgm
169900220309     C                   movel     trust         A73trst
170000220309     C                   movel     subno         A73sub#
170100220309     C                   movel     accno         A73acct
170200220309     C                   eval      A73ssno = ssno
170300220316     C                   eval      A73back = ' '
170400220809     C                   CALL      'GBS0073R'
170500220809     C****               CALL      'GBS0073RX'
170600220309     C                   PARM                    A73ssno
170700220309     C                   PARM                    lname
170800220309     C                   PARM                    fname
170900220309     C                   PARM                    mi
171000220309     C                   PARM                    A73tsa
171100220316     C                   PARM                    A73Back
171200220309
171300220316     c                   if        A73Back = 'Y'
171400220316     C                   EXSR      #RTRV
171500220316     C                   leavesr
171600220316     c                   end
171700220316     C*
171800130927
1719001309270895 C* seton 13 to display next (MCOV) screen IO03
1720009102150896 C                   SETON                                        3113
172100130520
1722001305201125 C* CLEAR MCOV ENTRY SCREEN FIELDS
172300130520     c                   exsr      #clrio03
172400130520
172500990128y2k  C     #ENDM         TAG
172600990128     C  N50
172700990128     CANNKD
172800990128     CANNKF              EXSR      #KIMBR
172900990203     C*
173000990203     C* BECAUSE OF SAL CHG AND BDAY CHG NEEDING TO DISPLAY WARNING
173100990203     C* MESSAGES ON THE NEXT SCREEN (IO03) IND. 50 WAS SET ON.
173200990203     C* BUT THAT CAUSED #KIMBR NOT TO BE EXECUTED. SINCE IT IS
173300990203     C* JUST A WARNING MESSAGE FOR THE NEXT SCREEN, "ER50" WILL BE
173400990203     C* USED TO BYPASS THE "N50" CONDITION INSTEAD OF SETTING ON 50
173500990203     C* BACK IN SUBROUTINE #MCHNG
173600990203     C*
173700990203     C     ER50          IFEQ      'Y'
173800990203     C                   SETON                                        50
173900990203     C                   MOVE      'N'           ER50
174000990203     C                   END
174100990203     C*
174200990128y2k  C                   ENDSR
1743009102150899 C/EJECT
1744009102150900 C****************************************************************
1745009102150902 C*----------------------- MEMBER COVERAGE ----------------------*
1746009102150903 C*
1747009901130904 C     #MEMC         BEGSR
1748009102150905 C*
1749009102150906 C* EXIT IF CMD 1  AND NO ACTION CODE INPUT
1750009102150907 C*
1751000002180908 C* IF ANY NON-INDIVIDAUL COVERAGE TYPES ENTERED DISPLAY DEPENDENT SCR
1752009102150909 C*       ELSE DISPLAY FIRST SCREEN
1753009102150910 C*
1754009102150911 C                   MOVE      *BLANKS       DS04A
1755009102150912 C                   MOVE      *BLANKS       DS04B
175600981207y2k  C                   MOVE      *BLANKS       DS04D
175700110719y2k  C                   MOVE      *BLANKS       DS04E
1758009102150913 C                   MOVE      *BLANKS       DRELCD
175900010226     C                   Z-add     *Zeros        DBIRTH
176000010226     C                   Z-add     *Zeros        DMEDAD
176100010226     C                   Z-add     *Zeros        DMEDBD
176200010226     C                   Z-add     *Zeros        DHDDT
176300010226     C                   Z-add     *Zeros        Dzip
176400010226     C                   Z-add     *Zeros        Darea
176500010226     C                   Z-add     *Zeros        Dphone
176600010226     C                   Z-add     *Zeros        Depss#
176700140627     C                   clear                   l#_hold
1768009102150914 C*
1769000204190914
1770000902040914 C* F1 - continue (action code blank)
1771000902040915 C                   if        *inka and sactcd = ' '
1772009102150919 C                   SETOFF                                       43  89
1773009102150920 C     SSNO          SETLL     DEPEND
1774009710090921 C     SSNO          READE     DEPEND                                 43
177500110719      * depend not found
177600110719     c                   if        *in43 = *on
1777001107190922 C                   Z-ADD     0             DSEQ#
1778001107190923 C                   MOVE      'N'           DCOB
1779001107190924 C                   MOVE      'N'           DCOBBC
1780001107190925 C                   MOVE      ' '           DHNDCP
1781001107190926 C                   MOVE      'N'           DMEDCR
1782001107190927 C                   MOVE      'N'           DSTUDN
178300110719     c                   clear                   d2email
178400131212     C                   EXCEPT    RELDEP
178500110719     c                   else
178600110719      * depend was found
1787001107190928 C                   MOVE      DRELCD        DRELC2
1788001107190929 C                   MOVE      DS04A         DS04AH
1789001107190930 C                   MOVE      DS04B         DS04BH
179000110719y2k  C                   MOVE      DS04D         DS04DH
1791001107190931 C     DLTC3         IFNE      'A'
1792009102150932 C                   SETON                                        5089
1793009102150933 C                   Z-ADD     27            X
1794009102150934 C                   END
179500110719      * get depend2 record
179600110719     c                   move      ssno          d2keyssn
179700110719     c                   move      dseq#         d2keyseq
179800110719     c     d2key         chain     depend2
179900110719     c                   if        not %found(depend2)
180000110719     c                   clear                   d2email
1801001107190934 C                   end
180200110720y2k  C                   MOVE      DS04E         DS04EH
180300110719
1804001107190934 C                   end
180500160720
180600160720     C* check for longer names and highlight
180700160720     c                   move      dseq#         CFSEQ
180800160720     C     CFSKEY        Chain     CFS100P
180900160720     C                   if        %found(CFS100P)
181000160720     C                   eval      *in52 = *on
181100160720     C                   eval      *in53 = *on
181200160720     C                   end
1813009710090537 C*
1814000210170537 C* IF PCPYN = 'Y' GO TO PCP SUBROUTINE
1815009710090537 C*
181600021017     C     PCPYN         IFEQ      'Y'
181700020318     C                   EXSR      #PCP
181800971009     C                   END
181900090204
1820000902110537  * if a debit card plan was added, then
1821000902110537  * add the member to the debit card file
182200100527     c                   if        debitcard <> ' ' and debitcard <> 'N'
182300090211     c     debkey        chain     debcard
182400090211      * reactivate
182500090211     c                   if        %found(debcard)
182600110316     c                   move      *date         dbtrdat
182700110316     c                   time                    dbtrtim
182800130927     c                   movel     luser         dbuser
182900090211     c                   clear                   dbprsta
183000090211     c                   clear                   dbprdat
183100090211     c                   clear                   dbprtim
183200090211     c                   update    debcardr
183300090211     c                   else
183400090211      * add debcard rec
183500090211     c                   clear                   debcardr
183600090211     c                   move      ssno          dbssn
183700090211     c                   move      *zeros        dbseq
183800090211     c                   move      *date         dbtrdat
183900090211     c                   time                    dbtrtim
184000130927     c                   movel     luser         dbuser
184100100527     c                   move      debitcard     dbdeliv
184200090211     c                   write     debcardr
184300090211     c                   end
184400090211     c                   clear                   debitcard
184500090204     c                   end
184600090204
184700981222y2k   * Reverse format of file dates for display
184800981230Y2K  C   40
184900981230y2k  CORN43              EXSR      #KIDEP
1850009812220935 C   40
1851001107190936 CORN43              SETON                                        14
1852009812220937 C  N14              SETON                                        11
1853009102150938 C*
1854009102150939 C                   GOTO      #ENDMC
1855009102150940 C                   END
1856009102150941 C*
185700910821     C*   ROLL MEMBER'S COVERAGES..........
185800910821     C*
185900910821     C   KE              EXSR      #DSPMC
186000910821     C   KE              SETON                                        13
186100910821     C   KE              GOTO      #ENDMC
186200910821     C*
1863000606300942 C* F8 - DISPLAY plans IF REQUESTED THEN EXIT
1864009102150943 C*
186500110325      * screen input enroll date to YMD
186600110325y2k  C                   MOVE      SENRLD        MDCY#
186700110325y2k  C                   EXSR      #CYMD8
186800110325y2k  C                   MOVEL     CYMD#         senrldymd         8 0
186900110325
187000060630     c                   if        *inkh
187100060630     c                   move      tsa           fm072parm        10
187200110325     c                   move      senrldymd     fm072parm2        8
187300060630     c                   call      'FM072'
187400060630     c                   parm                    fm072parm
187500110325     c                   parm                    fm072parm2
1876000606301010 C                   SETON                                        13
1877000606301011 C                   GOTO      #ENDMC
187800060630     c                   end
187900101221     C*
1880001012210942 C* F9 - DISPLAY coverage types IF REQUESTED THEN EXIT
1881001012210943 C* the field pos071parm is the start position of the window (across)
1882001012210943 C* FM071B is the 132 column version of FM071
1883001012210943 C*
188400101221     c                   if        *inki
188500101221     c                   move      'T'           fm071parm
188600101221     c                   move      085           pos071parm        3
188700101221     c                   call      'FM071B'
188800101221     c                   parm                    fm071parm
188900101221     c                   parm                    pos071parm
1890001012211010 C                   SETON                                        13
1891001012211011 C                   GOTO      #ENDMC
189200101221     c                   end
189300060630
189400110727     C*
1895001108050943 C* 7/27/11
1896001607060942 C* F12- DISPLAY term codes IF REQUESTED THEN EXIT
1897001107270943 C* the field pos071parm is the start position of the window (across)
1898001107270943 C* FM071B is the 132 column version of FM071
1899001108050943 C* 8/5/11 - admin did not like this because it shows too many codes
1900001108050943 C*          that are not applicable to member coverage term so it
1901001108050943 C*          was removed before it went live.
1902001606210943 C* 06/21/16 - now that we can exclude acct level term codes this
1903001606210943 C*            window can be put back
190400160706     c                   if        *inkl
190500160621     c                   move      'D'           fm071parm
190600160621     c                   move      085           pos071parm        3
190700160621     c                   call      'FM071B'
190800160621     c                   parm                    fm071parm
190900160621     c                   parm                    pos071parm
1910001606211010 C                   SETON                                        13
1911001606211011 C                   GOTO      #ENDMC
191200160621     c                   end
191300110727
191400140411     C*
1915001404110943 C* 4/11/14
1916001404110942 C* F10- call Tobacco file maintenance program for member
191700140411     c                   if        *inkj
191800140411     c                   move      ssno          fm410parm1        9
191900140411     c                   move      '00'          fm410parm2        2
192000140411     c                   call      'FM410CL'
192100140411     c                   parm                    fm410parm1
192200140411     c                   parm                    fm410parm2
1923001404111010 C                   SETON                                        13
1924001404111011 C                   GOTO      #ENDMC
192500140411     c                   end
192600140411
1927009102150952 C*
1928009102150953 C* EDIT TYPE ACTION ENTRY
1929009102150954 C*
193000910919     C   89SACTCD        IFNE      'C'
193100910919     C                   Z-ADD     46            X                    50
193200910919     C                   GOTO      #ERRCN
193300910919     C                   END
193400910919     C*
193500131206     C                   IF        SACTCD <> 'A' AND SACTCD <> 'C' AND
193600131206     C                             SACTCD <> 'T' AND SACTCD <> 'R'
1937009102150959 C                   Z-ADD     19            X                    50
1938009102150960 C                   SETON                                        55
1939001312060961 C                   ENDIF
1940009102150965 C*
1941009102150966 C     SACTCD        IFEQ      'A'
1942009102150967 C     L#            IFNE      0
1943009102150968 C                   Z-ADD     20            X                    50
1944009102150969 C                   SETON                                        56
1945009102150970 C                   END
194600981207      * As of Date
1947009812070971 C     ASOFDT        IFNE      0
1948009102150972 C                   Z-ADD     25            X                    50
1949009102150973 C                   SETON                                        57
1950009102150974 C                   END
1951009102150975 C                   END
1952009102150976 C*
1953002210230976 C* do not allow line # > 990
1954002210230976 C*
1955009102150977 C     SACTCD        IFNE      'A'
1956002210230978 C     L#            IFGT      990
1957009110110979 C                   Z-ADD     20            X                    50
1958009110110980 C                   SETON                                        56
1959009110110981 C                   ELSE
1960009102150982 C     L#            IFLT      1
1961009102150983 C                   Z-ADD     20            X                    50
1962009102150984 C                   SETON                                        56
1963009102150985 C**
1964009102150986 C     SACTCD        IFEQ      'C'
1965009812070987 C     ASOFDT        IFGT      *ZEROS
1966009812070988 C     SENRLD        IFGT      *ZEROS
1967009102150989 C                   Z-ADD     28            X                    50
1968009102150990 C                   END
1969009102150991 C                   END
1970009102150992 C                   END
1971009110110994 C                   END
1972009102150995 C                   END
1973009102150996 C*
1974009812070997 C                   Z-ADD     ASOFDT        DATECK
1975009102150998 C                   EXSR      #DATCK
1976009102150999 C   98              Z-ADD     25            X                    50
1977009102151000 C   98              SETON                                        57
197800140627
197900140627      * convert the line # entered to the line # for this screen and hold
198000140627      * the original line # to put back on the screen if an error occurs
198100221019     c                   z-add     L#            L#_hold           3 0
198200140627     c                   if        not *in50
198300221019     C     L2#           IFNE      *ZEROS
198400221019     C     L2#           MULT      10            HL2#              3 0
198500221019     C     L#            SUB       HL2#          L#
198600911011     C                   END
1987001406271002 C     L#            IFEQ      0
1988009411231003 C                   Z-ADD     10            L#
1989009102151006 C                   END
199000140627     c                   end
199100140627
1992009411231006 C                   END
199300030611
199400060413      * term code valid for term or chg candt
199500060413     c                   if        trmrcd <> *blanks
199600060413     c                   if        sactcd = 'T' or
199700060413     c                             (sactcd = 'C' and scand1 <> *zeros)
199800060413      * ok
199900060413     c                   else
200000060413     C                   Z-ADD     78            X                    50
200100060413     C                   SETON                                        58
200200060413     c                   end
200300060413     c                   end
200400060413
2005000604130986 C**                 IF        SACTCD <> 'T' AND TRMRCD <> *BLANKS
200600060413     C**                 Z-ADD     78            X                    50
200700060413     C**                 SETON                                        58
200800060413     C**                 ENDIF
200900030611
2010009102151007 C*
2011009102151008 C* EXIT IF SELECTIONS ARE WRONG
2012009102151009 C*
201300910919     C     #ERRCN        TAG
201400910919     C*
2015009102151010 C   50              SETON                                        13
2016009102151011 C   50              GOTO      #ENDMC
2017009102151012 C*
2018009102151013 C* PROCESS TERMINATION  * * * * * * * * * * * * * * * * * * * * * *
2019009102151014 C*
2020009102151015 C     SACTCD        IFEQ      'T'
2021009102151016 C*
2022009204021017 C* VALIDATE ALL FIELDS BLANK EXCEPT AS OF DATE
2023009102151018 C*
202400131213     C                   IF        (SPLAN# <> *BLANKS AND SPLAN# <> '0000') OR
202500131213     C                             SCVTYP <> *BLANKS OR SBENAM <> *ZEROS OR
202600131213     C                             SENRLD <> *ZEROS OR SCAND1 <> *ZEROS
2027001312131156 C                   Z-ADD     21            X                    50
2028001312131157 C                   END
202900910829     C*
203000910829     C*  CANCELLATION DATE CANNOT BE LESS THAN ENROLL DATE......
203100981207      *
203200981207y2k  C                   MOVE      ASOFDT        MDCY#
203300981207y2k  C                   EXSR      #CYMD8
203400981207y2k  C                   MOVEL     CYMD#         HASOFD            8 0
203500981207      *
203600981207y2k  C                   MOVE      ED(L#)        MDCY#
203700981207y2k  C                   EXSR      #CYMD8
203800981207y2k  C                   MOVEL     CYMD#         HED               8 0
203900981207      *
204000910829     C     HASOFD        IFLT      HED
204100910829     C                   Z-ADD     41            X                    50
204200910829     C                   END
2043009102151035 C* CHAIN TO MCOV
2044009102151037 C                   Z-ADD     SSNO          CSSNO
2045009102151038 C                   Z-ADD     00            CSEQ#
2046009102151039 C                   Z-ADD     TR#SUB        CTRSUB
2047009102151040 C                   MOVEL     TR#SUB        CTRUST
2048009102151041 C                   MOVE      TR#SUB        CSUB
2049009102151042 C                   MOVE      ED(L#)        CEFFDT
205000981207     C                   MOVE      TD(L#)        CCANDT
2051009102151043 C                   MOVE      P#(L#)        CPLAN
2052009102151044 C                   MOVE      AB(L#)        CAGEBD
205300910911     C                   MOVE      BA(L#)        CBENAM
2054009102151045 C                   MOVE      CT(L#)        CCOVTP
2055009102151046 C                   MOVEL     'T'           CCOVTP
205600020419     C*
205700020517     C* Move last termed carrier code to TCARR.  To be used in conjuction w/PCP
205800021017     C* Move value in PCP_REQ of last termed plan to TPCPR.  To be used in conju
205900020517     C*
2060000204191200 C     TKEY          CHAIN     PLNMST                             85
206100020419     C                   IF        *IN85 = *OFF
206200021017     C*                  MOVE      PCARR         TCARR
206300021017     C                   MOVE      PCP_REQ       TPCPR
206400020419     C                   ELSE
206500021017     C*                  MOVE      *BLANKS       TCARR
206600021017     C                   MOVE      *BLANK        TPCPR
206700020419     C                   ENDIF
206800030611     C
206900030611     C     PCARR         CHAIN     CARMST                             86
207000030611     C                   IF        *IN86 = *OFF
207100030611     C                   IF        CARBC = '1' OR CARBC = '2' OR
207200030613     C                             CARBC = '3' OR CARBC = '4' OR
207300030613     C                             CARBC = 'D'
207400160621
207500160621      * valid member level term code required for Care First plans
207600030611     C                   IF        TRMRCD = *BLANKS
207700030611     C                   Z-ADD     77            X                    50
207800030611     C                   SETON                                        58
207900030611     C                   ELSE
208000030611     C                   MOVEL     'D'           CDTYPE
208100030611     C                   MOVE      TRMRCD        CDKEY
208200030611     C     CDKEY         CHAIN     CODES                              58
208300160621     c                   if        *in58 = *on or dltc6 <> 'A' or
208400160621     c                             actn2 = 'A'
208500160621     C                   Z-ADD     77            X                    50
208600160621     C                   end
208700160621     C                   ENDIF
208800160621
208900030611     C                   ELSE
209000030611     C                   IF        TRMRCD <> *BLANKS
209100030611     C                   Z-ADD     78            X                    50
209200030611     C                   SETON                                        58
209300030611     C                   ENDIF
209400030611     C                   ENDIF
209500030611     C                   ENDIF
209600921023     C*
209700060412     C* VERIFY A GRATE RECORD EXISTS BECAUSE TRNMIT NEEDS THE GROUP#
209800921023     C*
209900981207y2k  C                   Z-ADD     HASOFD        HCYMD
2100009812071212 C                   MOVE      RATE          HRATE
2101009210231213 C                   EXSR      #GRATE
210200131206      *
210300060412      * IF NO GRATE FOUND FOR CANCEL DATE USE (CANCEL DATE - 1 MONTH)
210400060412      * TO TRY AGAIN
210500110726     C                   if        nograt = 'Y'
210600110726     C                   move      hcymd         holdhcymd         8 0
210700110726     C                   move      hcymd         workdt
210800110726     C                   subdur    1:*m          workdt
210900110726     C                   move      workdt        hcymd
211000110726     C                   EXSR      #GRATE
211100110726     C                   move      holdhcymd     hcymd
211200110726     C                   END
211300131206      *
211400060412     C* IF STILL NO RATE - ERROR
211500921023     C     NOGRAT        IFEQ      'Y'
211600921023     C                   Z-ADD     59            X                    50
211700921023     C                   END
211800131206      *
211900110726      * warning message if no rates for this effdt and it is more than
212000110726      * 60 days in the future. Press F11 to skip this edit.
212100110726     c                   exsr      #chk60derr
212200921023     C*
2123009102151050 C* CAN NOT TERMINATE PLAN THAT IS NOT ACTIVE
2124009102151051 C*
2125009109131052 C     DC(L#)        IFEQ      'A'
2126009102151053 C                   GOTO      #ERRSK
2127009102151054 C                   END
2128009102151055 C*
2129009102151056 C                   Z-ADD     23            X                    50
213000221023
213100221023     C*
2132002210231050 C* can not change line without a plan
2133002210231051 C*
2134002210231052 C                   if        p#(l#) = *blanks
2135002210231056 C                   Z-ADD     20            X                    50
213600221023     c                   end
213700221023
213800221023
2139009102151057 C     #ERRSK        TAG
2140009102151058 C*
2141009102151059 C* EXIT IF ERROR
2142009102151060 C*
214300100716     c                   if        *in50
2144001007161061 C                   SETON                                        13
2145001007161062 C                   GOTO      #ENDMC
214600100716     c                   end
2147009102151063 C*
2148009109131064 C                   MOVE      BA(L#)        CBENAM            7 0
2149009602281068 C                   MOVE      RATE          HRATE
215000960228     C*
215100960228     C* GET MCOV REC FOR UPDATE
215200960228     C*
215300910913     C                   EXSR      #READU
215400981207      *
215500981207y2k  C                   MOVE      ASOFDT        MDCY#
215600981207y2k  C                   EXSR      #CYMD8
215700981207y2k  C                   MOVEL     CYMD#         CCANDT            8 0
215800981207      *
2159009109131088 C                   MOVE      'C'           DLTC1
216000981125y2k  C                   MOVEL     CTRSUB        PLKEY            10
2161009511011077 C                   MOVE      CPLAN         PLKEY
216200981207      *
2163009602281078 C     PLKEY         CHAIN     PLNMST                             69
2164009602281079 C  N69PCARR         CHAIN     CARMST                             68
2165009102151071 C*
2166009602281072 C* IF TXMTYN = Y ,CREATE "MT"(MEMBER TERMINATION) TRNMIT RECORD
2167009602281071 C*
216800981207y2k  C                   MOVE      CEFFDT        MDCY#
216900981207y2k  C                   EXSR      #CYMD8
217000981207y2k  C                   MOVEL     CYMD#         CEFFDT
217100981207      *
217200951101     C  N68
2173009511011080 CANN69TXMTYN        IFEQ      'Y'
217400981207y2k  C                   Z-ADD     CCANDT        HCYMD
2175009602281069 C                   EXSR      #GRATE
217600060412
217700060412      * IF NO GRATE FOUND FOR CANCEL DATE USE (CANCEL DATE - 1 MONTH)
217800060412      * TO TRY AGAIN
217900060412     C                   if        nograt = 'Y'
218000080108     C                   move      hcymd         holdhcymd         8 0
218100060412     C                   move      hcymd         workdt
218200060412     C                   subdur    1:*m          workdt
218300060412     C                   move      workdt        hcymd
218400060412     C                   EXSR      #GRATE
218500080108     C                   move      holdhcymd     hcymd
218600060412     C                   END
218700060412
218800081117      * Set defaults
218900081117     C                   Exsr      TRNCFS
2190009102151081 C                   MOVE      'MT'          ACTCOD            2
2191000306112557 C                   MOVE      TRMRCD        HTCODE
2192001312121082 C                   EXCEPT    MCADD1
2193009102151083 C                   END
2194009102151084 C*
2195009812071094 C* UPDATE MCOV (ceffdt ccandt)
219600981207      *
219700131210    ***
219800140126     C                   EXCEPT    #UPMCV
2199009102151093 C*
2200001401211094 C* write HISTORY
2201009102151095 C*
220200990126     C                   Z-ADD     HASOFD        TRANDT
2203009902041097 C                   MOVE      P#(L#)        MH1               4
2204009102151098 C                   MOVE      AB(L#)        MH2               2 0
2205009102151099 C                   MOVE      CT(L#)        MH3               2
2206009902031100 C                   MOVE      BA(L#)        MH4               8
2207009102151101 C                   MOVE      'MDC'         TRCODE
220800030624     C                   IF        TRMRCD <> *BLANKS
220900030624
221000030624     C                   MOVEL     'TC='         TC                5
221100030624     C                   CAT       TRMRCD:0      TC
221200030624
221300030624     C                   ENDIF
221400981207      *
2215009902031102 C     BA(L#)        IFNE      0
2216009102151103 C                   SETON                                        46
221700910909     C                   ELSE
221800910909     C                   MOVE      *BLANKS       MH4
2219009102151104 C                   END
222000140121
222100130927     c                   exsr      #getsystime
222200140121      * adjust
222300140121     C                   EXSR      #hstadj
222400140121      * write hist
2225001401211106 C                   EXCEPT    histcov
2226001401211107 C                   SETOFF                                       46
2227009102151108 C*
2228000002181109 C* LOOP AND TERMINATE DEPENDENT COVERAGE
2229009102151110 C*
2230009102151111 C                   SETOFF                                       98
2231009102151112 C     SSNO          SETLL     DCOV
2232009102151113 C     #LMC03        TAG
2233009102151114 C     SSNO          READE     DCOV                                   98
223400140121     C   98              EXCEPT    reldcov
2235009102151115 C   98              GOTO      #TMC04
223600131212     C                   IF        DLTC5 = 'A' AND PLAN# = DPLAN#
223700990208y2k  C                   Z-ADD     HASOFD        DCANDT
223800011102     C                   MOVE      PLAN#         MH1
223900011102     C                   MOVE      'MDD'         TRCODE
224000011102     C                   MOVE      DSEQ#C        MH5               2
224100140122     C                   SETON                                          4725
224200140122      * cancel dcov
2243001401221    C                   EXCEPT    candcv
224400140122
224500140121     c                   exsr      #getsystime
224600140121      * adjust
224700140121     C                   EXSR      #hstadj
224800140121      * write hist
2249001401211    C                   EXCEPT    histcov
2250001401211    C                   SETOFF                                         4725
225100140121     C                   end
225200140121
2253009102151122 C                   GOTO      #LMC03
2254009102151123 C     #TMC04        TAG
2255001305201124
2256001305201125 C* CLEAR MCOV ENTRY SCREEN FIELDS
225700130520     c                   exsr      #clrio03
225800130520
2259009102151135 C                   END
2260009102151136 C*
2261009102151137 C* PROCESS REINSTATEMENT  * * * * * * * * * * * * * * * * * * * * *
2262009102151138 C*
2263009102151139 C     SACTCD        IFEQ      'R'
2264009102151140 C*
2265009102151141 C* VALIDATE ALL FIELDS BLANK EXCEPT EFFECTIVE DATE
2266009102151142 C*
226700131212     C                   IF        (SPLAN# <> *BLANKS AND SPLAN# <> '0000') OR
226800131212     C                             SCVTYP <> *BLANKS OR SBENAM <> *ZEROS OR
226900131212     C                             SENRLD <> *ZEROS OR SCAND1 <> *ZEROS
2270009204021156 C                   Z-ADD     21            X                    50
2271009204021157 C                   END
2272009102151158 C*
2273009204021159 C* VALIDATE EFFECTIVE DATE - MUST EQUAL CANCEL DATE TO REINSTATE
2274009102151160 C*
2275009812071161 C                   Z-ADD     ASOFDT        DATECK
2276009102151162 C                   EXSR      #DATCK
2277009102151163 C   98              Z-ADD     4             X                    50
2278009102151164 C*
227900981207     C     ASOFDT        IFNE      TD(L#)
228000920402     C                   Z-ADD     47            X                    50
228100911001     C                   END
2282009102151166 C*
2283009102151167 C                   Z-ADD     SSNO          CSSNO
2284009102151168 C                   Z-ADD     00            CSEQ#
2285009102151169 C                   Z-ADD     TR#SUB        CTRSUB
2286009102151170 C                   MOVEL     TR#SUB        CTRUST
2287009102151171 C                   MOVE      TR#SUB        CSUB
2288009102151172 C                   MOVE      P#(L#)        CPLAN
2289009102151173 C                   MOVE      AB(L#)        CAGEBD
229000981207      *
229100981207y2k  C                   MOVE      ED(L#)        MDCY#
229200981207y2k  C                   EXSR      #CYMD8
229300981207y2k  C                   MOVEL     CYMD#         CEFFDT
229400981223      *
229500981207y2k  C                   MOVE      TD(L#)        MDCY#
229600981207y2k  C                   EXSR      #CYMD8
229700981207y2k  C                   MOVEL     CYMD#         CCANDT
229800981207      *
229900910911     C                   MOVE      BA(L#)        CBENAM
2300009102151174 C                   MOVE      CT(L#)        CCOVTP
2301009102151175 C                   MOVEL     'T'           CCOVTP
2302009102151178 C*
2303009102151179 C* CAN NOT REINSTATE PLAN THAT IS ACTIVE
2304009102151180 C*
2305009109131181 C     DC(L#)        IFEQ      'A'
2306009102151182 C                   Z-ADD     26            X                    50
2307009102151183 C                   END
2308009102151184 C*
2309009102151185 C* CAN NOT REINSTATE PLAN THAT IS ACTIVE  (COBRA)
2310009102151186 C*
231100921020     C* CANNOT REINSTATE COVERAGE IF NO GRATE FOUND FOR PLAN/AS OF DATE
2312009102151187 C*
231300981207y2k  C                   MOVE      ASOFDT        MDCY#
231400981207y2k  C                   EXSR      #CYMD8
231500981207y2k  C                   MOVEL     CYMD#         HCYMD
231600981207      *
2317009210201212 C                   MOVE      RATE          HRATE
2318009210201213 C                   EXSR      #GRATE
231900060413
232000060413      * IF NO GRATE FOUND FOR as of DATE USE (as of DATE - 1 MONTH)
232100060413      * TO TRY AGAIN
232200060413     C                   if        nograt = 'Y'
232300080108     C                   move      hcymd         holdhcymd         8 0
232400080108     C                   move      hcymd         workdt
232500060413     C                   subdur    1:*m          workdt
232600060413     C                   move      workdt        hcymd
232700060413     C                   EXSR      #GRATE
232800080108     C                   move      holdhcymd     hcymd
232900060413     C                   END
233000060413
2331009210191214 C*
233200921020     C     NOGRAT        IFEQ      'Y'
233300921020     C                   Z-ADD     58            X                    50
233400921020     C                   END
233500110726
233600110726      * warning message if no rates for this effdt and it is more than
233700110726      * 60 days in the future. Press F11 to skip this edit.
233800110726     c                   exsr      #chk60derr
233900110726
234000100715     C*
234100100715     C*  EDIT AGAINST HAVING TWO ACTIVE PLANS WITH SAME PLAN CATEGORY CODE
234200100715     C*
2343001007151170 C                   MOVEL     TR#SUB        plan
2344001007151172 C                   MOVE      P#(L#)        plan
2345001007151275 C     PLAN          CHAIN     PLNMST
234600100715     c                   if        %found(plnmst)
234700100715     C     PLNCAT        LOOKUP    PCT                                    98
234800100715     C   98              Z-ADD     50            X                    50
234900100715     c                   end
235000221023     C*
2351002210231050 C* can not change line without a plan
2352002210231051 C*
2353002210231052 C                   if        p#(l#) = *blanks
2354002210231056 C                   Z-ADD     20            X                    50
235500221023     c                   end
235600100715
235700921019     C*
2358009102151188 C* EXIT IF ERROR
2359009102151189 C*
236000100716     c                   if        *in50
2361001007161190 C                   SETON                                        13
2362001007161191 C                   GOTO      #ENDMC
236300100716     c                   end
2364009207141192 C*
2365009905061193 C* PREPARE TRNMIT / MCOV FIELDS FOR UPDATE
2366009905061192 C*
2367000405281192  * hold effdt for trnmit
236800040528y2k  C                   MOVE      ceffdt        oenrdtymd         8 0
236900981207y2k  C                   Z-ADD     HCYMD         CEFFDT
2370009102151196 C                   MOVE      *ZEROS        CCANDT
2371009109241197 C                   MOVE      BA(L#)        CBENAM
2372009102151198 C                   MOVEL     CTRSUB        PLNKEY           10
2373009102151199 C                   MOVE      CPLAN         PLNKEY
2374009102151200 C     PLNKEY        CHAIN     PLNMST                             98
2375009102151201 C                   MOVE      'A'           DLTC1
2376009102151202 C*
2377009102151203 C*    IF TXMTYN(CARMST) = Y, CREATE "MR"(MEMBER REINSTATEMENT) TRNMITRECORD
2378009102151207 C*
2379009102151208 C     PCARR         CHAIN     CARMST                             69
2380009102151209 C  N69TXMTYN        IFEQ      'Y'
2381009102151210 C                   MOVE      'MR'          ACTCOD            2
2382009102151212 C                   MOVE      RATE          HRATE
2383009102151213 C                   EXSR      #GRATE
238400060413
238500060413      * IF NO GRATE FOUND FOR as of DATE USE (as of DATE - 1 MONTH)
238600060413      * TO TRY AGAIN
238700060413     C                   if        nograt = 'Y'
238800080108     C                   move      hcymd         holdhcymd         8 0
238900060413     C                   move      hcymd         workdt
239000060413     C                   subdur    1:*m          workdt
239100060413     C                   move      workdt        hcymd
239200060413     C                   EXSR      #GRATE
239300080108     C                   move      holdhcymd     hcymd
239400060413     C                   END
239500060413
239600081117      * Set defaults
239700081117     C                   Exsr      TRNCFS
239800081029
2399001312121215 C                   EXCEPT    MCADD1
2400009102151216 C                   END
240100111024
240200111024      * Check for Payroll Account Create Payroll Deductions (Reinstate Only)
2403001110241139 C     SACTCD        IFEQ      'R'
240400111024     C                   Eval      PaySSN = CSSNO
240500111024     C                   Eval      PayPLN = CPLAN
240600111024     C                   Eval      PayEFF = CEFFDT
240700111024     C                   EXSR      CREATE_PAYDED
240800111024     C                   End
240900040528
241000040528     c                   clear                   oenrdtymd
241100990506     C*
2412009105081217 C* UPDATE MCOV
241300990506     C*
241400990506     C* PUT ORIG EFFDT BACK FOR MCOV UPDATE
241500990506     C*
241600990506y2k  C                   MOVE      ED(L#)        MDCY#
241700990506y2k  C                   EXSR      #CYMD8
241800990506y2k  C                   MOVEL     CYMD#         CEFFDT
241900990506     C*
242000910913     C                   EXSR      #READU
2421009109131088 C                   MOVE      'A'           DLTC1
242200140126     C                   EXCEPT    #UPMCV
242300131213    ***
2424009102151222 C* UPDATE HISTORY
242500981207y2k  C                   Z-ADD     HCYMD         TRANDT
2426009102151225 C                   MOVE      P#(L#)        MH1
2427009102151226 C                   MOVE      AB(L#)        MH2
2428009102151227 C                   MOVE      CT(L#)        MH3
2429009102151228 C                   MOVE      'MRC'         TRCODE
2430009102151229 C                   MOVE      BENAMT        MH4
2431009902031230 C     BENAMT        IFNE      0
2432009102151231 C                   SETON                                            46
243300910909     C                   ELSE
243400910909     C                   MOVE      *BLANKS       MH4
2435009102151232 C                   END
2436009102151233 C*
243700130927     c                   exsr      #getsystime
243800140121      * adjust
243900140121     C                   EXSR      #hstadj
244000220413       exsr writeReinstate;
244100140121      * write hist
2442001401211235 C                   EXCEPT    histcov
2443001401211236 C                   SETOFF                                           46
244400220412
2445009102151237 C*
2446001305201125 C* CLEAR MCOV ENTRY SCREEN FIELDS
244700130520     c                   exsr      #clrio03
244800130520
2449009102151248 C                   END
2450009102151249 C*
2451009102151250 C* PROCESS ADDITION * * * * * * * * * * * * * * * * * * * * * * * *
2452009102151251 C*
2453009102151252 C     SACTCD        IFEQ      'A'
2454009102151253 C*
2455009102151254 C* VALIDATE EFFECTIVE DATE
2456009102151255 C*
2457009102151256 C                   Z-ADD     SENRLD        DATECK
2458009102151257 C                   EXSR      #DATCK
2459009902101258 C   98              SETON                                        5313
2460009102151259 C   98              Z-ADD     4             X                    50
246100990209     C   98              GOTO      #ENDMC
2462009102151260 C*
246300981207y2k  C                   MOVE      SENRLD        MDCY#
246400981207y2k  C                   EXSR      #CYMD8
246500981207y2k  C                   MOVEL     CYMD#         HCYMD
246600981207      *
246700140618      * EFFECTIVE DATE OF ADD CAN'T BE LESS THAN members enroll date
246800141112      *
246900141112     c                   if        hcymd < menrdt_ymd
247000920206     C                   Z-ADD     52            X                    50
247100920206     C                   SETON                                        13
247200920206     C                   GOTO      #ENDMC
247300920206     C                   END
247400140618
247500140618      * EFFECTIVE DATE CAN'T BE LESS THAN members employment date
247600140618     c                   if        hcymd < empdt_ymd
247700140618     C                   Z-ADD     107           X                    50
247800140618     C                   SETON                                        13
247900140618     C                   GOTO      #ENDMC
248000140618     C                   END
248100140618
248200920206     C*
248300921104     C* EFFECTIVE DATE OF ADD CAN'T BE LESS THAN ACCOUNT'S ORIGINAL
248400921104     C* ENROLLMENT DATE.........
248500981207      *
248600990126     C     HCYMD         IFLT      AENROL
248700921104     C                   Z-ADD     60            X                    50
248800921104     C                   SETON                                        13
248900921104     C                   GOTO      #ENDMC
249000921104     C                   END
249100921104     C*
2492009102151261 C* VALIDATE COVERAGE TYPE
2493009102151262 C*
2494009102151263 C                   MOVE      SCVTYP        COVTYP
2495009102151264 C                   MOVEL     'T'           COVTYP
2496009102151265 C     COVTYP        CHAIN     CODES                              52
249700160621     c                   if        *in52 = *on or dltc6 <> 'A'
2498001606211266 C                   Z-ADD     6             X                    50
249900160621     c                   end
2500009102151267 C                   MOVE      ACTION        CACTFL
2501009102151269 C* VALIDATE PLAN#
2502009102151271 C                   Z-ADD     TR#SUB        CTRSUB
250300981125y2k  C                   MOVE      SPLAN#        CPLAN
250400981207y2k  C                   Z-ADD     HCYMD         CEFFDT
250500910911     C                   Z-ADD     *ZEROS        CCANDT
250600130509      * validate plan
2507001305091275 C     PLAN          CHAIN     PLNMST
250800130522     c                   if        not %found(plnmst) or dltc7 <> 'A'
2509001305091276 C                   SETON                                        5113
2510001305091277 C                   Z-ADD     10            X                    50
2511001305091277 C                   GOTO      #ENDMC
2512009102151282 C                   END
251300130509
2514001305151293 C* find age band if needed
2515001305151294 C                   if        pabfl = 'N'
2516009102151295 C                   Z-ADD     0             CAGEBD
2517009102151296 C                   ELSE
251800130618      * fill agedatwk with the mcov effdt, this is what #findab needs
251900130620      * and fill key fields for plnauxp chain
252000130618     c                   z-add     hcymd         agedatwk
252100130620     C                   MOVE      ctrust        keytrust
252200130620     C                   MOVE      csub          keysub
252300130620     C                   MOVE      cplan         keyplan
252400130515     C                   EXSR      #findab
2525001305151295 C                   Z-ADD     ab_out        CAGEBD
2526009812071299 C                   END
2527001305091300
2528009102151301 C                   MOVE      COVTYP        CCOVTP
252900981207y2k  C                   Z-ADD     CEFFDT        HCYMD
2530009102151303 C                   MOVE      RATE          HRATE
2531009102151304 C                   EXSR      #GRATE
2532009102151305 C*
2533009102151306 C     NOGRAT        IFEQ      'Y'
2534009102151307 C                   SETON                                            52
2535009102151308 C                   Z-ADD     16            X                    50
2536009102151309 C                   END
253700110726
253800110726      * warning message if no rates for this effdt and it is more than
253900110726      * 60 days in the future. Press F11 to skip this edit.
254000110726     c                   exsr      #chk60derr
254100110726
2542009102151313 C*
2543009102151320 C* VALIDATE PLAN# - NO DUP COVERAGE ENTERED
254400910911     C*
2545009102151322 C                   Z-ADD     SSNO          CSSNO
2546009102151323 C                   Z-ADD     00            CSEQ#
254700910918     C*
254800910918     C     SSNO          SETLL     MCOV
254900910918     C                   SETOFF                                           60
255000910918     C                   MOVE      *BLANKS       DUPCOV
255100910918     C     #DUPCK        TAG
255200910918     C     SSNO          READE     MCOV                                   60
255300140121     C   60              EXCEPT    relmcov
255400910918     C   60              GOTO      #ENDPC
255500981207      *
255600910918     C     PLAN#         IFEQ      SPLAN#
255700930118     C     CANDT         IFEQ      *ZEROS
255800930118     C                   MOVE      'Y'           DUPCOV            1
255900140121     C                   EXCEPT    relmcov
256000930118     C                   GOTO      #ENDPC
256100981207     C                   ELSE
256200981207      *
256300981207y2k  C                   MOVE      SENRLD        MDCY#
256400981207y2k  C                   EXSR      #CYMD8
256500981208y2k  C                   MOVEL     CYMD#         SCENRL            8 0
256600981207      *
256700981207y2k  C                   Z-ADD     CANDT         MCANCL            8 0
256800981207y2k  C                   Z-ADD     ENRLDT        MCENRL            8 0
256900981207      *
257000930120     C     MCENRL        IFNE      MCANCL
257100930118     C     SCENRL        IFGE      MCENRL
257200930120     C     SCENRL        IFLT      MCANCL
257300910918     C                   MOVE      'Y'           DUPCOV            1
257400140121     C                   EXCEPT    relmcov
257500910918     C                   GOTO      #ENDPC
257600910918     C                   END
257700930120     C                   END
257800930118     C                   END
257900930118     C                   END
258000910918     C                   END
258100910918     C                   GOTO      #DUPCK
258200910919     C**
258300910918     C     #ENDPC        TAG
258400910918     C*
258500910918     C     DUPCOV        IFEQ      'Y'
258600910918     C                   Z-ADD     17            X                    50
258700910918     C                   END
258800910918     C*
258900911010     C*  EDIT AGAINST HAVING TWO ACTIVE PLANS WITH SAME PLAN CATEGORY CODE
259000911010     C*
259100930120     C     PLNCAT        LOOKUP    PCT                                    98
259200911010     C   98              Z-ADD     50            X                    50
259300920515     C*
259400920515     C*  EDIT AGAINST HAVING SALARY BASED PLAN BUT NO SALARY ENTERED.
259500920515     C*
259600920515     C     MULT          IFGT      *ZEROS
259700920515     C     SALARY        IFEQ      *ZEROS
259800920515     C                   Z-ADD     57            X                    50
259900920515     C                   END
260000920515     C                   END
260100101220
260200101220      * check for variable benefit amount plan
260300101220     c                   exsr      #chkvarben
260400101220
260500121127      * check for an active comctx, this ensures the plan is valid in the
260600121127      * account.
260700121127     c                   exsr      #chkcomctx
260800121127
260900920515     C*
2610000002181327 C* IF ERROR REDISPLAY SCREEN - ELSE CHECK FOR ANOTHER DEPENDENT
2611000002181328 C*       - ELSE WRITE RECORD AND CHECK FOR ANOTHER DEPENDENT
2612009102151329 C*
261300100716     c                   if        *in50
2614001007161330 C                   SETON                                        13
2615001007161331 C                   GOTO      #ENDMC
2616001007161331 C                   end
2617009102151332 C*
2618009102151333 C* UPDATE HISTORY
2619009109131334 C* IF SALARY BASED PLAN, PICK UP MULTIPLIER AND SALARY AND ROUNDING
2620009109131335 C* FACTOR, AND CALCULATE BENEFIT.
2621009109131336 C*
2622000606301337 C                   MOVEL     TR#SUB        PLANKY           10
2623009109131338 C                   MOVE      SPLAN#        PLANKY
2624009109131339 C     PLANKY        CHAIN     PLNMST                             98
2625009109131340 C*
262600020724      *
262700110825      * fill enrldt (used in #calcben) with screen enroll date
262800020724      *
262900020724y2k  C                   MOVE      SENRLD        MDCY#
263000020724y2k  C                   EXSR      #CYMD8
263100020724y2k  C                   MOVEL     CYMD#         enrldt
263200110825
263300110825      * calculate the benefit amount
2634001108251341 C                   clear                   FLTFLG            1
2635001108251341 C                   clear                   benamtwk
263600110825      * flat benefit
2637001108251342 C                   if        mult = 0
2638001108251345 C                   MOVE      'F'           FLTFLG
263900110825      * if variable benefit plan then use the amount entered on the
264000110825      * screen
264100110825     c                   if        varbenpln = 'Y'
264200110825     c                   z-add     sbenam        benamtwk
264300110825     c                   else
264400110825      * else use the plan values
2645001108254133 C                   Z-ADD     MAXBEN        BENAMTWK
264600110825     c                   end
2647009109131347 C                   END
264800110825
2649001108251343 C                   EXSR      #calcben
2650001108254133 C                   Z-ADD     cbenam        BENAMT
2651001109094133 C                   Z-ADD     benamtwkHOLD  horgben
2652001109094133 C                   clear                   benamtwkHOLD
265300140122
265400140122      * add mcovc record
2655001401221374 C                   MOVE      'A'           MSTAT             1
265600140122     c                   move      *zeros        mcuniq
2657001401221377 C                   EXCEPT    mcovcadd
265800240109
265900240109J002  * Check for existing decline and auto retire it
266000240125J002 C                   if        dclflg = 'Y'
266100240109J002 C                   clear                   WEBDCL
266200240109J002 C                   eval      DSTRS = ctrust
266300240109J002 C                   eval      DSSUB = csub
266400240109J002 C                   eval      DSACC = accno
266500240109J002 C                   eval      DSSSN = ssno
266600240109J002 C                   eval      DSEFF = SENRLD
266700240109J002 C                   eval      DSCAT = 'P' + %trim(plncat)
266800240109J002 C                   call      'PRCDCLSBM'
266900240109J002 C                   parm                    WEBDCL
267000240125J002 C                   end
267100140122
267200140122      * fill hist fields
2673009102151350 C                   MOVE      SPLAN#        MH1
2674009102151351 C                   MOVE      CAGEBD        MH2
2675009102151352 C                   MOVE      SCVTYP        MH3
2676009812081353 C                   MOVE      CBENAM        MH4
267700981207      *
2678009902031354 C     CBENAM        IFNE      0
2679009102151355 C                   SETON                                        46
268000910909     C                   ELSE
268100910909     C                   MOVE      *BLANKS       MH4
2682009102151356 C                   END
268300140122      * effdt in hist
268400981207y2k  C                   MOVE      SENRLD        MDCY#
268500981207y2k  C                   EXSR      #CYMD8
268600981207y2k  C                   MOVEL     CYMD#         TRANDT
268700981207      *
2688009102151358 C                   MOVE      'MAC'         TRCODE
268900130927     c                   exsr      #getsystime
269000140121      * adjust
269100140121     C                   EXSR      #hstadj
269200140121      * write hist
2693001401211360 C                   EXCEPT    histcov
2694001401211361 C                   SETOFF                                       46
269500140122
2696009102151362 C*
2697009102151364 C*  IF TXMTYN(CARMST) = Y, CREATE "MA"(MEMBER COVERAGE:ADDITION) TRNMIT REC
2698009102151365 C*
2699001406261367 C     PCARR         CHAIN     CARMST
270000140626     c                   if        %found(carmst) and txmtyn = 'Y'
2701009102151369 C                   MOVE      'MA'          ACTCOD
2702009102151370 C                   MOVE      GROUP#        HGROUP
270300081117      * Set defaults
270400081117     C                   Exsr      TRNCFS
2705001312121371 C                   EXCEPT    MCADD1
2706009102151372 C                   END
270700090204
270800090204      * keep track of "debit card = yes" plans added
270900090213     c                   if        pdebit <> ' '
271000100527     c                   eval      debitcard = pdebit
271100090204     c                   end
271200140626
271300140626      * clear fields used in mcovcadd (used to be blank after on o-spec but
271400140626      * these fields are still needed for the history and trnmit records
271500140626      * before this point)
271600140626     c                   clear                   horgben
271700140626     c                   clear                   CTRSUB
271800140626     c                   clear                   CPLAN
271900140626     c                   clear                   CAGEBD
272000140626     c                   clear                   CCOVTP
272100140626     c                   clear                   mcuniq
272200140626     c                   clear                   CACTFL
272300140626     c                   clear                   CBENAM
272400140626     c                   clear                   CEFFDT
272500140626
2726001305201125 C* CLEAR MCOV ENTRY SCREEN FIELDS
272700130520     c                   exsr      #clrio03
272800130520
2729009102151389 C*
273000130515     C* 42 = DISPLAY MESSAGE TO CAN. AND ADD AS OF ANIVDT (bday or plan
273100130515     C*      renewal date)
273200920226     C   42              EXSR      #DSPMC
273300920226     C   42              Z-ADD     55            X                    50
273400920225     C   42              SETON                                        13
273500130515y2k  C   42              MOVE      IN42date      CYMD#
273600981207y2k  C   42              EXSR      #MDCY8
273700130515y2k  C   42              MOVEL     MDCY#         in42datemdy       8 0
273800920225     C   42              GOTO      #ENDMC
2739009202251391 C*
2740009812071390 C                   END
2741009102151391 C*
2742009102151392 C* PROCESS COVERAGE CHANGE * * * * * * * * * * * * * * * * * * * *
2743009102151393 C*
2744009102151394 C     SACTCD        IFEQ      'C'
274500920515     C*
274600920515     C* ONLY ALLOW 1 CHANGE PER TRANSACTION
274700920515     C*
274800920515     C                   Z-ADD     0             NUMCHG            1 0
274900920515     C     SENRLD        IFNE      0
275000920515     C                   ADD       1             NUMCHG
275100920515     C                   END
275200920515     C     SCAND1        IFNE      0
275300920515     C                   ADD       1             NUMCHG
275400920515     C                   END
275500920515     C     SCVTYP        IFNE      *BLANKS
275600920515     C                   ADD       1             NUMCHG
275700920515     C                   END
275800920515     C     NUMCHG        IFGT      1
275900920515     C                   Z-ADD     51            X                    50
276000920515     C                   GOTO      #ERRT
276100920515     C                   END
276200101220
2763001012201489 C* do not allow BENEFIT AMOUNT CHANGE
2764001012201491 C                   if        sbenam <> 0
2765001012201493 C                   Z-ADD     87            X                    50
276600101220     C                   GOTO      #ERRT
2767001012201494 C                   END
276800920515     C*
276900910912     C                   MOVE      *BLANKS       NOUPDT
277000910909     C     SENRLD        IFEQ      *ZEROS
277100910909     C     SCAND1        IFEQ      *ZEROS
277200910909     C     SCVTYP        IFEQ      *BLANKS
277300910909     C                   Z-ADD     43            X                    50
277400910909     C                   END
277500910909     C                   END
277600910909     C                   END
277700920515     C*
2778009109041401 C* * * * * * * * * * * * * * * * * * *
2779009109041402 C* VALIDATE ENROLLMENT DATE CHANGE   *
2780009109041403 C* * * * * * * * * * * * * * * * * * *
2781009109041404 C*   (ENROLLMENT DATE IS USED AS THE EFFECTIVE DATE FOR ALL CHANGES
2782009109041405 C*
2783009109041406 C                   MOVE      *BLANKS       DATCHG            1
278400981207      *
2785009109041407 C     SENRLD        IFNE      0
2786009109041408 C                   Z-ADD     SENRLD        DATECK
2787009109041409 C                   EXSR      #DATCK
2788009109041410 C   98              SETON                                        53
2789009109041411 C   98              Z-ADD     4             X                    50
2790009109041412 C   98              GOTO      BADDTE
279100981207      *
279200910919     C     ASOFDT        IFNE      ED(L#)
279300910919     C                   Z-ADD     42            X                    50
279400910919     C                   GOTO      BADDTE
279500910919     C                   END
279600991109     C*
279700991109     C* PROHIBIT ENROLLMENT DATE CHANGE ON CANCELLED PLAN
279800991109     C*
279900991109     C     TD(L#)        IFNE      0
280000991109     C                   Z-ADD     68            X                    50
280100991109     C                   GOTO      BADDTE
280200991109     C                   END
280300910919     C*
2804009109041413 C                   Z-ADD     TR#SUB        CTRSUB
280500981125y2k  C                   MOVE      P#(L#)        CPLAN
2806009109041415 C                   MOVE      AB(L#)        CAGEBD
2807009109041416 C                   MOVEL     'T'           CCOVTP
2808009109041417 C                   MOVE      CT(L#)        CCOVTP
2809009812071418 C                   MOVE      RATE          HRATE
281000981207      *
281100981207y2k  C                   MOVE      SENRLD        MDCY#
281200981207y2k  C                   EXSR      #CYMD8
281300981207y2k  C                   MOVEL     CYMD#         HCYMD
281400981207      *
2815009109041420 C                   EXSR      #GRATE
281600981207      *
2817009109041421 C     NOGRAT        IFEQ      'Y'
2818009109041422 C                   SETON                                        52
2819009109041423 C                   Z-ADD     16            X                    50
2820009109041424 C                   END
282100110726
282200110726      * warning message if no rates for this effdt and it is more than
282300110726      * 60 days in the future. Press F11 to skip this edit.
282400110726     c                   exsr      #chk60derr
282500110726
2826009109041425 C                   MOVE      'Y'           DATCHG
2827009109041426 C     BADDTE        TAG
2828009109041427 C                   END
2829009109041428 C* * * * * * * * * * * * * * * * * * *
2830009109041429 C* VALIDATE PLAN # CHANGE            *
2831009109041430 C* * * * * * * * * * * * * * * * * * *
2832009109041431 C*
2833009901261432 C* CAN NOT CHANGE PLAN - MUST TERM OLD AND ADD NEW
2834009109041433 C*
283500981125y2k  C     SPLAN#        IFNE      *BLANKS
283600990126     C     SPLAN#        IFNE      '0000'
2837009109041435 C                   Z-ADD     24            X                    50
2838009109041436 C                   SETON                                        51
2839009109041437 C                   END
2840009901261437 C                   END
2841009109041438 C*
2842009109041439 C* * * * * * * * * * * * * * * * * * *
2843009109041440 C* VALIDATE COVERAGE TYPE CHANGE     *
2844009109041441 C* * * * * * * * * * * * * * * * * * *
2845009109041442 C*
2846009109041443 C* VALIDATE COVERAGE TYPE
284700910906     C*
2848009109041445 C     SCVTYP        IFNE      '  '
284900920309     C*
285000950209     C* CAN'T CHANGE COV TYPE ON CANCELED PLAN
285100950209     C*
285200950209     C     TD(L#)        IFNE      0
285300950209     C                   Z-ADD     62            X                    50
285400950209     C                   SETON                                        52
285500950209     C                   GOTO      #ERRT
285600950209     C                   END
285700950209     C*
285800920309     C     SCVTYP        IFEQ      CT(L#)
285900920309     C                   Z-ADD     56            X                    50
286000920309     C                   SETON                                        52
286100920309     C                   GOTO      #ERRT
286200920309     C                   END
286300920309     C*
2864009109041446 C                   MOVE      SCVTYP        CCOVTP
2865009109041447 C                   MOVEL     'T'           CCOVTP
2866009109041448 C     CCOVTP        CHAIN     CODES                              52
286700160621     c                   if        *in52 = *on or dltc6 <> 'A'
2868001606211449 C                   Z-ADD     6             X                    50
286900160621     c                   end
2870009109041450 C*
2871009109041451 C* VALIDATE COVERAGE TYPE FOR PLAN
2872009109041452 C*
2873009109041453 C                   Z-ADD     TR#SUB        CTRSUB
2874009901271454 C*          SPLAN#    IFNE *ZEROS
287500990127y2k  C*                    MOVE SPLAN#    CPLAN
2876009901271454 C*                    ELSE
287700990126     C                   MOVE      P#(L#)        CPLAN
287800990127 458 C*                    END
287900990126     C*
2880009109041459 C     PLAN          CHAIN     PLNMST                             98
2881009109041460 C   98              Z-ADD     10            X                    50
2882009109041461 C*
2883001305221462 C  N98DLTC7         IFNE      'A'
2884009109041463 C                   Z-ADD     10            X                    50
2885009109041464 C                   END
2886009109041465 C*
2887009109041466 C     PABFL         IFEQ      'N'
2888009109041467 C                   Z-ADD     0             CAGEBD
2889009109041468 C                   ELSE
2890009109041469 C                   Z-ADD     AB(L#)        CAGEBD
2891009109041470 C                   END
289200981207      *
289300981207y2k  C                   MOVE      ASOFDT        MDCY#
289400981207y2k  C                   EXSR      #CYMD8
289500981207y2k  C                   MOVEL     CYMD#         HASOFD
289600981207      *
289700981207y2k  C                   MOVE      ED(L#)        MDCY#
289800981207y2k  C                   EXSR      #CYMD8
289900981207y2k  C                   MOVEL     CYMD#         HED
290000981207      *
290100910913     C     HASOFD        IFLT      HED
290200910913     C                   Z-ADD     44            X                    50
290300910913     C                   GOTO      #ERRT
290400910913     C                   END
290500981207     C*
2906009109041472 C     DATCHG        IFEQ      'Y'
290700981207y2k  C                   MOVE      SENRLD        MDCY#
290800981207y2k  C                   EXSR      #CYMD8
290900981207y2k  C                   MOVEL     CYMD#         HCYMD
291000981207      *
2911009109041474 C                   ELSE
291200981207y2k  C                   MOVE      HASOFD        HCYMD
2913009109041476 C                   END
2914009109041477 C*
2915009109041478 C                   MOVE      RATE          HRATE
2916009109041479 C                   EXSR      #GRATE
2917009109041480 C*
2918009109041481 C     NOGRAT        IFEQ      'Y'
2919009109041482 C                   SETON                                        52
2920009109041483 C   52              Z-ADD     16            X                    50
2921009109041484 C                   END
292200110726
292300110726      * warning message if no rates for this effdt and it is more than
292400110726      * 60 days in the future. Press F11 to skip this edit.
292500110726     c                   exsr      #chk60derr
292600110726
2927009109041485 C                   END
2928009109041495 C*
2929009109041488 C* * * * * * * * * * * * * * * * * * *
2930009109051489 C* VALIDATE CANCELL DATE CHANGE      *
2931009109041490 C* * * * * * * * * * * * * * * * * * *
293200910905     C     SCAND1        IFGT      *ZEROS
293300910905     C                   Z-ADD     SCAND1        DATECK
293400910904     C                   EXSR      #DATCK
293500910904     C   98              Z-ADD     4             X                    50
293600910904     C   98              GOTO      #SKPA1
293700910904     C*
293800910917     C*   CHANGE CANCEL DATE CANNOT BE LESS THAN EFFECTIVE DATE......
293900981207      *
294000981207y2k  C                   MOVE      SCAND1        MDCY#
294100981207y2k  C                   EXSR      #CYMD8
294200981207y2k  C                   MOVEL     CYMD#         HASOFD
294300981207      *
294400981207y2k  C                   MOVE      ED(L#)        MDCY#
294500981207y2k  C                   EXSR      #CYMD8
294600981207y2k  C                   MOVEL     CYMD#         HED
294700981207      *
294800910904     C     HASOFD        IFLT      HED
294900910904     C                   Z-ADD     41            X                    50
295000910918     C                   GOTO      #SKPA1
295100910904     C                   END
295200910918     C*
295300981208     C* CHANGE CANCEL DATE MUST BE EQUAL TO OLD CANCEL DATE IF CANCELLED
295400910919     C*
295500910919     C     ASOFDT        IFNE      TD(L#)
295600910919     C                   Z-ADD     47            X                    50
295700910919     C                   GOTO      #SKPA1
295800910919     C                   END
295900910919     C*
296000910918     C*  MAKE SURE GRATE REC'S EXIST FOR CHANGE CANCEL DATE.
296100910918     C*( HAVE TO EDIT BECAUSE NEED GROUP # FOR DELETE/ADD TRNMIT RECS)
296200910918     C*
296300910918     C                   MOVE      TR#SUB        CTRSUB
296400910918     C                   MOVE      P#(L#)        CPLAN
296500910919     C                   MOVEL     'T'           CCOVTP
296600910919     C                   MOVE      CT(L#)        CCOVTP
296700910919     C                   MOVE      AB(L#)        CAGEBD
296800981207      *
296900981207y2k  C                   MOVE      ASOFDT        MDCY#
297000981207y2k  C                   EXSR      #CYMD8
297100981207y2k  C                   MOVEL     CYMD#         HCYMD
297200981207      *
297300910918     C                   MOVE      RATE          HRATE
297400910918     C                   EXSR      #GRATE
297500060413
297600060413      * IF NO GRATE FOUND FOR CANCEL DATE USE (CANCEL DATE - 1 MONTH)
297700060413      * TO TRY AGAIN
297800060413     C                   if        nograt = 'Y'
297900080108     C                   move      hcymd         holdhcymd         8 0
298000060413     C                   move      hcymd         workdt
298100060413     C                   subdur    1:*m          workdt
298200060413     C                   move      workdt        hcymd
298300060413     C                   EXSR      #GRATE
298400080108     C                   move      holdhcymd     hcymd
298500060413     C                   END
298600060413
298700060413     C* IF STILL NO RATE - ERROR
298800910918     C     NOGRAT        IFEQ      'Y'
298900910918     C                   Z-ADD     45            X                    50
299000910918     C                   END
299100110726
299200110726      * warning message if no rates for this effdt and it is more than
299300110726      * 60 days in the future. Press F11 to skip this edit.
299400110726     c                   exsr      #chk60derr
299500060413
299600060413      * validate term code
299700060413     C                   IF        TRMRCD <> *BLANKS
299800060413     C                   MOVEL     'D'           CDTYPE
299900060413     C                   MOVE      TRMRCD        CDKEY
300000060413     C     CDKEY         CHAIN     CODES                              58
300100160621     c                   if        *in58 = *on or dltc6 <> 'A'
300200160621     C                   Z-ADD     77            X                    50
300300160621     c                   end
300400060413     C                   ENDIF
300500221023
300600910905     C                   END
300700060413
300800910904     C     #SKPA1        TAG
300900981207     C*
3010009109041496 C* * * * * * * * * * * * * * * * * * *
3011009109041497 C* SET UP MCOV KEY FOR CHANGE LINE   *
3012009109041498 C* * * * * * * * * * * * * * * * * * *
3013009109041499 C                   Z-ADD     SSNO          CSSNO
3014009109041500 C                   Z-ADD     00            CSEQ#
3015009109041501 C                   Z-ADD     TR#SUB        CTRSUB
3016009109041502 C                   MOVEL     TR#SUB        CTRUST
3017009109041503 C                   MOVE      TR#SUB        CSUB
3018009109041504 C                   MOVE      P#(L#)        CPLAN
3019009109041505 C                   MOVE      AB(L#)        CAGEBD
3020009109041506 C                   MOVE      CT(L#)        CCOVTP
302100981207      *
302200981207y2k  C                   MOVE      ED(L#)        MDCY#
302300981207y2k  C                   EXSR      #CYMD8
302400981207y2k  C                   MOVEL     CYMD#         CEFFDT
302500981207y2k  C                   MOVE      TD(L#)        MDCY#
302600981207y2k  C                   EXSR      #CYMD8
302700981207y2k  C                   MOVEL     CYMD#         CCANDT
302800981207      *
3029009109041508 C                   MOVE      BA(L#)        CBENAM
3030009109041509 C                   MOVEL     'T'           CCOVTP
3031009109041512 C*
3032009109041513 C* EXIT IF ERROR
303300910913     C     #ERRT         TAG
303400221023
303500221023     C*
3036002210231050 C* can not change line without a plan
3037002210231051 C*
3038002210231052 C                   if        p#(l#) = *blanks
3039002210231056 C                   Z-ADD     20            X                    50
304000221023     c                   end
3041009109041514 C*
3042009109041515 C   50              SETON                                        13
3043009109041516 C   50              GOTO      #ENDMC
3044009109041524 C*
3045009109041525 C* * * * * * * * * * * * * * * * * * *
3046009109041526 C* PROCESS COVERAGE TYPE CHANGE      *
3047009109041527 C* * * * * * * * * * * * * * * * * * *
3048009109041528 C*
3049009109041529 C     SCVTYP        IFNE      *BLANKS
305000981223      *
3051009109041530 C* UPDATE MCOV FIELD
3052009109041531 C*
3053009109041532 C                   MOVE      SCVTYP        CCOVTP
3054009109041533 C                   MOVEL     'T'           CCOVTP
3055009109041534 C*
305600910917     C*   IF COVERAGE TYPE CHANGES, CANCEL MCOV RECORD & ADD NEW MCOV
305700910917     C*   RECORD WITH CHANGED COVERAGE TYPE........
305800910917     C*
305900910912     C                   MOVE      'N'           NOUPDT
306000910913     C                   EXSR      #READU
306100981208      *
306200981208y2k  C                   MOVE      ASOFDT        MDCY#
306300981208y2k  C                   EXSR      #CYMD8
306400981208y2k  C                   MOVEL     CYMD#         TRANDT
306500981208      *
306600110913     c                   move      *zeros        mcuniq
306700140122      * add new mcov
306800131213     C                   EXCEPT    CHGADD
306900140122      * cancel old mcov
307000131213     C                   EXCEPT    CHGCAN
307100140122
3072009109041535 C* UPDATE HISTORY
3073009109041536 C*
3074009109041537 C                   MOVE      *BLANKS       MH3
307500981207      *
307600981207y2k  C                   MOVE      ASOFDT        MDCY#
307700981207y2k  C                   EXSR      #CYMD8
307800981207y2k  C                   MOVEL     CYMD#         TRANDT
3079009109041539 C                   MOVE      P#(L#)        MH1
3080009109041540 C                   MOVE      AB(L#)        MH2
3081009109041541 C                   MOVE      CT(L#)        MH4
3082009109041542 C                   MOVEL     SCVTYP        MH3
3083001402271541 C                   clear                   MH6
308400140227     c                   if        ba(l#) <> 0
3085000103011541 C                   MOVE      BA(L#)        MH6
308600140227     c                   end
3087009109041543 C                   MOVE      'MCC'         TRCODE
308800911008     C*
308900911008     C*  ADJBEN = MULTIDEFINED FIELD.. (CANCEL DATE OR BENEFIT AMT)
309000981207      *
309100981207y2k  C                   MOVE      TD(L#)        MDCY#
309200981207y2k  C                   EXSR      #CYMD8
309300981207y2k  C                   MOVEL     CYMD#         ADJBEN
309400981207      *
3095001401211544 C                   SETON                                          26
309600130927     c                   exsr      #getsystime
309700140121      * adjust
309800140121     C                   EXSR      #hstadj
309900140121      * write hist
3100001401211545 C                   EXCEPT    histcov
3101001401211546 C                   SETOFF                                         26
3102009109041547 C*
3103009109041548 C*    IF TXMTYN(CARMST) = Y, CREATE "MC"(MEMBER COVERAGE: COV TYPE CHANGE
3104009109041550 C*
310500981125y2k  C                   MOVE      P#(L#)        CPLAN
3106009109041552 C     PLAN          CHAIN     PLNMST                             69
3107009109041553 C  N69PCARR         CHAIN     CARMST                             68
3108009109041554 C  N68TXMTYN        IFEQ      'Y'
3109009109041555 C                   MOVE      'MC'          ACTCOD
3110009109041556 C                   MOVE      RATE          HRATE
311100981207y2k  C                   Z-ADD     TRANDT        CEFFDT
311200981207y2k  C                   MOVE      CEFFDT        HCYMD
3113009109041559 C                   EXSR      #GRATE
3114009109041560 C*
3115009109041561 C                   MOVE      GROUP#        HGROUP
3116009602211563 C**USE ASOFDT INSTEAD Z-ADDED,L#     CEFFDT
311700081029
311800081117      * Set defaults
311900081117     C                   Exsr      TRNCFS
312000081029
3121001312131562 C                   EXCEPT    MCADD1
3122009109041564 C                   END
3123009109041566 C                   END
3124009109041567 C* * * * * * * * * * * * * * * * * * *
3125009109041568 C* PROCESS ENROLLMENT DATE CHANGE    *
3126009109041569 C* * * * * * * * * * * * * * * * * * *
3127009109041570 C     SENRLD        IFNE      *ZEROS
3128001401221571
312900140122      * change enroll date of mcov
313000140122     C                   MOVE      'N'           NOUPDT            1
313100140122     C                   EXSR      #READU
313200140122     c                   move      *zeros        mcuniq
313300140122
313400140122y2k  C                   MOVE      SENRLD        MDCY#
313500140122y2k  C                   EXSR      #CYMD8
313600140122     C                   MOVE      CYMD#         CEFFDT
313700140122
313800140122y2k  C                   MOVE      ASOFDT        MDCY#
313900140122y2k  C                   EXSR      #CYMD8
314000140122y2k  C                   MOVEL     CYMD#         TRANDT
314100140122      * cancel old mcov
314200140122     C                   EXCEPT    CHGCAN
314300140127      * add new mcov
314400140127     C                   EXCEPT    CHGEND
314500140122    ***
3146001401221577 C* fill HIST fields
314700990111y2k  C                   MOVE      ASOFDT        MDCY#
314800990111y2k  C                   EXSR      #CYMD8
314900990111y2k  C                   MOVEL     CYMD#         TRANDT
315000990112y2k  C                   MOVE      CYMD#         OLDEDT            8 0
315100990114      *
315200981208Y2K  C                   Z-ADD     BA(L#)        ADJBEN            8 0
3153009109041580 C                   MOVE      P#(L#)        MH1
3154009109041581 C                   MOVE      AB(L#)        MH2
3155009109041582 C                   MOVE      CT(L#)        MH3
315600140122
315700990108y2k  C                   MOVE      SENRLD        MDCY#
315800990108y2k  C                   EXSR      #CYMD8
315900990108y2k  C                   MOVEL     CYMD#         MH6
316000990108      *
316100990108y2k  C                   MOVE      ED(L#)        MDCY#
316200990108y2k  C                   EXSR      #CYMD8
316300990108y2k  C                   MOVEL     CYMD#         MH4
316400990108      *
3165009109041585 C                   MOVE      'MCE'         TRCODE
316600981223      *
3167001401211586 C                   SETON                                          26
316800130927     c                   exsr      #getsystime
316900140121      * adjust
317000140121     C                   EXSR      #hstadj
317100140121      * write hist
3172001401211587 C                   EXCEPT    histcov
3173001401211588 C                   SETOFF                                         26
317400981223      *
317500131213    ***
3176009109041596 C*   IF TXMTYN(CARMST) = Y, CREATE "ME"(MEMBER COVERAGE: ENROLL DATE CHANGE
3177009109041597 C*            TRNMIT RECORD
3178009109041598 C*
317900981125y2k  C                   MOVE      P#(L#)        CPLAN
3180009109041600 C     PLAN          CHAIN     PLNMST                             69
3181009109041601 C  N69PCARR         CHAIN     CARMST                             68
3182009109041602 C  N68TXMTYN        IFEQ      'Y'
3183009109041603 C                   MOVE      RATE          HRATE
318400981208      *
318500981208y2k  C                   MOVE      SENRLD        MDCY#
318600981208y2k  C                   EXSR      #CYMD8
318700981208y2k  C                   MOVEL     CYMD#         HCYMD
318800981208      *
3189009109041605 C                   EXSR      #GRATE
3190009109041606 C                   MOVE      'ME'          ACTCOD
319100990112      *
319200081117      * Set defaults
319300081117     C                   Exsr      TRNCFS
319400081029
3195001312131607 C                   EXCEPT    MCADD1
3196009109041608 C                   END
3197009109041613 C                   END
319800981208      *
3199009109041614 C* * * * * * * * * * * * * * * * * * *
3200009109041615 C* PROCESS CANCEL DATE CHANGE        *
3201009109041616 C* * * * * * * * * * * * * * * * * * *
3202009108271578 C*
320300910905     C     SCAND1        IFNE      *ZEROS
320400140122
320500140122y2k  C                   MOVE      SCAND1        MDCY#
320600140122y2k  C                   EXSR      #CYMD8
320700140122y2k  C                   MOVEL     CYMD#         CCANDT
320800140122      *
320900140122     C                   MOVE      BA(L#)        CBENAM
3210001401221645 C                   MOVE      P#(L#)        CPLAN
321100140122
321200140122      * change cancel date of mcov
321300140122     C     NOUPDT        IFEQ      *BLANKS
321400140122
321500140122      *********************
321600140122      * 4/13/06 - add trnmit
3217001401221642  *    IF TXMTYN(CARMST) = Y, CREATE "MT"(MEMBER COVERAGE: TERMINATION)
3218001401221643  *    "TRNMIT" RECORD.
3219001401221644  *
3220001401221646 C     PLAN          CHAIN     PLNMST                             69
3221001401221647 C  N69PCARR         CHAIN     CARMST                             68
3222001401221648 C  N68TXMTYN        IFEQ      'Y'
3223001401221649 C                   MOVE      'MT'          ACTCOD
3224001401222557 C                   MOVE      TRMRCD        HTCODE
3225001401221650 C                   MOVE      GROUP#        HGROUP
322600140122      * Set defaults
322700140122     C                   Exsr      TRNCFS
3228001401221651 C                   EXCEPT    MCADD1
3229001401221652 C                   END
323000140122
323100140122     C                   EXSR      #READU
323200140122      * write mcov
323300140122     C                   EXCEPT    #UPMCV
323400140122
323500140122      * fill hist fields
323600981208y2k  C                   MOVE      ASOFDT        MDCY#
323700981208y2k  C                   EXSR      #CYMD8
323800981208y2k  C                   MOVEL     CYMD#         TRANDT
323900981208      *
3240009108271580 C                   MOVE      P#(L#)        MH1
3241009108271581 C                   MOVE      AB(L#)        MH2
3242009108271582 C                   MOVE      CT(L#)        MH3
324300981208      *
324400981208y2k  C                   MOVE      SCAND1        MDCY#
324500981208y2k  C                   EXSR      #CYMD8
324600981208y2k  C                   MOVEL     CYMD#         MH6
324700981208      *
324800981208y2k  C                   MOVE      TD(L#)        MDCY#
324900981208y2k  C                   EXSR      #CYMD8
325000990203y2k  C                   MOVE      CYMD#         MH4
325100981208      *
325200910920     C                   MOVE      BA(L#)        ADJBEN
3253009108271585 C                   MOVE      'MCX'         TRCODE
325400981223      *
3255001401211586 C                   SETON                                          26
325600130927     c                   exsr      #getsystime
325700140121      * adjust
325800140121     C                   EXSR      #hstadj
325900140121      * write hist
3260001401211587 C                   EXCEPT    histcov
3261001401211588 C                   SETOFF                                         26
326200060413
326300140122     C                   END
326400140122
326500910919     C                   END
3266001305201379 C*
3267001305201125 C* CLEAR MCOV ENTRY SCREEN FIELDS
326800130520     c                   exsr      #clrio03
326900130520
3270009102151675 C                   END
3271009102151676 C*
3272009102151677 C* FILL COVERAGE SCREEN AND WRITE SCREEN
3273009102151678 C*
3274009102151679 C                   EXSR      #DSPMC
3275009102151680 C                   SETON                                        13
327600981221     C     #ENDMC        TAG
327700140627
327800140627      * if any error occured put back the line # entered so it remains
327900140627      * on the screen as the user entered it since it was converted to the
328000140627      * current screen line # for use in the programs processeing logic
328100140627     c                   if        *in50 and l#_hold <> 0
328200140627     c                   z-add     l#_hold       l#
328300140627     c                   end
328400140627
328500000829     C                   ENDSR
3286009102151682 C/EJECT
3287009102151683 C****************************************************************
3288009102151685 C*------------------- DISPLAY MEMBER COVERAGE ------------------*
3289009102151686 C*
3290009102151687 C     #DSPMC        BEGSR
3291009102151695 C*
3292009102151696 C* VALIDATE PLAN# - NO DUP COVERAGE ENTERED
3293009102151698 C* BLANK SCREEN AND FILL COVERAGE SCREEN ARRAYS
3294009102151699 C*
3295009102151700 C                   SETOFF                                       40
329600981125y2k  C                   MOVE      *BLANKS       P#
3297009102151702 C                   MOVE      *BLANKS       CT
3298009102151703 C                   MOVE      *ZEROS        ED
3299009102151704 C                   MOVE      *ZEROS        BA
3300001109131707 C                   MOVE      *BLANKS       RB
3301009102151705 C                   MOVE      *ZEROS        AB
3302009102151706 C                   MOVE      *ZEROS        TD
330300001017SZ   C                   MOVE      *BLANKS       PR
330400140627SZ   C                   clear                   p#des
3305009109131707 C                   MOVE      *BLANKS       CLEAR
3306009109271707 C                   MOVE      *BLANKS       ABX
3307009812071708 C                   MOVE      SSNO          CSSNO
330800910927     C                   Z-ADD     *ZEROS        LL
330900910913     C   95
331000910913     CORNKE              Z-ADD     *ZEROS        X#                3 0
331100100715
331200100715      * fill plan cat type array with all active mcov
331300911011     C   95
331400100715     CORNKE              exsr      #fillpct
331500100715
331600910821     C   95
3317009109131709 CORNKECOVKEY        SETLL     MCOVC
3318009102151710 C*
331900000830     C                   MOVE      'N'           PCPYN             1
3320009102151711 C                   DO        10            Z                 2 0
3321009108211712 C                   SETOFF                                       95
3322009109131713 C                   READ      MCOVC                                  95
332300910821     C  N95SSNO          IFNE      MCSSNO
332400140121     C                   EXCEPT    relmcovc
332500910821     C                   SETON                                        95
332600910222     C                   END
332700910222     C*
3328009108211714 C  N95SSNO          IFEQ      MCSSNO
3329009102151715 C*
333000910916     C     DLTC1         IFEQ      'D'
333100910916     C                   ADD       1             X#
333200910916     C                   END
333300910916     C*
3334009102151716 C* IF NOT DELETED MOVE TO ARRAY AND MARK AS DELETED UNTIL UPDATE
3335009102151717 C*
3336009812041718 C     DLTC1         IFNE      'D'
333700910913     C                   ADD       1             X#
333800910913     C                   MOVE      X#            LL(Z)
3339009102151719 C                   MOVE      PLAN#         P#(Z)
3340009102151720 C                   MOVE      COVTYP        CT(Z)
334100981207      *
334200981207y2k  C                   MOVE      ENRLDT        CYMD#
334300981207y2k  C                   EXSR      #MDCY8
334400981207y2k  C                   MOVEL     MDCY#         ED(Z)
334500981207      *
3346009102151722 C                   MOVE      AGEBND        AB(Z)
334700910927     C     AGEBND        IFEQ      *ZEROS
334800910927     C                   MOVE      *BLANKS       ABX(Z)
334900910927     C                   ELSE
335000910927     C                   MOVE      AGEBND        ABX(Z)
335100910927     C                   END
335200110913
3353009102151723 C                   MOVE      BENAMT        BA(Z)
335400110913
335500110913      * does this plan have a reduced benefit due to dec life?
335600110913     c                   if        benamt < mcorgben
335700110913     c                   move      'YES'         RB(Z)
335800110913     c                   else
335900110913     c                   clear                   RB(Z)
336000110913     c                   end
336100110913
336200001017      *---
336300001017SZ    * Translate proration rule to display text
336400001017      *---
336500001017     C     PK            CHAIN     PLNMST                             69
336600140627     c                   if        %found(plnmst)
336700140627     c                   movel     pdescr        p#des(z)
336800140627     c                   end
336900140627
337000001017     C  N69PCARR         CHAIN     CARMST                             68
337100001017     C   68              MOVEL     'N/A'         PR(Z)
337200001017     C     CPRRUL        IFEQ      '01'
337300001017     C                   MOVEL     'Daily'       PR(Z)
337400001017     C                   END
337500001017     C     CPRRUL        IFEQ      '02'
337600001017     C                   MOVEL     'Midmonth'    PR(Z)
337700001017     C                   END
337800001017     C     CPRRUL        IFEQ      '03'
337900120817     C                   MOVEL     'FullMonth'   PR(Z)
338000001017     C                   END
338100981207      *
338200981207y2k  C                   MOVE      CANDT         CYMD#
338300981207y2k  C                   EXSR      #MDCY8
338400981207y2k  C                   MOVEL     MDCY#         TD(Z)
338500981207      *
338600910913     C                   MOVE      DLTC1         DC(Z)
3387009102151725 C*
3388009102151726 C* IF SALARY BASED PLAN, PICK UP MULTIPLIER AND SALARY AND ROUNDING
3389009102151727 C* FACTOR, AND CALCULATE BENEFIT.
3390009102151728 C*
3391009102151729 C                   MOVEL     TR#SUB        PLANKY
3392009102151730 C                   MOVE      P#(Z)         PLANKY
3393009102151731 C     PLANKY        CHAIN     PLNMST                             98
339400020520
339500020419     C                   IF        DLTC1 = 'C' AND
339600021017     C                             TPCPR = 'Y'
339700020419     C                   MOVE      'Y'           PCPYN
339800020419     C                   ENDIF
339900020520
340000910830     C     DLTC1         IFEQ      'A'
340100021017     C     PCP_REQ       IFEQ      'Y'
340200000830     C                   MOVE      'Y'           PCPYN
340300000830     C                   END
3404001108251739 C                   END
3405009102151740 C*
3406000002181741 C* SETON 40 IF DEPENDENTS TO BE ENTERED
3407009102151742 C*
3408009102151743 C                   MOVE      CT(Z)         COVTYP
3409009102151744 C                   MOVEL     'T'           COVTYP
3410001606211745 C     COVTYP        CHAIN     CODES
341100160621     c                   if        %found(codes) and dltc6 = 'A' and
3412001606211746 C                             ACTION > '1'
3413009102151747 C                   SETON                                        40
3414009102151748 C                   END
3415009102151749 C*
341600140121     C                   EXCEPT    relmcovc
3417009102151750 C                   ELSE
3418009102151751 C                   SUB       1             Z
3419009102151752 C                   END
3420009102151754 C                   END
3421009102151756 C                   END
3422009102151757 C*
3423000008291758 C                   ENDSR
3424009102151759 C/EJECT
342500100715
3426001007151760 C****************************************************************
3427001007151760 C* fill plan category type array with all active mcov
3428001007151760 C****************************************************************
3429001007151764 C     #fillpct      BEGSR
343000100715     C                   MOVE      *BLANKS       PCT
343100100715     C                   z-add     1             pct#
343200100715
3433001007151709 C     ssno          SETLL     MCOVC
343400100715     c                   dou       %eof(mcovc)
3435001007151713 C     ssno          READe     MCOVC
3436001007151715
343700230414     C                   IF        enrldt = candt
343800230414     C                   iter
343900230414     C                   endif
3440002304141715
344100120919     C                   IF        not %eof(mcovc) and dltc1 = 'A'
3442001007151731 C     pk            CHAIN     PLNMST
344300100715     c                   if        %found(plnmst)
3444001007151732 C                   MOVE      PLNCAT        PCT(pct#)
344500100715
344600100715     c                   if        pct# < 99
344700100715     c                   add       1             pct#
344800100715     c                   else
344900100715     c                   leavesr
345000100715     c                   end
345100100715
345200100715     c                   end
345300100715     c                   end
345400100715
345500100715     c                   enddo
3456001007151758 C                   ENDSR
345700100715
345800100715
3459009102151760 C****************************************************************
3460000002181762 C*----------------------- DEPENDENTS ---------------------------*
3461009102151763 C*
3462009812091764 C     #DPND         BEGSR
3463009102151765 C*
3464009102151766 C* IF CMD6 INITIATE REINSTATE ROUTINE IF STATUS IS CANCELLED
3465009102151767 C*
3466009102151768 C     DLTC3         IFEQ      'C'
3467009102151769 C   KF              SETON                                        19
3468009102151770 C   KF              GOTO      #ENDDP
3469009102151771 C                   END
3470009102151772 C*
3471009102151773 C* CONTINUE IF CMD1 AND NO DEPEND RECORD READ
3472009102151774 C*
347300090204     c                   if        *inka and *in43
3474000902041775 C                   EXSR      #CLEAR
3475000902041776 C                   SETON                                        11
3476000902040537  * at the end of all dependents,
3477000902040537  * if a debit card plan was added, then call debit card maint pgm
347800100527     c                   if        debitcard <> ' ' and debitcard <> 'N'
347900090204     c                   move      ssno          fm430ssn
348000090204     c                   call      'FM430CL'
348100090204     c                   parm                    fm430ssn
348200090204     c                   end
3483000902041777 C                   GOTO      #ENDDP
348400090204     c                   end
3485009102151778 C*
3486009102151779 C*
3487009102151780 C   KT              EXSR      #CLEAR
3488009102151781 C   KT              SETON                                        11
3489009102151782 C   KT              GOTO      #ENDDP
3490009102151783 C*
3491009102151784 C* IF CMD4 INITIATE TERMINATION ROUTINE IF STATUS IS ACTIVE
3492009102151785 C*
349300160622     c                   if        dltc3 = 'A' and *inkd = *on
3494001606221787 C                   SETON                                        18
3495001606221787 C                   clear                   tcode
3496001606221788 C                   GOTO      #ENDDP
3497009102151789 C                   END
3498009102151792 C*
3499002203280942 C* F10 - DISPLAY RELATION aODES IF REQUESTED THEN EXIT
3500001109140943 C* the field pos071parm is the start position of the window (across)
3501001109140943 C* FM071 is the 80 column version
3502001109140943 C*
350300110914     c                   if        *inKJ
350400110914     c                   move      'R'           fm071parm
350500110914     c                   move      040           pos071parm
350600110914     c                   call      'FM071'
350700110914     c                   parm                    fm071parm
350800110914     c                   parm                    pos071parm
350900110914     c                   seton                                        14
3510001109141796 C                   GOTO      #ENDDP
351100110914     c                   end
3512009102151797 C*
3513009102151798 C* EXECUTE EDIT ROUTINE, REDISPLAY IF FAILED
3514009102151800 C*
3515000705251801 C                   EXSR      #EDITD
3516009102151802 C*
3517009102151803 C* IF ERROR REDISPLAY SCREEN AND EXIT
3518009102151804 C*
3519009102151805 C   50              SETON                                        14
3520009102151806 C   50              GOTO      #ENDDP
3521009102151807 C*
3522009102151808 C* CHECK FOR CHANGE IF NOT ADD
3523009102151809 C*
352400981230y2k   * Reverse format of dates from scrn to ...
352500981222y2k  C                   EXSR      #FLDEP
352600981222      *
3527009102151810 C                   MOVE      'NO '         CHANGE
3528001107190815 C                   MOVE      'NO '         CHANGE4e          3
3529009102151812 C                   MOVE      DS04A         HDS04A          256
3530009102151813 C                   MOVE      DS04B         HDS04B            2
353100981209Y2K  C                   MOVE      DS04D         HDS04D           32
353200110719Y2K  C                   MOVE      DS04E         HDS04E           65
3533009102151814 C                   MOVE      DS04AH        DSH04A          256
3534009102151815 C                   MOVE      DS04BH        DSH04B            2
353500981209Y2K  C                   MOVE      DS04DH        DSH04D           32
353600110719Y2K  C                   MOVE      DS04EH        DSH04E           65
3537009102151816 C*
353800110719     c                   if        *in43 = *off
3539001107191817 C     DS04A         IFNE      DS04AH
3540009102151818 C                   MOVE      'YES'         CHANGE
3541009102151819 C                   END
3542001107191820 C     DS04B         IFNE      DS04BH
3543009102151821 C                   MOVE      'YES'         CHANGE
3544009102151822 C                   END
3545001107191820 C     DS04D         IFNE      DS04DH
3546009812091821 C                   MOVE      'YES'         CHANGE
3547009812091822 C                   END
354800110719      * dep email
3549001107191820 C     DS04E         IFNE      DS04EH
3550001107191821 C                   MOVE      'YES'         CHANGE4E
3551001107191822 C                   END
3552001107191822 C                   end
3553009102151823 C*
3554009102151824 C*   IF DEPENDENT DEMOGRAPHIC INFO. CHANGE DETECTED, SPIN THRU
3555009102151825 C*      DCOV RECORDS. FOR EACH PLAN THAT IS XMITTABLE, CREATE "TRNMIT"
3556009102151826 C*       RECORD. ALSO SPIN TRHU MCOV RECORDS TO FIND MATCHING PLAN.
3557009102151827 C*       RECOVER MCOV VALUES FOR "TRNMIT" RECORDS.
3558009102151828 C*
355900110720      * if anything on the depend screen changed
3560001107191829 C                   if        change = 'YES' or change4e = 'YES'
3561001107201892  * write hist rec for data on screen that changed
3562001107201893 C                   EXSR      #DCHNG
3563001107201894 C                   END
356400110720
356500110720      * only do this logic for trnmit if something changed that is
356600110720      * used in trnmit. Email address is not (change4e)
356700110720     c                   if        change = 'YES'
3568009102151832 C     SSNO          SETLL     DCOV
3569001107201833 C                   dou       %eof(dcov)
3570001107201834 C     ssno          READe     DCOV
3571001107201835 C                   if        %eof(dcov)
357200140121     C                   EXCEPT    reldcov
3573001107201836 C                   leave
3574001107201839 C                   END
357500110720
357600110720     c                   if        dltc5 <> 'A' or dseq#c <> dseq#
357700110720     c                   iter
357800110720     c                   end
3579009102151840 C*
3580009102151845 C     DCVPLK        CHAIN     PLNMST                             69
3581009102151846 C  N69PCARR         CHAIN     CARMST                             68
358200960229     C  N68
3583009602291847 CANN69TXMTYN        IFEQ      'Y'
358400020315Y2K  C                   Z-ADD     tdate         hdcand
3585009102151849 C*
3586009102151851 C     SSNO          SETLL     MCOV
3587001107201852 C                   dou       %eof(mcov)
3588009102151853 C                   MOVE      *BLANKS       CANFLG
3589001107201855 C     SSNO          READE     MCOV
3590001107201835 C                   if        %eof(mcov)
359100140121     C                   EXCEPT    relmcov
3592001107201856 C                   leave
3593001107201860 C                   END
3594009102151857 C*
3595001107201858 C                   if        dltc2 = 'D' or
3596001107201873 C                             (plan# <> dplan#)
3597001107201859 C                   iter
3598001107201860 C                   end
3599009102151861 C*
3600009904051862 C     CANDT         IFNE      0
360100981209Y2K  C                   Z-ADD     CANDT         HCANDT
360200981201y2k  C                   Z-ADD     UDCYMD        HUDATE
3603009812091865 C     HCANDT        IFLE      HUDATE
3604001107201866 C                   iter
3605009102151867 C                   ELSE
3606009812091868 C                   Z-ADD     HCANDT        HCYMD
3607009102151869 C                   MOVE      'Y'           CANFLG
3608009102151870 C                   END
3609009102151871 C                   END
3610009102151872 C*
3611009102151874 C                   MOVE      'DD'          ACTCOD
3612009102151876 C                   MOVE      GRTKEY        HRATE
3613009811251875 C*
3614009102151877 C     CANFLG        IFNE      'Y'
361500981201y2k  C                   Z-ADD     ASDT          HCYMD
3616009102151879 C                   END
3617009102151880 C*
3618009603011881 C                   EXSR      #GRATE
361900960301  67 C*
3620009603010867 C* IF NO RATE REC FOUND, USE ENROLLMENT DATE
3621009603010867 C*
3622009603010862 C     NOGRAT        IFEQ      'Y'
362300981209Y2K  C                   Z-ADD     ENRLDT        HCYMD
3624009603010866 C                   EXSR      #GRATE
3625009603010864 C                   END
3626009603010867 C*
362700110720      * Set defaults and write trnmit record
362800081117     C                   Exsr      TRNCFS
3629001312131883 C                   EXCEPT    DCADD2
3630001107201885 C                   enddo
3631009102151887 C*
3632009102151888 C                   END
3633001107201889 C                   enddo
3634009102151894 C                   END
363500110720
3636009102151895 C*
3637000002181896 C* WRITE OUT DEPENDENT RECORD
3638009102151897 C   43              ADD       1             DSEQ#
363900060126     C                   Exsr      ChgSame
364000140121
364100140121      * add new dep (43) or update (n43)
364200140121     c                   if        *in43
3643001401211899 C                   EXCEPT    adddep
364400140121     c                   else
364500140121     c                   except    upddep
364600140215
364700140317      * if there was a birth date change or a relation change
364800140317      * and the depend has an aca plan
364900140215      * then call adjust pgm for all aca plans the depend has (had to be
365000140215      * done here AFTER the depend was updated.)
365100140317     c                   if        acabdaychg = 'Y' or acarelchg = 'Y'
3652001402152987 C     SSNO          SETLL     DCOV
3653001402152988 C                   dou       %eof(dcov)
3654001402152989 C     SSNO          READE(n)  DCOV
365500140215     c                   if        not %eof(dcov) and dseq#c = dseq#
365600140215     c                             and tdate = 0
3657001402152996 C     dcvplk        CHAIN     PLNMST
365800140215     c                   if        %found(plnmst)
365900140317
366000141110      * if individually rated aca plan write rel chg or bday adjust rec.
366100140318      * if a relation change and birth date change occurs together, the
366200140318      * relation change code will be the one that is used for the
366300140318      * adjustment since both changes will be adjusted at once in TR260
366400140318
3665001411102996 C***  plplankey     CHAIN     plnauxp
366600141110     c***                if        %found(plnauxp) and pxacar = 'Y'
366700141118     c                   clear                   acairat
366800141120
366900141120     c                   monitor
367000141118     c                   eval      acairat = #chk_aca_plan(pltrust:plsub#:pplan)
367100141120      * trap anything that goes wrong with the check aca function
367200141120     c                   on-error
367300141120      * error handling code here
367400141120     c                   endmon
367500141120
367600141118     c                   if        acairat = 'Y'
367700140318      * relation change
367800140318     c                   if        acarelchg = 'Y'
3679001403182975 C                   MOVE      'M41'         TRCODE
368000140318     c                   else
368100140318      * bday change
3682001403182975 C                   MOVE      'M51'         TRCODE
368300140318     c                   end
368400140318
3685001402152977 C                   MOVE      dplan#        mh1
3686001402152977 C                   MOVE      *zeros        mh2
368700140317      * cov type not needed tr260 handels it for all depend transaction
3688001402172977 C                   clear                   mh3
3689001402152977 C                   clear                   mh4
3690001402152977 C                   move      dseq#c        mh5
3691001402152977 C                   move      *zeros        mh6
369200140215      * use dcov effdt for effdt of adjustment since no effective date of
369300140215      * change is asked for at this time
369400140215     C                   move      dedate        TRANDT
369500140215     c                   eval      *in47 = *off
369600140215     c                   eval      *in46 = *off
369700140215     c                   eval      *in26 = *off
369800140215      * *in25 = depend transaction
369900140215     c                   eval      *in25 = *on
370000140215     c                   exsr      #getsystime
370100140215      * adjust
370200140215     C                   EXSR      #hstadj
370300140217     c                   clear                   trandt
370400140225     c                   clear                   mh6
370500141203     c                   eval      *in25 = *off
370600140215     c                   end
370700140317
370800140215     c                   end
370900140215     c                   end
371000140215     c                   enddo
371100140215     c                   end
371200140318
371300140121     c                   end
371400140318
371500140318      * clear aca change fields
371600140318     c                   clear                   acabdaychg
371700140318     c                   clear                   acarelchg
371800140318
371900131213    ***
372000110719      * if 43 is on a new depend was added so add it to the depend2 file
372100110719      * else update the depend2 file
372200110719     c                   if        *in43
372300130517      ******
372400130517      * write depend add hist rec
372500130517     c                   clear                   note2
372600140121     c                   clear                   ck#not
372700130517     c                   eval      trcode = 'MDB'
372800140121     c                   movel     'D#-'         d#fldwk           5
372900140121     c                   move      dseq#         d#fldwk
373000140121     c                   move      d#fldwk       ck#not
373100140121
373200140121     c**                 eval      note2 = 'Dep#-'
373300140121     c**                 move      dseq#         dseq#char
373400140121     c**                 cat       dseq#char:1   note2
373500130517     c***                eval      his_covtdt = dseffd
373600130517     c                   eval      his_covtdt = *zeros
373700130927     c                   exsr      #getsystime
373800131215     c                   except    histdep
373900140121     c                   clear                   ck#not
374000140121     c                   clear                   note2
374100130517      ******
374200110719     c                   eval      d2ssn = ssno
374300110719     c                   eval      d2seq = dseq#
374400110719     c                   write     depend2r
374500110719     c                   else
374600110719     c                   if        %found(depend2)
374700110719     c                   update    depend2r
374800110719     c                   else
374900110719      * if there was no depend2 rec on file to update, then add it now
375000110719     c                   eval      d2ssn = ssno
375100110719     c                   eval      d2seq = dseq#
375200110719     c                   write     depend2r
375300110719     c                   end
375400110719     c                   end
375500110719
3756001401211900 C                   SETOFF                                         43
3757009102151901 C*
3758000002181902 C* FILL DEPENDENT COVERAGE ARRAY FROM CURRENT MCOV AND OLD DCOV INFO
3759009102151903 C*
3760009109131904 C                   MOVE      *BLANKS       CLEAR
3761001402261905 C                   MOVE      *blanks       P#
3762009102151906 C                   MOVE      *ZEROS        #AG
3763009102151907 C                   MOVE      *BLANKS       #CT
3764009102151908 C                   MOVE      *ZEROS        #ED
3765009102151909 C                   MOVE      *ZEROS        #CD
3766009102151910 C                   MOVE      *ZEROS        #AC
3767009102151911 C                   MOVE      *ZEROS        #BA
3768009102151912 C                   MOVE      *BLANKS       #GP
3769009102151913 C                   MOVE      *BLANKS       #TX
3770009112051913 C                   MOVE      *BLANKS       #CR
3771009102151914 C                   MOVE      *ZEROS        DEF
3772009102151915 C                   MOVE      *ZEROS        DTD
3773009102151916 C                   MOVE      *BLANKS       DCV
3774009102151917 C                   MOVE      *BLANKS       PDS
3775009202101918 C                   Z-ADD     0             Y                 2 0
3776009109131919 C     COVKEY        SETLL     MCOVC
3777009102151920 C     #LDP01        TAG
377800971010     C     Y             IFEQ      13
377900140121     C                   EXCEPT    relmcovc
378000920210     C                   GOTO      #TDP02
378100920210     C                   END
378200920210     C*
3783009102151921 C                   SETOFF                                       98
3784009102151922 C                   READ      MCOVC                                  98
3785009102151923 C   98              GOTO      #TDP02
3786009102151924 C     MCSSNO        IFNE      SSNO
378700140121     C                   EXCEPT    relmcovc
3788009102151925 C                   GOTO      #TDP02
3789009102151926 C                   END
3790009102151927 C*
3791009102151928 C     DLTC1         IFEQ      'D'
3792009102151929 C                   GOTO      #LDP01
3793009102151930 C                   END
379400910827     C*
379500940418     C* ONLY DISPLAY MCOV RECS THAT ARE NOT "IN" COVERAGE
379600940418     C*
379700940418     C     COVTYP        IFEQ      'TIN'
379800940418     C                   GOTO      #LDP01
379900940418     C                   END
380000910827     C*
380100920212     C                   SETOFF                                           98
380200920212     C     PLAN#         LOOKUP    P#                                     98
380300920212     C   98              GOTO      #LDP01
380400920212     C*
3805009202101931 C                   ADD       1             Y
3806009102151932 C                   MOVE      DSEQ#         CSEQ#
3807009102151933 C                   Z-ADD     SSNO          CSSNO
3808009102151934 C                   MOVE      TR#SUB        CTRSUB
3809009102151935 C                   MOVE      PLAN#         CPLAN
3810009102151936 C     COVKEY        CHAIN     DCOVC                              98
3811009812091937 C                   MOVE      'N'           DCV(Y)
3812009102151938 C  N98DLTC4         IFNE      'D'
381300981209y2k  C                   MOVE      DENRDT        CYMD#
381400981209y2k  C                   EXSR      #MDCY8
381500981209y2k  C                   MOVEL     MDCY#         DEF(Y)            8 0
3816009102151940 C     DCANDT        IFNE      0
381700981209y2k  C                   MOVE      DCANDT        CYMD#
381800981209y2k  C                   EXSR      #MDCY8
381900981209y2k  C                   MOVEL     MDCY#         DTD(Y)            8 0
3820009102151942 C                   ELSE
3821009102151943 C                   MOVE      'Y'           DCV(Y)
3822009102151944 C                   END
3823009102151945 C                   END
3824009102151946 C*
382500140121     C  N98              EXCEPT    reldcovc
382600910225     C*
3827009102151947 C*   MOVE DATA TO "#" ARRAYS. IF DCOV RECORDS ARE ADDED, USE L# TO
3828009102151948 C*    GET ARRAY VALUES FOR "MCOV DATA" PORTION OF "TRNMIT" RECORD.
3829009102151949 C*
3830009102151950 C                   MOVE      PLAN#         P#(Y)
3831009102151951 C                   MOVE      AGEBND        #AG(Y)
3832009102151952 C                   MOVE      COVTYP        #CT(Y)
383300981209y2k  C                   MOVE      ENRLDT        CYMD#
383400981209y2k  C                   EXSR      #MDCY8
383500981209y2k  C                   MOVEL     MDCY#         #ED(Y)
383600990112      *
383700981209y2k  C                   MOVE      CANDT         CYMD#
383800981209y2k  C                   EXSR      #MDCY8
383900981209y2k  C                   MOVEL     MDCY#         #CD(Y)
384000981209      *
3841009102151955 C                   MOVE      CACTFL        #AC(Y)
3842009102151956 C                   MOVE      BENAMT        #BA(Y)
3843009102151957 C*
3844009102151958 C*    AT THIS POINT, CHECK IF PLAN'S CARRIER IS TRANMITTABLE.
3845009102151959 C*        IF YES, MOVE "Y" TO #TX,Y. ARRAY USED LATER IN DEPENDENT
3846009102151960 C*       COVERAGE ADDS.
3847009102151961 C*
3848009102151962 C                   MOVE      GRTKEY        HRATE
384900981201y2k  C                   Z-ADD     ASDT          HCYMD
3850009102151964 C                   EXSR      #GRATE
3851009102151965 C*
3852009102151966 C                   MOVE      HGROUP        #GP(Y)
3853009102151967 C*
3854009102151968 C     PLAN          CHAIN     PLNMST                             98
3855009102151969 C  N98              MOVEL     PDESCR        PDS(Y)
3856009102151970 C  N98PCARR         CHAIN     CARMST                             68
385700910215     C  N98
3858009102151971 CANN68TXMTYN        IFEQ      'Y'
3859009102151972 C                   MOVE      'Y'           #TX(Y)
386000920212     C                   MOVE      PCARR         #CR(Y)
3861009102151973 C                   END
3862009102151974 C*
3863009202101975 C                   GOTO      #LDP01
3864009102151976 C     #TDP02        TAG
3865009102151977 C*
3866000002181978 C* OUTPUT DEPENDENT COVERAGE SCREEN
3867009102151979 C*
3868009102151980 C                   SETON                                        15
386900140411
387000140411      * create name fields
387100140411     c                   clear                   subdsc           50
387200140411     c                   clear                   depdsc           50
387300140411     c                   clear                   dep#char          2
387400140411     c                   move      dseq#         dep#char
387500140411     c                   eval      subdsc = %trim(lname) + ', ' + %trim(fname)
387600140411     c                             + ' ' + mi
387700140411     c                   eval      depdsc = '#' + dep#char + ' '
387800140411     c                             + %trim(dlname) + ', '
387900140411     c                             + %trim(dfname) + ' ' + dmi
388000140411
3881009102151981 C*
3882000008291982 C     #ENDDP        ENDSR
3883009102151983 C/EJECT
3884009102151984 C****************************************************************
3885000002181986 C*----------------------- DEPENDENT COVERAGES ------------------*
3886009102151987 C*
3887009102151988 C     #DPNDC        BEGSR
3888001404111989
3889001404110943  * 4/11/14
3890001404110942  * F10- call Tobacco file maintenance program for dependent
3891001404111989  *
389200140411     c                   if        *inkj
389300140411     c                   move      ssno          fm410parm1
389400140411     c                   move      DSEQ#         fm410parm2
389500140411     c                   call      'FM410CL'
389600140411     c                   parm                    fm410parm1
389700140411     c                   parm                    fm410parm2
3898001404111010 C                   SETON                                        15
3899001404111011 C                   GOTO      #ENDDC
390000140411     c                   end
390100140411
3902001404111989 C*
3903001404111989 C* CMD5 - ROLL COVERAGES
3904001404111989 C*
390500910826     C   KE              GOTO      ROLDEP
390600910826     C*
3907009102151990 C* EXIT IF CMD 1  AND NO ACTION CODE INPUT
3908009102151991 C*
3909000002181992 C* IF ANY NON-INDIVIDAUL COVERAGE TYPES ENTERED DISPLAY DEPENDENT SCR
3910009102151993 C*       ELSE DISPLAY FIRST SCREEN
3911009102151994 C*
3912009102151995 C   KASACTCD        IFEQ      ' '
3913009102151996 C*
3914000002181997 C* DEPENDENT NAME AND CODE FOR NEXT DEPENDENT
3915009102151998 C*
391600971010M999 C                   MOVE      DFNAME        DFNHLD
3917009102151999 C                   MOVE      *BLANKS       DRELC2
3918009102152000 C                   MOVE      *BLANKS       DLNAME
3919009102152001 C                   MOVE      *BLANKS       DFNAME
3920009102152002 C                   MOVE      *BLANKS       DMI
3921000210142002 C                   MOVE      *BLANKS       DSEFFD
3922000210142002 C                   MOVE      *BLANKS       DSSCHL
3923009102152003 C                   SETOFF                                       43  89
3924009102152004 C                   MOVE      *BLANKS       DS04AH
3925009102152005 C                   MOVE      *BLANKS       DS04BH
392600981209y2k  C                   MOVE      *BLANKS       DS04DH
392700110719y2k  C                   MOVE      *BLANKS       DS04EH
3928009102152006 C*
3929009102152007 C     SSNO          READE     DEPEND                                 43
393000110719      * depend not found
393100110719     c                   if        *in43
3932001107192008 C                   MOVE      'N'           DCOB
3933001107192009 C                   MOVE      'N'           DCOBBC
3934001107192010 C                   MOVE      ' '           DHNDCP
3935001107192011 C                   MOVE      'N'           DMEDCR
3936001107192012 C                   MOVE      'N'           DSTUDN
393700110719     c                   clear                   d2email
393800131213     C                   EXCEPT    RELDEP
393900110719     c                   else
394000110719      * depend was found
3941001107192013 C                   MOVE      DRELCD        DRELC2
3942001107192014 C                   MOVE      DS04A         DS04AH
3943001107192015 C                   MOVE      DS04B         DS04BH
394400110719y2k  C                   MOVE      DS04D         DS04DH
3945001107192016 C     DLTC3         IFNE      'A'
3946009102152017 C                   SETON                                        5089
3947009102152018 C                   Z-ADD     27            X
3948009102152019 C                   END
394900110719      * get depend2 record
395000110719     c                   move      ssno          d2keyssn
395100110719     c                   move      dseq#         d2keyseq
395200110719     c     d2key         chain     depend2
395300110719     c                   if        not %found(depend2)
395400110719     c                   clear                   d2email
3955001107190934 C                   end
395600110720y2k  C                   MOVE      DS04E         DS04EH
395700110719
3958001107192019 C                   end
3959009710100537 C*
3960001305200537 C* IF ANY PCP PLANS ADDED FOR MMEBER, WRITE SCREEN FOR DEPEND
3961009710100537 C* PCP & COB ENTRY
3962009710100537 C*
3963000111010537 C* only show pcp screen if dcov screen has plans
396400021017     C                   IF        PCPYN = 'Y' and y <> 0
396500020404     C                   EXSR      #PCP
396600971010     C                   END
396700990104y2k   * Reverse format of file dates for display
396800990105Y2K   *
396900990105y2k  C                   EXSR      #KIDEP
3970009710102021 C*
3971009710102021 C* DISPLAY NEXT DEPEND SCREEN
3972009710102021 C*
3973009102152020 C                   SETON                                        14
3974009102152021 C*
3975009102152022 C                   GOTO      #ENDDC
3976009102152023 C                   END
3977009102152024 C*
3978009102152025 C* EDIT TYPE ACTION ENTRY
3979009102152026 C*
3980009102152027 C     SACTCD        IFNE      'C'
3981009102152028 C     SACTCD        IFNE      'T'
3982009102152029 C                   Z-ADD     19            X                    50
3983009102152030 C                   SETON                                        56
3984009102152031 C                   END
3985009102152032 C                   END
3986009102152033 C*
3987009509252034 C     L#            IFGT      13
3988009102152035 C                   Z-ADD     20            X                    50
3989009102152036 C                   SETON                                        57
3990009102152037 C                   ELSE
3991009102152038 C     L#            IFLT      1
3992009102152039 C                   Z-ADD     20            X                    50
3993009102152040 C                   SETON                                        57
3994009102152041 C                   END
3995009102152042 C                   END
3996009102152043 C*
3997009509252044 C     L#            IFLE      13
3998009102152045 C     L#            IFGE      1
399900981204y2k  C     P#(L#)        IFEQ      *BLANKS
4000009102152047 C                   Z-ADD     20            X                    50
4001009102152048 C                   SETON                                        57
4002009102152049 C                   END
4003009102152050 C                   END
4004009102152051 C                   END
4005009102152052 C*
4006009102152053 C* EXIT IF SELECTIONS ARE WRONG
4007009102152054 C*
4008009102152055 C   50              SETON                                        15
4009009102152056 C   50              GOTO      #ENDDC
4010009102152057 C*
4011009102152058 C* PROCESS TERMINATION  * * * * * * * * * * * * * * * * * * * * * *
4012009102152059 C*
4013009102152060 C     SACTCD        IFEQ      'T'
4014009102152061 C*
4015009102152062 C* VALIDATE ALL FIELDS BLANK EXCEPT TERMINATION DATE
4016009102152063 C*
4017009102152064 C     SENRLD        IFNE      *ZEROS
4018009102152065 C                   Z-ADD     21            X                    50
4019009102152066 C                   END
4020000108242061 C*
4021000111012061 C* if a termdate is entered for a plan already cancelled then a
4022000111012062 C* change cancel date is allowed but the date must be different
4023001107202063 C* then the dcov record.
4024000111012063 C*
4025000111012064 C                   if        scandt <> 0 and (scandt = dtd(l#))
4026000108242065 C                   Z-ADD     72            X                    50
4027000108242066 C                   END
4028009102152067 C*
4029009102152068 C* VALIDATE TERMINATION DATE
4030009102152069 C*
4031009812092070 C                   Z-ADD     SCANDT        DATECK
4032009102152071 C                   EXSR      #DATCK
4033000009062072 C   98              Z-ADD     4             X                    50
4034009102152073 C*
4035009102152074 C* CHAIN TO DCOV
4036009102152076 C                   MOVE      *BLANKS       CLEAR
4037009102152077 C                   MOVE      DSEQ#         CSEQ#
4038009102152078 C                   MOVE      TR#SUB        CTRSUB
4039009102152079 C                   MOVE      P#(L#)        CPLAN
4040009102152080 C     COVKEY        CHAIN     DCOVC                              44
4041009102152081 C   44              Z-ADD     22            X                    50
4042009102152082 C*
4043009102152083 C* EXIT IF ERROR
4044009102152084 C*
4045009102152085 C   50              SETON                                        15
4046009102152086 C   50              GOTO      #ENDDC
4047009102152087 C*
4048009102152088 C* UPDATE DCOVC
4049009102152089 C*
4050001402202165  * save old dcov cancel date for use in hist rec
405100140220y2k  C                   Z-ADD     dcandt        dcandt_hold       8 0
405200140220
405300981209y2k  C                   MOVE      SCANDT        MDCY#
405400981209y2k  C                   EXSR      #CYMD8
405500981209y2k  C                   MOVEL     CYMD#         HDCAND            8 0
405600981209y2k  C                   Z-ADD     HDCAND        DCANDT
4057009102152092 C                   MOVE      'C'           DLTC4
4058009102152093 C*
4059009102152094 C*     IF #TX,L# = Y ,CREATE "DT"(DEPENDENT COVERAGE:TERMINATION) TRNMIT
4060009102152095 C*      RECORD.
4061009102152096 C*
4062009102152097 C     #TX(L#)       IFEQ      'Y'
4063009102152098 C                   MOVE      'DT'          ACTCOD
4064009602272191 C                   MOVEL     PLAN          PLKEY
4065009102152099 C                   MOVE      P#(L#)        PLKEY
406600960226     C*
406700960226     C* GET CORRECT GROUP # FOR DATE ENTERED
406800960226     C*
406900960227     C                   MOVEL     PLKEY         HRATE
407000960226     C                   MOVEL     #AG(L#)       AC                5
407100960226     C                   MOVE      #CT(L#)       AC
407200960226     C                   MOVE      AC            HRATE
407300981209y2k  C                   Z-ADD     HDCAND        HCYMD
407400960226     C                   EXSR      #GRATE
4075000305210867 C*
4076000305210867 C* IF NO RATE REC FOUND, USE today's date to find group #
4077000305210867 C*
4078000305210862 C     NOGRAT        IFEQ      'Y'
407900030521y2k  C                   Z-ADD     udcymd        HCYMD
4080000305210866 C                   EXSR      #GRATE
4081000305210864 C                   END
408200030521
408300030521
408400990115y2k  C                   MOVE      #ED(L#)       MDCY#
408500990115y2k  C                   EXSR      #CYMD8
408600990115y2k  C                   MOVEL     CYMD#         #EDL#             8 0
408700990114      *
408800990115y2k  C                   MOVE      #CD(L#)       MDCY#
408900990115y2k  C                   EXSR      #CYMD8
409000990115y2k  C                   MOVEL     CYMD#         #CDL#             8 0
409100990114      *
409200081117      * Set defaults
409300081117     C                   Exsr      TRNCFS
409400090929
4095000909292061 C* depend coverage term - set transaction code for 834 transmission
4096000909292061 C* if a termdate is entered for a plan already cancelled then it is
4097000909292062 C* a change, else it is a term
4098000909292064 C                   clear                   trcode834
4099000909292064 C                   if        dtd(l#) <> 0
4100000909292065 C                   eval      trcode834 = 'C '
410100090929     c                   else
4102000909292065 C                   eval      trcode834 = 'T '
4103000909292066 C                   END
410400081029
4105001312132102 C                   EXCEPT    DCADD1
4106000909292064 C                   clear                   trcode834
4107009102152103 C                   END
4108009901292104 C*
410900990129y2k  C                   Z-ADD     DCANDT        TRANDT
4110009102152104 C*
4111001401212109 C* UPDATE DCOV
4112009901292110 C*
4113001401212106 C                   EXCEPT    updcovc
411400140121
4115009102152108 C*
4116009102152109 C* UPDATE HISTORY
4117009102152110 C*
4118009102152112 C                   MOVE      P#(L#)        MH1
411900090930
412000090930      * set hist trcode - update dep cov
4121009102152113 C                   MOVE      'MDD'         TRCODE
412200140220
412300090930      * set hist trcode - change dcov cancel date
4124000909302064 C                   if        dtd(l#) <> 0
4125000909302113 C                   MOVE      'MDX'         TRCODE
4126001402202204 C* if chg cancel date - show from - to dates in hist
412700140220     c                   eval      *in26 = *on
412800140220      * from
4129001402202208 C                   MOVE      dcandt_hold   MH4
413000140220      * to
4131001402202208 C                   MOVE      trandt        MH6
413200140220      * now put from date in hist effdt field
4133001402202208 C                   MOVE      dcandt_hold   trandt
413400090930     c                   end
413500090930
4136009102152114 C                   MOVE      DSEQ#         MH5               2
4137001401212115 C                   SETON                                          2547
413800130927     c                   exsr      #getsystime
413900140121      * adjust
414000140121     C                   EXSR      #hstadj
414100140121      * write hist
4142001401212116 C                   EXCEPT    histcov
414300140220     c                   clear                   dcandt_hold
4144001402202117 C                   SETOFF                                       262547
4145009102152118 C*
4146009102152119 C* BLANKOUT SCREEN FIELDS
4147009102152120 C*
4148009102152121 C                   MOVE      *ZEROS        SENRLD
4149009102152122 C                   MOVE      *ZEROS        SCANDT
4150009102152123 C                   MOVE      *BLANKS       SACTCD
4151009102152124 C                   MOVE      *ZEROS        L#
4152009102152125 C*
4153009102152126 C                   END
4154009102152127 C*
4155001406182128 C* PROCESS DEPENDENT COVERAGE ADDITION/CHANGE/REINSTATE * * * *
4156009102152129 C*
4157009102152130 C     SACTCD        IFEQ      'C'
4158001402262131
4159001402262132  * VALIDATE this is a valid line #
416000140226     c                   if        P#(L#) = *blanks or l# > 13
4161001402262142 C                   Z-ADD     20            X                    50
416200140226     c                   end
4163001404092131
4164001402262132 C* VALIDATE ALL FIELDS BLANK EXCEPT EFFECTIVE DATE
4165001404092134 C                   if        scandt <> 0
4166001404092135 C                   Z-ADD     61            X                    50
4167009102152136 C                   END
4168001404092137
4169001404092138  * VALIDATE EFFECTIVE DATE
4170009102152140 C                   Z-ADD     SENRLD        DATECK
4171009102152141 C                   EXSR      #DATCK
4172001404092142 C   98              Z-ADD     76            X                    50
417300140409
417400140618      * DCOV EFFECTIVE DATE CAN'T BE LESS THAN members employment date
417500140618     c                   if        senrld <> 0
417600140618y2k  C                   MOVE      senrld        MDCY#
417700140618y2k  C                   EXSR      #CYMD8
417800140618y2k  C                   MOVEL     CYMD#         senrld_ymd        8 0
417900140618
418000140618     C                   if        senrld_ymd < empdt_ymd
4181001406182142 C                   Z-ADD     107           X                    50
418200140618     c                   end
418300140618     c                   end
418400140618
4185001404092138  * on reinstate, effdt entered must match current dcov
4186001404092140 C                   if        senrld <> 0 and
4187001404092140 C                             senrld <> def(l#) and dtd(l#) <> 0
4188001404092142 C                   Z-ADD     36            X                    50
418900140409     c                   end
4190009102152143 C*
4191009102152144 C* CHAIN TO DCOV
4192009102152145 C*
4193009102152146 C                   MOVE      *BLANKS       CLEAR
4194009102152147 C                   Z-ADD     SSNO          CSSNO
4195009102152148 C                   Z-ADD     DSEQ#         CSEQ#
4196009102152149 C                   Z-ADD     TR#SUB        CTRSUB
4197009102152150 C                   MOVE      P#(L#)        CPLAN
4198009102152151 C     COVKEY        CHAIN     DCOVC                              44
419900140314   ***************************************************************************
4200009102152153 C*
4201009102152154 C* EXIT IF ERROR
4202009102152155 C*
4203009102152156 C   50              SETON                                        15
4204009102152157 C   50              GOTO      #ENDDC
420500140224
4206001402242165  * save old dcov cancel date for use in hist rec
420700140224y2k  C                   Z-ADD     dcandt        dcandt_hold       8 0
420800140224
4209009102152158 C*
4210009102152159 C* SETUP TRANS CODE
4211009102152160 C*
4212009902122160 C*  44 = DCOV NOT FOUND...ADD NEW DCOV RECORD
4213009902122160 C* N44 = DCOV FOUND...UPDATE DCOV RECORD
4214009902122160 C*
4215009102152161 C                   MOVE      'MDA'         TRCODE
421600090930     c                   if        *in44 = *off
421700140218      * reinstate dependent coverage
4218000909302182 C                   if        dcandt <> *ZEROS
4219000909302183 C                   MOVE      'MDR'         trcode
422000090930     c                   else
422100140218      * change depend cov effective date
4222000909302163 C                   MOVE      'MDU'         TRCODE
4223001402202165  * save old dcov enroll date for use in hist rec
422400140220y2k  C                   Z-ADD     DENRDT        denrdt_hold       8 0
4225000909302184 C                   END
422600090930     c                   end
422700090930
422800140220y2k  C                   Z-ADD     DENRDT        ODENDT            8 0
422900140220      * put new date from screen input in dcovc enroll date field
423000981209y2k  C                   MOVE      SENRLD        MDCY#
423100981209y2k  C                   EXSR      #CYMD8
423200981209y2k  C                   MOVEL     CYMD#         DENRDT
4233009102152169 C                   MOVE      'A'           DLTC4
4234009102152172 C*
4235009102152173 C*    IF #TX,L# = Y & DCOV RECORD ALREADY EXISTS(N44), THEN
4236009102152174 C*               CREATE "DC"(DEPENDENT COVERAGE:ENROLLMENT DATE CHANGE)
4237009102152175 C*
4238009102152176 C     #TX(L#)       IFEQ      'Y'
4239009102152177 C  N44              MOVE      'DC'          ACTCOD
4240009102152178 C*
4241009102152179 C*    IF DCOV ALREADY EXISTS(N44) & THERE IS A CANCEL DATE, CREATE
4242009102152180 C*        "DR"(DEPENDENT COVERAGE:REINSTATEMENT) TRNMIT RECORD.
4243009102152181 C*
4244009102152182 C  N44DCANDT        IFGT      *ZEROS
4245009102152183 C                   MOVE      'DR'          ACTCOD
4246001203082181 C* 03/07/12 - hold dcov cancel date to be used as reinstate effective
4247001203082181 C*            date in trnmit
4248001203082183 C                   MOVE      dcandt        holddccandt       8
4249009102152184 C                   END
4250009102152186 C*
4251009102152187 C*     IF DCOV RECORD DOES NOT EXIST(44), CREATE "DA"(DEPENDENT COVERAGE:
4252009102152188 C*           ADDITION) TRNMIT RECORD.
4253009102152189 C*
4254009102152190 C   44              MOVE      'DA'          ACTCOD
4255009602272191 C                   MOVEL     PLAN          PLKEY
4256009602272191 C                   MOVE      P#(L#)        PLKEY
425700960226     C*
425800960226     C* GET CORRECT GROUP # FOR DATE ENTERED
425900960226     C*
426000960227     C                   MOVEL     PLKEY         HRATE
426100960226     C                   MOVEL     #AG(L#)       AC                5
426200960226     C                   MOVE      #CT(L#)       AC
426300960226     C                   MOVE      AC            HRATE
426400981209y2k  C                   Z-ADD     DENRDT        HCYMD
426500960226     C                   EXSR      #GRATE
4266000305210867 C*
4267000305210867 C* IF NO RATE REC FOUND, USE today's date to find group #
4268000305210867 C*
4269000305210862 C     NOGRAT        IFEQ      'Y'
427000030521y2k  C                   Z-ADD     udcymd        HCYMD
4271000305210866 C                   EXSR      #GRATE
4272000305210864 C                   END
427300030521
427400990115GSPDA *
427500990115y2k  C                   MOVE      #ED(L#)       MDCY#
427600990115y2k  C                   EXSR      #CYMD8
427700990115y2k  C                   MOVEL     CYMD#         #EDL#             8 0
427800990114      *
427900990115y2k  C                   MOVE      #CD(L#)       MDCY#
428000990115y2k  C                   EXSR      #CYMD8
428100990115y2k  C                   MOVEL     CYMD#         #CDL#             8 0
428200040616
428300040616      * hdcand = dcov candt in trnmit
428400040616     c                   clear                   hdcand
428500040616
428600081117      * Set defaults
428700081117     C                   Exsr      TRNCFS
428800110509
428900110509      * Check for Payroll Account Create Payroll Deductions (Reinstate Only)
429000110509     C                   If        ACTCOD = 'DR'
429100110509     C                   Eval      PaySSN = CSSNO
429200110509     C                   Eval      PayPLN = CPLAN
429300110509     C                   Eval      PayEFF = DENRDT
429400110509     C                   EXSR      CREATE_PAYDED
429500110509     C                   End
429600081029
4297001312132194 C                   EXCEPT    DCADD1
4298001203082194 C                   clear                   holddccandt
4299009102152195 C                   END
430000090204
430100090204      * keep track of "debit card = yes" plans added
4302000902042191 C                   MOVEL     PLAN          PLKEY
4303000902042191 C                   MOVE      P#(L#)        PLKEY
430400090204     c     plkey         chain     plnmst
430500090213     c                   if        %found(plnmst) and pdebit <> ' '
430600100527     c                   eval      debitcard = pdebit
430700090204     c                   end
430800090204
4309009102152199 C                   Z-ADD     *ZEROS        DCANDT
431000140224y2k  C                   Z-ADD     DENRDT        TRANDT
431100140121
4312001401212197 C* UPDATE or add DCOVC
431300140121     c                   if        *in44
4314001401212201 C                   EXCEPT    adddcovc
4315001401212202 C                   else
4316001401212201 C                   EXCEPT    updcovc
431700140121     c                   end
4318009102152203 C*
4319009102152204 C* UPDATE HISTORY
4320009102152207 C                   MOVEL     P#(L#)        MH1
4321009102152208 C                   MOVE      DSEQ#         MH5
432200140220
4323001402202204 C* if chg enroll date - show from - to dates in hist
432400140220     c                   if        trcode = 'MDU'
432500140220     c                   eval      *in26 = *on
432600140220      * from
4327001402202208 C                   MOVE      denrdt_hold   MH4
432800140220      * to
4329001402202208 C                   MOVE      trandt        MH6
433000140220      * now put from date in hist effdt field
4331001402202208 C                   MOVE      denrdt_hold   trandt
433200140220     c                   end
433300140224
4334001402242204 C* if reinstate - show prior cancel date in hist effdt
433500140224     c                   if        trcode = 'MDR'
4336001402242208 C                   MOVE      dcandt_hold   trandt
433700140224     c                   end
433800981209      *
4339001401212209 C                   SETON                                          2547
434000130927     c                   exsr      #getsystime
434100140121      * adjust
434200140121     C                   EXSR      #hstadj
434300140121      * write hist
4344001401212210 C                   EXCEPT    histcov
434500140220     c                   clear                   denrdt_hold
434600140224     c                   clear                   dcandt_hold
4347001402202211 C                   SETOFF                                       262547
4348009102152212 C*
4349009102152213 C* BLANKOUT SCREEN FIELDS
4350009102152214 C*
4351009102152215 C                   MOVE      *ZEROS        SENRLD
4352009102152216 C                   MOVE      *ZEROS        SCANDT
4353009102152217 C                   MOVE      *BLANKS       SACTCD
4354009102152218 C                   MOVE      *ZEROS        L#
4355009102152219 C*
4356009102152220 C                   END
4357009102152221 C*
435800910826     C     ROLDEP        TAG
435900910826     C*
4360000002182222 C* FILL DEPENDENT COVERAGE ARRAY FROM CURRENT MCOV AND OLD DCOV INFO
4361009102152223 C*
436200091103     C                   MOVE      *BLANKS       CLEAR
436300140226SCR2 C                   MOVE      *blanks       P#
436400091103SCR2 C                   MOVE      *ZEROS        #AG
436500091103SCR2 C                   MOVE      *BLANKS       #CT
436600091103SCR2 C                   MOVE      *ZEROS        #ED
436700091103SCR2 C                   MOVE      *ZEROS        #CD
436800091103SCR2 C                   MOVE      *ZEROS        #AC
436900091103SCR2 C                   MOVE      *ZEROS        #BA
437000091103SCR2 C                   MOVE      *BLANKS       #GP
437100091103SCR2 C                   MOVE      *BLANKS       #TX
437200091103SCR2 C                   MOVE      *BLANKS       #CR
437300091103SCR2 C                   MOVE      *ZEROS        DEF
437400091103SCR2 C                   MOVE      *ZEROS        DTD
437500091103SCR2 C                   MOVE      *BLANKS       DCV
437600091103SCR2 C                   MOVE      *BLANKS       PDS
4377009202102230 C                   Z-ADD     0             Y                 2 0
437800910826     C   95
4379009109132231 CORNKECOVKEY        SETLL     MCOVC
4380009102152232 C     #LDC01        TAG
438100981209      *
438200971010     C     Y             IFEQ      13
438300140121     C                   EXCEPT    relmcovc
438400920210     C                   GOTO      #TDC02
438500920210     C                   END
438600920210     C*
4387009108262233 C                   SETOFF                                       95
4388009108262234 C                   READ      MCOVC                                  95
4389009108262235 C   95              GOTO      #TDC02
439000981209      *
4391009102152236 C     MCSSNO        IFNE      SSNO
439200140121     C                   EXCEPT    relmcovc
439300910826     C                   SETON                                        95
4394009102152237 C                   GOTO      #TDC02
4395009102152238 C                   END
4396009102152239 C*
4397009102152240 C     DLTC1         IFEQ      'D'
4398009102152241 C                   GOTO      #LDC01
4399009102152242 C                   END
440000940418     C*
440100940418     C* ONLY DISPLAY MCOV RECS THAT ARE NOT "IN" COVERAGE
440200940418     C*
440300940418     C     COVTYP        IFEQ      'TIN'
440400940418     C                   GOTO      #LDC01
440500940418     C                   END
440600910827     C*
440700920212     C                   SETOFF                                           98
440800920212     C     PLAN#         LOOKUP    P#                                     98
440900920212     C   98              GOTO      #LDC01
441000920212     C*
4411009202102243 C                   ADD       1             Y
4412009102152244 C                   MOVE      DSEQ#         CSEQ#
4413009102152245 C                   Z-ADD     SSNO          CSSNO
4414009102152246 C                   MOVE      TR#SUB        CTRSUB
4415009102152247 C                   MOVE      PLAN#         CPLAN
4416009109112248 C     COVKEY        CHAIN     DCOVC                              98
4417009102152249 C                   MOVE      'N'           DCV(Y)
441800981209      *
4419009102152250 C  N98DLTC4         IFNE      'D'
442000981209y2k  C                   MOVE      DENRDT        CYMD#
442100981209y2k  C                   EXSR      #MDCY8
442200981209y2k  C                   MOVEL     MDCY#         DEF(Y)
4423009102152252 C     DCANDT        IFNE      0
442400981209y2k  C                   MOVE      DCANDT        CYMD#
442500981209y2k  C                   EXSR      #MDCY8
442600981209y2k  C                   MOVEL     MDCY#         DTD(Y)
4427009102152254 C                   ELSE
4428009102152255 C                   MOVE      'Y'           DCV(Y)
4429009102152256 C                   END
4430009102152257 C                   END
443100910225     C*
443200140121     C  N98              EXCEPT    reldcovc
443300910225     C*
443400091103     C                   MOVE      PLAN#         P#(Y)
443500091103SCR2 C                   MOVE      AGEBND        #AG(Y)
443600091103SCR2 C                   MOVE      COVTYP        #CT(Y)
443700091103SCR2 C                   MOVE      ENRLDT        CYMD#
443800091103SCR2 C                   EXSR      #MDCY8
443900091103SCR2 C                   MOVEL     MDCY#         #ED(Y)
444000091103SCR2  *
444100091103SCR2 C                   MOVE      CANDT         CYMD#
444200091103SCR2 C                   EXSR      #MDCY8
444300091103SCR2 C                   MOVEL     MDCY#         #CD(Y)
444400091103SCR2  *
444500091103SCR2 C                   MOVE      CACTFL        #AC(Y)
444600091103SCR2 C                   MOVE      BENAMT        #BA(Y)
444700091103SCR2 C*
444800091103SCR2 C                   MOVE      GRTKEY        HRATE
444900091103SCR2 C                   Z-ADD     ASDT          HCYMD
445000091103SCR2 C                   EXSR      #GRATE
445100091103SCR2 C*
445200091103SCR2 C                   MOVE      HGROUP        #GP(Y)
445300091103SCR2
445400091103SCR2 C     PLAN          CHAIN     PLNMST                             98
445500091103SCR2 C  N98              MOVEL     PDESCR        PDS(Y)
445600091103SCR2 C  N98PCARR         CHAIN     CARMST                             68
445700091103SCR2 C  N98
445800091103SCR2 CANN68TXMTYN        IFEQ      'Y'
445900091103SCR2 C                   MOVE      'Y'           #TX(Y)
446000091103SCR2 C                   MOVE      PCARR         #CR(Y)
446100091103SCR2 C                   END
446200091103SCR2
446300091103     C                   GOTO      #LDC01
446400091103     C     #TDC02        TAG
446500091103     C                   SETON                                        15
446600091103     C     #ENDDC        ENDSR
446700160622
4468009102152266 C****************************************************************
4469009102152268 C*----------------------- TERMINATION ROUTINE ------------------*
4470009102152269 C*
4471009102152270 C     #TERM         BEGSR
4472009102152271 C*
4473009102152272 C* RETURN TO SCREEN 1 ON CMD 1
4474009102152273 C*
4475009102152274 C   KA              SETON                                        11
4476009102152275 C   KA              GOTO      #ENDT
4477000412152427 C*
4478000412152428 C* DISPLAY CODES IF REQUESTED (F21) THEN EXIT
4479001012210943 C* the field pos071parm is the start position of the window (across)
4480001012210943 C* FM071 is the 80 column version
4481001012210943 C*
448200041215     c                   if        *inkv
448300041215     c                   move      'D'           fm071parm         1
448400101221     c                   move      040           pos071parm
448500041215     c                   call      'FM071'
448600041215     c                   parm                    fm071parm
448700101221     c                   parm                    pos071parm
448800041215      * redisplay screen
4489000412152298 C                   SETON                                        16
4490000412152299 C                   GOTO      #ENDT
449100041215     c                   end
449200041215
4493009102152283 C*
4494001606212284 C* EDIT TERM CODE AND DATE (only member level term codes allowed)
4495009102152285 C*
4496009812082286 C                   Z-ADD     TERMDT        DATECK
4497009102152287 C                   EXSR      #DATCK
4498009102152288 C   98              SETON                                        52
4499009102152289 C   52              Z-ADD     4             X                    50
4500009102152291 C                   MOVE      'D'           CDTYPE
4501009102152292 C                   MOVE      TCODE         CDKEY
4502009102152293 C     CDKEY         CHAIN     CODES                              51
450300160621     c                   if        *in51 = *on or actn2 = 'A' or
450400160621     c                             dltc6 <> 'A'
4505001606212294 C                   Z-ADD     6             X                    50
450600160621     c                   end
4507000912042295
4508000912042296  * check for any mcov cancelled after the requested member term date
4509000912042297
451000091204      * flip member term date entered on screen to YMD
451100091204y2k  C                   MOVE      TERMDT        MDCY#
451200091204y2k  C                   EXSR      #CYMD8
451300091204y2k  C                   MOVEL     CYMD#         termdtymd         8 0
451400091204
4515000912042305 C     SSNO          SETLL     MCOV
451600091204     c                   dou       %eof(mcov)
4517000912042307 C     SSNO          READE(n)  MCOV
451800091204     c                   if        not %eof(mcov) and candt > termdtymd
451900091204     c                             and candt <> enrldt
4520000912042294 C                   Z-ADD     85            X                    50
452100091204     c                   leave
452200091204     c                   end
452300091204     c                   enddo
452400091204
4525000912042295 C*
4526000912042296 C* REDISPLAY SCREEN AND EXIT IF ERROR
4527000912042297 C*
4528009102152298 C   50              SETON                                        16
4529009102152299 C   50              GOTO      #ENDT
4530009102152300 C*
4531009102152301 C* LOOP AND TERMINATE MCOV + DCOV
4532009102152302 C*
4533009102152303 C                   Z-ADD     1             M                 2 0
4534009102152304 C                   SETOFF                                           98
453500910924     C                   MOVE      *BLANKS       DCHECK            1
4536009102152305 C     SSNO          SETLL     MCOV
4537009102152306 C     #TCL01        TAG
4538009102152307 C     SSNO          READE     MCOV                                   98
453900140121     C   98              EXCEPT    relmcov
4540009102152308 C   98              GOTO      #TCL02
4541009811252324 C*
4542009904052309 C     CANDT         IFEQ      0
4543009109062324 C*
454400910906     C*  IF "TERM DATE" IS LESS THAN COV ENROLL DATE, USE ENROLL DATE
454500910906     C*  AS CANCELLATION DATE........
454600981208      *
454700981208y2k  C                   MOVE      TERMDT        MDCY#
454800981208y2k  C                   EXSR      #CYMD8
454900981208y2k  C                   MOVEL     CYMD#         HCYMD
455000981208      *
455100990203     C     HCYMD         IFLT      EDATE
455200910906     C                   Z-ADD     EDATE         TDATE
455300981208     C                   Z-ADD     EDATE         TDCVDT            8 0
455400910906     C                   Z-ADD     EDATE         CANDT
455500910918     C                   Z-ADD     EDATE         TRANDT
455600910924     C                   MOVE      'Y'           DCHECK
455700910906     C                   ELSE
455800981208y2k  C                   Z-ADD     HCYMD         CANDT
455900981208y2k  C                   Z-ADD     HCYMD         TDATE
456000981208y2k  C                   Z-ADD     HCYMD         TDCVDT
456100981208y2k  C                   Z-ADD     HCYMD         TRANDT
456200910906     C                   END
456300910906     C*
4564009102152311 C*   IF TERMINATE, SPIN THRU "MCOV" & IF PLAN'S CARRIER IS XMITTABLE,
4565009102152312 C*    CREATE "MT"(MEMBER COVERAGE:TERMINATION) TRNMIT RECORD.
4566009102152313 C*
4567009102152316 C     MPLKEY        CHAIN     PLNMST                             69
4568009102152317 C  N69PCARR         CHAIN     CARMST                             68
456900981125     C*
457000951101     C  N68
4571009511012318 CANN69TXMTYN        IFEQ      'Y'
4572009102152319 C                   MOVE      'MT'          ACTCOD
4573009102152321 C                   MOVE      GRTKEY        HRATE
4574009602282320 C*
4575009602282320 C* USE SAME DATE AS MCOV CANCEL TO FIND GROUP#
4576009602282320 C*
457700981208y2k  C                   Z-ADD     CANDT         HCYMD
4578009102152323 C                   EXSR      #GRATE
4579000305200867 C*
4580000305200867 C* IF NO RATE REC FOUND, USE today's date to find group #
4581000305200867 C*
4582000305200862 C     NOGRAT        IFEQ      'Y'
458300030520y2k  C                   Z-ADD     udcymd        HCYMD
4584000305200866 C                   EXSR      #GRATE
4585000305200864 C                   END
458600030520
4587009102152326 C                   MOVE      TCODE         HTCODE            2
4588009102152327 C                   Z-ADD     ENRLDT        MDDATE
4589009901282320 C*
4590009901282320 C* EXECUTE #KIMBR TO CONVERT MEMBER DATES FROM MDY TO YMD FOR
4591009901282320 C* TRNMIT OUTPUT, THEN RUN #KIMBR AGAIN TO CONVERT BACK TO MDY
4592009901282320 C*
459300990128     C                   EXSR      #KIMBR
459400081117      * Set defaults
459500081117     C                   Exsr      TRNCFS
459600081029
4597001312132328 C                   EXCEPT    MADD1
459800990128     C                   EXSR      #KIMBR
4599009102152329 C                   END
4600009102152330 C*
4601009102152333 C                   MOVE      'C'           DLTC2
460200131210    ***
460300131210    *** TERM MC2V RECORDS
460400131210    ***
4605001312132334 C                   EXCEPT    MCOVU
4606009102152336 C*
4607009102152337 C                   MOVE      'MDC'         TRCODE
4608009102152338 C                   MOVE      PLAN#         MH1
4609009102152339 C                   MOVE      AGEBND        MH2
4610009102152340 C                   MOVE      COVTYP        MH3
4611000203192342 C                   MOVE      BENAMT        MH4
4612009811252336 C*
4613009902032343 C     BENAMT        IFNE      0
4614009102152344 C                   SETON                                            46
4615009102152345 C                   END
4616009102152346 C*
461700130927     c                   exsr      #getsystime
461800140121      * adjust
461900140121     C                   EXSR      #hstadj
462000140121      * write hist
4621001401212348 C                   EXCEPT    histcov
4622001401212349 C                   SETOFF                                           46
4623009102152350 C                   END
4624009102152352 C*
4625009102152353 C                   GOTO      #TCL01
4626009102152354 C     #TCL02        TAG
4627001402232356  *
462800140223      * once all mcov have been cancelled, now cancel all dcov
4629001402232356  *
4630009102152357 C                   SETOFF                                           98
4631009102152358 C     SSNO          SETLL     DCOV
4632009102152359 C     #TCL03        TAG
4633009102152360 C     SSNO          READE     DCOV                                   98
463400140121     C   98              EXCEPT    reldcov
4635009102152361 C   98              GOTO      #TCL04
4636009102152362 C     DLTC5         IFEQ      'A'
4637009211042324 C*
463800921104     C*  IF "TERM DATE" IS LESS THAN COV ENROLL DATE, USE ENROLL DATE
463900921104     C*  AS CANCELLATION DATE........
464000921104     C*
464100921104     C* DEDATE = DCOV ENROLL DATE; TERMDT = DATE INPUT FROM SCREEN
464200921104     C*
464300981209y2k  C                   MOVE      TERMDT        MDCY#
464400981209y2k  C                   EXSR      #CYMD8
464500981209y2k  C                   MOVEL     CYMD#         HCYMD
464600981209      *
464700000111     C     HCYMD         IFLT      DEDATE
464800921104     C                   Z-ADD     DEDATE        TDCVDT
464900921104     C                   Z-ADD     DEDATE        TRANDT
465000921104     C                   MOVE      'Y'           DCHECK
465100921104     C                   ELSE
465200981209y2k  C                   Z-ADD     HCYMD         TDCVDT
465300981209y2k  C                   Z-ADD     HCYMD         TRANDT
465400921104     C                   END
465500921104     C*
465600921104     C* CANCEL DCOV REC
4657009102152364 C                   MOVE      'C'           DLTC5
4658001401212366 C                   EXCEPT    candcv2
465900140314     *************************************************************************
4660009102152368 C*
466100921104     C* WRITE HISTORY REC
466200921104     C*
4663009102152369 C                   MOVE      'MDD'         TRCODE
4664009102152370 C                   MOVE      DPLAN#        MH1
4665009102152371 C                   MOVE      DSEQ#C        MH5
4666001401212373 C                   SETON                                          2547
466700140121     c                   exsr      #getsystime
466800140121      * adjust
466900140121     C                   EXSR      #hstadj
467000140121      * write hist
4671001401212374 C                   EXCEPT    histcov
4672001401212375 C                   SETOFF                                         2547
4673009102152376 C                   END
4674009102152377 C                   GOTO      #TCL03
4675009102152378 C     #TCL04        TAG
467600020319
467700020319      *   CANCEL PCP FOR MEMBER AND DEPENDENTS
467800020319     C     SSNO          SETLL     PCPR
467900020319     C     SSNO          READE     PCPR                                   90
468000020319     C                   DOW       *IN90 = *OFF
468100020506     C                   IF        PCCAN = *ZEROS
468200020319     C                   EVAL      PCCAN = CANDT
468300020506     C                   ENDIF
468400020520     C*                  EVAL      PCCUR = 'N'
468500020319     C                   UPDATE    PCPR
468600020319     C     SSNO          READE     PCPR                                   90
468700020319     C                   ENDDO
468800020320     C                   EVAL      *IN90 = *OFF
468900020319
4690009102152379 C*
4691009211042380 C* CANCEL DEPEND REC
4692009211042380 C*
4693009102152381 C                   SETOFF                                           98
4694009102152382 C     SSNO          SETLL     DEPEND
4695009102152383 C     #TCL05        TAG
4696009102152384 C     SSNO          READE     DEPEND                                 98
469700131213     C   98              EXCEPT    RELDEP
4698009102152385 C   98              GOTO      #TCL06
4699009102152386 C     DLTC3         IFEQ      'A'
4700009102152387 C                   MOVE      'C'           DLTC3
4701009102152388 C                   SETON                                        39
4702001312132389 C                   EXCEPT
4703009102152390 C                   SETOFF                                       39
470400130517      ******
470500130517      * write depend cancel hist rec
470600130517     c                   clear                   note2
470700140121     c                   clear                   ck#not
470800130517     c                   eval      trcode = 'MDT'
470900140121     c                   movel     'D#-'         d#fldwk           5
471000140121     c                   move      dseq#         d#fldwk
471100140121     c                   move      d#fldwk       ck#not
471200140121
471300140121     c**                 eval      note2 = 'Dep#-'
471400140121     c**                 move      dseq#         dseq#char
471500140121     c**                 cat       dseq#char:1   note2
471600140121     c**                 cat       'Code-':2     note2
471700140121     c                   cat       'Code-':0     note2
471800130517     c                   cat       cdkey:1       note2
471900130517     c                   eval      his_covtdt = termdtymd
472000130927     c                   exsr      #getsystime
472100140121      * adj not needed for depend cancel
472200140121     C**                 EXSR      #hstadj
472300131213     c                   except    histdep
472400140121     c                   clear                   ck#not
472500140121     c                   clear                   note2
472600130517      ******
4727009102152391 C                   END
472800130517
4729009102152392 C                   GOTO      #TCL05
4730009102152393 C     #TCL06        TAG
4731009102152394 C*
4732009102152395 C* UPDATE MEMBER COUNT IN ACCMST#
4733009102152396 C*
4734009102152397 C     TSA           CHAIN     ACCMST#                            H3
4735009102152398 C                   SUB       1             NOEMPL
4736001312132399 C                   EXCEPT    ACCU
473700111207
473800111207      * Update Payroll Status
473900111207     C                   Eval      webpay = #pchain(TRUST:SUBNO:ACCNO:SSNO)
474000111207     C                   If        PYSSN > 0
474100111207     C                   Eval      PYCHGUS = WQUSRN
474200111207     C                   Eval      PYSTS = 'T'
474300120911     C                   Eval      wwrtn = #pwrite(webpay)
474400111207     C                   End
4745009102152400 C*
4746009102152401 C* WRITE TERMINATION TRANSACTION RECORD AND CANCEL MEMBER STATUS
4747009102152402 C*
4748009102152403 C                   MOVE      CDKEY         HTRCOD            3
4749009102152404 C                   MOVE      CDKEY         TRCODE
4750009102152405 C                   MOVE      'C'           USTAT             1
475100981209y2k  C                   MOVE      TERMDT        MDCY#
475200981209y2k  C                   EXSR      #CYMD8
475300981209y2k  C                   MOVEL     CYMD#         HTRAND            8 0
475400981209y2k  C                   Z-ADD     HTRAND        TRANDT
475500981209      *
475600140121      * cancel member
4757001401212408 C                   EXCEPT    canmem
475800140121      * write hist
475900140121     c                   exsr      #getsystime
4760001401212408 C                   EXCEPT    hisdemo
476100920206     C                   MOVE      *BLANKS       TCODE
4762009102152411 C* DISPLAY SCREEN 1
4763009102152412 C*
476400910924     C     DCHECK        IFEQ      'Y'
476500910924     C                   Z-ADD     48            X                    50
476600910924     C                   EXSR      #DSPMC
476700910924     C                   SETON                                        13
476800910924     C                   END
476900910924     C     DCHECK        IFNE      'Y'
4770009102152413 C                   SETON                                        11
477100910924     C                   END
4772009102152414 C*
4773000008292415 C     #ENDT         ENDSR
4774009102152416 C/EJECT
4775009102152417 C****************************************************************
4776001305202419 C*-------------- MEMBER REINSTATEMENT ROUTINE ------------------*
4777009102152420 C*
4778009102152421 C     #REIN         BEGSR
4779009102152422 C*
4780009102152423 C* RETURN TO SCREEN 1 ON CMD 1
4781009102152424 C*
4782009102152425 C   KA              SETON                                        11
4783009102152426 C   KA              GOTO      #ENDR
4784009102152427 C*
4785000412152428 C* DISPLAY CODES IF REQUESTED (F22) THEN EXIT
4786001012210943 C* the field pos071parm is the start position of the window (across)
4787001012210943 C* FM071 is the 80 column version
4788001012210943 C*
478900041215     c                   if        *inkw
479000041215     c                   move      'E'           fm071parm         1
479100101221     c                   move      040           pos071parm
479200041215     c                   call      'FM071'
479300041215     c                   parm                    fm071parm
479400101221     c                   parm                    pos071parm
479500041215      * redisplay screen
4796000412152449 C                   SETON                                        17
4797000412152450 C                   GOTO      #ENDR
479800041215     c                   end
4799009102152434 C*
4800000412172435 C* EDIT REIN CODE AND DATE and retain cobra service
4801009102152436 C*
4802009102152437 C                   Z-ADD     REINDT        DATECK
4803009102152438 C                   EXSR      #DATCK
4804009102152439 C   98              SETON                                        52
4805009102152440 C   52              Z-ADD     4             X                    50
4806009102152442 C                   MOVE      'E'           CDTYPE
4807009102152443 C                   MOVE      RCODE         CDKEY
4808009102152444 C     CDKEY         CHAIN     CODES                              51
480900160621     c                   if        *in51 = *on or dltc6 <> 'A'
4810001606212445 C                   Z-ADD     6             X                    50
481100160621     c                   end
4812009102152446 C*
4813009206042441 C*  WJP 06/92 - HARD CODED EXCLUSION OF CODE 'ERA'....
481400920604     C*
481500920604     C     RCODE         IFEQ      'RA'
481600920604     C                   Z-ADD     6             X                    50
481700920604     C                   END
481800041217
481900041217     c                   if        retainc <> 'N' and retainc <> 'Y'
482000041217     c                   z-add     80            x                    50
482100041217     c                   end
482200041217
482300920604     C*
4824009506092447 C* IF MEMBER HAS A COBRA BALANCE - ERROR
4825009102152448 C*
482600950609     C                   MOVE      *ZEROS        TOTBAL            7 2
482700950609     C     PRVBAL        ADD       CURBAL        TOTBAL
482800950609     C     TOTBAL        IFNE      0
482900910430     C                   Z-ADD     38            X                    50
483000910430     C                   END
483100980202     C*
4832009802022447 C* IF ACCOUNT IS CANCELLED - ERROR
4833000110112448 C*
4834009802022470 C     TSA           CHAIN     ACCMST                             H3
483500040901      *---
483600040901      * If Special Handling Flag is Yes, then show Cmd8 to see notes.
483700040901      *---
483800040901     C                   Eval      *In78  = *Off
483900040901     C                   If        *InH3  = *Off
484000040901     C                   If        ASPHFL = 'Y'
484100040901     C                   Eval      *In78  = *On
484200040901     C                   End
484300040901     C                   End
484400011012     C                   if        aterm <> 0
484500011012     C                   if        cexpdt = 0
484600980202     C                   Z-ADD     65            X                    50
484700011012     c                   else
484800011012     C                   Z-ADD     74            X                    50
484900980202     C                   END
485000011012     C                   END
4851009104302446 C*
4852009104302447 C* REDISPLAY SCREEN AND EXIT IF ERROR
4853009104302448 C*
4854009102152449 C   50              SETON                                        17
4855009102152450 C   50              GOTO      #ENDR
485600130517
485700130517      * reinstate date selected on screen to YMD
485800130517y2k  C                   MOVE      REINDT        MDCY#
485900130517y2k  C                   EXSR      #CYMD8
486000130517y2k  C                   MOVEL     CYMD#         reindtymd         8 0
4861009102152451 C*
4862000002182452 C* LOOP AND REINSTATE DEPENDENTS
4863009102152453 C*
4864009102152454 C                   SETOFF                                           98
4865009102152455 C     SSNO          SETLL     DEPEND
4866009102152456 C     #RCL05        TAG
4867009102152457 C     SSNO          READE     DEPEND                                 98
486800131213     C   98              EXCEPT    RELDEP
4869009102152458 C   98              GOTO      #RCL06
4870009102152459 C     DLTC3         IFEQ      'C'
4871009102152460 C                   MOVE      'A'           DLTC3
4872009102152461 C                   SETON                                        39
4873001312132462 C                   EXCEPT
4874009102152463 C                   SETOFF                                       39
487500130517      ******
487600130517      * write depend reinstate hist rec
487700130517     c                   clear                   note2
487800140121     c                   clear                   ck#not
487900130517     c                   eval      trcode = 'MDF'
488000140121     c                   movel     'D#-'         d#fldwk
488100140121     c                   move      dseq#         d#fldwk
488200140121     c                   move      d#fldwk       ck#not
488300140121
488400140121     c**                 eval      note2 = 'Dep#-'
488500140121     c**                 move      dseq#         dseq#char
488600140121     c**                 cat       dseq#char:1   note2
488700140121     c**                 cat       'Code-':2     note2
488800140121     c                   cat       'Code-':0     note2
488900130517     c                   cat       cdkey:1       note2
489000130517     c                   eval      his_covtdt = reindtymd
489100130927     c                   exsr      #getsystime
489200140121      * adj not needed for depend reintated
489300140121     C**                 EXSR      #hstadj
489400131213     c                   except    histdep
489500140121     c                   clear                   ck#not
489600140121     c                   clear                   note2
489700130517      ******
4898009102152464 C                   END
489900130517
4900009102152465 C                   GOTO      #RCL05
4901009102152466 C     #RCL06        TAG
4902009102152467 C*
4903009102152468 C* UPDATE MEMBER COUNT IN ACCMST#
4904009102152469 C*
4905009802022470 C     TSA           CHAIN     ACCMST#                            H3
4906009102152471 C                   ADD       1             NOEMPL
4907001312132472 C                   EXCEPT    ACCU
4908009102152473 C*
4909009104302474 C* WRITE REINSTATE TRANSACTION RECORD AND UPDATE MEMBER STATUS
4910009102152475 C*
4911009102152476 C                   MOVE      CDKEY         HTRCOD            3
4912009102152477 C                   MOVE      CDKEY         TRCODE
4913009102152478 C                   MOVE      'A'           USTAT             1
491400981208y2k  C                   Z-ADD     *ZEROS        HTRAND            8 0
491500981208y2k  C                   MOVE      REINDT        MDCY#
491600981208y2k  C                   EXSR      #CYMD8
491700981208y2k  C                   MOVEL     CYMD#         TRANDT
491800111024
491900111024      * Payroll Rehire
492000111024     C                   Eval      webpay = #pchain(TRUST:SUBNO:ACCNO:SSNO)
492100111024     C                   If        PYSSN > 0 and
492200111024     C                             PYSTS = 'T'
492300111207     C                   Eval      PYCHGUS = WQUSRN
492400150325     C                   Eval      PYSTS = 'A'
492500120911     C                   Eval      wwrtn = #pwrite(webpay)
492600220110RFG1 C                   if        wwrtn <> *blanks
492700220111RFG1 C                   call      'WEBRFG'
492800220111RFG1 C                   parm                    WEBPAY
492900220111RFG1 C                   parm                    WQUSRN
493000220110RFG1 C                   end
493100111024     C                   End
493200041005
493300041005      * if retain cobra notification info =  Y, set on 93 to prevent
493400041005      * blanking out the notify code & date
493500041214      * (only check for letter only accounts)
493600041005
493700041005     c                   eval      *in93 = *off
493800041214     c                   if        acobsrv = 'L' and retainc = 'Y'
493900041005     c                   eval      *in93 = *on
494000041005     c                   end
494100981208      *
494200041214      * show retain info choice in hist rec
494300041215     c                   eval      ck#not = 'RETAIN NOTIFY INFO = ' +
494400041214     c                             retainc
494500041214
494600130927     c                   exsr      #getsystime
494700140121      * reinstate member
4948001401212481 C                   EXCEPT    reinmem
494900140121      * write hist
4950001401212481 C                   EXCEPT    hisdemo
495100041005     c                   eval      *in93 = *off
495200041214     c                   clear                   ck#not
4953009102152485 C*
495400920710     C                   EXSR      #DSPMC
495500920206     C                   MOVE      *BLANKS       RCODE
495600920710     C                   Z-ADD     *ZEROS        REINDT
495700920710     C**** ADDED WJP 071092 \/
495800920714     C                   SETOFF                                       89
495900920710     C                   SETON                                        1348
4960009902152485 C*
4961009902152485 C* FLIP DATES FROM MEMBER SCREEN TO YMD FOR LATER USE IN TRNMIT
4962009902152485 C* REC IF NEEDED
4963009902152485 C*
496400990215     C                   EXSR      #KIMBR
496500990215     C*
4966000008292488 C     #ENDR         ENDSR
4967009102152489 C/EJECT
4968009102152490 C****************************************************************
4969000002182492 C*------------- DEPENDENT TERMINATION ROUTINE ------------------*
4970009102152493 C*
4971009102152494 C     #DTERM        BEGSR
4972009102152495 C*
4973009102152496 C* RETURN TO SCREEN 1 ON CMD 1
4974009102152497 C*
4975009102152498 C   KA              SETON                                        14
4976009102152499 C   KA              GOTO      #ENDTD
4977001305172427 C*
4978001305172428 C* DISPLAY TERM CODES IF REQUESTED (F21) THEN EXIT
4979001305170943 C* the field pos071parm is the start position of the window (across)
4980001305170943 C* FM071 is the 80 column version
4981001305170943 C*
498200130517     c                   if        *inkv
498300130517     c                   move      'D'           fm071parm         1
498400130517     c                   move      040           pos071parm
498500130517     c                   call      'FM071'
498600130517     c                   parm                    fm071parm
498700130517     c                   parm                    pos071parm
498800130517      * redisplay dep reinstate screen (*In18)
4989001305172449 C                   SETON                                        18
4990001305172450 C                   GOTO      #ENDTD
499100130517     c                   end
499200130517
4993009102152507 C*
4994001606212284 C* EDIT TERM CODE AND DATE (only member level term codes allowed)
4995009102152509 C*
4996009102152510 C                   Z-ADD     TERMDT        DATECK
4997009102152511 C                   EXSR      #DATCK
4998009102152512 C   98              SETON                                        52
4999009102152513 C   52              Z-ADD     4             X                    50
5000009102152514 C*
5001009102152515 C                   MOVE      'D'           CDTYPE
5002009102152516 C                   MOVE      TCODE         CDKEY
5003009102152517 C     CDKEY         CHAIN     CODES                              51
500400160621     c                   if        *in51 = *on or actn2 = 'A' or
500500160621     c                             dltc6 <> 'A'
5006001606212518 C                   Z-ADD     6             X                    50
500700160621     c                   end
5008009102152519 C*
5009001305172520 C* REDISPLAY DEPEND TERM SCREEN (*IN18) AND EXIT IF ERROR
5010009102152521 C*
5011001305172522 C   50              SETON                                        18
5012009102152523 C   50              GOTO      #ENDTD
5013009102152524 C*
5014009102152525 C* LOOP AND TERMINATE DCOV
5015009102152527 C*
5016009102152528 C                   SETOFF                                       98  60
5017009102152529 C     SSNO          SETLL     DCOV
5018009102152530 C     #TDL01        TAG
5019009102152531 C     SSNO          READE     DCOV                                   98
502000140121     C   98              EXCEPT    reldcov
5021009102152532 C   98              GOTO      #TDL02
502200981222      *
502300981222y2k  C                   MOVE      TERMDT        MDCY#
502400981222y2k  C                   EXSR      #CYMD8
502500981222y2k  C                   MOVEL     CYMD#         TERMWK            8 0
502600981222      *
5027009102152533 C     DLTC5         IFEQ      'A'
5028009102152534 C     DSEQ#         IFEQ      DSEQ#C
5029009102152535 C*
5030009102152536 C     DCVPLK        CHAIN     PLNMST                             69
5031009102152537 C  N69PCARR         CHAIN     CARMST                             68
5032009102152538 C  N68TXMTYN        IFEQ      'Y'
503300040806
503400110720      * get mcov rec for group # but do not lock record for update
5035009102152539 C     SSNO          SETLL     MCOV
5036000412022540
5037009102152541 C     #TDL10        TAG
503800041202
5039000412022543 C     SSNO          READE(n)  MCOV                                   60
504000140121     C** 60              EXCEPT    relmcov
5041009102152544 C   60              GOTO      #TDL11
5042009102152545 C*
5043009102152546 C     DLTC2         IFEQ      'D'
5044009102152547 C                   GOTO      #TDL10
5045009102152548 C                   END
5046009102152549 C*
5047009102152550 C     DPLAN#        IFEQ      PLAN#
504800981222y2k  C                   MOVEL     TERMWK        HDCAND
504900981222y2k  C                   MOVEL     TERMWK        HCYMD
5050009102152553 C                   MOVE      GRTKEY        HRATE
5051009102152554 C                   EXSR      #GRATE
5052000305210867 C*
5053000305210867 C* IF NO RATE REC FOUND, USE today's date to find group #
5054000305210867 C*
5055000305210862 C     NOGRAT        IFEQ      'Y'
505600030521y2k  C                   Z-ADD     udcymd        HCYMD
5057000305210866 C                   EXSR      #GRATE
5058000305210864 C                   END
505900030521
5060009102152556 C                   MOVE      'DT'          ACTCOD
5061009102152557 C                   MOVE      TCODE         HTCODE
506200990129     C*
5063009901292320 C*
5064009901292320 C* EXECUTE #KIDEP TO CONVERT DEPEND DATES FROM MDY TO YMD FOR
5065009901292320 C* TRNMIT OUTPUT, THEN RUN #KIMBR AGAIN TO CONVERT BACK TO MDY
5066009901292320 C*
506700990129     C                   EXSR      #KIDEP
506800081029
506900081117      * Set defaults
507000081117     C                   Exsr      TRNCFS
507100081029
5072000909302065 C                   eval      trcode834 = 'T '
5073001312132558 C                   EXCEPT    DCADD2
5074000909302065 C                   clear                   trcode834
507500990129     C                   EXSR      #KIDEP
507600040806      * once trnmit has been written, leave mcov read loop
5077000408062561 C                   GOTO      #TDL11
5078009102152559 C                   END
5079009102152560 C*
5080009102152561 C                   GOTO      #TDL10
5081009102152562 C                   END
5082009102152563 C*
5083009102152564 C     #TDL11        TAG
5084009102152565 C*
5085009102152566 C                   MOVE      'C'           DLTC5
5086009812222567 C                   MOVE      TERMWK        TDCVDT
508700140121      * cancel dcov
5088001401212569 C                   EXCEPT    candcv2
508900131210    ***
5090001403142571 C************************************************************************
5091009102152572 C                   MOVE      'MDD'         TRCODE
5092009102152573 C                   MOVE      DPLAN#        MH1
5093009102152574 C                   MOVE      DSEQ#C        MH5
5094001402252574 C                   clear                   MH6
5095009812222575 C                   Z-ADD     TERMWK        TRANDT
5096001401212576 C                   SETON                                          2547
509700130927     c                   exsr      #getsystime
509800140121      * adjust
509900140121     C                   EXSR      #hstadj
510000140121      * write hist
5101001401212577 C                   EXCEPT    histcov
5102001401212578 C                   SETOFF                                         2547
5103009102152579 C                   END
5104009102152580 C                   END
510500140121
5106009102152581 C                   GOTO      #TDL01
5107009102152582 C     #TDL02        TAG
5108009102152583 C*
5109001305172585 C* CANCEL DEPENDT
5110009102152586 C*
5111009102152587 C                   MOVE      CDKEY         TRCODE            3
5112009102152588 C                   MOVE      'C'           DLTC3
5113009102152589 C                   MOVE      DSEQ#         HDSEQ#
5114009812222590 C                   Z-ADD     TERMWK        TRANDT            8 0
511500130517
511600140121      * write hist
5117001305172591 C                   SETON                                          39
5118001312132592 C                   EXCEPT
5119001305172593 C                   SETOFF                                         39
512000130517
512100130517      ******
512200130517      * write depend cancel hist rec
512300130517     c                   clear                   note2
512400140121     c                   clear                   ck#not
512500130517     c                   eval      trcode = 'MDT'
512600140121     c                   movel     'D#-'         d#fldwk
512700140121     c                   move      dseq#         d#fldwk
512800140121     c                   move      d#fldwk       ck#not
512900140121
513000140121     c**                 eval      note2 = 'Dep#-'
513100140121     c**                 move      dseq#         dseq#char
513200140121     c**                 cat       dseq#char:1   note2
513300140121     c**                 cat       'Code-':2     note2
513400140121     c                   cat       'Code-':0     note2
513500130517     c                   cat       cdkey:1       note2
513600130517     c                   eval      his_covtdt = trandt
513700130927     c                   exsr      #getsystime
513800140121      * write hist
513900131213     c                   except    histdep
514000140121     c                   clear                   ck#not
514100140121     c                   clear                   note2
514200130517      ******
514300020320
514400020320      *   CANCEL PCP FOR DEPENDENT
514500020320     C     DEPKEY        SETLL     PCPR
514600020320     C     DEPKEY        READE     PCPR                                   91
514700020320     C                   DOW       *IN91 = *OFF
514800020506     C                   IF        PCCAN = *ZEROS
514900020320y2k  C                   MOVE      TERMDT        MDCY#
515000020320y2k  C                   EXSR      #CYMD8
515100020320y2k  C                   MOVEL     CYMD#         HCYMD
515200020320     C                   EVAL      PCCAN = HCYMD
515300020506     C                   ENDIF
515400020520     C*                  EVAL      PCCUR = 'N'
515500020320     C                   UPDATE    PCPR
515600020320     C     DEPKEY        READE     PCPR                                   91
515700020320     C                   ENDDO
515800020320     C                   EVAL      *IN91 = *OFF
515900020320
5160009102152594 C*
5161000002182595 C* DISPLAY SCREEN 1 OR NEXT DEPENDENT
5162009102152596 C*
5163001203202597 C                   SETON                                        11
5164009102152598 C*
5165000008292599 C     #ENDTD        ENDSR
5166009102152600 C/EJECT
5167009102152601 C****************************************************************
5168000002182603 C*----------------- DEPENDENT REINSTATEMENT ROUTINE ------------*
5169009102152604 C*
5170009102152605 C     #DREIN        BEGSR
5171009102152606 C*
5172009102152607 C* RETURN TO SCREEN 1 ON CMD 1
5173009102152608 C*
5174009102152609 C   KA              SETON                                        11
5175009102152610 C   KA              GOTO      #ENDRD
5176001305172427 C*
5177001305172428 C* DISPLAY REINSTATE CODES IF REQUESTED (F22) THEN EXIT
5178001305170943 C* the field pos071parm is the start position of the window (across)
5179001305170943 C* FM071 is the 80 column version
5180001305170943 C*
518100130517     c                   if        *inkw
518200130517     c                   move      'E'           fm071parm         1
518300130517     c                   move      040           pos071parm
518400130517     c                   call      'FM071'
518500130517     c                   parm                    fm071parm
518600130517     c                   parm                    pos071parm
518700130517      * redisplay dep reinstate screen (*In19)
5188001305172449 C                   SETON                                        19
5189001305172450 C                   GOTO      #ENDRD
519000130517     c                   end
5191009102152618 C*
5192009102152619 C* EDIT TERM CODE AND DATE
5193009102152620 C*
5194009102152621 C                   Z-ADD     REINDT        DATECK
5195009102152622 C                   EXSR      #DATCK
5196009102152623 C   98              SETON                                        52
5197009102152624 C   52              Z-ADD     4             X                    50
5198009102152625 C*
5199009102152626 C                   MOVE      'E'           CDTYPE
5200009102152627 C                   MOVE      RCODE         CDKEY
5201009102152628 C     CDKEY         CHAIN     CODES                              51
520200160621     c                   if        *in51 = *on or dltc6 <> 'A'
5203001606212629 C                   Z-ADD     6             X                    50
520400160621     c                   end
5205009102152630 C*
5206001305172631 C* REDISPLAY DEP REINSTATE SCREEN (*IN19) AND EXIT IF ERROR
5207009102152632 C*
5208001305172633 C   50              SETON                                        19
5209009102152634 C   50              GOTO      #ENDRD
5210009102152636 C*
5211001305172637 C* REINSTATE DEPENDENT
5212009102152638 C*
5213009102152639 C                   MOVE      CDKEY         TRCODE            3
5214009102152640 C                   MOVE      'A'           DLTC3
5215000010022641 C                   MOVE      DSEQ#         HDSEQ#
521600981222      *
521700981222y2k  C                   MOVE      REINDT        MDCY#
521800981222y2k  C                   EXSR      #CYMD8
521900981222y2k  C                   MOVEL     CYMD#         TRANDT
522000130517
522100140121      * write hist
5222001305172643 C                   SETON                                          39
5223001312152644 C                   EXCEPT
5224001305172645 C                   SETOFF                                         39
522500130517
522600130517      ******
522700130517      * write depend reinstate hist rec
522800130517     c                   clear                   note2
522900140121     c                   clear                   ck#not
523000130517     c                   eval      trcode = 'MDF'
523100140121     c                   movel     'D#-'         d#fldwk
523200140121     c                   move      dseq#         d#fldwk
523300140121     c                   move      d#fldwk       ck#not
523400140121
523500140121     c**                 eval      note2 = 'Dep#-'
523600140121     c**                 move      dseq#         dseq#char
523700140121     c**                 cat       dseq#char:1   note2
523800140121     c**                 cat       'Code-':2     note2
523900140121     c                   cat       'Code-':0     note2
524000130517     c                   cat       cdkey:1       note2
524100130517     c                   eval      his_covtdt = trandt
524200130927     c                   exsr      #getsystime
524300130517     c                   except    histdep
524400140121     c                   clear                   ck#not
524500140121     c                   clear                   note2
524600130517      ******
5247009102152646 C*
5248009102152647 C* DISPLAY SCREEN 1
5249009102152648 C*
5250009102152649 C                   SETON                                        11
5251009102152650 C*
5252000008292651 C     #ENDRD        ENDSR
5253009102152652 C/EJECT
5254009102152653 C****************************************************************
5255009102152656 C*----------------------- EDIT ---------------------------------*
5256009102152657 C*
5257009102152658 C     #EDIT         BEGSR
5258009102152659 C                   SETOFF                                       50
5259001112062659 C                   clear                   badcharsout
5260000304102660 C*
5261009102152665 C* VALIDATE COB BC/BS
5262009102152666 C*
5263000109072667 C     COBBCF        COMP      'Y'                                    98
5264000109072668 C  N98COBBCF        COMP      'N'                                    98
5265000109072669 C  N98              Z-ADD     73            X                    50
5266000109072670 C                   SETOFF                                           98
5267009102152671 C*
5268001012152672 C* VALIDATE non-ssn
5269009102152673 C*
5270001012152674 C                   if        mnonssn <> 'Y' and mnonssn <> ' '
5271001012152676 C                   Z-ADD     86            X                    50
527200101215     c                   end
5273001012152671 C*
5274001012152672 C* VALIDATE COB
5275001012152673 C*
5276001012152674 C     COBX          COMP      'Y'                                6767
5277001012152675 C   67COBX          COMP      'N'                                6767
5278001012152676 C   67              Z-ADD     73            X                    50
5279009102152677 C*
5280001406112678 C* VALIDATE HANDICAP codes (match Care First)
5281001408122679 C* 1 = short term disability
5282001406112679 C* 2 = long term disability
5283001406112679 C* 3 = permanent / total disability
5284001406112679 C*
528500140611     c                   eval      *in66 = *off
528600140611     c                   if        hndicp <> ' ' and hndicp <> '1' and
528700140611     c                             hndicp <> '2' and hndicp <> '3'
528800140611     c                   eval      *in66 = *on
5289001406112682 C                   Z-ADD     14            X                    50
529000140611     c                   end
529100140611
5292009102152683 C*
5293001807162684 C* VALIDATE MEDICARE
5294009102152685 C*
529500180713       if medicr <> 'Y' and medicr <> 'N';
529600191107         eval *in65 = *on;  // 65 = position cursor
529700191107         eval x = 018;
529800191107         eval *in50 = *on;
529900180713       endif;
530000180713
5301009102152699 C*
5302009105212700 C* VALIDATE EMPLOYMENT STATUS, IF WAIVER CODE - SKIP EDIT
5303009102152701 C*
5304009105162702 C                   MOVE      *BLANKS       CDKEY
5305009105162703 C                   MOVE      'J'           CDTYPE
5306009105162704 C                   MOVE      EMPST         CD3
530700910516     C     CDKEY         CHAIN     CODES                              63
530800160621     c                   if        *in63 = *on or dltc6 <> 'A'
5309001606212705 C                   Z-ADD     15            X                    50
531000160621     c                   end
5311000602212699 C*
531200110916     C* validate cost center against "use cost center" field in ac2mst
531300120417     C*
531400110916     C     acckey        CHAIN     ac2mstl2
531500110916      * acct does use cost centers, it must not be blank
531600120417     C* 4/17/12 - allow F11 - skip edit, per Shelly request
531700110916     c                   if        %found(ac2mstl2) and
531800110916     c                             (a2usecc =  'Y' and ccflg  = *blanks)
5319001204172705 C  nkk              Z-ADD     84            X                    50
532000110919     c                   goto      #skipccck
532100110916     c                   end
532200110916
532300110916      * acct does NOT use cost centers, it must be blank
532400110916     c                   if        (not %found(ac2mstl2) and ccflg <> *blanks)
532500110916     c                             or
532600110916     c                             (%found(ac2mstl2) and
532700110916     c                             a2usecc <> 'Y' and ccflg <> *blanks)
5328001110252705 C                   Z-ADD     101           X                    50
532900110919     c                   goto      #skipccck
533000110916     c                   end
533100110916
533200110916
533300111118     C* Validate Cost Center: Must begin with Y and be in CODES file
533400111118     C* and be active
533500110916     C                   If        CCFLG <> *Blanks
533600110916     C                   If        %SUBST(ccflg:1:1) = 'Y'
533700110916     C     CCFLG         Chain     CODES
533800111118     C                   If        not %found(codes) or dltc6 <> 'A'
5339001204202705 C                   Z-ADD     102           X                    5070
534000060221     C                   End
534100060221     C                   Else
5342001204202705 C                   Z-ADD     102           X                    5070
534300060221     C                   End
534400060221     C                   End
534500110919
534600110919     c     #skipccck     tag
534700050928     C*
534800050928     C* Validate Ineligible for LIFE (Y is ineligble/Blank is eligible)
534900050928     C*
535000050928     C                   If        INLIF    <>   'Y'     And
535100050928     C                             INLIF    <>   *Blank
535200050928     C                   Eval      *In84    =    *On
535300050928     C                   Z-add     82            X                    50
535400050928     C                   End
535500050928     C*
535600050928     C* Validate Ineligible for AD&D (Y is ineligble/Blank is eligible)
535700050928     C*
535800050928     C                   If        INADD    <>   'Y'     And
535900050928     C                             INADD    <>   *Blank
536000050928     C                   Eval      *In82    =    *On
536100050928     C                   Z-add     83            X                    50
536200050928     C                   End
536300050628     C*
536400050628     C* Validate Non-Employee (Y = non-employee/blank = employee)
536500050628     C*
536600050628     C                   If        NONEMP   <>   'Y'     And
536700050628     C                             NONEMP   <>   *Blank
536800050628     C                   Eval      *In83    =    *On
536900050628     C                   Z-add     81            X                    50
537000050628     C                   End
5371001411122706  *
5372001411122707  * VALIDATE ENROLLMENT DATE
5373001411122706  *
5374009812022709 C                   Z-ADD     MENRDT        DATECK
5375009102152710 C                   EXSR      #DATCK
5376009104172711 C   98              SETON                                        49
5377009104172712 C   49              Z-ADD     37            X                    50
5378001411122723  * save in ymd format for later use
537900141112y2k  C                   MOVE      menrdt        MDCY#
538000141112y2k  C                   EXSR      #CYMD8
538100141112y2k  C                   MOVEL     CYMD#         menrdt_ymd        8 0
5382009812022723 C*
5383009812022724 C* VALIDATE BIRTH DATE
5384009812022725 C*
5385009812022726 C                   Z-ADD     BIRTH         DATECK
5386009812022727 C                   EXSR      #DATCK
5387001012152728 C   98              SETON                                        59
5388009812022729 C   59              Z-ADD     4             X                    50
5389001402112730
539000140211      * birth date must be in the past
539100140211y2k  C                   MOVE      BIRTH         MDCY#
539200140211y2k  C                   EXSR      #CYMD8
539300140320y2k  C                   MOVEL     CYMD#         birth_ymd         8 0
539400140320     C                   if        birth_ymd > udcymd
5395001402112729 C                   Z-ADD     4             X                    50
539600140211     C                   SETON                                        59
539700140211     C                   END
539800140211
539900140211     C*  VALIDATE THAT MEMBER MUST AT LEAST 12 YEARS OLD
540000140318     C*  3/12/99 - E&B REQUEST REMOVAL OF MINIMUM AGE EDIT.
540100990312     C*
540200140318y2k  C*          UDCY    SUB    BCY       BAGE    30
540300140318y2k  C*          UDMM      IFNE 12
540400140318y2k  C*          UDMM      IFLT BMO
540500140318     C*                    SUB  1         BAGE
540600140318     C*                    END
540700140318     C*                    END
540800990312     C*
540900990312     C*          BAGE      IFLT 12
541000990312     C*                    Z-ADD4         X          50
541100990312     C*                    SETON                     59
541200990312     C*                    END
541300140318
541400140318      * 3/18/14 - add max age edit to prevent bad birthdates
541500140318     c                   eval      bage = udcy - bcy
541600140318     c                   if        udmm <> 12 and udmm < bmo
541700140318     c                   sub       1             bage
541800140318     c                   end
541900140318
542000140318      * only check for active existing member or new member
542100140318     c                   if        ((*in41 = *on) or
542200140318     c                             (*in41 = *off and scheck = 'A')) and
542300140318     c                             bage > maxvalidage
542400140318     c                   z-add     105           x                    50
542500140318     c                   seton                                        59
542600140318     c                   end
542700140318
5428009104172706 C*
5429009104172707 C* VALIDATE EMPLOYMENT DATE
5430009104172708 C*
5431009812022709 C                   Z-ADD     EMPDT         DATECK
5432009104172710 C                   EXSR      #DATCK
5433009104172711 C   98              SETON                                        62
5434009104172712 C   62              Z-ADD     4             X                    50
543500140320
543600140320y2k  C                   MOVE      empdt         MDCY#
543700140320y2k  C                   EXSR      #CYMD8
543800140320y2k  C                   MOVEL     CYMD#         empdt_ymd         8 0
543900140618
544000140618      * 3/20/14 employment date must also be after birth date
544100140618      * only check for active existing member or new member
544200140320     c                   if        ((*in41 = *on) or
544300140320     c                             (*in41 = *off and scheck = 'A')) and
544400140320     C                             empdt_ymd <= birth_ymd
5445001403202729 C                   Z-ADD     106           X                    50
544600140320     C                   SETON                                        62
544700140320     C                   END
544800140320y2k  C                   clear                   birth_ymd
544900140320
5450009812022690 C*
5451009812022691 C* VALIDATE MARRIAGE DATE
5452009812022692 C*
5453009812022693 C     MARDT         IFNE      0
5454009812022694 C                   Z-ADD     MARDT         DATECK
5455009812022695 C                   EXSR      #DATCK
5456009812022696 C   98              SETON                                        64
5457009812022697 C   64              Z-ADD     4             X                    50
5458009812022698 C                   END
5459009901272690 C*
5460009901272691 C* VALIDATE MEDICARE A DATE
5461009901272692 C*
5462009901272693 C     MEDADT        IFNE      0
5463009901272694 C                   Z-ADD     MEDADT        DATECK
5464009901272695 C                   EXSR      #DATCK
5465009901272696 C   98              SETON                                        74
5466009901272697 C   74              Z-ADD     4             X                    50
5467009901272698 C                   END
5468009901272690 C*
5469009901272691 C* VALIDATE MEDICARE B DATE
5470009901272692 C*
5471009901272693 C     MEDBDT        IFNE      0
5472009901272694 C                   Z-ADD     MEDBDT        DATECK
5473009901272695 C                   EXSR      #DATCK
5474009901272696 C   98              SETON                                        75
5475009901272697 C   75              Z-ADD     4             X                    50
5476009901272698 C                   END
5477009901272690 C*
5478009901272691 C* VALIDATE HANDICAPPED DATE
5479009901272692 C*
5480009901272693 C     HDCPDT        IFNE      0
5481009901272694 C                   Z-ADD     HDCPDT        DATECK
5482009901272695 C                   EXSR      #DATCK
5483009901272696 C   98              SETON                                        76
5484009901272697 C   76              Z-ADD     4             X                    50
5485009901272698 C                   END
5486009102152713 C*
5487009102152714 C* VALIDATE ACCOUNT #
5488009102152715 C*
5489009102152716 C     TSA           CHAIN     ACCMST                             61
5490009102152717 C   61              Z-ADD     7             X                    50
549100110913
549200110913      * If Payroll Account Must have Screen 1 + 2 already filled out.
549300110913     C                   If        *in61 = *off
549400110913     C                   Exsr      CHECKPAYROLL
549500110913     C                   If        PayChoice = 'Y'
549600110913     C                   Eval      webpay = #pchain(TRUST:SUBNO:ACCNO:SSNO)
549700110913     C                   If        pyssn = 0
549800111103     C*** hold for now   Z-ADD     93  shelly    X                    50
549900110913     C                   End
550000110913     C                   End
550100110913     C                   End
550200110913
550300011012
550400011012     C* do not allow maintenance to member in cancelled account
550500020204     C* Unless member is not active (89) Address changes are welcome.
5506000110122448 C* 10/11/01  allow access to COBRA member in cancelled acct
550700011012
550800020204     C                   if        aterm <> 0 and cexpdt = 0 and
550900020204     C                             *in89 =  *off
551000950925     C                   Z-ADD     63            X                    50
551100950925     C                   END
5512009102152718 C*
5513009102152719 C* VALIDATE PHONE #
5514000309222720 C* 09/22/03 - remove edit
5515000309222720 C*
551600030922     C*    PHONE         IFLE      *ZEROS
551700030922     C*                  Z-ADD     3             X
551800030922     C*                  SETON                                        50  60
551900030922     C*                  END
552000030922     C*    AREA          IFLE      *ZEROS
552100030922     C*                  Z-ADD     3             X
552200030922     C*                  SETON                                        50  60
552300030922     C*                  END
552400981202      *
5525009102152731 C* VALIDATE SEX
5526009102152732 C*
5527009102152733 C     SEX           COMP      'M'                                5858
5528009102152734 C   58SEX           COMP      'F'                                5858
5529009102152735 C   58              Z-ADD     5             X                    50
5530009102152736 C*
5531009102152737 C* CHECK FOR REQUIRED FIELDS LEFT BLANK
5532009102152738 C*
5533000008212739 C*******    ZIP       COMP *ZEROS                   57
5534009102152740 C   57              Z-ADD     3             X                    50
5535009102152741 C*
5536009102152742 C     STATE         COMP      *BLANK                                 56
5537009102152743 C   56              Z-ADD     3             X                    50
5538009102152744 C*
5539009102152745 C     CITY          COMP      *BLANK                                 55
5540009102152746 C   55              Z-ADD     3             X                    50
5541009102152747 C*
5542009102152748 C     ADDR1         COMP      *BLANK                                 54
5543009102152749 C   54              Z-ADD     3             X                    50
554400111025
554500111025      * check address for invalid characters (per Care First 834 rules)
554600111025      * addr 1
554700111025     c                   clear                   chartstfld
554800111025     c                   movel     addr1         chartstfld
554900111025     c                   move      'ADDR'        whattstfld
555000111025     c                   exsr      #testchar
555100111025     c                   if        badcharfnd = 'Y'
555200111206     c                   move      badcharswk    badcharsout
555300111025     c                   eval      *in54 = *on
555400111025     c                   z-add     97            x                    50
555500111025     c                   end
555600111025
555700111025      * addr 2
555800111025     c                   clear                   chartstfld
555900111025     c                   movel     addr2         chartstfld
556000111025     c                   move      'ADDR'        whattstfld
556100111025     c                   exsr      #testchar
556200111025     c                   if        badcharfnd = 'Y'
556300111206     c                   move      badcharswk    badcharsout
556400111025     c                   eval      *in71 = *on
556500111025     c                   z-add     98            x                    50
556600111025     c                   end
556700111025
556800111025      * city
556900111025     c                   clear                   chartstfld
557000111025     c                   movel     city          chartstfld
557100111025     c                   move      'ADDR'        whattstfld
557200111025     c                   exsr      #testchar
557300111025     c                   if        badcharfnd = 'Y'
557400111206     c                   move      badcharswk    badcharsout
557500111025     c                   eval      *in55 = *on
557600111025     c                   z-add     99            x                    50
557700111025     c                   end
557800111025
557900111025      * state
558000111025     c                   clear                   chartstfld
558100111025     c                   movel     state         chartstfld
558200111025     c                   move      'ADDR'        whattstfld
558300111025     c                   exsr      #testchar
558400111025     c                   if        badcharfnd = 'Y'
558500111206     c                   move      badcharswk    badcharsout
558600111025     c                   eval      *in56 = *on
558700111025     c                   z-add     100           x                    50
558800111025     c                   end
558900111025
559000111025
559100111025      * member name edit
5592009102152750 C*
5593009102152751 C*          MI        COMP *BLANK                   53
5594009102152752 C*  53                Z-ADD3         X          50
5595009102152753 C*
5596009102152754 C     FNAME         COMP      *BLANK                                 52
5597009102152755 C   52              Z-ADD     3             X                    50
5598009102152756 C*
5599009102152757 C     LNAME         COMP      *BLANK                                 51
5600009102152758 C   51              Z-ADD     3             X                    50
5601009102152759 C*
560200111025      * check name for invalid characters (per Care First 834 rules)
560300111025      * first name
560400111025     c                   clear                   chartstfld
560500111025     c                   movel     fname         chartstfld
560600111025     c                   move      'NAME'        whattstfld
560700111025     c                   exsr      #testchar
560800111025     c                   if        badcharfnd = 'Y'
560900111206     c                   move      badcharswk    badcharsout
561000111025     c                   eval      *in52 = *on
561100111025     c                   z-add     94            x                    50
561200111025     c                   end
561300111025
561400111025      * last name
561500111025     c                   clear                   chartstfld
561600111025     c                   movel     lname         chartstfld
561700111025     c                   move      'NAME'        whattstfld
561800111025     c                   exsr      #testchar
561900111025     c                   if        badcharfnd = 'Y'
562000111206     c                   move      badcharswk    badcharsout
562100111025     c                   eval      *in51 = *on
562200111025     c                   z-add     95            x                    50
562300111025     c                   end
562400111025
562500111025      * middle initial
562600111025     c                   clear                   chartstfld
562700111025     c                   movel     mi            chartstfld
562800111025     c                   move      'NAME'        whattstfld
562900111025     c                   exsr      #testchar
563000111025     c                   if        badcharfnd = 'Y'
563100111206     c                   move      badcharswk    badcharsout
563200111025     c                   eval      *in53 = *on
563300111025     c                   z-add     96            x                    50
563400111025     c                   end
563500111025
563600041015
563700041015      * if no other error was found -
563800041015      * if the member was not found, check if it was added since this
563900041015      * session started
564000041015
564100041015     c                   if        not *in50  and *in41 = *on
564200041015     c     ssno          setll     member
564300041015     c                   if        %equal(member)
5644000410152758 C                   Z-ADD     79            X                    50
564500041015     c                   end
564600041015     c                   end
564700041015
5648000008292760 C     #ENDE         ENDSR
5649009102152761 C/EJECT
5650009102152762 C****************************************************************
5651000002182765 C*----------------------- EDIT DEPENDENT -----------------------*
5652009102152766 C*
5653009102152767 C     #EDITD        BEGSR
5654009102152768 C                   SETOFF                                       50
565500111208     c                   clear                   badcharsout
5656009102152773 C*
5657009102152774 C* VALIDATE COB BC/BS
5658009102152775 C*
5659009102152776 C     DCOBBC        COMP      'Y'                                    98
5660009102152777 C  N98DCOBBC        COMP      'N'                                    98
5661000109072778 C  N98              Z-ADD     73            X                    50
5662009102152779 C                   SETOFF                                           98
5663009102152780 C*
5664009102152781 C* VALIDATE COB
5665009102152782 C*
5666009102152783 C     DCOB          COMP      'Y'                                6767
5667009102152784 C   67DCOB          COMP      'N'                                6767
5668000109072785 C   67              Z-ADD     73            X                    50
5669009102152786 C*
5670001406112678 C* VALIDATE HANDICAP codes (match Care First)
5671001406112679 C* 1 = short term disablility
5672001406112679 C* 2 = long term disability
5673001406112679 C* 3 = permanent / total disability
5674001406112679 C*
567500140611     c                   eval      *in66 = *off
567600140611     c                   if        dhndcp <> ' ' and dhndcp <> '1' and
567700140611     c                             dhndcp <> '2' and dhndcp <> '3'
567800140611     c                   eval      *in66 = *on
5679001406112682 C                   Z-ADD     14            X                    50
568000140611     c                   end
568100220928
568200220928J001 C                   if        DMEDAD <> *zeros
568300220928 |   C                   MOVE      DMEDAD        DATECK
568400220928 |   C                   EXSR      #DATCK
568500220928 |   C   98              SETON                                        68
568600220928 |   C   68              Z-ADD     4             X                    50
568700220928J001 C                   end
568800220928
568900220928J001 C                   if        DMEDBD <> *zeros
569000220928 |   C                   MOVE      DMEDBD        DATECK
569100220928 |   C                   EXSR      #DATCK
569200220928 |   C   98              SETON                                        69
569300220928 |   C   69              Z-ADD     4             X                    50
569400220928J001 C                   end
569500220928
569600220928J001 C     DHDDT         IFNE      0
569700220928 |   C                   Z-ADD     DHDDT         DATECK
569800220928 |   C                   EXSR      #DATCK
569900220928 |   C   98              SETON                                        76
570000220928 |   C   76              Z-ADD     4             X                    50
570100220928J001 C                   END
570200140611
5703009102152792 C*
5704001807162793 C* VALIDATE MEDICARE
5705009102152794 C*
570600180713       if dmedcr <> 'Y' and dmedcr <> 'N';
570700191107         eval *in65 = *on;  // 65 = position cursor
570800191107         eval x = 018;
570900191107         eval *in50 = *on;
571000180713       endif;
571100180713
5712009102152799 C*
5713009102152800 C* VALIDATE STUDENT
571400021015
5715009102152802 C     DSTUDN        COMP      'Y'                                6464
5716009102152803 C   64DSTUDN        COMP      'N'                                6464
5717001104292804 C   64              Z-ADD     91            X                    50
5718000210182805 C*
571900021018     C* VALIDATE EFFECTIVE DATE & SCHOOL NAME (IF ENTERED)
572000021018     C
572100021018     C     DSEFFD        IFEQ      *BLANKS
572200021018     C     DSSCHL        IFNE      *BLANKS
572300021018     C                   SETON                                        74
572400021018     C                   Z-ADD     75            X                    50
572500021018     C                   ENDIF
572600021018     C                   ELSE
572700021018     C                   MOVE      DSEFFD        DATECK
572800021018     C                   EXSR      #DATCK
572900021018     C   98              SETON                                        74
573000021018     C   74              Z-ADD     4             X                    50
573100021018     C                   ENDIF
573200021018
573300021018     C     DSSCHL        IFEQ      *BLANKS
573400021018     C     DSEFFD        IFNE      *BLANKS
573500021018     C                   SETON                                        75
573600021018     C                   Z-ADD     75            X                    50
573700021018     C                   ENDIF
573800021018     C                   ENDIF
573900021018
5740009102152805 C*
5741009102152806 C* VALIDATE BIRTH DATE
5742009102152807 C*
5743009102152808 C                   Z-ADD     DBIRTH        DATECK
5744009102152809 C                   EXSR      #DATCK
5745009102152810 C   98              SETON                                        61
5746009102152811 C   61              Z-ADD     4             X                    50
5747001402112730
574800140211      * birth date must be in the past
574900140211y2k  C                   MOVE      dbirth        MDCY#
575000140211y2k  C                   EXSR      #CYMD8
575100140211y2k  C                   MOVEL     CYMD#         dbirthymd         8 0
575200140211     C                   if        dbirthymd > udcymd
5753001402112729 C                   Z-ADD     4             X                    50
575400140211     C                   SETON                                        61
575500140211     C                   END
575600140211y2k  C                   clear                   dbirthymd
575700220927
5758009610173832 C*
5759001407143833 C* VALIDATE AGE - ACTIVE DEPENDENTS (NOT HU OR WI) GET WARNING MESSAGE
5760001407143834 C* FOR AGE > 18. Press F11 to skip msg
576100140318     c                   if        *inkk or (*in43 = *off and dltc3 <> 'A')
576200961023     C                   GOTO      #SKPKK
576300961023     C                   END
576400140318
576500140318     c                   eval      bage = udcy - yy
576600140318     c                   if        umonth <> 12 and umonth < mm
576700140318     c                   sub       1             bage
576800140318     c                   end
576900110621
577000110621     c                   if        (drelc2 <> 'HU' and drelc2 <> 'WI' and
577100110621     c                              drelc2 <> 'DP' and drelc2 <> 'PA') and
577200140318     c                             bage > 18
5773009610172810 C                   SETON                                        61
5774009610172791 C                   Z-ADD     64            X                    50
5775009610173840 C                   END
5776001403193834
577700961017     C     #SKPKK        TAG
577800140714
577900140714      * 3/19/14 - add max age edit to prevent bad birthdates
578000140714      * only check for active existing dependent or new dependent(in43=on)
578100140714     c                   if        ((*in43 = *on) or
578200140714     c                             (*in43 = *off and dltc3 = 'A')) and
578300140714     c                             bage > maxvalidage
578400140714     c                   z-add     105           x                    50
578500140714     c                   seton                                        61
578600140714     c                   end
578700140714
5788009102152812 C*
5789009102152813 C* VALIDATE SEX
5790009102152814 C*
5791009102152815 C     DSEX          IFNE      'M'
5792009102152816 C     DSEX          IFNE      'F'
5793009102152817 C                   Z-ADD     5             X
5794009102152818 C                   SETON                                        5060
5795009102152819 C                   END
5796009102152820 C                   END
5797009102152848 C*
5798009102152849 C* CHECK FOR ADDRESS FIELDS IF ADDR1 NE 'SAME'
5799009102152850 C*
5800009102152851 C     DADDR1        IFNE      SA(1)
5801009102152852 C*
5802000004242853 C*          DPHONE    COMP *ZEROS                   62
5803000004242854 C*  62                Z-ADD3         X          50
5804009102152855 C*
5805000008212856 C***        DZIP      COMP *ZEROS                   59
5806009102152857 C   59              Z-ADD     3             X                    50
5807009102152858 C*
5808009102152859 C     DSTATE        COMP      *BLANK                                 58
5809009102152860 C   58              Z-ADD     3             X                    50
5810009102152861 C*
5811009102152862 C     DCITY         COMP      *BLANK                                 57
5812009102152863 C   57              Z-ADD     3             X                    50
5813009102152864 C*
5814009102152865 C     DADDR1        COMP      *BLANK                                 55
5815009102152866 C   55              Z-ADD     3             X                    50
581600111025
581700111025      * check depend address for invalid characters (Care First 834 rules)
581800111025      * addr 1
581900111025     c                   clear                   chartstfld
582000111025     c                   movel     daddr1        chartstfld
582100111025     c                   move      'ADDR'        whattstfld
582200111025     c                   exsr      #testchar
582300111025     c                   if        badcharfnd = 'Y'
582400111208     c                   move      badcharswk    badcharsout
582500111025     c                   eval      *in55 = *on
582600111025     c                   z-add     97            x                    50
582700111025     c                   end
582800111025
582900111025      * addr 2
583000111025     c                   clear                   chartstfld
583100111025     c                   movel     daddr2        chartstfld
583200111025     c                   move      'ADDR'        whattstfld
583300111025     c                   exsr      #testchar
583400111025     c                   if        badcharfnd = 'Y'
583500111208     c                   move      badcharswk    badcharsout
583600111025     c                   eval      *in56 = *on
583700111025     c                   z-add     98            x                    50
583800111025     c                   end
583900111025
584000111025      * city
584100111025     c                   clear                   chartstfld
584200111025     c                   movel     dcity         chartstfld
584300111025     c                   move      'ADDR'        whattstfld
584400111025     c                   exsr      #testchar
584500111025     c                   if        badcharfnd = 'Y'
584600111208     c                   move      badcharswk    badcharsout
584700111025     c                   eval      *in57 = *on
584800111025     c                   z-add     99            x                    50
584900111025     c                   end
585000111025
585100111025      * state
585200111025     c                   clear                   chartstfld
585300111025     c                   movel     dstate        chartstfld
585400111025     c                   move      'ADDR'        whattstfld
585500111025     c                   exsr      #testchar
585600111025     c                   if        badcharfnd = 'Y'
585700111208     c                   move      badcharswk    badcharsout
585800111025     c                   eval      *in58 = *on
585900111025     c                   z-add     100           x                    50
586000111025     c                   end
586100111025
5862009102152867 C* END ADDRESS CHECK
5863009102152868 C                   END
5864009102152869 C*
5865009102152870 C     DFNAME        COMP      *BLANK                                 53
5866009102152871 C   53              Z-ADD     3             X                    50
5867009102152872 C*
5868009102152873 C     DLNAME        COMP      *BLANK                                 52
5869009102152874 C   52              Z-ADD     3             X                    50
587000111025
587100111025      * check depend name for invalid characters (per Care First 834 rules)
587200111025      * first name
587300111025     c                   clear                   chartstfld
587400111025     c                   movel     dfname        chartstfld
587500111025     c                   move      'NAME'        whattstfld
587600111025     c                   exsr      #testchar
587700111025     c                   if        badcharfnd = 'Y'
587800111208     c                   move      badcharswk    badcharsout
587900111025     c                   eval      *in53 = *on
588000111025     c                   z-add     94            x                    50
588100111025     c                   end
588200111025
588300111025      * last name
588400111025     c                   clear                   chartstfld
588500111025     c                   movel     dlname        chartstfld
588600111025     c                   move      'NAME'        whattstfld
588700111025     c                   exsr      #testchar
588800111025     c                   if        badcharfnd = 'Y'
588900111208     c                   move      badcharswk    badcharsout
589000111025     c                   eval      *in52 = *on
589100111025     c                   z-add     95            x                    50
589200111025     c                   end
589300111025
589400111025      * middle initial
589500111025     c                   clear                   chartstfld
589600111025     c                   movel     dmi           chartstfld
589700111025     c                   move      'NAME'        whattstfld
589800111025     c                   exsr      #testchar
589900111025     c                   if        badcharfnd = 'Y'
590000111208     c                   move      badcharswk    badcharsout
590100111025     c                   eval      *in54 = *on
590200111025     c                   z-add     96            x                    50
590300111025     c                   end
590400111025
5905009102152875 C*
5906009102152876 C* VALIDATE RELATIONSHIP CODE
5907009102152877 C*
5908009102152878 C                   MOVE      DRELC2        DRELCD
5909009102152879 C                   MOVEL     'R'           DRELCD
5910009102152880 C     DRELCD        CHAIN     CODES                              51
591100160621     c                   if        *in51 = *on or dltc6 <> 'A'
5912001606212881 C                   Z-ADD     35            X                    50
591300160621     c                   end
591400220927
5915009102152882 C*
5916000008292883 C                   ENDSR
5917009102152884 C/EJECT
5918000601262885 C****************************************************************
5919000601262887 C*------Change Dependent info from "SAME" to Member's before writing
5920000601262888 C*
5921000601262889 C     ChgSame       BEGSR
5922000601262882 C*
592300060126     C                   If        DLNAME     =   'SAME'
592400060126     C                   Eval      DLNAME     =   LNAME
592500060126     C                   End
592600060126     C                   If        DADDR1     =   'SAME'
592700060126     C                   Eval      DADDR1     =   ADDR1
592800060126     C                   Eval      DADDR2  =  ADDR2
592900060126     C                   Eval      DCITY   =  CITY
593000060126     C                   Eval      DSTATE  =  STATE
593100060126     C                   Eval      DZIP    =  ZIP
593200060126     C                   If        DPHONE  =  *Zeros
593300060126     C                   Eval      DAREA   =  AREA
593400060126     C                   Eval      DPHONE  =  PHONE
593500060126     C                   End
593600060126     C                   End
5937000601262883 C                   ENDSR
5938000601262884 C/EJECT
5939009102152885 C****************************************************************
5940009102152887 C*----------------- MEMBER SCREEN CHANGE ROUTINE ---------------*
5941009102152888 C*
5942009102152889 C     #MCHNG        BEGSR
594300981216      * Dates entering this subroutine should be in ccyymmdd format
5944009105212891 C*  WRITE CHANGE HISTORY RECORD FOR EACH CHANCED FIELD
5945009105213094 C*
5946001305163094 C* SALARY CHANGE
594700130516     c                   if        skpsal <> 'Y' and salary <> F17
5948001305163094 C* PROMPT FOR SALARY CHANGE DATE (SCHDT)
594900130516     C                   if        schdt = 0
595000130516     C                   EXCEPT    SALCHGSCRN
595100910522     C                   MOVE      'Y'           SKIP1
595200910522     C                   GOTO      #ENMCH
5953001305163102 C                   end
595400130516     c                   exsr      #salchg
5955009105223102 C                   END
5956001305162973
595700130516      *
5958001305162973  * BIRTH DATE CHANGE
595900130516     C                   if        birth <> F10
5960001305162973 C* PROMPT FOR B-DAY CHANGE DATE
596100130516     C                   if        bchdt = 0
596200981203     C                   EXCEPT    BIRCHG
596300910522     C                   MOVE      'Y'           SKPSAL
596400910522     C                   MOVE      'Y'           SKIP1
596500910522     C                   GOTO      #ENMCH
5966009105223102 C                   END
596700130516     c                   exsr      #bdaychg
5968009105213025 C                   END
5969001305162890
597000130516
5971000606292923 C                   clear                   trandt
597200060629
5973009102152893 C     LNAME         IFNE      F1
5974009102152894 C                   MOVE      'M01'         TRCODE
5975009102152895 C                   MOVEL     LNAME         NOTE2            30
5976009102152896 C                   MOVEL     F1            CK#NOT           30
597700130927     c                   exsr      #getsystime
5978001401212898 C                   EXCEPT    hisdemo
5979009102152900 C                   END
5980009102152901 C*
5981009102152902 C     FNAME         IFNE      F2
5982009102152903 C                   MOVE      'M02'         TRCODE
5983009102152904 C                   MOVEL     FNAME         NOTE2
5984009102152905 C                   MOVEL     F2            CK#NOT
598500130927     c                   exsr      #getsystime
5986001401212907 C                   EXCEPT    hisdemo
5987009102152909 C                   END
5988009102152910 C*
5989009102152911 C     MI            IFNE      F3
5990009102152912 C                   MOVE      'M03'         TRCODE
5991009102152913 C                   MOVEL     MI            NOTE2
5992009102152914 C                   MOVEL     F3            CK#NOT
599300130927     c                   exsr      #getsystime
5994001401212916 C                   EXCEPT    hisdemo
5995009102152918 C                   END
5996009102152919 C*
5997009102152920 C     ADDR1         IFNE      F4
5998009102152921 C                   MOVE      'M04'         TRCODE
5999009102152922 C                   MOVEL     ADDR1         NOTE2
6000009102152923 C                   MOVEL     F4            CK#NOT
600100130927     c                   exsr      #getsystime
6002001401212925 C                   EXCEPT    hisdemo
6003009102152927 C                   END
6004009102152928 C*
6005009102152929 C     ADDR2         IFNE      F5
6006009102152930 C                   MOVE      'M05'         TRCODE
6007009102152931 C                   MOVEL     ADDR2         NOTE2
6008009102152932 C                   MOVEL     F5            CK#NOT
600900130927     c                   exsr      #getsystime
6010001401212934 C                   EXCEPT    hisdemo
6011009102152936 C                   END
6012009102152937 C*
6013009102152938 C     CITY          IFNE      F6
6014009102152939 C                   MOVE      'M06'         TRCODE
6015009102152940 C                   MOVEL     CITY          NOTE2
6016009102152941 C                   MOVEL     F6            CK#NOT
601700130927     c                   exsr      #getsystime
6018001401212943 C                   EXCEPT    hisdemo
6019009102152945 C                   END
6020009102152946 C*
6021009102152947 C     STATE         IFNE      F7
6022009102152948 C                   MOVE      'M07'         TRCODE
6023009102152949 C                   MOVEL     STATE         NOTE2
6024009102152950 C                   MOVEL     F7            CK#NOT
602500130927     c                   exsr      #getsystime
6026001401212952 C                   EXCEPT    hisdemo
6027009102152954 C                   END
6028009102152955 C*
6029009102152956 C     ZIP           IFNE      F8
6030009102152957 C                   MOVE      'M08'         TRCODE
6031009102152958 C                   MOVEL     ZIP           NOTE2
6032009102152959 C                   MOVEL     F8            CK#NOT
603300130927     c                   exsr      #getsystime
6034001401212961 C                   EXCEPT    hisdemo
6035009102152963 C                   END
6036009102152964 C*
6037009102152965 C     SEX           IFNE      F9
6038009102152966 C                   MOVE      'M09'         TRCODE
6039009102152967 C                   MOVEL     SEX           NOTE2
6040009102152968 C                   MOVEL     F9            CK#NOT
604100130927     c                   exsr      #getsystime
6042001401212970 C                   EXCEPT    hisdemo
6043009102152972 C                   END
6044009102153026 C*
6045009102153027 C     AREA          IFNE      F11
6046009102153028 C                   MOVE      'M11'         TRCODE
6047009102153029 C                   MOVEL     AREA          NOTE2
6048009102153030 C                   MOVEL     F11           CK#NOT
604900130927     c                   exsr      #getsystime
6050001401213032 C                   EXCEPT    hisdemo
6051009102153034 C                   END
6052009102153035 C*
6053009102153036 C     PHONE         IFNE      F12
6054009102153037 C                   MOVE      'M12'         TRCODE
6055009102153038 C                   MOVEL     PHONE         NOTE2
6056009102153039 C                   MOVEL     F12           CK#NOT
605700130927     c                   exsr      #getsystime
6058001401213041 C                   EXCEPT    hisdemo
6059009102153043 C                   END
6060009102153044 C*
6061009102153045 C     TRUST         IFNE      F13
6062009102153046 C                   MOVE      'M13'         TRCODE
6063009102153047 C                   MOVEL     TRUST         NOTE2
6064009102153048 C                   MOVEL     F13           CK#NOT
606500130927     c                   exsr      #getsystime
6066001401213050 C                   EXCEPT    hisdemo
6067009102153052 C                   END
6068009102153053 C*
6069009102153054 C     SUBNO         IFNE      F14
6070009102153055 C                   MOVE      'M14'         TRCODE
6071009102153056 C                   MOVEL     SUBNO         NOTE2
6072009102153057 C                   MOVEL     F14           CK#NOT
607300130927     c                   exsr      #getsystime
6074001401213059 C                   EXCEPT    hisdemo
6075009102153061 C                   END
6076009102153062 C*
6077009102153063 C     ACCNO         IFNE      F15
6078009102153064 C                   MOVE      'M15'         TRCODE
6079009102153065 C                   MOVEL     ACCNO         NOTE2
6080009102153066 C                   MOVEL     F15           CK#NOT
608100130927     c                   exsr      #getsystime
6082001401213068 C                   EXCEPT    hisdemo
6083009102153070 C                   END
6084009102153071 C*
6085009102153072 C     DTSA          IFNE      FTSA
6086009102153073 C     FTSA          CHAIN     ACCMST#                            69
6087009102153074 C  N69NOEMPL        SUB       1             NOEMPL
6088009102153075 C  N69              EXCEPT    ACCU
6089009102153076 C*
6090009102153077 C     DTSA          CHAIN     ACCMST#                            69
6091009102153078 C  N69NOEMPL        ADD       1             NOEMPL
6092009102153079 C                   EXCEPT    ACCU
6093009102153082 C                   END
6094000509303103 C*
6095000509303104 C     INLIF         IFNE      F39
6096000510033105 C                   MOVE      'L39'         TRCODE
609700050930     C                   If        INLIF    =    *Blank
609800051007     C                   Eval      CK#NOT   =    *Blanks
609900051007     C                   Eval      NOTE2    =    %Trim('Eligible for LIFE')
610000050930     C                   Else
610100051007     C                   Eval      CK#NOT   =    %Trim('Y')
610200051007     C                   Eval      NOTE2    =    %Trim('Not Eligible for LIFE')
610300050930     C                   End
610400130927     c                   exsr      #getsystime
6105001401213109 C                   EXCEPT    hisdemo
6106000509303111 C                   END
6107000509303103 C*
6108000509303104 C     INADD         IFNE      F40
6109000510033105 C                   MOVE      'L40'         TRCODE
611000050930     C                   If        INADD    =    *Blank
611100051007     C                   Eval      CK#NOT   =    *Blanks
611200051007     C                   Eval      NOTE2    =    %Trim('Eligible for AD&D')
611300050930     C                   Else
611400051007     C                   Eval      CK#NOT   =    %Trim('Y')
611500051007     C                   Eval      NOTE2    =    %Trim('Not Eligible for AD&D')
611600050930     C                   End
611700130927     c                   exsr      #getsystime
6118001401213109 C                   EXCEPT    hisdemo
6119000509303111 C                   END
6120009812243103 C*
6121009812243104 C     EMPST         IFNE      F18
6122009812243105 C                   MOVE      'M18'         TRCODE
6123009812243106 C                   MOVEL     EMPST         NOTE2
6124009812243107 C                   MOVEL     F18           CK#NOT
612500130927     c                   exsr      #getsystime
6126001401213109 C                   EXCEPT    hisdemo
6127009812243111 C                   END
6128000602213103 C*
6129000602213104 C     CCFLG         IFNE      F41
613000060221     C                   If        F41      =    *Blanks
613100060221     C                   Move      'CCA'         TRCODE
613200060221     C                   Else
6133000602213105 C                   MOVE      'CCC'         TRCODE
613400060221     C                   End
6135000602213106 C                   MOVEL     CCFLG         NOTE2
6136000602213107 C                   MOVEL     F41           CK#NOT
613700130927     c                   exsr      #getsystime
6138001401213109 C                   EXCEPT    hisdemo
6139000602213111 C                   END
6140000506283103 C*
6141000506283104 C     NONEMP        IFNE      F38
6142000506283105 C                   MOVE      'L37'         TRCODE
614300050628     C                   If        NONEMP   =    *Blank
614400050628     C                   Movel     'EMPLOYEE'    NOTE2
614500050628     C                   Movel     'Y=NONEMP'    CK#NOT
614600050628     C                   Else
614700050628     C                   Movel     'Y=NONEMP'    NOTE2
614800050628     C                   Movel     'EMPLOYEE'    CK#NOT
614900050628     C                   End
615000130927     c                   exsr      #getsystime
6151001401213109 C                   EXCEPT    hisdemo
6152000506283111 C                   END
615300981228      *
6154009102153086 C     EMPDT         IFNE      F16
6155009102153087 C                   MOVE      'M16'         TRCODE
615600981223      *
615700990105y2k  C                   MOVEL     EMPDT         NOTE2
615800990105y2k  C*                    MOVE EMPDT     MDCY#            mmddccyy
615900990105y2k  C*                    EXSR #CYMD8                        \/
616000990105y2k  C*                    MOVELCYMD#     NOTE2            ccyymmdd
616100981223      *
6162009102153089 C                   MOVEL     F16           CK#NOT
616300130927     c                   exsr      #getsystime
6164001401213091 C                   EXCEPT    hisdemo
6165009102153093 C                   END
6166009102153112 C*
6167009102153113 C     MARDT         IFNE      F19
6168009102153114 C                   MOVE      'M19'         TRCODE
616900981223      *
617000981224y2k  C                   MOVEL     MARDT         NOTE2
617100981224y2k  C*                    MOVE MARDT     MDCY#            mmddccyy
617200981224y2k  C*                    EXSR #CYMD8                        \/
617300981224y2k  C*                    MOVELCYMD#     NOTE2            ccyymmdd
617400981223      *
6175009812163116 C                   MOVEL     F19           CK#NOT
617600130927     c                   exsr      #getsystime
6177001401213118 C                   EXCEPT    hisdemo
6178009102153120 C                   END
6179009102153121 C*
6180009102153122 C     MEDICR        IFNE      F20
6181009102153123 C                   MOVE      'M20'         TRCODE
6182009102153124 C                   MOVEL     MEDICR        NOTE2
6183009102153125 C                   MOVEL     F20           CK#NOT
618400130927     c                   exsr      #getsystime
6185001401213127 C                   EXCEPT    hisdemo
6186009102153129 C                   END
6187009102153130 C*
6188009102153131 C     MED#          IFNE      F21
6189009102153132 C                   MOVE      'M21'         TRCODE
6190009102153133 C                   MOVEL     MED#          NOTE2
6191009102153134 C                   MOVEL     F21           CK#NOT
619200130927     c                   exsr      #getsystime
6193001401213136 C                   EXCEPT    hisdemo
6194009102153138 C                   END
6195009102153139 C*
6196009102153140 C     MEDADT        IFNE      F22
6197009102153141 C                   MOVE      'M22'         TRCODE
619800981223      *
619900990105y2k  C                   MOVEL     MEDADT        NOTE2
620000990105y2k  C*                    MOVE MEDADT    MDCY#            mmddccyy
620100990105y2k  C*                    EXSR #CYMD8                        \/
620200990105y2k  C*                    MOVELCYMD#     NOTE2            ccyymmdd
620300981223      *
6204009102153143 C                   MOVEL     F22           CK#NOT
620500130927     c                   exsr      #getsystime
6206001401213145 C                   EXCEPT    hisdemo
6207009102153147 C                   END
6208009102153148 C*
6209009102153149 C     MEDBDT        IFNE      F23
6210009102153150 C                   MOVE      'M23'         TRCODE
621100981223      *
621200990105y2k  C                   MOVEL     MEDBDT        NOTE2
621300990105y2k  C*                    MOVE MEDBDT    MDCY#            mmddccyy
621400990105y2k  C*                    EXSR #CYMD8                        \/
621500990105y2k  C*                    MOVELCYMD#     NOTE2            ccyymmdd
621600981223      *
6217009102153152 C                   MOVEL     F23           CK#NOT
621800130927     c                   exsr      #getsystime
6219001401213154 C                   EXCEPT    hisdemo
6220009102153156 C                   END
6221009102153157 C*
6222009102153158 C     HNDICP        IFNE      F24
6223009102153159 C                   MOVE      'M24'         TRCODE
6224009102153160 C                   MOVEL     HNDICP        NOTE2
6225009102153161 C                   MOVEL     F24           CK#NOT
622600130927     c                   exsr      #getsystime
6227001401213163 C                   EXCEPT    hisdemo
6228009102153165 C                   END
6229009102153166 C*
6230009102153167 C     HDCPDT        IFNE      F25
6231009102153168 C                   MOVE      'M25'         TRCODE
623200981223      *
623300990105y2k  C                   MOVEL     HDCPDT        NOTE2
623400990105y2k  C*                    MOVE HDCPDT    MDCY#            mmddccyy
623500990105y2k  C*                    EXSR #CYMD8                        \/
623600990105y2k  C*                    MOVELCYMD#     NOTE2            ccyymmdd
623700981223      *
6238009102153170 C                   MOVEL     F25           CK#NOT
623900130927     c                   exsr      #getsystime
6240001401213172 C                   EXCEPT    hisdemo
6241009102153174 C                   END
6242009102153175 C*
6243000102143176 C     COBX          IFNE      F26
6244009102153177 C                   MOVE      'M26'         TRCODE
6245000102143178 C                   MOVEL     COBX          NOTE2
6246009102153179 C                   MOVEL     F26           CK#NOT
624700130927     c                   exsr      #getsystime
6248001401213181 C                   EXCEPT    hisdemo
6249009102153183 C                   END
6250009102153184 C*
6251009102153185 C     COBENM        IFNE      F27
6252009102153186 C                   MOVE      'M27'         TRCODE
6253009102153187 C                   MOVEL     COBENM        NOTE2
6254009102153188 C                   MOVEL     F27           CK#NOT
625500130927     c                   exsr      #getsystime
6256001401213190 C                   EXCEPT    hisdemo
6257009102153192 C                   END
6258009102153193 C*
6259009102153194 C     COBPNM        IFNE      F28
6260009102153195 C                   MOVE      'M28'         TRCODE
6261009102153196 C                   MOVEL     COBPNM        NOTE2
6262009102153197 C                   MOVEL     F28           CK#NOT
626300130927     c                   exsr      #getsystime
6264001401213199 C                   EXCEPT    hisdemo
6265009102153201 C                   END
6266009102153202 C*
6267009102153203 C     COBP#         IFNE      F29
6268009102153204 C                   MOVE      'M29'         TRCODE
6269009102153205 C                   MOVEL     COBP#         NOTE2
6270009102153206 C                   MOVEL     F29           CK#NOT
627100130927     c                   exsr      #getsystime
6272001401213208 C                   EXCEPT    hisdemo
6273009102153210 C                   END
6274009102153211 C*
6275009102153212 C     COBBCF        IFNE      F30
6276009102153213 C                   MOVE      'M35'         TRCODE
6277009102153214 C                   MOVEL     COBBCF        NOTE2
6278009102153215 C                   MOVEL     F30           CK#NOT
627900130927     c                   exsr      #getsystime
6280001401213217 C                   EXCEPT    hisdemo
6281009102153219 C                   END
6282009102153220 C*
6283009102153221 C     COBCTY        IFNE      F31
6284009102153222 C                   MOVE      'M36'         TRCODE
6285009102153223 C                   MOVEL     COBCTY        NOTE2
6286009102153224 C                   MOVEL     F31           CK#NOT
628700130927     c                   exsr      #getsystime
6288001401213226 C                   EXCEPT    hisdemo
6289009102153228 C                   END
6290009102153229 C*
6291009102153230 C     COBST         IFNE      F32
6292009102153231 C                   MOVE      'M37'         TRCODE
6293009102153232 C                   MOVEL     COBST         NOTE2
6294009102153233 C                   MOVEL     F32           CK#NOT
629500130927     c                   exsr      #getsystime
6296001401213235 C                   EXCEPT    hisdemo
6297009102153237 C                   END
6298009102153238 C*
6299001012153130  * email change
6300001012153131 C     memail        IFNE      F42
6301001012153132 C                   MOVE      'M75'         TRCODE
6302001012153133 C                   MOVEL     memail        NOTE2
6303001012153134 C                   MOVEL     F42           CK#NOT
630400130927     c                   exsr      #getsystime
6305001401213136 C                   EXCEPT    hisdemo
6306001012153138 C                   END
6307001012153139 C*
6308001012153130  * non ssn change
6309001012153131 C     mnonssn       IFNE      F43
6310001012153132 C                   MOVE      'M74'         TRCODE
6311001012153133 C                   MOVEL     mnonssn       NOTE2
6312001012153134 C                   MOVEL     F43           CK#NOT
631300130927     c                   exsr      #getsystime
6314001401213136 C                   EXCEPT    hisdemo
6315001012153138 C                   END
6316001012153139 C*
6317001804173130  * member enroll date change
6318001804173131 C     menrdt        IFNE      F44
6319001804173132 C                   MOVE      'M77'         TRCODE
6320001804173133 C                   MOVEL     menrdt        NOTE2
6321001804173134 C                   MOVEL     F44           CK#NOT
632200180417     c                   exsr      #getsystime
6323001804173136 C                   EXCEPT    hisdemo
6324001804173138 C                   END
6325001804173139 C*
6326009102153283 C*
632700910522     C                   MOVE      *ZEROS        BCHDT
632800920318     C                   MOVE      *ZEROS        SENRLD
632900910522     C                   MOVE      'N'           SKIP1
6330000008293284 C     #ENMCH        ENDSR
633100130516
6332001305163286 C****************************************************************
6333001305163288 C* Salary change routine
6334001305163286 C****************************************************************
6335001305163289 C*
6336001305163290 C     #salchg       BEGSR
633700220607     C*
633800130516     C*  CREATE HISTORY RECORD FOR SALARY CHANGE.........
633900130516     C*
634000130516     C                   MOVE      'Y'           SKPSAL
6341001305163096 C                   MOVE      'M17'         TRCODE
6342001305163097 C                   MOVEL     SALARY        NOTE2
6343001305163098 C                   MOVEL     F17           CK#NOT
634400130516     C*
634500130516     C                   MOVE      SCHDT         MDCY#
634600130516     C                   EXSR      #CYMD8
634700130516     C                   MOVE      CYMD#         SCHYMD            8 0
634800130516     C                   MOVE      CYMD#         SCHYMDhold        8 0
634900130516     C                   MOVE      CYMD#         TRANDT
635000220608      *
635100130927     c                   exsr      #getsystime
6352001401213100 C                   EXCEPT    hisdemo
635300220608      *
6354002206080537  *   Update/Add the Mbr Extention File with Sal Chg Date
635500220608     c     SSNO          chain     memextp
635600220608      *      Update existing record if already there
635700220608     c                   if        %found(memextp)
635800220608     c                   move      cymd#         mesaldt
635900220608     c                   update    r_memextp
636000220608     c                   else
636100220608      *      Add memextp rec
636200220608     c                   clear                   r_memextp
636300220608     c                   move      ssno          messno
636400220608     c                   move      cymd#         mesaldt
636500220608     c                   write     r_memextp
636600220608     c                   endif
636700220608      *
6368001305162985 C*
6369001305162987 C     SSNO          SETLL     MCOV
6370001305162988 C                   dou       %eof(mcov)
6371001305162989 C     SSNO          READE     MCOV
637200130516     c                   if        %eof(mcov)
637300140121     C                   EXCEPT    relmcov
6374001305162990 C                   leave
637500130516     c                   end
6376001305162991 C*
6377001305162992 C                   if        candt <> 0
6378001305162993 C                   iter
6379001305162994 C                   end
6380001305162995 C*
6381001305162996 C     MPLKEY        CHAIN     PLNMST
638200130516      * skip flat benefit plans
638300130516     c                   if        not %found(plnmst) or mult = 0
6384001305162998 C                   iter
638500130516     c                   end
638600130516
638700130516     C                   Z-ADD     BENAMT        BENAMH            7 0
638800130516
638900130516     C* restore salary change date since it is lost
639000130516     C* when schymd < edate (see below)
639100130516     C                   MOVE      SCHYMDhold    schymd
639200130516
639300130516     C*
639400130516     C     SCHYMD        IFLT      EDATE
639500130516     C                   Z-ADD     EDATE         SCHYMD
639600130516     C                   Z-ADD     53            X
639700130516     C                   MOVE      'Y'           ER50              1
639800130516     C                   END
639900130516     C*
640000130516y2k  C                   MOVE      MPLKEY        PLANKY
640100130516
640200130516      * only salary based plans are included here
640300130516     C                   clear                   FLTFLG
640400130516     c                   clear                   benamtwk
6405001305163001 C                   EXSR      #calcben
640600130516     c                   z-add     cbenam        benamt
640700130516      * original beneft (horgben) will hold the amt before declife
6408001305164133 C                   Z-ADD     benamtwkHOLD  horgben
6409001305164133 C                   clear                   benamtwkHOLD
641000130516     C*
641100130516     C     benamt        IFNE      BENAMH
641200130516     C                   Z-ADD     SCHYMD        TRANDT
6413001305164107 C                   MOVE      PLAN#         MH1
6414001305164108 C                   MOVE      AGEBND        MH2
6415001305164109 C                   MOVE      COVTYP        MH3
6416001305164110 C                   MOVE      BENAMH        MH4
6417001305164111 C                   MOVE      benamt        MH6
6418001305164112 C                   MOVE      'MCB'         TRCODE
641900140121      * cancel mcov
642000130516     C                   EXCEPT    CANMC2
642100130516     c                   move      *zeros        mcuniq
642200140121      * add mcov
642300131215     C                   EXCEPT    MCVAD2
642400130516     c                   clear                   horgben
642500140121
6426001401214113 C                   SETON                                          26
642700140121     c                   exsr      #getsystime
642800140121      * adjust
642900140121     C                   EXSR      #hstadj
643000140121      * write hist
6431001401214114 C                   EXCEPT    histcov
6432001401214115 C                   SETOFF                                         26
643300130516     C                   END
643400130516     C*
643500130516     C                   enddo
643600130516
643700191107
643800191107
643900191107br01
644000191107       // Check to see if this account has OLE
644100191107       Setll ( Trust : SubNo : AccNo ) AccOspL2;
644200191107
644300191107       Dou %Eof(AccOspL2);
644400191107         reade ( Trust : SubNo : AccNo ) AccOspL2;
644500191107         if %eof(AccOspL2);
644600191107           leave;
644700191107         endif;
644800191107
644900191107
645000191107         if aobedt <= %Dec(%Date) and
645100191107           (aoendt >= %Dec(%Date) or aoendt = 0 ) ;
645200191107
645300191107           //--------------------------
645400191107           //
645500191107           // Found OLE Record!
645600191107           //
645700191107           //--------------------------
645800191107
645900191107
646000191107
646100191107           //-------------------------------------
646200191108           // Dashboard - Update correct library
646300191107           //-------------------------------------
646400191107           if AOCODE = 8 or AOCODE = 9;
646500191108
646600191108             if wqFill = 'GBSDTAT';
646700191108
646800191126               exec sql
646900191126                 update RpgspBeta / webpayroll
647000191126                   set pyans = :Salary, PYSALDT = :schymd
647100191126                   where pyssn = :ssno;
647200191108
647300191108             else;
647400191108
647500191126               exec sql
647600191126                 update RpgspDash / webpayroll
647700191126                   set pyans = :Salary, PYSALDT = :schymd
647800191126                   where pyssn = :ssno;
647900191108
648000191108             EndIf;
648100191107
648200191107
648300191107           EndIf;
648400191107
648500191108
648600191108           //-------------------------------------
648700191108           // Payroll System
648800191108           //-------------------------------------
648900191202       //    if aoCode = 4 or
649000191202       //      aoCode = 5 or
649100191202       //      aoCode = 6 or
649200191202       //      aoCode = 7;
649300191202       //
649400191202       //      if wqFill = 'QS36F';
649500191202       //
649600191202       //        wpypfq = '';
649700191202       //
649800191202       //        exec sql
649900191202       //          Select Pypfq
650000191202       //            into :wpypfq
650100191202       //            from rpgsppayr / webpayroll
650200191202       //            where pyssn = :ssno;
650300191202       //
650400191202       //        if wpypfq > '';
650500191202       //          Select;
650600191202       //          when wpypfq = 'WKY';
650700191202       //            PayFreq = 52;
650800191202       //          when wpypfq = 'W48';
650900191202       //            PayFreq = 48;
651000191202       //          when wpypfq = 'BW1';
651100191202       //            PayFreq = 26;
651200191202       //          when wpypfq = 'SEM';
651300191202       //            PayFreq = 24;
651400191202       //          when wpypfq = 'MTH';
651500191202       //            PayFreq = 12;
651600191202       //          when wpypfq = 'QTR';
651700191202       //            PayFreq = 4;
651800191202       //          EndSl;
651900191202       //
652000191202       //
652100191202       //          if Salary > 0;
652200191202       //            eval(h) pySal = Salary / PayFreq;
652300191202       //          else;
652400191202       //            pySal = 0;
652500191202       //          EndIf;
652600191202       //
652700191202       //
652800191202       //          exec sql
652900191202       //            update RpgspPayr / webpayroll
653000191202       //              set pySal = :pySal, PYSALDT = :schymd
653100191202       //              where pyssn = :ssno;
653200191202       //
653300191202       //        EndIf;
653400191202       //      endif;
653500191202       //
653600191202       //    EndIf;
653700191107
653800191108         endif;
653900191107       enddo;
654000191107
654100191107
654200191107
654300191107
654400191107
6545001305163284 C                   ENDSR
654600130516
654700130516
6548001305163286 C****************************************************************
6549001305163288 C* Birthday change routine
6550001305163286 C****************************************************************
6551001305163289 C*
6552001305163290 C     #bdaychg      BEGSR
655300140123     c                   clear                   acabdaychg        1
655400130516
6555001305162975 C                   MOVE      'M10'         TRCODE
6556001305162976 C                   MOVEL     BIRTH         NOTE2
6557001305162977 C                   MOVEL     F10           CK#NOT
655800130516     C*
655900130516     C                   MOVE      BCHDT         MDCY#
656000130516     C                   EXSR      #CYMD8
656100130516     C                   MOVE      CYMD#         TRANDT
656200130516     C                   MOVE      CYMD#         BCHYMD            8 0
656300130516     C                   MOVE      CYMD#         BCHYMDhold        8 0
656400130516     C*
656500130927     c                   exsr      #getsystime
6566001401212979 C                   EXCEPT    hisdemo
6567001312130823 C*
6568001305162982 C*
6569001305162983 C*     IF BIRTH DATE CHANGES, THEN SPIN THRU MCOV. FOR EACH AGE BANDED
6570001305162984 C*                 PLAN, CALCULATE NEW AGE BAND. UPDATE MCOV.
6571001305162985 C*
6572001305162987 C     SSNO          SETLL     MCOV
6573001305162988 C                   dou       %eof(mcov)
6574001305162989 C     SSNO          READE     MCOV
657500130516     c                   if        %eof(mcov)
657600140121     C                   EXCEPT    relmcov
6577001305162990 C                   leave
657800130516     c                   end
657900130516
658000130516     C                   if        candt <> 0
658100130516     C                   iter
658200130516     C                   end
658300130516
6584001305162996 C     MPLKEY        CHAIN     PLNMST
658500130516     c                   if        %found(plnmst)
658600140123
658700141110      * if individually rated aca plan flag for bday chg adjust rec later
658800141110      * (after member update)
6589001411102996 C***  mcplankey     CHAIN     plnauxp
659000141110     c***                if        %found(plnauxp) and pxacar = 'Y'
659100141118     c                   clear                   acairat
659200141120
659300141120     c                   monitor
659400141118     c                   eval      acairat = #chk_aca_plan(trust#:sub#:plan#)
659500141120      * trap anything that goes wrong with the check aca function
659600141120     c                   on-error
659700141120      * error handling code here
659800141120     c                   endmon
659900141120
660000141118     c                   if        acairat = 'Y'
660100140123     c                   move      'Y'           acabdaychg
660200140123     c                   end
660300140123
660400130516     C*****************
660500130516     C* age band = renewal or monthly - check for AB change
660600130516     C*****************
660700130516     c                   if        pabfl = 'R' or pabfl = 'M'
660800130620      * fill agedatwk with the mcov effdt, this is what #findab needs
660900130620      * and fill key fields for plnauxp chain
661000130620     c                   z-add     enrldt        agedatwk
661100130620     C                   MOVE      trust#        keytrust
661200130620     C                   MOVE      sub#          keysub
661300130620     C                   MOVE      plan#         keyplan
661400130620     C                   EXSR      #findab
6615001306201295 C                   Z-ADD     ab_out        agbandwk
661600130516
661700130516     C                   Z-ADD     *ZEROS        SENRLD
6618001306203002
6619001306203003  * IF THE AGE BAND CHANGED CREATE HISTORY RECORD
6620001306203007 C                   if        agbandwk <> AGEBND
662100130516     C                   ADD       1             UPDFLG
6622001305163008 C                   MOVE      'MCA'         TRCODE
662300130516     C                   MOVE      *BLANKS       MH4
662400130516
662500130516     C* restore bday change date since it is lost
662600130516     C* when bchymd < edate (see below)
662700130516     C                   move      BCHYMDhold    bchymd
662800130516
662900130516     C     BCHYMD        IFLT      EDATE
663000130516     C                   Z-ADD     EDATE         BCHYMD
663100130516     C                   Z-ADD     54            X
663200130516     C                   MOVE      'Y'           ER50
663300130516     C                   END
663400130516     C*
663500130516     C                   Z-ADD     BCHYMD        TRANDT
663600130516     C*
6637001305163010 C                   MOVE      PLAN#         MH1
6638001305163011 C                   MOVE      agbandwk      MH2
6639001305163012 C                   MOVE      COVTYP        MH3
6640001305163013 C                   MOVE      AGEBND        MH4
664100130516     C                   MOVE      BENAMT        MH6
664200140121      *
6643001401213014 C                   SETON                                            26
664400130927     c                   exsr      #getsystime
664500140121      * adjust for change age band
664600140121     C                   EXSR      #hstadj
664700140121      * write hist for change age band
6648001401213015 C                   EXCEPT    histcov
6649001401213016 C                   SETOFF                                           26
6650001305163018 C                   END
665100130516
665200130516     C* calc benamt including declife
665300130516
665400130516     C                   Z-ADD     BENAMT        BENAMH            7 0
665500130516y2k  C                   MOVE      MPLKEY        PLANKY
665600130516
665700130516      * calculate benefit amount
6658001305161341 C                   clear                   FLTFLG
6659001305161341 C                   clear                   benamtwk
666000130620
6661001305161342 C                   if        mult = 0
6662001305161345 C                   MOVE      'F'           FLTFLG
666300130516      * always use original benefit amount field from mcov
666400130516     c                   z-add     mcorgben      benamtwk
6665001305161347 C                   end
666600130516
6667001305163001 C                   EXSR      #calcben
666800130516     c                   z-add     cbenam        benamt
666900130516      * fill horgben with benefit before declife was considered
6670001305164133 C                   Z-ADD     benamtwkHOLD  horgben
6671001305164133 C                   clear                   benamtwkHOLD
667200130516     C*
667300130516     C     BENAMT        IFNE      BENAMH
6674001305164107 C                   MOVE      PLAN#         MH1
6675001305164108 C                   MOVE      agbandwk      MH2
6676001305164109 C                   MOVE      COVTYP        MH3
6677001305164110 C                   MOVE      BENAMH        MH4
6678001305164111 C                   MOVE      BENAMT        MH6
6679001305164112 C                   MOVE      'MCB'         TRCODE
668000130516     C                   Z-ADD     BCHYMD        TRANDT
668100130516     C                   Z-ADD     BENAMT        HBENAM            7 0
6682001401214113 C                   SETON                                          26
668300130927     c                   exsr      #getsystime
668400140121      * adjust for change benefit amount
668500140121     C                   EXSR      #hstadj
668600140121      * write hist for change benefit amount
6687001401214114 C                   EXCEPT    histcov
6688001401214115 C                   SETOFF                                         26
668900130516     C                   ADD       1             UPDFLG            2 0
669000130516     C*
669100130516     C                   ELSE
669200130516     C                   Z-ADD     BENAMH        HBENAM
669300130516     C                   END
669400130516     C*
669500130516     C     UPDFLG        IFGT      *ZEROS
6696001312133017 C                   EXCEPT    CANMCV
669700130516      * horgben will already have the original benefit amount before
669800130516      * it declined (see above) but if the plan is a flat plan then
669900130516      * use the previous mcov rec benefit here instead
670000130516     c                   if        fltflg = 'F'
670100130516     C                   Z-ADD     mcorgben      horgben
670200130516     c                   end
670300130516
670400130516     c                   move      *zeros        mcuniq
670500131213     C                   EXCEPT    MCVADD
670600130516     C                   Z-ADD     *ZEROS        HBENAM
670700130516     C                   Z-ADD     *ZEROS        UPDFLG
670800130516     C                   clear                   horgben
670900140121
671000130516     C                   END
671100130516
6712001305163020 C                   END
671300130516
671400130516     C*****************
671500130516     C* age band = NO AGE BAND - still need to check declife for
671600130516     C*                          benefit decrease
671700130516     C*****************
671800130516     c                   if        pabfl = 'N'
671900130516
672000130516     C                   Z-ADD     BENAMT        BENAMH            7 0
672100130516y2k  C                   MOVE      MPLKEY        PLANKY
672200130516
672300130516      * calculate benefit amount
6724001305161341 C                   clear                   FLTFLG
6725001305161341 C                   clear                   benamtwk
672600130516
6727001305161342 C                   if        mult = 0
6728001305161345 C                   MOVE      'F'           FLTFLG
672900130516      * always use original benefit amount field from mcov
673000130516     c                   z-add     mcorgben      benamtwk
6731001305161347 C                   end
673200130516
6733001305163001 C                   EXSR      #calcben
673400130516     c                   z-add     cbenam        benamt
673500130516      * fill horgben with benefit before declife was considered
6736001305164133 C                   Z-ADD     benamtwkHOLD  horgben
6737001305164133 C                   clear                   benamtwkHOLD
673800130516     C*
673900130516     C     BENAMT        IFNE      BENAMH
6740001305164108 C                   MOVE      *zeros        agbandwk
6741001305164107 C                   MOVE      PLAN#         MH1
6742001305164108 C                   MOVE      agbandwk      MH2
6743001305164109 C                   MOVE      COVTYP        MH3
6744001305164110 C                   MOVE      BENAMH        MH4
6745001305164111 C                   MOVE      BENAMT        MH6
6746001305164112 C                   MOVE      'MCB'         TRCODE
674700130516     C                   Z-ADD     BCHYMD        TRANDT
674800130516     C                   Z-ADD     BENAMT        HBENAM            7 0
674900140121      * cancel mcov
6750001305163017 C                   EXCEPT    CANMCV
675100130516      * horgben will already have the original benefit amount before
675200130516      * it declined (see above) but if the plan is a flat plan then
675300130516      * use the previous mcov rec benefit here instead
675400130516     c                   if        fltflg = 'F'
675500130516     C                   Z-ADD     mcorgben      horgben
675600130516     c                   end
675700130516
675800130516     c                   move      *zeros        mcuniq
675900130516     C                   EXCEPT    MCVADD
676000140121     C                   Z-ADD     *ZEROS        HBENAM
676100140121     C                   clear                   horgben
676200140121
6763001401214113 C                   SETON                                          26
676400140121     c                   exsr      #getsystime
676500140121      * adjust
676600140121     C                   EXSR      #hstadj
676700140121      * write hist
6768001401214114 C                   EXCEPT    histcov
6769001401214115 C                   SETOFF                                         26
677000140121
677100130516     C                   END
6772001305163021 C                   end
677300130516
6774001305163021 C                   END
677500130516
6776001305163022 C                   enddo
677700130516
6778001305163290 C                   endsr
677900130516     C*
6780009102153285 C/EJECT
6781009102153286 C****************************************************************
6782000002183288 C*---------------DEPENDENT SCREEN CHANGE ROUTINE ---------------*
6783009102153289 C*
6784001312123292 C*  WRITE CHANGE HISTORY RECORD FOR EACH CHANCED FIELD
6785009812303290 C     #DCHNG        BEGSR
678600140215     c                   clear                   acabdaychg
678700140317     c                   clear                   acarelchg
6788001403143291*C************************************************************************
6789001403173293
6790001403173293 C* relation change
6791009102153294 C     DRELC2        IFNE      D1
6792009102153295 C                   MOVE      'M41'         TRCODE
6793009102153296 C                   MOVEL     DRELC2        NOTE2
6794009102153297 C                   MOVEL     D1            CK#NOT
6795009102153298 C                   MOVE      DSEQ#         HDSEQ#
679600140317      * indicate depend relation change so a check for aca plans can be done
679700140317      * after the depend update occurs and adjustments can be issued if
679800140317      * needed
679900140317     c                   move      'Y'           acarelchg
680000140317
680100130927     c                   exsr      #getsystime
6802001401213300 C                   EXCEPT    hisdemo
6803009102153302 C                   END
6804009102153303 C*
6805009102153304 C     DLNAME        IFNE      D2
6806009102153305 C                   MOVE      'M42'         TRCODE
6807009102153306 C                   MOVEL     DLNAME        NOTE2
6808009102153307 C                   MOVEL     D2            CK#NOT
6809009102153308 C                   MOVE      DSEQ#         HDSEQ#
681000130927     c                   exsr      #getsystime
6811001401213310 C                   EXCEPT    hisdemo
6812009102153312 C                   END
6813009102153313 C*
6814009102153314 C     DFNAME        IFNE      D3
6815009102153315 C                   MOVE      'M43'         TRCODE
6816009102153316 C                   MOVEL     DFNAME        NOTE2
6817009102153317 C                   MOVEL     D3            CK#NOT
6818009102153318 C                   MOVE      DSEQ#         HDSEQ#
681900130927     c                   exsr      #getsystime
6820001401213320 C                   EXCEPT    hisdemo
6821009102153322 C                   END
6822009102153323 C*
6823009102153324 C     DMI           IFNE      D4
6824009102153325 C                   MOVE      'M44'         TRCODE
6825009102153326 C                   MOVEL     DMI           NOTE2
6826009102153327 C                   MOVEL     D4            CK#NOT
6827009102153328 C                   MOVE      DSEQ#         HDSEQ#
682800130927     c                   exsr      #getsystime
6829001401213330 C                   EXCEPT    hisdemo
6830009102153332 C                   END
6831009102153333 C*
6832009102153334 C     DADDR1        IFNE      D5
6833009102153335 C                   MOVE      'M45'         TRCODE
6834009102153336 C                   MOVEL     DADDR1        NOTE2
6835009102153337 C                   MOVEL     D5            CK#NOT
6836009102153338 C                   MOVE      DSEQ#         HDSEQ#
683700130927     c                   exsr      #getsystime
6838001401213340 C                   EXCEPT    hisdemo
6839009102153342 C                   END
6840009102153343 C*
6841009102153344 C     DADDR2        IFNE      D6
6842009102153345 C                   MOVE      'M46'         TRCODE
6843009102153346 C                   MOVEL     DADDR2        NOTE2
6844009102153347 C                   MOVEL     D6            CK#NOT
6845009102153348 C                   MOVE      DSEQ#         HDSEQ#
684600130927     c                   exsr      #getsystime
6847001401213350 C                   EXCEPT    hisdemo
6848009102153352 C                   END
6849009102153353 C*
6850009102153354 C     DCITY         IFNE      D7
6851009102153355 C                   MOVE      'M47'         TRCODE
6852009102153356 C                   MOVEL     DCITY         NOTE2
6853009102153357 C                   MOVEL     D7            CK#NOT
6854009102153358 C                   MOVE      DSEQ#         HDSEQ#
685500130927     c                   exsr      #getsystime
6856001401213360 C                   EXCEPT    hisdemo
6857009102153362 C                   END
6858009102153363 C*
6859009102153364 C     DSTATE        IFNE      D8
6860009102153365 C                   MOVE      'M48'         TRCODE
6861009102153366 C                   MOVEL     DSTATE        NOTE2
6862009102153367 C                   MOVEL     D8            CK#NOT
6863009102153368 C                   MOVE      DSEQ#         HDSEQ#
686400130927     c                   exsr      #getsystime
6865001401213370 C                   EXCEPT    hisdemo
6866009102153372 C                   END
6867009102153373 C*
6868009102153374 C     DZIP          IFNE      D9
6869009102153375 C                   MOVE      'M49'         TRCODE
6870009102153376 C                   MOVEL     DZIP          NOTE2
6871009102153377 C                   MOVEL     D9            CK#NOT
6872009102153378 C                   MOVE      DSEQ#         HDSEQ#
687300130927     c                   exsr      #getsystime
6874001401213380 C                   EXCEPT    hisdemo
6875009102153382 C                   END
6876009102153383 C*
6877009102153384 C     DSEX          IFNE      D10
6878009102153385 C                   MOVE      'M50'         TRCODE
6879009102153386 C                   MOVEL     DSEX          NOTE2
6880009102153387 C                   MOVEL     D10           CK#NOT
6881009102153388 C                   MOVE      DSEQ#         HDSEQ#
688200130927     c                   exsr      #getsystime
6883001401213390 C                   EXCEPT    hisdemo
6884009102153392 C                   END
6885009102153393 C*
6886009102153394 C     DBIRTH        IFNE      D11
6887009812233395 C                   MOVE      'M51'         TRCODE
6888009812233398 C                   MOVE      DSEQ#         HDSEQ#
6889009812303397 C                   MOVEL     D11           CK#NOT
689000981230y2k  C                   MOVEL     DBIRTH        NOTE2
689100140215      * indicate depend bday change so a check for aca plans can be done
689200140215      * after the depend update occurs and adjustments can be issued if
689300140215      * needed
689400140215     c                   move      'Y'           acabdaychg
689500981223      *
689600130927     c                   exsr      #getsystime
689700140121     C                   EXCEPT    hisdemo
6898009102153402 C                   END
6899009102153403 C*
6900009102153404 C     DAREA         IFNE      D12
6901009102153405 C                   MOVE      'M52'         TRCODE
6902009102153406 C                   MOVEL     DAREA         NOTE2
6903009102153407 C                   MOVEL     D12           CK#NOT
6904009102153408 C                   MOVE      DSEQ#         HDSEQ#
690500130927     c                   exsr      #getsystime
6906001401213410 C                   EXCEPT    hisdemo
6907009102153412 C                   END
6908009102153413 C*
6909009102153414 C     DPHONE        IFNE      D13
6910009102153415 C                   MOVE      'M53'         TRCODE
6911009102153416 C                   MOVEL     DPHONE        NOTE2
6912009102153417 C                   MOVEL     D13           CK#NOT
6913009102153418 C                   MOVE      DSEQ#         HDSEQ#
691400130927     c                   exsr      #getsystime
6915001401213420 C                   EXCEPT    hisdemo
6916009102153422 C                   END
6917009102153423 C*
6918009102153424 C     DEPSS#        IFNE      D14
6919009102153425 C                   MOVE      'M54'         TRCODE
6920009102153426 C                   MOVEL     DEPSS#        NOTE2
6921009102153427 C                   MOVEL     D14           CK#NOT
6922009102153428 C                   MOVE      DSEQ#         HDSEQ#
692300130927     c                   exsr      #getsystime
6924001401213430 C                   EXCEPT    hisdemo
6925009102153432 C                   END
6926009102153433 C*
6927009102153434 C     DSTUDN        IFNE      D15
6928009102153435 C                   MOVE      'M55'         TRCODE
6929009102153436 C                   MOVEL     DSTUDN        NOTE2
6930009102153437 C                   MOVEL     D15           CK#NOT
6931009102153438 C                   MOVE      DSEQ#         HDSEQ#
693200130927     c                   exsr      #getsystime
6933001401213440 C                   EXCEPT    hisdemo
6934009102153442 C                   END
6935009102153443 C*
6936009102153444 C     DMEDCR        IFNE      D16
6937009102153445 C                   MOVE      'M56'         TRCODE
6938009102153446 C                   MOVEL     DMEDCR        NOTE2
6939009102153447 C                   MOVEL     D16           CK#NOT
6940009102153448 C                   MOVE      DSEQ#         HDSEQ#
694100130927     c                   exsr      #getsystime
6942001401213450 C                   EXCEPT    hisdemo
6943009102153452 C                   END
6944009102153453 C*
6945009102153454 C     DMED#         IFNE      D17
6946009102153455 C                   MOVE      'M57'         TRCODE
6947009102153456 C                   MOVEL     DMED#         NOTE2
6948009102153457 C                   MOVEL     D17           CK#NOT
6949009102153458 C                   MOVE      DSEQ#         HDSEQ#
695000130927     c                   exsr      #getsystime
6951001401213460 C                   EXCEPT    hisdemo
6952009102153462 C                   END
6953009102153463 C*
6954009102153464 C     DMEDAD        IFNE      D18
6955009102153465 C                   MOVE      'M58'         TRCODE
6956009102153468 C                   MOVE      DSEQ#         HDSEQ#
6957009812303467 C                   MOVEL     D18           CK#NOT
695800981230y2k  C                   MOVEL     DMEDAD        NOTE2
695900981223      *
696000130927     c                   exsr      #getsystime
6961001401213470 C                   EXCEPT    hisdemo
6962009102153472 C                   END
6963009102153473 C*
6964009102153474 C     DMEDBD        IFNE      D19
6965009102153475 C                   MOVE      'M59'         TRCODE
6966009812233478 C                   MOVE      DSEQ#         HDSEQ#
6967009812303477 C                   MOVEL     D19           CK#NOT
696800981230y2k  C                   MOVEL     DMEDBD        NOTE2
696900981230      *
697000130927     c                   exsr      #getsystime
6971001401213480 C                   EXCEPT    hisdemo
6972009102153482 C                   END
6973009102153483 C*
6974009102153484 C     DHNDCP        IFNE      D20
6975009102153485 C                   MOVE      'M60'         TRCODE
6976009102153486 C                   MOVEL     DHNDCP        NOTE2
6977009102153487 C                   MOVEL     D20           CK#NOT
6978009102153488 C                   MOVE      DSEQ#         HDSEQ#
697900130927     c                   exsr      #getsystime
6980001401213490 C                   EXCEPT    hisdemo
6981009102153492 C                   END
6982009102153493 C*
6983009102153494 C     DHDDT         IFNE      D21
6984009102153495 C                   MOVE      'M61'         TRCODE
6985009812233498 C                   MOVE      DSEQ#         HDSEQ#
6986009812303497 C                   MOVEL     D21           CK#NOT
698700981230y2k  C                   MOVEL     DHDDT         NOTE2
698800981230      *
698900130927     c                   exsr      #getsystime
6990001401213500 C                   EXCEPT    hisdemo
6991009102153502 C                   END
6992009102153503 C*
6993009102153504 C     DCOB          IFNE      D22
6994009102153505 C                   MOVE      'M62'         TRCODE
6995009102153506 C                   MOVEL     DCOB          NOTE2
6996009102153507 C                   MOVEL     D22           CK#NOT
6997009102153508 C                   MOVE      DSEQ#         HDSEQ#
699800130927     c                   exsr      #getsystime
6999001401213510 C                   EXCEPT    hisdemo
7000009102153512 C                   END
7001009102153513 C*
7002009102153514 C     DCOBEN        IFNE      D23
7003009102153515 C                   MOVE      'M63'         TRCODE
7004009102153516 C                   MOVEL     DCOBEN        NOTE2
7005009102153517 C                   MOVEL     D23           CK#NOT
7006009102153518 C                   MOVE      DSEQ#         HDSEQ#
700700130927     c                   exsr      #getsystime
7008001401213520 C                   EXCEPT    hisdemo
7009009102153522 C                   END
7010009102153523 C*
7011009102153524 C     DCOBPN        IFNE      D24
7012009102153525 C                   MOVE      'M64'         TRCODE
7013009102153526 C                   MOVEL     DCOBPN        NOTE2
7014009102153527 C                   MOVEL     D24           CK#NOT
7015009102153528 C                   MOVE      DSEQ#         HDSEQ#
701600130927     c                   exsr      #getsystime
7017001401213530 C                   EXCEPT    hisdemo
7018009102153532 C                   END
7019009102153533 C*
7020009102153534 C     DCOBP#        IFNE      D25
7021009102153535 C                   MOVE      'M65'         TRCODE
7022009102153536 C                   MOVEL     DCOBP#        NOTE2
7023009102153537 C                   MOVEL     D25           CK#NOT
7024009102153538 C                   MOVE      DSEQ#         HDSEQ#
702500130927     c                   exsr      #getsystime
7026001401213540 C                   EXCEPT    hisdemo
7027009102153542 C                   END
7028009102153543 C*
7029009102153544 C     DCOBBC        IFNE      D26
7030009102153545 C                   MOVE      'M71'         TRCODE
7031009102153546 C                   MOVEL     DCOBBC        NOTE2
7032009102153547 C                   MOVEL     D26           CK#NOT
7033009102153548 C                   MOVE      DSEQ#         HDSEQ#
703400130927     c                   exsr      #getsystime
7035001401213550 C                   EXCEPT    hisdemo
7036009102153552 C                   END
7037009102153553 C*
7038009102153554 C     DCOBCT        IFNE      D27
7039009102153555 C                   MOVE      'M72'         TRCODE
7040009102153556 C                   MOVEL     DCOBCT        NOTE2
7041009102153557 C                   MOVEL     D27           CK#NOT
7042009102153558 C                   MOVE      DSEQ#         HDSEQ#
704300130927     c                   exsr      #getsystime
7044001401213560 C                   EXCEPT    hisdemo
7045009102153562 C                   END
7046009102153563 C*
7047009102153564 C     DCOBST        IFNE      D28
7048009102153565 C                   MOVE      'M73'         TRCODE
7049009102153566 C                   MOVEL     DCOBST        NOTE2
7050009102153567 C                   MOVEL     D28           CK#NOT
7051009102153568 C                   MOVE      DSEQ#         HDSEQ#
705200130927     c                   exsr      #getsystime
7053001401213570 C                   EXCEPT    hisdemo
7054009102153572 C                   END
705500110719
7056001107193573  * depend email change
7057001107193564 C     d2email       IFNE      D33
7058001107193565 C                   MOVE      'M76'         TRCODE
7059001107193566 C                   MOVEL     d2email       NOTE2
7060001107193567 C                   MOVEL     D33           CK#NOT
7061001107193568 C                   MOVE      DSEQ#         HDSEQ#
706200130927     c                   exsr      #getsystime
7063001401213570 C                   EXCEPT    hisdemo
7064001107193572 C                   END
7065001107193573 C*
7066000008293624 C                   ENDSR
706700160622
7068001305153760  ****************************************************************
7069001305153762  *----------------- CALCULATE AGE BAND -------------------------*
7070001306183762  * Fields needed by this routine = age & plnmst record for age bands
7071001306183762  * Field returned by this routine = agbandwk
7072001305153762  *
7073001305153760  ****************************************************************
7074001305093764 C     #calcageband  BEGSR
7075001305093775
707600130515     C                   clear                   agbandwk          2 0
707700130509     C                   DO        20            D                 2 0
707800130509     c                   if        (age >= fa(d)) and
707900130509     c                             (age <= ta(d))
708000130515     C                   Z-ADD     D             agbandwk
708100130509     c                   leave
708200130509     C                   end
708300130509     C                   enddo
708400130509
7085000008293797 C                   ENDSR
708600130509
7087001305093830 C*
7088009102153827 C****************************************************************
7089001306183842 C* ------- Find the declinning life range for age -------
7090001306183762  * Fields needed by this routine = age & declif record for age range
7091001305153762  * Field returned by this routine = dlwork
7092001305153762  *
7093001305093827 C****************************************************************
7094001305093831 C     #getDLrange   BEGSR
7095009102153841 C*
709600130515     C                   clear                   dlwork            2 0
709700130509     C                   DO        20            D
709800130509     c                   if        (age >= abf(d)) and
709900130509     c                             (age <= abt(d))
710000130515     C                   Z-ADD     D             dlwork
710100130509     c                   leave
710200130509     C                   end
710300130509     C                   enddo
710400130509
7105000008293854 C                   ENDSR
710600130509
710700130618      ******************************************************************
710800130618      * ---------- Calculate the members age as of agedtwk ------------
7109001306183762  * Field needed by this routine = agedatwk
7110001306183762  * Field returned by this routine = age
711100130618      ******************************************************************
711200130509     C     #calcage      BEGSR
711300130509
711400130509     C                   eval      age = agedatyr - bcy
711500130509     C                   if        (agedatmo <> 12) and (agedatmo < bmo)
711600130509     C                   sub       1             age               3 0
711700130509     C                   end
711800130509
711900130509     C                   endsr
712000130509
712100981202A896 C/EJECT
712200981202      ****************************************************************
712300221013     C*----------------------- DATE CHECK ---------------------------*
712400221013E001  *  This subr validates the field DATECK in MMDDYYYY order
712500221013 |   C*  Invalid = *in98 *on
712600221013 |   C*  Year exceeds 2099 = *in98  prevents valid dates like 2200
712700221013E001 C*
712800221013     C     #DATCK        BEGSR
712900221013E001 C                   eval      *in98 = *off
713000221013 |   C                   If        DATECK > 0
713100221013 |   C                   Movel     DATECK        Input_Date
713200221013 |   C                   EXSR      EDTDAT
713300221013 |   C                   If        Output_Error <> *Blanks
713400221013 |   C                   eval      *in98 = *on
713500221013 |   C                   end
713600221013 |   C                   If        YY > 2099
713700221013 |   C                   eval      *in98 = *on
713800221013 |   C                   end
713900240109J003 C                   else
714000240109J003 C                   eval      *in98 = *on
714100221013E001 C                   end
714200130516     C                   ENDSR
7143009102153856 C****************************************************************
7144009102153858 C*----------------------- SET OFF ------------------------------*
7145009102153859 C*
7146009102153860 C     #SETOF        BEGSR
7147009102153861 C*
7148009102153862 C                   SETOFF                                       111213
7149009102153863 C                   SETOFF                                       141516
7150009102153864 C                   SETOFF                                       171819
7151001108303865 C                   SETOFF                                       3031
7152001401213866 C                   SETOFF                                           42
7153009202253867 C                   SETOFF                                         4950
7154009102153868 C                   SETOFF                                       515253
7155009102153869 C                   SETOFF                                       545556
7156009102153870 C                   SETOFF                                       575859
7157009102153871 C                   SETOFF                                       606162
7158009102153872 C                   SETOFF                                       636465
7159009102153873 C                   SETOFF                                       666768
7160001110253874 C                   SETOFF                                       697071
7161009901273875 C                   SETOFF                                       747576
7162000306113875 C                   SETOFF                                       7778
716300220607     C*
7164000008293877 C                   ENDSR
7165009102153896 C/EJECT
7166009102153897 C****************************************************************
7167009102153899 C*----------------------- CLEAR --------------------------------*
7168009102153901 C     #CLEAR        BEGSR
7169001012173902 C                   clear                   mnonssn
7170001012173902 C                   clear                   memail
7171009104251574 C                   MOVE      *ZEROS        MENRDT
7172001411121574 C                   clear                   menrdt_ymd
7173009102153902 C                   MOVE      *BLANKS       LNAME
7174009102153903 C                   MOVE      *BLANKS       FNAME
7175009102153904 C                   MOVE      *BLANKS       MI
7176009102153905 C                   MOVE      *BLANKS       ADDR1
7177009102153906 C                   MOVE      *BLANKS       ADDR2
7178009102153907 C                   MOVE      *BLANKS       CITY
7179009102153908 C                   MOVE      *BLANKS       STATE
7180009102153909 C                   MOVE      *BLANKS       SEX
7181009102153910 C                   MOVE      *BLANKS       QECD
7182009102153911 C                   MOVE      *BLANKS       NTFYCD
7183009102153912 C                   MOVE      *BLANKS       TERMCD
7184009202063912 C                   MOVE      *BLANKS       TCODE
7185009202063912 C                   MOVE      *BLANKS       RCODE
718600050930     C                   Move      *Blanks       INLIF
718700050930     C                   Move      *Blanks       INADD
7188009102153913 C                   MOVE      'A'           EMPST
718900050628     C                   Move      *Blanks       NONEMP
719000060221     C                   Move      *Blanks       CCFLG
7191009102153914 C                   MOVE      'N'           MEDICR
7192009102153915 C                   MOVE      *BLANKS       MED#
7193009102153916 C                   MOVE      *ZEROS        MEDADT
7194009102153917 C                   MOVE      *ZEROS        MEDBDT
7195009602213918 C                   MOVE      ' '           HNDICP
7196009102153919 C                   MOVE      *ZEROS        HDCPDT
7197000102143920 C                   MOVE      'N'           COBX
7198009102153921 C                   MOVE      'N'           COBBCF
7199009102153922 C                   MOVE      *BLANKS       COBENM
7200009102153923 C                   MOVE      *BLANKS       COBPNM
7201009102153924 C                   MOVE      *BLANKS       COBP#
7202009102153930 C                   MOVE      *ZEROS        ZIP
7203009102153931 C                   MOVE      *ZEROS        AREA
7204009102153932 C                   MOVE      *ZEROS        PHONE
7205009102153933 C                   MOVE      *ZEROS        BIRTH
7206009102153934 C                   MOVE      *ZEROS        TRUST
7207009102153935 C                   MOVE      *ZEROS        SUBNO
7208009102153936 C                   MOVE      *ZEROS        ACCNO
7209009102153937 C                   MOVE      *ZEROS        QEDT
7210009102153938 C                   MOVE      *ZEROS        NTFYDT
7211009102153939 C                   MOVE      *ZEROS        TERMDT
7212009202063939 C                   MOVE      *ZEROS        REINDT
7213009102153940 C                   MOVE      *ZEROS        EEXPDT
7214009102153941 C                   MOVE      *ZEROS        PEXPDT
7215009102153942 C                   MOVE      *ZEROS        EMPDT
7216009102153943 C                   MOVE      *ZEROS        SALARY
7217009102153944 C                   MOVE      *ZEROS        MARDT
7218009102153945 C                   MOVE      *ZEROS        ZERO7             7 0
7219009102153947 C                   MOVE      *ZEROS        ZERO9             9 0
7220000008293948 C                   ENDSR
7221009102154120 C/EJECT
7222009102154121 C****************************************************************
7223001305201665 C* clear data entry fields on IO03 screen (mcov)
7224001305204121 C****************************************************************
7225001305204123
7226001305204129 C     #clrio03      BEGSR
7227001305201666
722800130520y2k  C                   clear                   SPLAN#
7229001305201668 C                   clear                   SCVTYP
7230001305201669 C                   clear                   SENRLD
7231001305201669 C                   clear                   SCAND1
7232001305201670 C                   clear                   SBENAM
7233001305201671 C                   clear                   ASOFDT
7234001305201672 C                   clear                   SACTCD
7235001305201673 C                   clear                   L#
7236001305201672 C                   clear                   trmrcd
723700110825
7238001305203948 C                   ENDSR
723900130520
7240001305204121 C****************************************************************
7241001305204123 C*            * BENEFIT CALCULATION *
7242001305204126 C* THIS SUBROUTINE WILL CALCULATE THE BENEFIT AMOUNT
7243001305204129 C     #calcben      BEGSR
724400130520
7245001108254130  * Flat benefit amount - skip salary based calcs and go to declife calc
7246001108254131 C                   if        fltflg = 'F'
7247001108254134 C                   GOTO      #declif
7248009102154135 C                   END
724900110825
7250001108254130  * Salary based benefit amount...
725100110825
7252001108254138 C* MULTIPLY SALARY TIMES MULTIPLIER IN PLAN RECORD AND
7253001108254139 C* MOVE TO WORK FIELD
7254009102154140 C*
7255009102154141 C     SALARY        MULT      MULT          BENHLD            9 2
7256000102144142 C                   MOVE      BENHLD        @BA
7257009102154143 C*
7258009102154144 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM PLAN RECORD
7259009102154145 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
7260009102154146 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
7261009102154147 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
7262009102154148 C*
7263009102154149 C                   MOVE      'NO '         ADD$R             3
7264009102154150 C     ROUND         IFGT      0
7265009102154151 C*
7266009102154152 C* FIND $ AMOUNT TO BE ROUNDED
7267009102154153 C*
7268000102144154 C                   MOVE      ROUND         @RA
7269009102154155 C                   MOVE      *ZEROS        $BR
7270009102154156 C                   Z-ADD     5             $C                1 0
7271009102154157 C                   Z-ADD     7             $D                1 0
7272009102154158 C                   MOVE      $BA(9)        $BR(9)
7273009102154159 C                   MOVE      $BA(8)        $BR(8)
7274009102154160 C                   DO        5
7275009102154161 C     $RA($C)       IFEQ      0
7276009102154162 C                   MOVE      $BA($D)       $BR($D)
7277009102154163 C                   SUB       1             $C
7278009102154164 C                   SUB       1             $D
7279009102154165 C                   ELSE
7280009102154166 C                   GOTO      #S$T02
7281009102154167 C                   END
7282009102154168 C                   END
7283009102154169 C*
7284009102154170 C     #S$T02        TAG
7285009102154171 C*
7286009102154172 C     $BA           SUB       $BR           $BA
7287009102154173 C*
7288009102154174 C     RNDFLG        IFEQ      'U'
7289000102144175 C                   MOVE      @BR           BRTEST            9 2
7290009102154176 C     BRTEST        IFGT      0
7291009102154177 C                   MOVE      'YES'         ADD$R
7292009102154178 C                   END
7293009102154179 C                   END
7294009102154181 C                   END
7295009102154182 C*
7296009102154184 C* NOW PLACE RESULT IN FIELD BENAMT, AND MOVE TO SCREEN ARRAY
7297009102154185 C* FOR SCREEN IO03, BA,Z.
7298009102154186 C*
7299001108254188 C                   MOVEL     @BA           benamtwk
7300009811254180 C*
7301009102154189 C     ADD$R         IFEQ      'YES'
7302001108254190 C                   ADD       ROUND         benamtwk
7303009102154191 C                   END
7304009102154192 C*
7305009102154193 C* IF COMPUTED BENEFIT AMOUNT IS GREATER THAN THE MAXIMUM BENEFIT
7306009102154194 C* ALLOWED, REPLACE COMPUTED BENEFIT WITH MAXIMUM BENEFIT
7307009102154195 C* FROM PLAN RECORD.
7308009102154196 C*
7309001108254197 C     benamtwk      IFGT      MAXBEN
7310001108254198 C                   MOVE      MAXBEN        benamtwk
7311009102154199 C                   END
731200110825
7313001108254201  * calc declining life
731400110825
7315001108254202 C     #declif       TAG
7316001109094203  * hold benefit amount before declife calcs
731700110909     c                   z-add     benamtwk      benamtwkHOLD
731800110909
7319001305104204 C     PLANKY        CHAIN     DECLIF
732000130510     c                   if        not %found(declif)
7321001305104205 C                   GOTO      #SKDE2
732200130510     c                   end
7323001305094206 C* find age
7324001305094206 C* 11/01/07 - use mcov enrollment date for age
732500130509     C                   z-add     enrldt        agedatwk
732600130509     c                   exsr      #calcage
7327001305094206 C* find declife percent
7328001305094208 C                   EXSR      #getDLrange
7329001305104206
7330001305104206 C* no declife - skip
7331001305154209 C                   if        dlwork = 0
7332009102154210 C                   GOTO      #SKDE2
7333009102154211 C                   END
7334009102154212 C*
7335001305154213 C     benamtwk      MULT(H)   DRT(dlwork)   HOLD             13 5
7336009102154214 C                   Z-ADD     HOLD          BENHLD
7337000102144216 C                   MOVE      BENHLD        @BA
7338009102154217 C*
7339009102154218 C* IF ROUNDING UP, ADD ROUNDING FACTOR FROM DECLINING LIFE BENEFIT RECORD
7340009102154219 C* TO BENEFIT AMOUNT. IF ROUNDING DOWN, LEAVE BENEFIT AMOUNT
7341009102154220 C* AS IS, AFTER FIRST ASCERTAINING WHETHER THE BENEFIT AMOUNT
7342009102154221 C* IS ALREADY AN EVEN AMOUNT IN THE POSITIONS TO BE ROUNDED.
7343009102154222 C*
7344009102154223 C                   MOVE      'NO '         ADD$R             3
7345009102154224 C     DRNDAM        IFGT      0
7346009102154225 C*
7347009102154226 C* FIND $ AMOUNT TO BE ROUNDED
7348009102154227 C*
7349000102144228 C                   MOVE      DRNDAM        @RA
7350009102154229 C                   MOVE      *ZEROS        $BR
7351009102154230 C                   Z-ADD     5             $C                1 0
7352009102154231 C                   Z-ADD     7             $D                1 0
7353009102154232 C                   MOVE      $BA(9)        $BR(9)
7354009102154233 C                   MOVE      $BA(8)        $BR(8)
7355009102154234 C                   DO        5
7356009102154235 C     $RA($C)       IFEQ      0
7357009102154236 C                   MOVE      $BA($D)       $BR($D)
7358009102154237 C                   SUB       1             $C
7359009102154238 C                   SUB       1             $D
7360009102154239 C                   ELSE
7361009102154240 C                   GOTO      #S$T04
7362009102154241 C                   END
7363009102154242 C                   END
7364009102154243 C*
7365009102154244 C     #S$T04        TAG
7366009102154245 C*
7367009102154246 C     $BA           SUB       $BR           $BA
7368009102154247 C*
7369009102154248 C     DROUND        IFEQ      'U'
7370000102144249 C                   MOVE      @BR           BRTEST            9 2
7371009102154250 C     BRTEST        IFGT      0
7372009102154251 C                   MOVE      'YES'         ADD$R
7373009102154252 C                   END
7374009102154253 C                   END
7375009102154255 C                   END
7376009102154258 C*
7377001108254260 C                   MOVEL     @BA           benamtwk
7378009102154261 C     ADD$R         IFEQ      'YES'
7379001108254262 C                   ADD       DRNDAM        benamtwk
7380009102154263 C                   END
7381009102154264 C*
7382009102154265 C     #SKDE2        TAG
738300920316     C*
7384001108254267 C                   MOVE      benamtwk      CBENAM
7385000008304268 C                   ENDSR
738600981125     C/EJECT
738700910905     C*****************************************************************
7388000710034271 C* Get grate
738900071003     C*****************************************************************
7390009102154272 C     #GRATE        BEGSR
7391009102154273 C**
7392009102154274 C                   MOVE      *BLANKS       NOGRAT            1
7393009102154275 C                   MOVE      *BLANKS       HGROUP
739400071003     C                   clear                   grfound           1
739500110622      * hold original date passed to this routine
739600110622     C                   move      cymd          holdgrcymd        8 0
739700110622y2k  C                   Z-ADD     ACVTDT        acvtdt31          8 0
739800110622y2k  C                   move      31            acvtdt31
739900110622      * safety measure in case acvdtd31 is bad
740000110622     c                   if        acvtdt31 < 19800101
740100110622y2k  C                   Z-ADD     udcymd        acvtdt31          8 0
740200110622     c                   end
740300110701
740400110701      * get 60 days from today for warning msg
740500110701     C                   clear                   gr60dayerr        1
740600110701y2k  C                   move      udcymd        workdt2
740700110701     C                   adddur    60:*d         workdt2
740800110701     C                   move      workdt2       ahead60daysymd    8 0
740900071003
741000110622     c     #againgrate   tag
741100110622
741200071003     C     hrate         SETLL     GRATE
741300071003     C                   DOU       %eof(grate)
741400071003     C     hrate         READE     GRATE
741500071003     c                   if        not %eof(grate) and grdltd = 'A' and
741600071003     C                             (cymd >= frmdat) and (cymd <= todat)
741700071003     C                   move      'Y'           grfound
7418000710034295 C                   MOVE      GROUP#        HGROUP           15
741900071003     c                   leave
742000071003     C                   end
742100071003     C                   ENDDO
742200071003
742300110622      * rate record not found
7424000710034304 C                   if        grfound = *blank
742500110622
742600110701      * is this error > 60 days from today?
742700110701     c                   if        cymd > ahead60daysymd
742800110701     c                   eval      gr60dayerr = 'Y'
742900110701     c                   end
743000110701
743100110622      * if date searched is > the acct cover thru month then subtract 1
743200110622      * month and try again
743300110622     c                   if        cymd > acvtdt31
743400110622     C                   move      cymd          workdt
743500110622     C                   subdur    1:*m          workdt
743600110622     C                   move      workdt        cymd
743700110622     c                   goto      #againgrate
7438001106224306 C                   END
743900110622
7440009102154305 C                   MOVE      'Y'           NOGRAT            1
7441009102154306 C                   END
744200071003
744300110622      * put original date back in cymd in case it is used elsewhere as
744400110622      * it was passed to this routine
744500110622     C                   move      holdgrcymd    cymd
744600110622
7447000008304307 C                   ENDSR
744800131211   S***S
7449009105222653 C****************************************************************
7450001305164324 C* Display SALARY CHANGE EFFECTIVE DATE screen
7451001305162653 C****************************************************************
745200130516     C     #dspsalchdt   BEGSR
745300130516     c                   if        *inka
745400130516     C                   EXSR      #RTRV
745500130516     C                   leavesr
745600130516     c                   end
745700910917     C*
745800910522     C                   Z-ADD     SCHDT         DATECK
745900910522     C                   EXSR      #DATCK
746000130516
746100130516      * *in98 = date error from #datck routine
746200130516     c                   if        *in98
746300130516     C                   Z-ADD     4             X                    50
746400130516     C                   EXCEPT    SALCHGSCRN
746500130516     C                   SETOFF                                       50
746600130516     C                   MOVE      *ZEROS        SCHDT
746700130516     c                   else
746800130516     C                   EXSR      #MEM
746900130516     c                   end
747000130516
747100130516     C                   ENDSR
747200130516
7473009105222653 C****************************************************************
7474001305164324 C* Display BIRTH DATE CHANGE EFFECTIVE DATE screen
7475001305162653 C****************************************************************
7476009105224324 C*
747700130516     C     #dspbdchdt    BEGSR
747800130516     c                   if        *inka
747900130516     C                   EXSR      #RTRV
748000130516     C                   Z-ADD     *ZEROS        BCHDT
748100130516     C                   leavesr
748200130516     c                   end
748300981216      *
748400990127     C                   MOVE      BCHDT         DATECK
748500910522     C                   EXSR      #DATCK
748600130516
748700130516      * *in98 = date error from #datck routine
748800130516     c                   if        *in98
748900130516     C                   Z-ADD     4             X                    50
749000130516     C                   EXCEPT    BIRCHG
749100130516     C                   SETOFF                                       50
749200130516     C                   MOVE      *ZEROS        BCHDT
749300130516     c                   else
749400910522     C                   EXSR      #MEM
749500130516     C                   end
749600130516
749700130516     C                   ENDSR
749800981125     C/EJECT
7499001305152653  ****************************************************************
750000130515      * find most recent plan renewal based on acct covtdt.
7501001305152653  ****************************************************************
750200130515     C     #fndlstprenew BEGSR
750300130510
750400130515     c                   clear                   lastprenewwk
750500130515
750600130509     C                   if        prenewmm = 0
750700130509     C                   leavesr
750800130509     C                   end
750900130509
751000130515     c                   move      acvtdt        lastprenewwk
751100130515
751200130515      * same year renew
751300130515     c                   if        prenewmm <= lastprenmm
751400130515     c                   move      prenewmm      lastprenmm
751500130509     c                   else
751600130509      * last year renew
751700130515     c                   move      prenewmm      lastprenmm
751800130515     c                   move      lastprenewwk  workdt
751900130509     c                   subdur    1:*y          workdt
752000130515     c                   move      workdt        lastprenewwk
752100130509     c                   end
752200130515
752300130510     C                   ENDSR
752400130510
752500130510     C****************************
752600130510     C* READ MCOV REC
752700130510     C****************************
752800910913     C     #READU        BEGSR
752900910913     C*
753000910913     C                   SETOFF                                       95
753100910913     C                   MOVEL     SSNO          MSETL            21
753200910913     C     MSETL         SETLL     MCOVC
753300910913     C                   Z-ADD     1             Z#                3 0
753400910913     C     #READ1        TAG
753500910913     C                   READ      MCOVC                                  95
753600910913     C  N95SSNO          IFNE      MCSSNO
753700140121     C                   EXCEPT    relmcovc
753800910913     C                   SETON                                            95
753900910913     C                   END
754000910913     C*
754100910913     C   95              GOTO      #ENDR1
754200910913     C     Z#            IFEQ      LL(L#)
754300910913     C                   GOTO      #ENDR1
754400910913     C                   END
754500910913     C*
754600910913     C                   ADD       1             Z#
754700910913     C                   GOTO      #READ1
754800000830     C     #ENDR1        ENDSR
754900130510
755000130510
7551009203062653 C****************************************************************
755200130620     C* Find the age band for new mcov add and BDAY change
755300130618     C* agedatwk  is the field used by this routine as the input date
755400130618     C*           it should be filled in with the coverage effective date
755500130618     C* AB_OUT    is the field returned from this routine
7556001305152653 C****************************************************************
755700130515     C     #findab       BEGSR
755800130620     C                   eval      *in42 = *off
755900130620     C                   clear                   in42date
756000130620     C                   clear                   ab_out            2 0
756100981208y2k  C                   Z-ADD     ACVTDT        ACVYMD            8 0
756200130620
756300130620      * agedatwk will be the default date used. This should be the coverage
756400130620      * effective date that was passed to this routine.
756500130620      * hold the original mcov effdt for use in this routine
756600130620     c                   z-add     agedatwk      findab_mceffdt    8 0
756700130618
756800130515     C*
756900130515     C                   if        pabfl = 'R'
757000130715     C* check for BOR age calc date OVERRIDE for renewal based plans
757100130715     C* Field getborad_ADR = the Age Date Returned from the call, this
757200130715     C* is the date to use for the age calcualtion
757300130715     c                   clear                   getborad_tsp     10
757400130716     c                   move      keytrust      keytrustchar      3
757500130716     c                   move      keysub        keysubchar        3
757600130716     c                   eval      getborad_tsp = keytrustchar +
757700130716     c                             keysubchar + keyplan
757800130716     c                   move      findab_mceffdtgetborad_mceff    8
757900130716     c                   move      empdt         getborad_empdt    8
758000130716     c                   clear                   getborad_ADR      8
758100130717     c                   clear                   getborad_ADT      2
758200130716     c                   clear                   getborad_error    1
758300130715     c                   call      'GETBORAD'
758400130715     c                   parm                    getborad_tsp
758500130715     c                   parm                    getborad_mceff
758600130715     c                   parm                    getborad_empdt
758700130715     c                   parm                    getborad_ADR
758800130717     c                   parm                    getborad_ADT
758900130715     c                   parm                    getborad_error
759000130715
759100130715      * as long as no error was found, use the date returned
759200130715     c                   if        getborad_error = *blanks and
759300130715     c                             getborad_ADR <> *blanks
759400130715     c                   move      getborad_ADR  agedatwk
759500130715     c                   end
759600130515     c                   end
759700130715
759800130515
759900130618     C* calculate age as of the eff date or BOR date depending on what
760000130515     C* was needed in logic above
760100130515     c                   exsr      #calcage
760200130515     c                   z-add     age           age_effdt         3 0
760300130515
760400130515     c                   exsr      #calcageband
760500130515     c                   z-add     agbandwk      ab_effdt          2 0
760600130515
760700130516      * place AB in ab_out field returned from this routine
760800130515     c                   z-add     ab_effdt      ab_out
760900130515
761000130515      **********************************************************************
761100130515      * Check for the need to issue a message when the age band used to add
761200130515      * the plan differs from the age band calcuated at the current account
761300130515      * cover thru date. This would mean an age band change should have
761400130515      * occured after the add effdt but since the member was not active it
761500130515      * was not able to occr at normal invoice time. This means the operator
761600130515      * must cancel / add a new mcov record to handel the age band change
761700130515      * manually.
761800130515      **********************************************************************
761900130515
762000130515      *****************************
762100130515      * monthly age banded plans
762200130515      *****************************
762300130515     c                   if        pabfl = 'M'
762400130515      * if add is before acvtdt - check for age band change after add effdt
762500130618     c                   if        findab_mceffdt < acvymd
762600130515     C* calc age & AB as of account cover thru date
762700130515     c                   z-add     acvtdt        agedatwk
762800130515     c                   exsr      #calcage
762900130515     c                   z-add     age           age_acvtdt        3 0
763000130515
763100130515     C                   Z-ADD     age_acvtdt    AGE
7632001305153816 C                   clear                   ab_acvtdt         2 0
763300130515     c                   exsr      #calcageband
763400130515     c                   z-add     agbandwk      ab_acvtdt
763500130515
763600130515      * if AB is different then issue msg to cancel/add as of bday
763700130515     c                   if        ab_effdt <> ab_acvtdt
763800130515     C                   eval      *in42 = *on
763900130515     c                   z-add     birth         IN42date          8 0
764000130515     c                   end
764100130515     c                   end
764200130516     c                   end
764300130515
764400130515      *****************************
764500130515      * Renewal age banded plans
764600130515      *****************************
764700130515     c                   if        pabfl = 'R'
764800130515
764900130515      * find last plan renew date
765000130515     c                   exsr      #fndlstprenew
765100130515
765200130515      * skip if no renewal date was found
765300130515     c                   if        lastprenewwk = 0
765400130515     c                   leavesr
765500130515     c                   end
765600130515
765700130515      * if add is before last plan renew date check for age band change
765800130515      * after add effdt
765900130618     c                   if        findab_mceffdt < lastprenewwk
766000130515
766100130515      * calc age & AB as of last plan renew date
766200130515     c                   z-add     lastprenewwk  agedatwk
766300130515     c                   exsr      #calcage
7664001305153001 C                   EXSR      #calcageband
766500130515     c                   z-add     agbandwk      ab_lastprenew     2 0
766600130515
766700130515      * if age band changed, issue msg to cancel/add as of plan renew date
766800130515     c                   if        ab_effdt <> ab_lastprenew
766900130515     C                   eval      *in42 = *on
767000130515     c                   z-add     lastprenewwk  IN42date
767100130515     c                   end
767200130515
767300130515     c                   end
767400130515
767500130515     c                   end
767600130515
767700000830     C                   ENDSR
767800920306     C/EJECT
7679009710090922 C********************************************************************
7680009710090924 C*------------------------- #PCP   ---------------------------------*
7681009710090926 C     #PCP          BEGSR
768200020307     C
7683000208080931 C                   MOVE      SSNO          SSNUM             9
7684000208080931 C***                MOVE      'N'           NEW               1
768500020318001  C                   CALL      'FM33XCL'
768600020808001  C                   PARM                    SSNUM
768700020808001  C***                PARM                    NEW
768800020318     C                   GOTO      ENDPCP
768900020307     C
769000020307     C
7691009902010925 C*
7692009902010928 C* WRITE PCP RECORD - SHOW SCREEN AGAIN UNTIL CMD1
7693009902010925 C*
7694009710120931 C                   MOVE      SSNO          PCSSN             9 0
7695009710120931 C                   MOVE      *ZEROS        PCCAN             8 0
7696009811250940 C*
769700971012     C     PCID#         IFNE      *BLANKS
7698009902010927 C* EDIT EFFDT
7699009902011163 C  NKA              SETOFF                                       77
7700009902011161 C  NKA              Z-ADD     PCEFF         DATECK
7701009902011162 C  NKA              EXSR      #DATCK
770200990201     C  NKA
7703009902011163 CAN 98              SETON                                        77
770400990201     C  NKA
770500990201     CAN 98              EXCEPT    IO78
770600990201     C  NKA
770700990201     CAN 98              GOTO      #END78
770800990201     C  NKA              MOVE      PCEFF         MDCY#
770900990201     C  NKA              EXSR      #CYMD8
771000990201     C  NKA              MOVE      CYMD#         PCEYMD            8 0
771100990201     C  NKA              EXCEPT    PCPADD
771200971012     C                   END
7713009902010927 C*
771400971009     C  NKA              MOVE      *BLANKS       PCID#
771500971009     C  NKA              MOVE      *BLANKS       PCSPCD
771600971009     C  NKA              EXCEPT    IO78
7717000009072006 C*
7718000009070941 C     #END78        TAG
7719000009072006 C*
7720000009072013 C  N43              MOVE      DRELCD        DRELC2
7721000009072014 C  N43              MOVE      DS04A         DS04AH
7722000009072015 C  N43              MOVE      DS04B         DS04BH
772300000907y2k  C  N43              MOVE      DS04D         DS04DH
772400110719y2k  C  N43              MOVE      DS04E         DS04EH
7725000009072016 C  N43DLTC3         IFNE      'A'
7726000009072017 C                   SETON                                        5089
7727000009072018 C                   Z-ADD     27            X
7728000009072019 C                   END
772900000907     C****************TEST*************
773000000907y2k   * Reverse format of file dates for display
773100000907Y2K  C   40
773200000907y2k  CORN43              EXSR      #KIDEP
7733000009070935 C   40
7734000009070936 CORN43              SETON                                        14
7735000009070937 C  N14              SETON                                        11
7736000009070940 C*
773700000907     C****************TEST*************
7738000008300940 C*
7739000203080941 C     ENDPCP        TAG
7740000203080941 C                   ENDSR
774100981230     C/EJECT
774200990106      **--------------------------------------------------**
774300990106      ** Format member dates for output to file  from scrn
774400981223     C     #FLMBR        BEGSR
774500981223      *
774600981223y2k  C                   MOVE      MENRDT        MDCY#
774700981223y2k  C                   EXSR      #CYMD8
774800981223y2k  C                   MOVEL     CYMD#         MENRDT
774900981223      *
775000981223y2k  C                   MOVE      BIRTH         MDCY#
775100981223y2k  C                   EXSR      #CYMD8
775200981223y2k  C                   MOVEL     CYMD#         BIRTH
775300981223      *
775400981223y2k  C                   MOVE      EMPDT         MDCY#
775500981223y2k  C                   EXSR      #CYMD8
775600981223y2k  C                   MOVEL     CYMD#         EMPDT
775700981223      *
775800981223y2k  C                   MOVE      MARDT         MDCY#
775900981223y2k  C                   EXSR      #CYMD8
776000981223y2k  C                   MOVEL     CYMD#         MARDT
776100981223      *
776200981223y2k  C                   MOVE      MEDADT        MDCY#
776300981223y2k  C                   EXSR      #CYMD8
776400981223y2k  C                   MOVEL     CYMD#         MEDADT
776500981223      *
776600981223y2k  C                   MOVE      MEDBDT        MDCY#
776700981223y2k  C                   EXSR      #CYMD8
776800981223y2k  C                   MOVEL     CYMD#         MEDBDT
776900981223      *
777000981223y2k  C                   MOVE      HDCPDT        MDCY#
777100981223y2k  C                   EXSR      #CYMD8
777200981223y2k  C                   MOVEL     CYMD#         HDCPDT
777300981223      *
777400981223     C                   ENDSR
777500990113      **-------------------------------------------------**
777600990113      * Rearrange date / ccyymmdd to mmddccyy
777700990113      **-------------------------------------------------**
777800990113     C     #MDCY8        BEGSR
777900990113     C                   MOVE      CYMD#         MMDD#             4
778000990113     C                   MOVEL     CYMD#         CCYY#             4
778100990113     C                   MOVEL     MMDD#         MDCY#             8
778200990113     C                   MOVE      CCYY#         MDCY#
778300000830     C                   ENDSR
778400990113     C/EJECT
778500990113      **-------------------------------------------------**
778600990113      * Convert dates from mmddccyy to ccyymmdd
778700990113      **-------------------------------------------------**
778800990113     C     #CYMD8        BEGSR
778900990113     C                   MOVEL     MDCY#         MMDD#             4
779000990113     C                   MOVE      MDCY#         CCYY#             4
779100990113     C                   MOVE      MMDD#         CYMD#             8
779200990113     C                   MOVEL     CCYY#         CYMD#
779300000830     C                   ENDSR
779400990106      **-------------------------------------------------------**
779500990106      ** Format member dates for output to IO02  (file to scrn)
779600981223     C     #KIMBR        BEGSR
779700981223      *
779800981223y2k  C                   MOVE      MENRDT        CYMD#
779900981223y2k  C                   EXSR      #MDCY8
780000981223y2k  C                   MOVEL     MDCY#         MENRDT
780100981223      *
780200981223y2k  C                   MOVE      BIRTH         CYMD#
780300981223y2k  C                   EXSR      #MDCY8
780400981223y2k  C                   MOVEL     MDCY#         BIRTH
780500981223      *
780600981223y2k  C                   MOVE      EMPDT         CYMD#
780700981223y2k  C                   EXSR      #MDCY8
780800981223y2k  C                   MOVEL     MDCY#         EMPDT
780900981223      *
781000981223y2k  C                   MOVE      MARDT         CYMD#
781100981223y2k  C                   EXSR      #MDCY8
781200981223y2k  C                   MOVEL     MDCY#         MARDT
781300981223      *
781400981223y2k  C                   MOVE      MEDADT        CYMD#
781500981223y2k  C                   EXSR      #MDCY8
781600981223y2k  C                   MOVEL     MDCY#         MEDADT
781700981223      *
781800981223y2k  C                   MOVE      MEDBDT        CYMD#
781900981223y2k  C                   EXSR      #MDCY8
782000981223y2k  C                   MOVEL     MDCY#         MEDBDT
782100981223      *
782200981223y2k  C                   MOVE      HDCPDT        CYMD#
782300981223y2k  C                   EXSR      #MDCY8
782400981223y2k  C                   MOVEL     MDCY#         HDCPDT
782500981223      *
782600000830     C                   ENDSR
782700990106     C/EJECT
782800990106      **-------------------------------------------------------------**
782900000218      ** Format DEPENDENT dates for output to file  from scrn (DEPEND)
783000981223     C     #FLDEP        BEGSR
783100981223      *
783200981223y2k  C                   MOVE      DBIRTH        MDCY#
783300981223y2k  C                   EXSR      #CYMD8
783400981223y2k  C                   MOVEL     CYMD#         DBIRTH
783500981223      *
783600981223y2k  C                   MOVE      DMEDAD        MDCY#
783700981223y2k  C                   EXSR      #CYMD8
783800981223y2k  C                   MOVEL     CYMD#         DMEDAD
783900981223      *
784000981223y2k  C                   MOVE      DMEDBD        MDCY#
784100981223y2k  C                   EXSR      #CYMD8
784200981223y2k  C                   MOVEL     CYMD#         DMEDBD
784300981223      *
784400981223y2k  C                   MOVE      DHDDT         MDCY#
784500981223y2k  C                   EXSR      #CYMD8
784600981223y2k  C                   MOVEL     CYMD#         DHDDT
784700981223      *
784800021218y2k  C                   MOVE      DSEFFD        MDCY#
784900021218y2k  C                   EXSR      #CYMD8
785000021218y2k  C                   MOVEL     CYMD#         DSEFFD
785100021218      *
785200981223     C                   ENDSR
785300990106      **---------------------------------------------------------**
785400990106      ** Format depenant dates for output to IO04  (file to scrn)
785500981223     C     #KIDEP        BEGSR
785600981223      *
785700981223y2k  C                   MOVE      DBIRTH        CYMD#
785800981223y2k  C                   EXSR      #MDCY8
785900981223y2k  C                   MOVEL     MDCY#         DBIRTH
786000981223      *
786100981223y2k  C                   MOVE      DMEDAD        CYMD#
786200981223y2k  C                   EXSR      #MDCY8
786300981223y2k  C                   MOVEL     MDCY#         DMEDAD
786400981223      *
786500981223y2k  C                   MOVE      DMEDBD        CYMD#
786600981223y2k  C                   EXSR      #MDCY8
786700981223y2k  C                   MOVEL     MDCY#         DMEDBD
786800981223      *
786900981223y2k  C                   MOVE      DHDDT         CYMD#
787000981223y2k  C                   EXSR      #MDCY8
787100981223y2k  C                   MOVEL     MDCY#         DHDDT
787200981223      *
787300021218y2k  C                   MOVE      DSEFFD        CYMD#
787400021218y2k  C                   EXSR      #MDCY8
787500021218y2k  C                   MOVEL     MDCY#         DSEFFD
787600021218      *
787700981223     C                   ENDSR
7878009710090943 C/EJECT
787900010215DTAQ  ******************************************************
788000140121DTAQ  *  CREATE ADJUSTMENT FROM HIST PARM FOR COVERAGE ACTIVITY
788100010215DTAQ  ******************************************************
788200140121DTAQ C     #hstadj       BEGSR
788300140121
788400140121DTAQ C                   CLEAR                   WDHIST
788500140121DTAQ C                   CLEAR                   H_CK#NOT
788600140121DTAQ C                   CLEAR                   H_NOTE2
788700140121DTAQ C                   MOVE      SSNO          Q_HKEY
788800140121DTAQ C                   MOVE      TRCODE        Q_TRCODE
788900140121DTAQ C                   EVAL      QCKMH1   =    MH1
789000140121
789100140121DTAQ C                   IF        *IN47 = *OFF
789200140121DTAQ C                   EVAL      QCKAB  = 'AgeBand-'
789300140121DTAQ C                   EVAL      QCKABD =  MH2
789400140121DTAQ C                   EVAL      QCKCT  = 'CovType-'
789500140121DTAQ C                   EVAL      QCKCTP =  MH3
789600140121DTAQ C                   END
789700140121
789800140121DTAQ C                   IF        *IN46
789900140121DTAQ C                   EVAL      QNT2DSC = 'BenAmt'
790000140121DTAQ C                   MOVE      MH4           QNT8AMT
790100140121DTAQ C                   END
790200140121
790300140121DTAQ C                   IF        *IN26
790400140121DTAQ C                   EVAL      QNT2DSC = ' From-'
790500140121DTAQ C                   Move      MH4           QNT8AMT
790600140121DTAQ C                   END
790700140121
790800140121      * dependent transaction
790900140121DTAQ C                   IF        *IN25
791000140121DTAQ C**                 EVAL      QNT2DSC = ' Dep#-'
791100140121DTAQ C**                 Move      MH5           QNT8AMT
791200140121DTAQ C                   MOVE      MH5           Q_HDSEQ#
791300140121DTAQ C                   END
791400140121
791500140121dtaq C                   Move      MH6           QNT2DAT
791600140121DTAQ C                   MOVE      H_CK#NOT      Q_CK#NOT
791700140121DTAQ C                   MOVE      H_NOTE2       Q_NOTE2
791800140121DTAQ C                   MOVEl     thispgmname   Q_HPRGNM
791900140121DTAQ C                   MOVE      TRUST         Q_HSTRST
792000140121DTAQ C                   MOVE      SUBNO         Q_HSSUB#
792100140121DTAQ C                   MOVE      ACCNO         Q_HSACCT
792200140121DTAQ C                   MOVEl     luser         Q_HOPER
792300140121DTAQ C                   MOVE      'A'           Q_HSDLTD
792400140121DTAQ C                   MOVE      UDCYMD        Q_TRDATE
792500140121DTAQ C                   MOVE      ADJBEN        Q_RECVDT
792600140121DTAQ C                   MOVE      TRANDT        Q_COVTDT
792700140121
792800140121DTAQ C                   CALL      'TR261'
792900140121DTAQ C                   PARM                    Wdhist
793000140121
793100010215DTAQ C                   ENDSR
793200140121
793300081117DTAQ  ******************************************************
793400081117      * Set defaults
793500081117DTAQ  ******************************************************
793600081117DTAQ C     TRNCFS        BEGSR
793700081117     C                   eval      QQPGNM = WQPGMN
793800081117     C                   eval      QQUSER = WQUSRN
793900081117
794000081117     C     QQPGNM        Chain     TRNCFSP
794100081117     C                   if        %found(TRNCFSP)
794200081117     C                   if        OOSTAT = 'Y'
794300081117     C                   eval      QQFLAG = OOFLAG
794400081117     C                   else
794500081117     C                   eval      QQFLAG = OOOFFL
794600081117     C                   end
794700081117     C                   else
794800081117     C                   eval      QQFLAG = 'H'
794900081117     C                   end
795000081222
795100081222     C                   Select
795200081222     C                   When      HTCODE = 'BT'
795300081222     C                   eval      QQFLAG = 'D'
795400081222     C                   When      HTCODE = 'BC'
795500081222     C                   eval      QQFLAG = 'H'
795600081222     C                   Endsl
795700081117
795800081117     C                   eval      QQFIXF = 'N'
795900081117     C     *date         mult      10000.0001    QQDATE
796000081117     C                   Time                    QQTIME
796100081117     C                   eval      QQPCPE = *zeros
796200081117     C                   eval      QQPCPC = *zeros
796300081117DTAQ C                   ENDSR
796400101220
796500101220DTAQ  ******************************************************
796600101220      * check for variable benefit
796700101220DTAQ  ******************************************************
796800101220DTAQ c     #chkvarben    begsr
796900101220
797000101220     c     webnotkey     klist
797100101220     c                   kfld                    trust
797200101220     c                   kfld                    subno
797300101220     c                   kfld                    accno
797400101220     c                   kfld                    splan#
797500101220
797600110208      * screen input enroll date to YMD
797700110208y2k  C                   MOVE      SENRLD        MDCY#
797800110208y2k  C                   EXSR      #CYMD8
797900110208y2k  C                   MOVEL     CYMD#         senrldymd         8 0
798000110208
798100101220     c                   clear                   validben
798200101220     c                   clear                   varbenpln
798300101220     c     webnotkey     setll     webnotl1
798400101220     c                   dou       %eof(webnotl1)
798500101220     c     webnotkey     reade     webnotl1
798600110208     c                   if        not %eof(webnotl1) and senrldymd >= cnbeg
798700101220     c                             and (cnend = 0 or
798800110208     c                             (cnend <> 0 and senrldymd <= cnend))
798900101220     c                   eval      varbenpln = 'Y'
799000101220     c                   leave
799100101220     c                   end
799200101220     c                   enddo
799300101220
799400101220
799500101220      * this is a variable benefit amount plan
799600101220     c                   if        varbenpln = 'Y'
799700220720      * set up error - invalid max, min or increment value
799800220720     c                   if        cnmax <= 0 or cnmax < cnmin or cninc <= 0
7999001012201032 C                   Z-ADD     89            X                    50
800000101220     c                   leavesr
800100101220     c                   end
800200101220
800300101220      * see if benefit amount entered is in the range of valid values
800400101220     c                   z-add     cnmin         wkvalid
800500101220     c                   z-add     cnmax         wkmax
800600101220     c     wkvalid       dougt     wkmax
800700101220     c                   if        wkvalid  = sbenam
800800101220     c                   eval      validben = 'Y'
800900101220     c                   leavesr
801000101220     c                   else
801100101220     c                   add       cninc         wkvalid
801200101220     c                   end
801300101220     c                   enddo
801400101220
801500101220      * set error for variable benefit plan but invlaid amount entered
8016001012201032 C                   Z-ADD     90            X                    50
801700101220
801800101220      * this is not a variable benefit amount plan, the benefit entered
801900101220      * must be zero
802000101220     c                   else
802100101220     c                   if        sbenam <> 0
8022001012201032 C                   Z-ADD     88            X                    50
802300101220     c                   end
802400101220
802500101220     c                   end
802600101220
802700101220DTAQ c                   endsr
802800121127
802900121127DTAQ  ******************************************************
803000121127      * check for an active commission control
803100121127DTAQ  ******************************************************
803200121127DTAQ c     #chkcomctx    begsr
803300121127
803400121127     c     cmct14key     klist
803500121127     c                   kfld                    trust
803600121127     c                   kfld                    subno
803700121127     c                   kfld                    accno
803800121127     c                   kfld                    splan#
803900121127
804000121127      * screen input enroll date to YMD
804100121127y2k  C                   MOVE      SENRLD        MDCY#
804200121127y2k  C                   EXSR      #CYMD8
804300121127y2k  C                   MOVEL     CYMD#         senrldymd
804400121127
804500121127     c                   clear                   validcom
804600121127     c     cmct14key     setll     cmct14
804700121127     c                   dou       %eof(cmct14)
804800121127     c     cmct14key     reade     cmct14
804900121127     c                   if        not %eof(cmct14) and senrldymd >= cm_effdat
805000121127     c                             and (cm_cmcan = 0 or
805100121129     c                             (cm_cmcan <> 0 and senrldymd <= cm_cmcan))
805200121129     c                             and (cm_effdat <> cm_cmcan)
805300121127     c                   eval      validcom = 'Y'
805400121127     c                   leave
805500121127     c                   end
805600121127     c                   enddo
805700121127
805800121127      * there is no active comm rec
805900121127     c                   if        validcom <> 'Y'
8060001211271032 C                   Z-ADD     103           X                    50
806100121127      * if renewal age band change error msg was indicated, turn it off
806200121127      * because it would obsure this error msg with the date overlay
806300121127     c   42              setoff                                       42
806400121127     c                   leavesr
806500121127     c                   end
806600121127
806700121127
806800121127DTAQ c                   endsr
806900110506DTAQ  ******************************************************
807000110506      * Check Payroll Account
807100110506DTAQ  ******************************************************
807200110506DTAQ C     CREATE_PAYDED BEGSR
807300110506
807400120320      * This function is turned off for now until we can revisit
807500120320      * this in the future. (4 hour meeting on 03/19/2012)
807600120320     C                   LeaveSR
807700120320
807800120320     c     AccKeyI       klist
807900120320     c                   kfld                    TRUST
808000120320     c                   kfld                    SUBNO
808100120320     c                   kfld                    ACCNO
808200120320     C                   Eval      PayChoice = 'N'
808300120320     C     AccKeyI       Chain     ACCMSP
808400120320     C                   If        %found(ACCMSP)
808500120320     C                   If        %trim(AMPAYR) <> *Blanks  and
808600120320     C                             %trim(AMPAYR) <> 'PAYR'
808700120320     C                   Eval      PayChoice = 'Y'
808800120320     C                   End
808900120320     C                   End
809000120320
809100120320      * If Payroll, then create deduction record
809200120320     C                   If        PayChoice = 'Y'
809300120320     C                   Move      TRUST         myTRS             3
809400120320     C                   Move      SUBNO         mySUB             3
809500120320     C                   Move      *blanks       MYKEY            10
809600120320     C                   Eval      MYKEY = myTRS + mySUB + PayPLN
8097001203200852 C     MYKEY         Chain     PLNMST
809800120320     C                   Clear                   WEBDED
809900120320     C                   Eval      PQTRS = TRUST
810000120320     C                   Eval      PQSUB = SUBNO
810100120320     C                   Eval      PQACT = ACCNO
810200120320     C                   Eval      PQSSN = PaySSN
810300120320     C                   Eval      PQSEQ = 0
810400120320     C                   Eval      PQCAT = 'P' + PLNCAT
810500120320     C                   Eval      PQPLN = PayPLN
810600120320     C                   Eval      PQPCMT = 'C'
810700120320     C     PayEFF        Mult      10000.0001    PQSTART
810800120320     C                   Call      'REINDEDCL'
810900120320     C                   Parm                    WEBDED
811000120320     C                   Clear                   WEBDED
811100120320     C                   End
811200120320
811300110506
811400110506DTAQ C                   ENDSR
811500101220
811600110726DTAQ  ******************************************************
811700110726      * check for 60 day error (grate)
811800110726DTAQ  ******************************************************
811900110726DTAQ c     #chk60derr    begsr
812000110726
812100110726      * warning message if no rates for this effdt and it is more than
812200110726      * 60 days in the future. Press F11 to skip this edit.
812300110726     c                   if        *inkk = *off
812400110726     c                   if        gr60dayerr = 'Y'
8125001107261288 C                   Z-ADD     92            X                    50
812600110726     c                   end
812700110726     c                   end
812800110726
812900110726DTAQ C                   ENDSR
813000110913    ? *___________________________________________________________________
813100110913    ? * Check Payroll Account
813200110913    ? *___________________________________________________________________
813300110913    ?C     CHECKPAYROLL  Begsr
813400110913
813500110913     c     PayKey        klist
813600110913     c                   kfld                    TRUST
813700110913     c                   kfld                    SUBNO
813800110913     c                   kfld                    ACCNO
813900110913
814000110913     C                   Eval      PayChoice = 'N'
814100110913     C     PayKey        Chain     ACCMSP
814200110913     C                   If        %found(ACCMSP)
814300110913     C                   If        %trim(AMPAYR) <> *Blanks  and
814400110913     C                             %trim(AMPAYR) <> 'PAYR'
814500110913     C                   Eval      PayChoice = 'Y'
814600110913     C                   End
814700110913     C                   End
814800110913    ?C                   Endsr
814900111025
815000111025DTAQ  ******************************************************
815100111025      * test field for special characters not allowed
815200111025DTAQ  ******************************************************
815300111025DTAQ c     #testchar     begsr
815400111025
815500111025     c                   clear                   badcharfnd
815600111206     c                   clear                   badcharswk
815700111025     c                   do        30            xx                2 0
815800111025     c                   eval      testchar = %subst(chartstfld:xx:1)
815900111025
816000111025      * different characters are valid for name / addr
816100111025     c                   if        whattstfld = 'NAME'
816200111025     c                   Eval      Posfnd = %scan(testchar:validchar_name)
816300111025     c                   else
816400111025     c                   Eval      Posfnd = %scan(testchar:validchar_addr)
816500111025     c                   end
816600111025
816700111206      * if the character tested was not one of the valid ones then it is
816800111206      * an error. record what character is invalid for display later
816900111025     c                   If        Posfnd = 0
817000111025     c                   move      'Y'           badcharfnd
817100111206     c                   cat       testchar:0    badcharswk
817200111206     c**                 leave
817300111025     c                   end
817400111025     c                   enddo
817500111025
817600111025DTAQ C                   ENDSR
817700130516
817800130927DTAQ  ******************************************************
817900130927      * Get current system time and date to be used in history record
818000130927DTAQ  ******************************************************
818100130927DTAQ c     #getsystime   begsr
818200130927
818300130927     C                   eval      sysdateymd = %date
818400130927     C                   MOVE      sysdateymd    udcymd
818500130927     c                   eval      systime = %time
818600130927
818700130927DTAQ C                   ENDSR
818800220412
818900220412      //===================================================
819000220412      // write reinstate date record
819100220412      //===================================================
819200220412
819300220412       begsr writeReinstate;
819400220412
819500220413        chain (trust : subno : accno : ssno : mh1 : adddt) reinstFile;
819600220412        rtrst = trust;
819700220413        rsub# = subno;
819800220413        racct = accno;
819900220413        rssn = ssno;
820000220413        rplan = qckmh1;
820100220413        rdate = trandt;
820200220413        if %found;
820300220413         update reinstFile;
820400220413        else;
820500220413         write reinstFile;
820600220413        endif;
820700220412
820800220412       endsr;
820900130927
821000221013    ? *___________________________________________________________________
821100221013    ? * format Date edit
821200221013    ? *___________________________________________________________________
821300221013    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
821400221013     C                   movel     'MMDDYYYY'    Input_Format
821500221013     C                   Call      'FMTDATE'
821600221013     C                   Parm                    Input_Date       32
821700221013     C                   Parm                    Input_Format     32
821800221013     C                   Parm      'MM/DD/YYYY'  Output_Format    32
821900221013     C                   Parm                    Output_Date      32
822000221013     C                   Parm                    Output_Error     10
822100221013    ?C                   Endsr                                                  END DLT RQST
822200130516DTAQ  ******************************************************
822300130516      * first cycle
822400130516DTAQ  ******************************************************
822500130516DTAQ c     *inzsr        begsr
822600130516
822700130516     C     DEPKEY        KLIST
822800130516     C                   KFLD                    SSNO
822900130516     C                   KFLD                    DSEQ#
823000130516
823100130516     C     debkey        KLIST
823200130516     C                   KFLD                    SSNO
823300130516     C                   KFLD                    key00
823400130516
823500130516     C     d2key         KLIST
823600130516     C                   KFLD                    d2keyssn          9 0
823700130516     C                   KFLD                    d2keyseq          2 0
823800130516
823900130516     C     acckey        KLIST
824000130516     C                   KFLD                    TRUST
824100130516     C                   KFLD                    SUBNO
824200130516     C                   KFLD                    ACCNO
824300130516
824400141110     C***  mcplankey     KLIST
824500141110     C***                KFLD                    trust#
824600141110     C***                KFLD                    sub#
824700141110     C***                KFLD                    plan#
824800140123
824900141110     C***  plplankey     KLIST
825000141110     C***                KFLD                    PLTRUST
825100141110     C***                KFLD                    PLSUB#
825200141110     C***                KFLD                    PPLAN
825300140215
825400130516     C     tspkey        KLIST
825500130620     C                   KFLD                    keytrust          3 0
825600130620     C                   KFLD                    keysub            3 0
825700130620     C                   KFLD                    keyplan           4
825800130516
825900130516     C                   MOVE      SA            SA
826000130516     C                   MOVE      SN            SN
826100130516     C                   Z-ADD     *ZEROS        ZERO9
826200130516     C                   Z-ADD     *ZEROS        HDSEQ#            2 0
826300130516y2k  C                   MOVEL     LDADTE        UDCYMD            8 0
826400130516y2k  C                   MOVEL     UDCYMD        HUDATE            8 0
826500130516y2k  C                   MOVEL     UDCYMD        ASDT              8 0
826600130516y2k  C                   MOVEL     UDCYMD        MDDATE            8 0
8267001305160701 C                   Z-ADD     01            MM01              2 0
8268001305160702 C                   Z-ADD     01            MDDD              2 0
8269001305160706
827000191108
827100130516DTAQ C                   ENDSR
827200220111
827300220111      *-------------------------------------------------------------------------
827400220111      *
827500220111      * Setup the Library List
827600220111      *
827700220111      *-------------------------------------------------------------------------
827800220111RFG1 C     SetLIBL       Begsr
827900220111
828000220111         //----------------------------------------------------
828100220111         //
828200220111         //   Retrieve Current Library List
828300220111         //
828400220111         //----------------------------------------------------
828500220111
828600220111         RtvJobInf( Rcvvar : RcvVarLen : 'JOBI0700' : '*' : '' ) ;
828700220111         libsToSkip = NbrSysLibs +
828800220111         NbrPrdLibs +
828900220111         NbrCurLibs;
829000220111
829100220111         Pos = ( LibsToSkip * 11 ) + 81;
829200220111
829300220111         UsrLibs = %Subst( RcvVar: Pos : NbrUsrLibs * 11 ) ;
829400220111
829500220111
829600220111
829700220111         //----------------------------------------------------
829800220111         //
829900220111         //   Check for RPGSPDASH in the current Library list
830000220111         //
830100220111         //----------------------------------------------------
830200220111         Dash = %Lookup( 'RPGSPDASH' : theLibs ) ;
830300220111         Beta = %Lookup( 'RPGSPBETA' : theLibs ) ;
830400220111
830500220111
830600220111
830700220111         //----------------------------------------------------
830800220111         //
830900220111         //   Check for RPGSPPAYR in the current Library list
831000220111         //
831100220111         //----------------------------------------------------
831200220111         Payr = %Lookup( 'RPGSPPAYR' : theLibs ) ;
831300220111         Pgmr = %Lookup( 'RPGSPPGMR' : theLibs ) ;
831400220111
831500220111
831600220111         //----------------------------------------------------
831700220111         //
831800220111         //   Check the web environment
831900220111         //
832000220111         //----------------------------------------------------
832100240125j002       dclflg = 'N';
832200220111br01
832300220111       // Check to see if this account has OLE
832400220111       Setll ( Trust : SubNo : AccNo ) AccOspL2;
832500220111
832600220111       Dou %Eof(AccOspL2);
832700220111         reade ( Trust : SubNo : AccNo ) AccOspL2;
832800220111         if %eof(AccOspL2);
832900220111           leave;
833000220111         endif;
833100220111
833200220111         if aobedt <= %Dec(%Date) and
833300220111           (aoendt >= %Dec(%Date) or aoendt = 0 ) ;
833400240125
833500240125j002       if (aoCode = 8 or aoCode = 9);
833600240125j002       dclflg = 'Y';
833700240125j002       endif;
833800220111
833900220111             if wqFill = 'QS36F';
834000220111
834100220111           // Payroll System
834200220111           //   --  Replace Dashboard with Payroll
834300220111           if (aoCode = 6 or aoCode = 7) and Dash > 0;
834400220111             CmdString = 'RmvLible RPGSPDASH' ;
834500220111             #Command(CmdString : %len(%Trim(CmdString))) ;
834600220111
834700220111             CmdString = 'AddLible LIB(RPGSPPAYR) POSITION(*AFTER ' + 'QS36F)' ;
834800220111             #Command(CmdString : %len(%Trim(CmdString))) ;
834900220111
835000220111           EndIf;
835100220111
835200220111
835300220111           // Dashboard System
835400220111           //   --  Replace Payroll  with Dashboard
835500220111           if (aoCode = 8 or aoCode = 9) and Payr > 0;
835600220111             CmdString = 'RmvLible RPGSPPAYR' ;
835700220111             #Command(CmdString : %len(%Trim(CmdString))) ;
835800220111
835900220111             CmdString = 'AddLible LIB(RPGSPDASH) POSITION(*AFTER ' + 'QS36F)' ;
836000220111             #Command(CmdString : %len(%Trim(CmdString))) ;
836100220111           EndIf;
836200220111
836300220111             else;
836400220111
836500220111           // In TEST only use BETA
836600220111
836700220111           //   --  Replace Dashboard with Payroll
836800220111           if Dash > 0;
836900220111             CmdString = 'RmvLible RPGSPDASH' ;
837000220111             #Command(CmdString : %len(%Trim(CmdString))) ;
837100220111           EndIf;
837200220111
837300220111           if Payr > 0;
837400220111             CmdString = 'RmvLible RPGSPPAYR' ;
837500220111             #Command(CmdString : %len(%Trim(CmdString))) ;
837600220111           EndIf;
837700220111
837800220111           if Pgmr > 0;
837900220111             CmdString = 'RmvLible RPGSPPGMR' ;
838000220111             #Command(CmdString : %len(%Trim(CmdString))) ;
838100220111           EndIf;
838200220111
838300220111           if Beta = 0;
838400220111             CmdString = 'AddLible LIB(RPGSPBETA) POSITION(*AFTER ' +
838500220111                         'GBSPGM)';
838600220111             #Command(CmdString : %len(%Trim(CmdString))) ;
838700220111           EndIf;
838800220111
838900220111             EndIf;
839000220111         EndIf;
839100220111       enddo;
839200220111
839300220111     C                   Endsr
839400130516
8395009812214325  ******************************************************
8396009102154326 O*  OUTPUT SPECIFICATIONS                             *
8397009102154327 O******************************************************
8398009102154328 OTRNMIT    EADD         MADD1
8399000810294329 O                       ACTCOD               2
8400009102154330 O                       DS02AH             258
8401000602204331 O                       DS02BH             281
8402009102154332 O                       DS02A              531
8403000602204333 O                       DS02B              551
8404009102154334 O                       PLAN#             1068
8405009102154335 O                       AGEBND            1070
8406000810294336 O                       COVTYP            1073
8407009102154339 O                       CACTFL            1086
8408009102154340 O                       BENAMT            1093
8409009102154341 O                       HGROUP            1108
8410009102154342 O                       SSNO              1133
8411009102154343 O                       PCARR             1142
8412009102154344 O                       HTCODE         B  1150
8413009102154345 O                                         1159 'FM070'
8414009102154346 O                                         1168 'A'
841500981201      *
841600981201y2k  O                       MDDATE            1336
841700981201y2k  O                       CANDT             1344
841800040528y2k  O                       oenrdtymd         1368
841900981201      * Dates formerly contained in DS02AH (3-258)
842000981201     O                       F10               1176
842100981201     O                       F16               1184
842200981201     O                       F19               1192
842300981201     O                       F22               1200
842400981201     O                       F23               1208
842500981201     O                       F25               1216
842600981201      * Dates formerly contained in DS02A (276-531)
842700981201y2k  O                       BIRTH             1224
842800981201y2k  O                       EMPDT             1232
842900981201y2k  O                       MARDT             1240
843000981201y2k  O                       MEDADT            1248
843100981201y2k  O                       MEDBDT            1256
843200981201y2k  O                       HDCPDT            1264
843300081114      * New fields placed here to bypass DS overlay above
8434000811144330 O                       QQTIME             126
8435000811144330 O                       QQDATE             463
8436000811144330 O                       QQUSER             718
8437000811144330 O                       QQFLAG             719
8438000811144330 O                       QQPGNM             976
8439000811144330 O                       QQFIXF             977
8440000811144336 O                       QQPCPE            1081
8441000811144336 O                       QQPCPC            1120
844200981201      *
8443009102154361 OTRNMIT    EADD         MCADD1
8444009102154362 O                       ACTCOD               2
8445009102154363 O                       DS02AH             258
8446000602204364 O                       DS02BH             281
8447009102154365 O                       DS02A              531
8448000602204366 O                       DS02B              551
8449009102154367 O                       CPLAN             1068
8450009102154368 O                       CAGEBD            1070
8451009102154369 O                       CCOVTP            1073
8452000810294336 O                       QQPCPE            1081
8453009102154372 O                       CACTFL            1086
8454009102154373 O                       CBENAM            1093
8455009102154374 O                       HGROUP            1108
8456009102154375 O                       CSSNO             1133
8457009102154377 O                       PCARR             1142
845800030611     O                       HTCODE         B  1150
8459009102154378 O                                         1159 'FM070'
8460009102154379 O                                         1168 'A'
846100981201      *
846200981201y2k  O                       CEFFDT            1336
846300981201y2k  O                       CCANDT            1344
846400040528y2k  O                       oenrdtymd         1368
846500981201y2k  O                       OLDEDT         B  1376
846600981201      * Dates formerly contained in DS02AH
846700981201     O                       F10               1176
846800981201     O                       F16               1184
846900981201     O                       F19               1192
847000981201     O                       F22               1200
847100981201     O                       F23               1208
847200981201     O                       F25               1216
847300981201      * Dates formerly contained in DS02A (276-531)
847400981201y2k  O                       BIRTH             1224
847500981201y2k  O                       EMPDT             1232
847600981201y2k  O                       MARDT             1240
847700981201y2k  O                       MEDADT            1248
847800981201y2k  O                       MEDBDT            1256
847900981201y2k  O                       HDCPDT            1264
848000081114      * New fields placed here to bypass DS overlay above
8481000811144330 O                       QQTIME             126
8482000811144330 O                       QQDATE             463
8483000811144330 O                       QQUSER             718
8484000811144330 O                       QQFLAG             719
8485000811144330 O                       QQPGNM             976
8486000811144330 O                       QQFIXF             977
8487000811144336 O                       QQPCPE            1081
8488000811144336 O                       QQPCPC            1120
848900981201      *
8490009102154380 OTRNMIT    EADD         DCADD1
8491009102154381 O                       ACTCOD               2
8492009102154382 O                       DS02AH             258
8493000602204383 O                       DS02BH             281
8494009102154384 O                       DS02A              531
8495000602204385 O                       DS02B              553
8496009102154386 O                       DSH04A             804
8497009102154387 O                       DSH04B             806
8498009102154388 O                       HDS04A            1062
8499009102154389 O                       HDS04B            1064
8500009102154390 O                       P#(L#)            1068
8501009102154391 O                       #AG(L#)           1070
8502009102154392 O                       #CT(L#)           1073
8503009602264395 O                       #AC(L#)           1086
8504009102154396 O                       #BA(L#)           1093
8505009602264397 O                       HGROUP            1108
8506009102154398 O                       P#(L#)            1112
8507009102154401 O                       SSNO              1133
8508009112054402 O                       #CR(L#)           1142
8509009102154404 O                                         1159 'FM070'
8510009709104403 O                       DSEQ#             1161
8511009102154405 O                                         1168 'A'
851200981201      *
851300990114y2k  O**                       #ED,L#  1336                               enrldt
851400990114y2k  O**                       #CD,L#  1344                               cancdt
851500990114y2k  O                       #EDL#             1336
851600990114y2k  O                       #CDL#             1344
851700981201y2k  O                       DENRDT            1352
851800981209y2k  O                       HDCAND         B  1360
851900140220y2k  O                       ODENDT         B  1376
852000981201      * Dates formerly contained in DS02AH
852100981201     O                       F10               1176
852200981201     O                       F16               1184
852300981201     O                       F19               1192
852400981201     O                       F22               1200
852500981201     O                       F23               1208
852600981201     O                       F25               1216
852700981201      * Dates formerly contained in DS02A (276-531)
852800981201y2k  O                       BIRTH             1224
852900981201y2k  O                       EMPDT             1232
853000981201y2k  O                       MARDT             1240
853100981201y2k  O                       MEDADT            1248
853200981201y2k  O                       MEDBDT            1256
853300981201y2k  O                       HDCPDT            1264
853400990104      * Dates formerly contained in DSH04A & HDS04A
853500990104Y2K  O                       DSH04D            1296
853600990104Y2K  O                       HDS04D            1328
853700081114      * New fields placed here to bypass DS overlay above
8538000811144330 O                       QQTIME             126
8539000909294330 O                       trcode834          194
8540000811144330 O                       QQDATE             463
8541000811144330 O                       QQUSER             718
8542000811144330 O                       QQFLAG             719
8543000811144330 O                       QQPGNM             976
8544000811144330 O                       QQFIXF             977
8545001203084388 O                       holddccandt       1060
8546000811144336 O                       QQPCPE            1081
8547000811144336 O                       QQPCPC            1120
854800981201      *
8549009102154406 OTRNMIT    EADD         DCADD2
8550009102154407 O                       ACTCOD               2
855100981230 408 O                       DS02AH             258
8552000602204409 O                       DS02BH             281
8553009102154410 O                       DS02A              531
8554000602204411 O                       DS02B              553
8555009102154412 O                       DS04AH             804
8556009102154413 O                       DS04BH             806
8557009102154414 O                       DS04A             1062
8558009102154415 O                       DS04B             1064
8559009102154416 O                       PLAN#             1068
8560009102154417 O                       AGEBND            1070
8561009102154418 O                       COVTYP            1073
8562009102154421 O                       CACTFL            1086
8563009102154422 O                       BENAMT            1093
8564009102154423 O                       HGROUP            1108
8565009102154424 O                       DPLAN#            1112
8566009102154427 O                       SSNO              1133
8567009102154428 O                       PCARR             1142
8568009102154430 O                       HTCODE            1150
8569009102154431 O                                         1159 'FM070'
8570009709104403 O                       DSEQ#C            1161
8571009102154432 O                                         1168 'A'
857200981201      *
857300990115y2k  O                       ENRLDT            1336
857400981201y2k  O                       CANDT             1344
857500020315y2k  O**                     DENRDT            1352
857600020315y2k  O                       dedate            1352
857700981209y2k  O                       HDCAND            1360
857800140220y2k  O                       ODENDT         B  1376
857900981201      * Dates formerly contained in DS02AH (3-258)
858000981201     O                       F10               1176
858100981201     O                       F16               1184
858200981201     O                       F19               1192
858300981201     O                       F22               1200
858400981201     O                       F23               1208
858500981201     O                       F25               1216
858600981201      * Dates formerly contained in DS02A (276-531)
858700990115y2k  O                       BIRTH             1224
858800981201y2k  O                       EMPDT             1232
858900981201y2k  O                       MARDT             1240
859000981201y2k  O                       MEDADT            1248
859100981201y2k  O                       MEDBDT            1256
859200981201y2k  O                       HDCPDT            1264
859300990104      * Dates formerly contained in DS04AH
859400990105Y2K  O                       DS04DH            1296
859500990105Y2K  O                       DS04D             1328
859600081114      * New fields placed here to bypass DS overlay above
8597000811144330 O                       QQTIME             126
8598000909304330 O                       trcode834          194
8599000811144330 O                       QQDATE             463
8600000811144330 O                       QQUSER             718
8601000811144330 O                       QQFLAG             719
8602000811144330 O                       QQPGNM             976
8603000811144330 O                       QQFIXF             977
8604000811144336 O                       QQPCPE            1081
8605000811144336 O                       QQPCPC            1120
8606009102154433 O*
8607009102154434 O*  HISTORY RECORD FOR ADD MEMBER RECORD
8608001309274435 OHIST      eADD         histmemadd
8609009102154436 O                       SSNO                10
8610009102154440 O                                           19 'MMA'
8611009102154441 O                       ZERO9               24P
861200001002     O                                           90 '00'
861300130927     O                       thispgmname        107
861400130927     O                                          108 ' '
8615009102154444 O                       TRUST              112
8616009102154445 O                       SUBNO              115
8617009102154446 O                       ACCNO              119
861800130927     o                       zero8              127
8619009102154448 O                                          128 'A'
862000981130      * dates
862100981201y2k  O                       UDCYMD             136
862200001002     O                       ZERO8              144
862300001002y2k  O                       ZERO8              152
862400981130y2k  O                       ADDDT              160
862500130927     o                       zero9              184
862600130927     o                       zero7              191
862700130927     o                       systime            199
862800130927     o                       zero7              206
862900130927     O                       luser              216
863000130516
8631001305174434 O*  HISTORY RECORD FOR DEPENDENT ADD/TERM/REIN
8632001305174435 O          eADD         histdep
8633001305164436 O                       SSNO                10
8634001305174440 O                       trcode              19
8635001305164441 O                       ZERO9               24P
8636001401214458 O                       ck#not              55
8637001401214458 O                       NOTE2               85
863800130516     O                       dseq#               90
863900130927     O                       thispgmname        107
864000130927     O                                          108 ' '
8641001305164444 O                       TRUST              112
8642001305164445 O                       SUBNO              115
8643001305164446 O                       ACCNO              119
864400130927     o                       zero8              127
8645001305164448 O                                          128 'A'
864600130516y2k  O                       UDCYMD             136
864700130516     O                       ZERO8              144
864800130516y2k  O                       ZERO8              152
864900130517y2k  O                       his_covtdt     b   160
865000130927     o                       zero9              184
865100130927     o                       zero7              191
865200130927     o                       systime            199
865300130927     o                       zero7              206
865400130927     O                       luser              216
865500130516
8656009102154449 O*  HISTORY RECORD DEMOGRAPHICS CHANGE
8657001401214450 O          EADD         hisdemo
8658009102154451 O                       SSNO                10
8659009102154455 O                       TRCODE         B    19
8660009102154456 O                       ZERO9               24P
8661009102154457 O                       CK#NOT         B    55
8662009102154458 O                       NOTE2          B    85
8663009102154459 O                       HDSEQ#         B    90
866400130927     O                       thispgmname        107
866500130927     O                                          108 ' '
8666009102154462 O                       TRUST              112
8667009102154463 O                       SUBNO              115
8668009102154464 O                       ACCNO              119
866900130927     o                       zero8              127
8670009102154466 O                                          128 'A'
867100981130      * dates
867200981201y2k  O                       UDCYMD             136
867300001002     O                       ZERO8              144
867400001002y2k  O                       ZERO8              152
867500981130y2k  O                       TRANDT         B   160
867600130927     o                       zero9              184
867700130927     o                       zero7              191
867800130927     o                       systime            199
867900130927     o                       zero7              206
868000130927     O                       luser              216
868100130927
8682009102154467 O*  HISTORY RECORD FOR COVERAGE TERM,REINSTATE,CHANGE
8683001401214468 O          EADD         histcov
8684009102154469 O                       SSNO                10
8685009102154473 O                       TRCODE         B    19
8686009102154474 O                       ZERO9               24P
868700981125      *                        CK#NOT B  55
8688009102154477 O                       MH1            B    29
8689009102154478 O              N47                          39 'AgeBand-'
8690009102154479 O              N47      MH2            B    41
8691009102154480 O              N47                          51 'CovType-'
8692009102154481 O              N47      MH3            B    53
869300981125      *                        NOTE2  B  85
8694000306244488 O                       TC             B    60
8695009102154482 O               46                          62 'BenAmt-'
8696009102154483 O               46      MH4            B    69
8697009901294484 O               26                          61 'From-'
8698009102154485 O               26      MH4            B    69
8699001401214486 O               25                          53 'D#-'
8700001401214487 O               25      MH5                 55
8701009102154488 O                       MH6            B    85
8702000009134489 O               25      MH5            B    90
870300001002     O              N25                          90 '00'
870400130927     O                       thispgmname        107
870500130927     O                                          108 ' '
8706009102154493 O                       TRUST              112
8707009102154494 O                       SUBNO              115
8708009102154495 O                       ACCNO              119
870900130927     o                       zero8              127
8710009102154497 O                                          128 'A'
871100981130      * dates
871200981201y2k  O                       UDCYMD             136
871300001002     O                       ZERO8              144
871400001002y2k  O                       ZERO8              152
871500981130y2k  O                       TRANDT             160
871600130927     o                       zero9              184
871700130927     o                       zero7              191
871800130927     o                       systime            199
871900130927     o                       zero7              206
872000130927     O                       luser              216
8721009102154498 O*  MEMBER FILE
8722009102154499 OMEMBER    D    KA 30
8723001312124500 O*  RELEASE RECORD ON CMD1
8724001401214501 O          E            canmem
8725009104304502 O*  UPDATE STATUS ON CANCEL
8726009102154504 O                       HTRCOD         B   331
8727009102154505 O                       USTAT              512
872800981201y2k  O                       HTRAND         B   584
8729000410054502
8730000410144502  *  93 = retain cobra notify info and change status to "C"
8731000410144502  * N93 = normal reinstate - blank out cobra info and make status "A"
8732001401214501 O          E            reinmem
873300041005     O               93                         148 'C'
873400041014     O              N93                         148 'A'
8735000410054502
873600001017     O                       ZERO8              233
8737009104304504 O                       HTRCOD         B   331
873800910501     O                                          334 '   '
873900041005      * notify code
874000041005     O              N93                         337 '   '
874100910430     O                                          344 ' '
874200910430     O                                          419 ' '
8743009104304505 O                       USTAT              512
874400981201y2k  O                       HTRAND         B   584
874500041014y2k  O                       ZERO8              576
874600041014y2k  O                       ZERO8              592
874700041005      * notify date
874800041005y2k  O              N93      ZERO8              600
874900100929y2k  O              N93      ZERO8              616
875000981201y2k  O                       ZERO8              632
8751001309274506 O          eADD         memberadd
8752009102154507 O                       SSNO                 9
8753009102154508 O                       LNAME               27
8754009102154509 O                       FNAME               39
8755009102154510 O                       MI                  40
8756009102154511 O                       ADDR1               70
8757009102154512 O                       ADDR2              100
8758009102154513 O                       CITY               115
8759009102154514 O                       STATE              117
8760009102154515 O                       ZIP                122P
8761009102154516 O                       AREA               124P
8762009102154517 O                       PHONE              128P
8763009102154518 O                       SEX                129
8764009102154520 O                       TRUST              138
8765009102154521 O                       SUBNO              141
8766009102154522 O                       ACCNO              145
8767009102154524 O                       EMPST              148
876800220505     O                                          156 '00'                        NODPND field
876900060220     O                       NONEMP             158
8770000602204526 O                       HNDICP             159
8771000602204528 O                       COBX               166
8772000602204529 O                       COBENM             186
8773000602204530 O                       COBPNM             201
8774000602204531 O                       COBP#              211
8775000602204532 O                       MEDICR             212
8776000602204533 O                       MED#               225
877700060220     O                       ZERO8              233
8778000602204541 O                       ZERO7              256P
8779000602204542 O                       ZERO7              260P
8780000602204543 O                       SALARY             265P
8781000602204544 O                       COBBCF             266
8782000602204545 O                       COBCTY             276
8783000602204546 O                       COBST              278
878400060220     O                       INLIF              279
878500060220     O                       INADD              280
8786000602204554 O                       TERMCD             331
8787000602204555 O                       QECD               334
8788000602204556 O                       NTFYCD             337
8789000602204557 O                       CANCD              340
8790000602204558 O                                          344 ' '
8791000602204563 O                       ZERO7              372P
8792000602204564 O                       ZERO7              376P
8793000602204565 O                       ZERO7              380P
8794000602204566 O                       ZERO7              384P
879500060220     O                       ZERO7              418P
879600060220     O                                          420 '0'
879700060220     O                       ZERO7              424P
879800060220     O                       ZERO7              428P
879900101215     O                       memail             493
880000101215     O                       mnonssn            494
880100101215     O                       CCFLG              497
8802000602204567 O                       AUTCAN             498
8803001309274569 O                       luser8             510
8804000602204570 O                       TSCODE             511
8805000602204571 O                                          512 'A'
880600981201      * dates
880700060220y2k  O                       BIRTH              520
880800060220y2k  O                       MARDT              528
880900060220y2k  O                       HDCPDT             536
881000060220y2k  O                       MEDADT             544
881100060220y2k  O                       MEDBDT             552
881200060220y2k  O                       EMPDT              560
881300060220y2k  O                       MENRDT             568
881400060220y2k  O                       ZERO8              576
881500060220y2k  O                       TERMDT             584
881600060220y2k  O                       QEDT               592
881700060220y2k  O                       NTFYDT             600
881800060220y2k  O                       ZERO8              608
881900060220y2k  O                       EEXPDT             616
882000060220y2k  O                       PEXPDT             624
882100060220y2k  O                       ZERO8              632
882200060220y2k  O                       PARPDT             640
882300060220y2k  O                       UDCYMD             648
882400130927
8825001309274572 O          e            memberup
8826009102154573 O                       LNAME               27
8827009102154574 O                       FNAME               39
8828009102154575 O                       MI                  40
8829009102154576 O                       ADDR1               70
8830009102154577 O                       ADDR2              100
8831009102154578 O                       CITY               115
8832009102154579 O                       STATE              117
8833009102154580 O                       ZIP                122P
8834009102154581 O                       AREA               124P
8835009102154582 O                       PHONE              128P
8836009102154583 O                       SEX                129
8837009102154585 O                       TRUST              138
8838009102154586 O                       SUBNO              141
8839009102154587 O                       ACCNO              145
8840009102154588 O                       EMPST              148
884100060220     O                       NONEMP             158
8842000602204590 O                       HNDICP             159
8843000602204592 O                       COBX               166
8844000602204593 O                       COBENM             186
8845000602204594 O                       COBPNM             201
8846000602204595 O                       COBP#              211
8847000602204596 O                       MEDICR             212
8848000602204597 O                       MED#               225
8849000602204605 O                       SALARY             265P
8850000602204606 O                       COBBCF             266
8851000602204607 O                       COBCTY             276
8852000602204608 O                       COBST              278
885300060220     O                       INLIF              279
885400060220     O                       INADD              280
8855000602204616 O                       TERMCD             331
8856000602204617 O                       QECD               334
8857000602204618 O                       NTFYCD             337
8858000602204619 O                       CANCD              340
885900101215     O                       memail             493
886000101215     O                       mnonssn            494
886100060220     O                       CCFLG              497
8862000602204625 O                       AUTCAN             498
8863001309274627 O                       luser8             510
8864000602204628 O                       TSCODE             511
886500981201      * dates
886600060220y2k  O                       BIRTH              520
886700060220y2k  O                       MARDT              528
886800060220y2k  O                       HDCPDT             536
886900060220y2k  O                       MEDADT             544
887000060220y2k  O                       MEDBDT             552
887100060220y2k  O                       EMPDT              560
887200060220y2k  O                       MENRDT             568
887300060220y2k  O                       TERMDT             584
887400060220y2k  O                       QEDT               592
887500060220y2k  O                       NTFYDT             600
887600060220y2k  O                       ZERO8              608
887700060220y2k  O                       EEXPDT             616
887800060220y2k  O                       PEXPDT             624
887900060220y2k  O                       PARPDT             640
888000060220y2k  O                       UDCYMD             648
8881001401214629 ODEPEND    E            upddep
8882009102154630 O                       DLNAME              29
8883009102154631 O                       DFNAME              41
8884009102154632 O                       DMI                 42
8885009102154633 O                       DADDR1         B    72
8886009102154634 O                       DADDR2         B   102
8887009102154635 O                       DCITY          B   117
8888009102154636 O                       DSTATE         B   119
8889009102154637 O                       DZIP           B   124P
8890009102154638 O                       DAREA          B   126P
8891009102154639 O                       DPHONE         B   130P
8892009102154640 O                       DSEX           B   131
8893009102154642 O                       DRELCD         B   140
8894009102154643 O                       DEPSS#         B   145P
8895009102154644 O                       DSTUDN         B   146
8896009102154645 O                       DHNDCP         B   147
8897009102154647 O                       DCOB           B   154
8898009102154648 O                       DCOBEN         B   174
8899009102154649 O                       DCOBPN         B   189
8900009102154650 O                       DCOBP#         B   204
8901009102154651 O                       DMEDCR         B   205
8902009102154652 O                       DMED#          B   218
8903009102154660 O                       DCOBBC         B   257
8904009102154661 O                       DCOBCT         B   267
8905009102154662 O                       DCOBST         B   269
8906000210150600 O                       DSEFFD             278
8907000210150600 O                       DSSCHL             305
8908001309274664 O                       luser8             319
890900981130      * dates
891000981130y2k  O                       DBIRTH         B   328
891100981130y2k  O                       DHDDT          B   336
891200981130y2k  O                       DMEDAD         B   344
891300981130y2k  O                       DMEDBD         B   352
891400981221y2k  O                       UDCYMD             360
8915001401214665 O          EADD         adddep
8916009102154666 O                       SSNO                 9
8917009102154667 O                       DSEQ#               11
8918009102154668 O                       DLNAME              29
8919009102154669 O                       DFNAME              41
8920009102154670 O                       DMI                 42
8921009102154671 O                       DADDR1         B    72
8922009102154672 O                       DADDR2         B   102
8923009102154673 O                       DCITY          B   117
8924009102154674 O                       DSTATE         B   119
8925009102154675 O                       DZIP           B   124P
8926009102154676 O                       DAREA          B   126P
8927009102154677 O                       DPHONE         B   130P
8928009102154678 O                       DSEX           B   131
8929009102154680 O                       DRELCD         B   140
8930009102154681 O                       DEPSS#         B   145P
8931009102154682 O                       DSTUDN         B   146
8932009102154683 O                       DHNDCP         B   147
8933009102154685 O                       DCOB           B   154
8934009102154686 O                       DCOBEN         B   174
8935009102154687 O                       DCOBPN         B   189
8936009102154688 O                       DCOBP#         B   204
8937009102154689 O                       DMEDCR         B   205
8938009102154690 O                       DMED#          B   218
8939009902014698 O                       ZERO7              252P
8940009902014699 O                       ZERO7              256P
8941009102154700 O                       DCOBBC         B   257
8942009102154701 O                       DCOBCT         B   267
8943009102154702 O                       DCOBST         B   269
894400910410     O                                          270 '0'
8945000212170600 O                       DSEFFD             278
8946000212170600 O                       DSSCHL             305
8947001309274704 O                       luser8             319
8948009102154705 O                                          320 'A'
894900981130      * dates
895000981130y2k  O                       DBIRTH         B   328
895100981130y2k  O                       DHDDT          B   336
895200981130y2k  O                       DMEDAD         B   344
895300981130y2k  O                       DMEDBD         B   352
895400981221y2k  O                       UDCYMD             360
8955009102154706 O          E    39
8956009102154707 O                       DLTC3              320
895700910222     ODEPEND    E            RELDEP
895800910222     O*
8959001401264708 OMCOVC     E            #UPMCV
8960009109134709 O                       CTRSUB         B    17
8961009109134710 O                       CPLAN          B    21
8962009109134711 O                       CAGEBD         B    23
8963009109134712 O                       CCOVTP         B    26
896400981130y2k  O                       CEFFDT         B    72
896500981130y2k  O                       CCANDT         B    80
8966009109134715 O                       CACTFL         B    43
8967009109134716 O                       CBENAM         B    47P
8968009109134717 O                       DLTC1               64
896900110830
897000110830      * used for adding new mcov rec from coverage screen
8971001108304718 O          EADD         mcovcadd
8972009102154719 O                       SSNO                 9
8973009102154720 O                                           11 '00'
8974001401224721 O                       CTRSUB              17
8975001401224722 O                       CPLAN               21
8976001401224723 O                       CAGEBD              23
8977001401224724 O                       CCOVTP              26
8978001401224724 O                       mcuniq              38
8979009902014727 O                       ZERO7               42P
8980001401224728 O                       CACTFL              43
8981001401224729 O                       CBENAM              47P
8982009102154730 O                       ACCNO               54
8983001401224729 O                       horgben             59P
8984009102154731 O                       MSTAT               64
898500140122y2k  O                       CEFFDT              72
898600990201y2k  O                       ZERO8               80
898700990201     O                       ZERO8               88
898800110831
898900110831      * change coverage type and change enroll date - cancel old mcov
899000910913     O          E            CHGCAN
899100981208y2k  O                       TRANDT              80
899200910913     O                                           64 'C'
899300110831
899400110831      * change coverage type - add new mcov
8995009109124718 O          EADD         CHGADD
899600981130y2k  O                       ALLC                88
8997009109164724 O                       CCOVTP              26
8998001109134724 O                       mcuniq              38
899900981208y2k  O                       TRANDT              72
9000009109184726 O                       ZERO7               42P
9001009109124731 O                                           64 'A'
900200110831
900300110831      * change enroll date - add new mcov
9004009109124718 O          EADD         CHGEND
900500981130y2k  O                       ALLC                88
9006001109134724 O                       mcuniq              38
900700981130y2k  O                       CEFFDT              72
9008009109184726 O                       ZERO7               42P
9009009109124731 O                                           64 'A'
901000140121     OMCOVC     E            relmcovc
901100910222     O*
9012009102154734 OMCOV      E            MCOVU
901300981130y2k  O                       EDATE               72
901400981130y2k  O                       TDATE               80
9015009102154737 O                       DLTC2               64
901600910830     OMCOV      E            CANMCV
901700990203y2k  O                       BCHYMD              80
901800910829     O                                           64 'C'
901900910829     OMCOV      E            CANMC2
902000990203y2k  O                       SCHYMD              80
902100910829     O                                           64 'C'
902200110830
902300110830      * used for birthday change causing new benefit
902400910829     OMCOV2     EADD         MCVADD
902500981130y2k  O                       ALL                 88
902600130515     O                       agbandwk       B    23
9027001109134724 O                       mcuniq              38
902800990203y2k  O                       BCHYMD              72
902900981130y2k  O                       ZERO8               80
903000910918     O                       ZERO7               42P
903100920217     O                       HBENAM              47P
903200110830     O                       horgben             59P
903300910829     O                                           64 'A'
903400110830
903500110830      * used for salary change causing new benefit
903600910829     OMCOV2     EADD         MCVAD2
903700981130y2k  O                       ALL                 88
9038001109134724 O                       mcuniq              38
903900990203y2k  O                       SCHYMD              72
904000981130y2k  O                       ZERO8               80
904100910918     O                       ZERO7               42P
904200910829     O                       BENAMT              47P
904300110830     O                       horgben             59P
904400910829     O                                           64 'A'
904500110830
904600140121     OMCOV      E            relmcov
904700910222     O*
9048001401214740 ODCOV      E            candcv
904900981130y2k  O                       DCANDT              64
9050009102154742 O                                           48 'C'
9051001401214743 O          E            candcv2
905200981130y2k  O                       TDCVDT         B    64
9053009102154745 O                       DLTC5               48
905400140121     ODCOV      E            reldcov
905500910222     O*
9056001401214750 ODCOVC     E            updcovc
9057009102154751 O                       CTRSUB         B    17
9058009102154752 O                       CPLAN          B    21
9059009102154755 O                       DLTC4               48
906000981209y2k  O                       DENRDT         B    56
906100981209y2k  O                       DCANDT         B    64
9062001401214756 O          EADD         adddcovc
9063009102154757 O                       SSNO                 9
9064009102154758 O                       CSEQ#               11
9065009102154759 O                       CTRSUB         B    17
9066009102154760 O                       CPLAN          B    21
906700990201y2k  O                       ZERO8               42
9068009102154764 O                                           48 'A'
906900981209y2k  O                       DENRDT         B    56
907000990201y2k  O                       ZERO8               64
907100140121     ODCOVC     E            reldcovc
907200910225     O*
9073009102154765 OACCMST#   E            ACCU
9074009102154766 O                       NOEMPL             213P
9075009710072223 OPCP       EADD         PCPADD
9076009710072224 O                       PCSSN                5P
9077009710072225 O                       PCDSEQ               7P
9078000503212225 O                       PCID#               27
9079000503212225 O                       PCSPCD              32
9080000503212225 O                       PCEYMD              37P
9081000503212225 O                       PCCAN               42P
9082000503212225 O*                      PCRPAT              43
908300981125     O/EJECT
9084009102154767 O* SCREEN OUTPUT **************************************************
9085000102144768 OFM070FM   D    11N1P
908600010214     O         OR    1PN11
9087009102154769 O                                           K8 'IO01    '
9088009102154770 O                       CONAME              40
9089009102154771 O                       SSNO                49
9090009102154772 O               50      MSG(X)             124
9091000102144773 OFM070FM   D    12
9092009102154774 O                                           K8 'IO02    '
9093009102154775 O                       CONAME              40
9094009102154776 O                       SSNO                49
909500101215y2k  O                       mnonssn             50
909600101214y2k  O                       MENRDT              58
909700101214     O                       LNAME               76
909800101214     O                       FNAME               88
909900101214     O                       MI                  89
910000101214     O                       ADDR1              119
910100101214     O                       ADDR2              149
910200101214     O                       CITY               164
910300101214     O                       STATE              166
910400101214     O                       ZIP                175
910500101214     O                       SEX                176
910600101214y2k  O                       BIRTH              184
910700101214     O                       AREA               187
910800101214     O                       PHONE              194
910900101215y2k  O                       memail             259
911000101215     O                       TRUST              262
911100101215     O                       SUBNO              265
911200101215     O                       ACCNO              269
911300101215     O                       SRVDES             275
911400101215y2k  O                       EMPDT              283
911500101215     O                       SALARY             292
911600101215     O                       INLIF              293
911700101215     O                       INADD              294
911800101215     O                       EMPST              295
911900101215     O                       CCFLG              298
912000120417     O                       NONEMP             299
912100120417y2k  O                       MARDT              307
912200120417     O                       MEDICR             308
912300120417     O                       MED#               321
912400120417y2k  O                       MEDADT             329
912500120417y2k  O                       MEDBDT             337
912600120417     O                       HNDICP             338
912700120417y2k  O                       HDCPDT             346
912800120417     O                       COBX               347
912900120417     O                       COBENM             367
913000120417     O                       COBPNM             382
913100120417     O                       COBP#              392
913200120417     O                       COBBCF             393
913300120417     O                       COBCTY             403
913400120417     O                       COBST              405
913500120417     O               50      MSG(X)             480
913600111206
913700111206      * this looks ugly but it was the best way to condition this field
913800111206      * to only show when 1 of these indicators is on. A new indicator
913900111206      * could not be used becuase all indicators are taken.
914000120417     O               50 51   badcharsout        476
914100120417     O               50 52   badcharsout        476
914200120417     O               50 53   badcharsout        476
914300120417     O               50 54   badcharsout        476
914400120417     O               50 55   badcharsout        476
914500120417     O               50 56   badcharsout        476
914600120417     O               50 71   badcharsout        476
9147000102144815 OFM070FM   D    13
9148009102154816 O                                           K8 'IO03    '
9149009102154817 O                       CONAME              40
915000910925     O                       TSA                 52 '   -   -   0'
9151009109254819 O                       ACNAM1              92
915200910925     O                       SSNO               113 '   -  -   0'
9153009109254821 O                       LNAME              131
9154009109254822 O                       FNAME              144
9155009109254823 O                       MI                 143
9156009109274824 O                                          144 '.'
915700221023     O                       LL(1)              167 '  0.'
915800981130y2k  O                       P#(1)              171
915900140627y2k  O                       P#des(1)           211
9160001406274826 O                       CT(1)              213
916100140627     O                       ABX(1)             215
916200140627y2k  O                       ED(1)         Z    223
9163001406274828 O                       BA(1)         Z    230
9164001406274828 O                       RB(1)              233
916500140627y2k  O                       TD(1)         Z    241
916600140627     O                       PR(1)              250
916700221023     O                       LL(2)              254 '  0.'
916800221023y2k  O                       P#(2)              258
916900140627y2k  O                       P#des(2)           298
9170001406274831 O                       CT(2)              300
917100140627     O                       ABX(2)             302
917200140627y2k  O                       ED(2)         Z    310
9173001406274833 O                       BA(2)         Z    317
9174001406274828 O                       RB(2)              320
917500140627y2k  O                       TD(2)         Z    328
917600140627     O                       PR(2)              337
917700140627     O                       LL(3)              341 '  0.'
917800140627y2k  O                       P#(3)              345
917900140627y2k  O                       P#des(3)           385
9180001406274836 O                       CT(3)              387
918100140627     O                       ABX(3)             389
918200140627y2k  O                       ED(3)         Z    397
918300140627     O                       BA(3)         Z    404
9184001406274828 O                       RB(3)              407
918500140627y2k  O                       TD(3)         Z    415
918600140627     O                       PR(3)              424
918700140627     O                       LL(4)              428 '  0.'
918800140627y2k  O                       P#(4)              432
918900140627y2k  O                       P#des(4)           472
9190001406274841 O                       CT(4)              474
919100140627     O                       ABX(4)             476
919200140627y2k  O                       ED(4)         Z    484
9193001406274843 O                       BA(4)         Z    491
9194001406274828 O                       RB(4)              494
919500140627y2k  O                       TD(4)         Z    502
919600140627     O                       PR(4)              511
919700140627     O                       LL(5)              515 '  0.'
919800140627y2k  O                       P#(5)              519
919900140627y2k  O                       P#des(5)           559
9200001406274846 O                       CT(5)              561
920100140627     O                       ABX(5)             563
920200140627y2k  O                       ED(5)         Z    571
9203001406274848 O                       BA(5)         Z    578
9204001406274828 O                       RB(5)              581
920500140627y2k  O                       TD(5)         Z    589
920600140627     O                       PR(5)              598
920700140627     O                       LL(6)              602 '  0.'
920800140627y2k  O                       P#(6)              606
920900140627y2k  O                       P#des(6)           646
9210001406274851 O                       CT(6)              648
921100140627     O                       ABX(6)             650
921200140627y2k  O                       ED(6)         Z    658
9213001406274853 O                       BA(6)         Z    665
9214001406274828 O                       RB(6)              668
921500140627y2k  O                       TD(6)         Z    676
921600140627     O                       PR(6)              685
921700140627     O                       LL(7)              689 '  0.'
921800140627y2k  O                       P#(7)              693
921900140627y2k  O                       P#des(7)           733
9220001406274856 O                       CT(7)              735
922100140627     O                       ABX(7)             737
922200140627y2k  O                       ED(7)         Z    745
9223001406274858 O                       BA(7)         Z    752
9224001406274828 O                       RB(7)              755
922500140627y2k  O                       TD(7)         Z    763
922600140627     O                       PR(7)              772
922700140627     O                       LL(8)              776 '  0.'
922800140627y2k  O                       P#(8)              780
922900140627y2k  O                       P#des(8)           820
9230001406274861 O                       CT(8)              822
923100140627     O                       ABX(8)             824
923200140627y2k  O                       ED(8)         Z    832
9233001406274863 O                       BA(8)         Z    839
9234001406274828 O                       RB(8)              842
923500140627y2k  O                       TD(8)         Z    850
923600140627     O                       PR(8)              859
923700140627     O                       LL(9)              863 '  0.'
923800140627y2k  O                       P#(9)              867
923900140627y2k  O                       P#des(9)           907
9240001406274866 O                       CT(9)              909
924100140627     O                       ABX(9)             911
924200140627y2k  O                       ED(9)         Z    919
9243001406274868 O                       BA(9)         Z    926
9244001406274828 O                       RB(9)              929
924500140627y2k  O                       TD(9)         Z    937
924600140627     O                       PR(9)              946
924700221023     O                       LL(10)             950 '  0.'
924800140627y2k  O                       P#(10)             954
924900140627y2k  O                       P#des(10)          994
9250001406274871 O                       CT(10)             996
925100140627     O                       ABX(10)            998
925200140627y2k  O                       ED(10)        Z   1006
9253001406274873 O                       BA(10)        Z   1013
9254001406274828 O                       RB(10)            1016
925500140627y2k  O                       TD(10)        Z   1024
925600140627     O                       PR(10)            1033
9257001406274875 O                       SPLAN#            1037
9258001406274876 O                       SCVTYP            1039
925900140627y2k  O                       SENRLD            1047
9260001406274878 O                       SBENAM            1054
926100140627y2k  O                       SCAND1            1062
926200140627     O                       SACTCD            1063
926300221020     O                       L#            Z   1066
926400221019y2k  O                       ASOFDT            1074
926500221019y2k  O                       TRMRCD            1076
9266002210194882 O               50      MSG(X)            1151
926700221019y2k  O               50 42   in42datemdy       1146
9268000102144883 OFM070FM   D    14
9269009102154884 O                                           K8 'IO04    '
9270009102154885 O                       CONAME              40
9271009102154887 O                       ACNAM1              80
9272009102154889 O                       LNAME              108
9273009102154890 O                       FNAME              121
9274009102154891 O                       MI                 123
9275009102154892 O                                          124 '.'
9276009102154893 O                       DRELC2             142
9277009102154894 O                       DLNAME             160
9278009102154895 O                       DFNAME             172
9279009102154896 O                       DMI                173
9280009102154897 O                       DADDR1             203
9281009102154898 O                       DADDR2             233
9282009102154899 O                       DCITY              248
9283009102154900 O                       DSTATE             250
9284009102154901 O                       DZIP               259
9285009102154902 O                       DSEX               260
928600981130y2k  O                       DBIRTH             268
9287009811304904 O                       DAREA              271
9288009811304905 O                       DPHONE             278
9289009811304906 O                       DEPSS#             287
9290009811304907 O                       DSTUDN             288
9291001107190600 O                       DSEFFD             296
9292001107190600 O                       DSSCHL             323
9293001107190600 O                       D2email            388
929400110719
9295001107194908 O                       DMEDCR             389
9296001107194909 O                       DMED#              402
929700110719y2k  O                       DMEDAD             410
929800110719y2k  O                       DMEDBD             418
9299001107194912 O                       DHNDCP             419
930000110719y2k  O                       DHDDT              427
9301001107194914 O                       DCOB               428
9302001107194915 O                       DCOBEN             448
9303001107194916 O                       DCOBPN             463
9304001107194917 O                       DCOBP#             478
9305001107194918 O                       DCOBBC             479
9306001107194919 O                       DCOBCT             489
9307001107194920 O                       DCOBST             491
9308001107194926 O               50      MSG(X)             566
930900111208      * this looks ugly but it was the best way to condition this field
931000111208      * to only show when 1 of these indicators is on. A new indicator
931100111208      * could not be used becuase all indicators are taken.
931200111208     O               50 52   badcharsout        562
931300111208     O               50 53   badcharsout        562
931400111208     O               50 54   badcharsout        562
931500111208     O               50 55   badcharsout        562
931600111208     O               50 56   badcharsout        562
931700111208     O               50 57   badcharsout        562
931800111208     O               50 58   badcharsout        562
9319000102144927 OFM070FM   D    15
9320009102154928 O                                           K8 'IO05    '
9321009102154929 O                       CONAME              40
9322009102154931 O                       ACNAM1              80
932300140411     o                       subdsc             140
9324001404114933 O**                     LNAME              108
9325001404114934 O**                     FNAME              121
9326001404114935 O**                     MI                 123
9327001404114936 O**                                        124 '.'
932800140411     o                       depdsc             190
9329001404114938 O**                     DLNAME             158
9330001404114939 O**                     DFNAME             171
9331001404114940 O**                     DMI                173
9332001404114941 O**                                        174 '.'
933300140411
9334009811304942 O                       P#(1)              194
9335009102154943 O                       PDS(1)             233
9336009102154944 O                       DCV(1)             234
933700990205y2k  O                       DEF(1)        Z    242
933800990205y2k  O                       DTD(1)        Z    250
9339009811304947 O                       P#(2)              254
9340009811304948 O                       PDS(2)             293
9341009811304949 O                       DCV(2)             294
934200990205y2k  O                       DEF(2)        Z    302
934300990205y2k  O                       DTD(2)        Z    310
9344009811304952 O                       P#(3)              314
9345009811304953 O                       PDS(3)             353
9346009811304954 O                       DCV(3)             354
934700990205y2k  O                       DEF(3)        Z    362
934800990205y2k  O                       DTD(3)        Z    370
9349009811304957 O                       P#(4)              374
9350009811304958 O                       PDS(4)             413
9351009811304959 O                       DCV(4)             414
935200990205y2k  O                       DEF(4)        Z    422
935300990205y2k  O                       DTD(4)        Z    430
9354009811304962 O                       P#(5)              434
9355009811304963 O                       PDS(5)             473
9356009811304964 O                       DCV(5)             474
935700990205y2k  O                       DEF(5)        Z    482
935800990205y2k  O                       DTD(5)        Z    490
9359009811304967 O                       P#(6)              494
9360009811304968 O                       PDS(6)             533
9361009811304969 O                       DCV(6)             534
936200990205y2k  O                       DEF(6)        Z    542
936300990205y2k  O                       DTD(6)        Z    550
9364009811304972 O                       P#(7)              554
9365009811304973 O                       PDS(7)             593
9366009811304974 O                       DCV(7)             594
936700990205y2k  O                       DEF(7)        Z    602
936800990205y2k  O                       DTD(7)        Z    610
9369009811304977 O                       P#(8)              614
9370009811304978 O                       PDS(8)             653
9371009811304979 O                       DCV(8)             654
937200990205y2k  O                       DEF(8)        Z    662
937300990205y2k  O                       DTD(8)        Z    670
9374009811304982 O                       P#(9)              674
9375009901274983 O                       PDS(9)             713
9376009901274984 O                       DCV(9)             714
937700990205y2k  O                       DEF(9)        Z    722
937800990205y2k  O                       DTD(9)        Z    730
9379009811304987 O                       P#(10)             734
9380009811304988 O                       PDS(10)            773
9381009901274989 O                       DCV(10)            774
938200990205y2k  O                       DEF(10)       Z    782
938300990205y2k  O                       DTD(10)       Z    790
9384009811304987 O                       P#(11)             794
9385009811304988 O                       PDS(11)            833
9386009811304989 O                       DCV(11)            834
938700990205y2k  O                       DEF(11)       Z    842
938800990205y2k  O                       DTD(11)       Z    850
9389009811304987 O                       P#(12)             854
9390009811304988 O                       PDS(12)            893
9391009811304989 O                       DCV(12)            894
939200990205y2k  O                       DEF(12)       Z    902
939300990205y2k  O                       DTD(12)       Z    910
9394009811304987 O                       P#(13)             914
9395009811304988 O                       PDS(13)            953
9396009811304989 O                       DCV(13)            954
939700990205y2k  O                       DEF(13)       Z    962
939800990205y2k  O                       DTD(13)       Z    970
9399009901274994 O                       SACTCD             971
9400002210204995 O                       L#            Z    974
940100221019y2k  O                       SENRLD             982
940200221019y2k  O                       SCANDT             990
9403002210194996 O               50      MSG(X)            1065
9404009102154997 O          D    16
9405009102154998 O                                           K8 'IO06    '
9406009102154999 O                       CONAME              40
9407009102155000 O                       SSNO                49
9408001012165000 O                       mnonssn             50
940900101216Y2K  O                       MENRDT              58
9410001012165001 O                       LNAME               76
9411001012165002 O                       FNAME               88
9412001012165003 O                       MI                  89
9413001012165004 O                       ADDR1              119
9414001012165005 O                       ADDR2              149
9415001012165006 O                       CITY               164
9416001012165007 O                       STATE              166
9417001012165008 O                       ZIP                175
9418001012165009 O                       SEX                176
941900101216y2k  O                       BIRTH              184
942000101216     O                       AREA               187
942100101216     O                       PHONE              194
942200101216     O                       memail             259
942300101216     O                       TRUST              262
942400101216     O                       SUBNO              265
942500101216     O                       ACCNO              269
942600101216     O                       srvdes             275
942700101216y2k  O                       EMPDT              283
942800101216     O                       SALARY             292
942900101216     O                       INLIF              293
943000101216     O                       INADD              294
943100101216     O                       EMPST              295
9432001012165020 O                       TCODE              297
943300101216y2k  O                       TERMDT             305
9434001012165022 O               50      MSG(X)             382
9435009102155023 O          D    17
9436009102155024 O                                           K8 'IO07    '
9437009102155025 O                       CONAME              40
9438009102155026 O                       SSNO                49
9439001012165000 O                       mnonssn             50
944000101216y2k  O                       MENRDT              58
944100101216     O                       LNAME               76
944200101216     O                       FNAME               88
944300101216     O                       MI                  89
944400101216     O                       ADDR1              119
944500101216     O                       ADDR2              149
944600101216     O                       CITY               164
944700101216     O                       STATE              166
9448001012165034 O                       ZIP                175
9449001012165035 O                       SEX                176
945000101216y2k  O                       BIRTH              184
945100101216     O                       AREA               187
945200101216     O                       PHONE              194
945300101216     O                       memail             259
945400101216     O                       TRUST              262
945500101216     O                       SUBNO              265
945600101216     O                       ACCNO              269
945700101216     O                       srvdes             275
945800101216y2k  O                       EMPDT              283
945900101216     O                       SALARY             292
946000101216     O                       INLIF              293
946100101216     O                       INADD              294
946200101216     O                       EMPST              295
9463001012165046 O                       RCODE              297
9464001012165047 O                       REINDT             305
9465001012165047 O                       retainc            306
946600101216y2k  O               50      MSG(X)             381
946700130517
946800130517      * IO08 = Dependent term screen
9469009102155049 O          D    18
9470009102155050 O                                           K8 'IO08    '
9471009102155051 O                       CONAME              40
9472009102155053 O                       ACNAM1              80
9473009102155055 O                       LNAME              108
9474009102155056 O                       FNAME              121
9475009102155057 O                       MI                 123
9476009102155058 O                                          124 '.'
9477009102155059 O                       DRELC2             142
9478009102155060 O                       DLNAME             160
9479009102155061 O                       DFNAME             172
9480009102155062 O                       DMI                173
9481009102155063 O                       DADDR1             203
9482009102155064 O                       DADDR2             233
9483009102155065 O                       DCITY              248
9484009102155066 O                       DSTATE             250
9485009811305067 O                       DZIP               259
9486009102155068 O                       DSEX               260
948700981130y2k  O                       DBIRTH             268
9488009811305070 O                       DAREA              271
9489009811305071 O                       DPHONE             278
9490009811305072 O                       DEPSS#             287
9491009811305073 O                       DSTUDN             288
9492009811305074 O                       TCODE              290
949300981130y2k  O                       TERMDT             298
9494009901055076 O               50      MSG(X)             375
949500130517
949600130517      * IO09 = Dependent reinstate screen
9497009102155077 O          D    19
9498009102155078 O                                           K8 'IO09    '
9499009102155079 O                       CONAME              40
9500009102155080 O*                        ACTDSC    90
9501009102155081 O                       ACNAM1              80
9502009102155082 O*                        SUBDSC   140
9503009102155083 O                       LNAME              108
9504009102155084 O                       FNAME              121
9505009102155085 O                       MI                 123
9506009102155086 O                                          124 '.'
9507009102155087 O                       DRELC2             142
9508009102155088 O                       DLNAME             160
9509009102155089 O                       DFNAME             172
9510009102155090 O                       DMI                173
9511009102155091 O                       DADDR1             203
9512009102155092 O                       DADDR2             233
9513009102155093 O                       DCITY              248
9514009102155094 O                       DSTATE             250
9515009102155095 O                       DZIP               259
9516009102155096 O                       DSEX               260
951700981130y2k  O                       DBIRTH             268
9518009811305098 O                       DAREA              271
9519009811305099 O                       DPHONE             278
9520009811305100 O                       DEPSS#             287
9521009811305101 O                       DSTUDN             288
9522009811305102 O                       RCODE              290
952300981130y2k  O                       REINDT             298
9524009901055104 O               50      MSG(X)             375
952500130516     O          E            SALCHGSCRN
952600910522     O                                           K8 'IO10    '
952700981130y2k  O                       SCHDT                8
952800981215     O               50      MSG(X)              83
952900910522     O          E            BIRCHG
953000910523     O                                           K8 'IO37    '
953100981130y2k  O                       BCHDT                8
953200981215     O               50      MSG(X)              83
9533009710072003 O          E            IO78
9534009710072004 O                                           K8 'IO78    '
9535009710071763 O                       CONAME              40
9536009710071764 O                       SSNO                51 '   -  -   0'
9537009710071765 O                       N                   82
9538009710071766 O                       PCDSEQ              84
9539009710071766 O                       DFNHLD              96
9540000503211766 O                       PCID#              116
9541000503211766 O                       PCSPCD             121
9542000503211766 O                       PCEFF              129
9543000503211766 O*                      PCRPAT             130
954400910215** ERROR MESSAGE ARRAY
954500910215 ** BLANK SOC. SEC. # IS INVALID                                       *01*
954600910215 ** THIS MEMBER IS NOT ACTIVE                                          *02*
954700910215 ** ENTER REQUIRED INFORMATION                                         *03*
954800910215 ** INVALID DATE                                                       *04*
954900910215 ** INVALID SEX (M or F)                                               *05*
955000910215 ** INVALID CODE                                                       *06*
955100910215 ** INVALID Acct#                                                      *07*
955200910215 ** INVALID Group #                                                    *08*
955300910215 ** SELECTED COVERAGE PLAN IS NOT PRIMARY MEDICAL                      *09*
955400130522 ** INVALID OR INACTIVE PLAN #                                         *10*
955500910215 ** SELECTED COVERAGE PLAN CANNOT BE PRIMARY MEDICAL                   *11*
955600910215 ** INVALID TYPE FOR THE PLAN ENTERED                                  *12*
955700910215 ** PLAN SELECTION MUST BE Y OR BLANK                                  *13*
955800960221 ** INVALID HANDICAP (1=PERMANENT, 2=NEEDS RECERT, BLANK=NO HANDICAP)  *14*
955900910516 ** INVALID CHOICE (R, A, C, 1-6    PRESS HELP FOR MORE INFO)          *15*
956000911009 ** RATE RECORD NOT FOUND FOR - PLAN#/COVERAGE TYPE/EFF DATE ENTERED    *16*
956100910215 ** DUPLICATE PLAN ENTERED                                             *17*
956200180713 ** MEDICARE MUST BE Y OR N                                            *18*
956300910215 ** INVALID ACTION CODE (A, C OR T)                                    *19*
956400221023 ** INVALID LINE #, ENTER A VALID LINE # USING 3 DIGITS (i.e. 001)     *20*
956500030609 ** ENTER AS OF DATE ONLY FOR TERMINATION OR REINSTATEMENT             *21*
956600910215 ** PROGRAM ERROR # 22 - SEE PROGRAMMER!!                              *22*
956700910826 ** CANNOT CHANGE CANCEL DATE FOR ACTIVE PLAN                          *23*
956800910215 ** CANNOT CHANGE PLAN - MUST TERMINATE OLD AND ADD NEW                *24*
956900910215 ** INVALID AS OF DATE                                                 *25*
957000910215 ** CANNOT REINSTATE ACTIVE PLAN                                       *26*
957100000218 ** THIS DEPENDENT IS NOT ACTIVE                                       *27*
957200910215 ** ENROLL DATE & AS OF DATE CANNOT BE CHANGED AT THE SAME TIME        *28*
957300910215 ** MSG  29                                                            *29*
957400910215 ** PROGRAM ERROR # 30 - SEE PROGRAMMER!!                              *30*
957500910215 ** RATE TYPE = PREMIUM. BENEFIT AMOUNT ENTERED IS INVALID             *31*
957600910215 ** RATE TYPE = RATIO. BENEFIT AMOUNT INVALID FOR SALARY BASED         *32*
957700910215 ** RATE TYPE= RATIO. BENEFIT AMT MUST BE ENTERED FOR NON-SALARY BASED *33*
957800910215 ** SEX= M --  DEPENDENT MUST BE 'SON' OR 'HUSBAND'                    *34*
957900961023 ** INVALID RELATION CODE                                              *35*
958000140409 ** REINSTATE DATE MUST EQUAL EXISTING COVERAGE EFFECTIVE DATE         *36*
958100910417 ** INVALID ENROLLMENT DATE                                            *37*
958200950609 ** COBRA TOTAL BALANCE DUE NOT EQUAL ZERO                             *38*
958300910823 ** CHANGE ONLY ALLOWED FOR CANCELLATION DATE                          *39*
958400910823 ** CHANGE SPECIFIED BUT AS OF DATE = ZERO                             *40*
958500140226 ** CANCEL DATE CANNOT BE LESS THAN EFFECTIVE DATE.                    *41*
958600910919 ** AS OF DATE MUST BE SAME AS EFFECTIVE DATE                          *42*
958700910909 ** "C" FOR CHANGE SPECIFIED,BUT NO CHANGE FIELDS ENTERED.             *43*
958800910913 ** AS OF DATE CANNOT BE LESS THAN EFFECTIVE DATE                      *44*
958900910917 ** NO GRATE RECORD FOUND FOR CANCELLATION DATE ENTERED                *45*
959000910919 ** MEMBER IS CANCELLED. ONLY CHANGES ARE ALLOWED.                     *46*
959100910924 ** AS OF DATE MUST BE EQUAL TO CANCELLATION DATE                      *47*
959200911001 ** WARNING ** TERM. DATE MAY NOT HAVE BEEN USED TO CANCEL COVERAGES   *48*
959300911001 ** AS OF DATE CANNOT BE LESS THAN CANCELLATION DATE                   *49*
959400911010 ** AN ACTIVE PLAN EXISTS ALREADY WITH SAME PLAN CATEGORY CODE.        *50*
959500920205 ** ONLY 1 CHANGE ALLOWED PER TRANSACTION                              *51*
959600141112 ** EFFECTIVE DATE IS LESS THAN MEMBER ENROLL DATE (SEE PRV SCREEN)    *52*
959700920710 ** WARNING ** SALARY CHANGE CANNOT PRECEDE EFFECTIVE DATE OF PLAN     *53*
959800920225 * WARNING * BIRTH CHG DATE MAY NOT HAVE BEEN USED TO CANCEL COVERAGES *54*
959900110902 ** ADD CROSSES AGE BAND CHANGE, YOU MUST CANCEL/ADD AS OF             *55*
960000920309 ** COVERAGE TYPE MUST BE DIFFERENT TO PROCESS CHANGE                  *56*
960100920515 ** PLAN IS SALARY BASED. NO SALARY ENTERED   (SEE PRV SCREEN)         *57*
960200921019 ** NO RATES FOUND FOR PLAN/EFFECTIVE DATE. REINSTATE NOT ALLOWED.     *58*
960300921023 ** NO RATES FOUND FOR PLAN/EFFECTIVE DATE. TERMINATE NOT ALLOWED.     *59*
960400921104 ** EFFECTIVE DATE CAN'T BE LESS THAN ACCOUNT ENROLL DATE              *60*
960500140409 CANCEL DATE MUST BE BLANK ON A CHANGE, USE "T" TO CHANGE CANCEL DATE  *61*
960600950209 ** CHANGE COVERAGE TYPE NOT ALLOWED ON CANCELED PLAN                  *62*
960700950925 ** CANCELLED ACCOUNT                                                  *63*
960800140319 ** WARNING - DEPENDENT AGE AS OF THIS MONTH > 18 - F11 TO ACCEPT      *64*
960900980202 ** ACCOUNT CANCELLED...REINSTATE NOT ALLOWED                          *65*
961000991028 ** MEMBER IS ACTIVE...REINSTATE NOT ALLOWED                           *66*
961100991104 ** MEMBER IS ALREADY CANCELLED...CANCEL NOT ALLOWED                   *67*
961200991110 ** ENROLLMENT DATE CHANGE NOT ALLOWED ON CANCELLED PLAN               *68*
961300010426PLEASE SEE COBRA ADMINISTRATOR. YOU CANNOT PROCESS FOR EXTENDING MEMBER*69*
961400010426 ** INVALID SOCIAL SECURITY NUMBER FOR THIS CLIENT                     *70*
961500010426 ** TRUST MUST BE 403 FOR THIS CLIENT                                  *71
961600011101 ** NEW TERM DATE MUST NOT = OLD TERM DATE IN ORDER TO PROCESS CHANGE  *72*
961700010907 ** INVALID COB FLAG - PLEASE ENTER Y OR N                             *73*
961800011012 ** ACCT CANCELLED, TO REINSTATE THIS COBRA MEMBER USE COBRA REINSTATE *74*
961900021018 ** EFFECTIVE DATE AND SCHOOL NAME MUST BOTH BE ENTERED OR LEFT BLANK  *75*
962000140409 ** INVALID EFFECTIVE DATE                                             *76*
962100030611 ** INVALID TERM REASON CODE                                           *77*
962200030611 ** TERM REASON CODE MUST BE BLANK                                     *78*
962300041015 THIS SSN HAS BEEN ADDED BY SOMEONE ELSE SINCE YOU STARTED, PRESS F1   *79*
962400041217 PLEASE CHOOSE "Y" OR "N" FOR RETAIN COBRA NOTIFICATION INFO...        *80*
962500050628 ** IF MEMBER IS NON-EMPLOYEE, YOU MUST ENTER  Y  OTHERWISE BLANK.
962600050928 ** IF MEMBER IS INELIGIBLE FOR LIFE, ENTER  Y  OTHERWISE BLANK.
962700050928 ** IF MEMBER IS INELIGIBLE FOR AD&D, ENTER  Y  OTHERWISE BLANK.
962800120417 ** ENTER A COST CENTER THAT BEGINS WITH "Y", PRESS F11 TO ACCEPT      *84*
962900091204 THERE ARE PLANS CANCELLED AFTER THIS DATE, CORRECT BEFORE CONTINUING
963000101215 NON-SSN MUST BE "Y" OR BLANK
963100101220 ** CANNOT CHANGE BENEFIT AMOUNT                                       *87*
963200101220 ** BENEFIT AMOUNT MUST BE ZERO FOR THIS PLAN / DATE                   *88*
963300101220 ** THIS VARIABLE BENEFIT PLAN HAS A SET UP ERROR - CHECK SET UP       *89*
963400101221 ** THIS PLAN REQUIRES A VALID BENEFIT ENTRY, PRESS F8 TO SHOW RANGE   *90*
963500110429 ** STUDENT FIELD MUST BE Y OR N                                       *91*
963600110701 ** WARNING - NO RATE FOR EFFDT > 60 DAYS AHEAD, PRESS F11 TO ACCEPT   *92*
963700110913 ** PAYROLL EMPLOYEE MISSING SCREENS 1 + 2, MUST USE OLE TO ADD FIRST  *93*
963800111206 ** INVALID CHARACTER IN FIRST NAME                                    *94*
963900111025 ** INVALID CHARACTER IN LAST NAME                                     *95*
964000111025 ** INVALID CHARACTER IN MIDDLE INITIAL                                *96*
964100111025 ** INVALID CHARACTER IN ADDRESS 1                                     *97*
964200111025 ** INVALID CHARACTER IN ADDRESS 2                                     *98*
964300111025 ** INVALID CHARACTER IN CITY                                          *99*
964400111025 ** INVALID CHARACTER IN STATE                                         *100
964500111025 ** THIS ACCOUNT DOES NOT USE COST CENTERS, FIELD MUST BE BLANK        *101
964600120420 ** PLEASE ENTER A VALID COST CENTER THAT BEGINS WITH "Y"              *102
964700121127 * THIS PLAN DOES NOT HAVE AN ACTIVE COMMISSION FOR THE EFFECTIVE DATE *103
964800131216 ** DEPENDENT COVERAGE EFF DATE IS PRIOR TO MBR COVG EFFECTIVE DATE    *104
964900140318 ** INVALID BIRTH DATE, AGE OVER 150 YEARS OLD                         *105
965000140320 ** EMPLOYMENT DATE MUST BE AFTER BIRTH DATE                           *106
965100140618 ** EFFECTIVE DATE CANNOT BE LESS THAN EMPLOYMENT DATE                 *107
965200910215**  DAYS IN MONTH ARRAY
965300910215312931303130313130313031
965400910215**  SAME NAME COMPARISON
965500910215SAME
965600910215**  SAME ADDRESS COMPARISON
965700910215SAME
