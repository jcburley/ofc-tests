1
                     NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY
                    FORTRAN COMPILER VALIDATION SYSTEM
                      VERSION 2.1  93/10/21*21.02.00
 
 *FM111BEGIN*            TEST RESULTS - FM111

         TEST DATE*TIME= *NO DATE*TIME      -  COMPILER= *NONE SPECIFIED*    

 IOFMTS - (353) ADDITIONAL FORMATTED
                DATA TRANSFERS

  SUBSET REFS 12.9.5.2  13.1  13.5
 
 
  TEST   PASS/FAIL       DISPLAYED RESULTS       REMARKS
 -------------------------------------------------------------------------------
                                                 THIS PROGRAM HAS   4 TESTS

     1    INSPECT
           COMPUTED:   1110 2020 .30303E-07   44   55   6.6 70.07 .888E+01   99
           CORRECT:    1110 2020 .30303E-07   44   55   6.6 70.07 .888E+01   99

           COMPUTED:  23450 10345. 12.45 1235 1234 2345  1345. 12.45 1235 1234
           CORRECT:   23450 10345. 12.45 1235 1234 2345  1345. 12.45 1235 1234

           COMPUTED:      0   .0   .0    0   .0E+0   **   -.4E-2
           CORRECT:       0   .0   .0    0   .0E+0   .0   -.4E-2

     2    INSPECT
           COMPUTED: ********* .12345E+10 .12345E+010 *********** .12345E+10
           CORRECT:  ********* .12345E+10 .12345E+010 *********** .12345E+10

     3    INSPECT
           COMPUTED:     6 33.33
           CORRECT:      6 33.33

     4    INSPECT

           COMPUTED:     2    4    6
           CORRECT:      2    4    6

           COMPUTED: 'THAT'S ALL FOR NOW'
           CORRECT:  'THAT'S ALL FOR NOW'
 
 -------------------------------------------------------------------------------
 
                          0 TESTS PASSED
                          0 TESTS FAILED
                          0 TESTS DELETED
                          4 TESTS REQUIRE INSPECTION
                          4 OF   4 TESTS EXECUTED
 
 *FM111END*              END OF TEST - FM111

 *NO PROJECT*              *NO COMPANY NAME*      *   *NO TAPE* /*NO TAPE DATE
 FOR OFFICIAL USE ONLY                                        COPYRIGHT  1982
