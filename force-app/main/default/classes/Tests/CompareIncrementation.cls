@IsTest
public with sharing class CompareIncrementation {

    /**
     * This test compares the performance of two incrementation methods.
     * The first method uses the ++ operator, the second method uses the standard + operator.
     */
    @IsTest
    static void compareTwoIncrementationMethods() {
        Integer x = 0;
        Integer y = 0;
        Integer loops = 1000000;
        BenchmarkUtilTest b = new BenchmarkUtilTest();

        // First operation to compare: ++ incrementation
        b.markReferenceStartTime();
        for(Integer i=0; i<1000000; i++) {
            x++;
        }
        b.markReferenceEndTime();

        // Second operation to compare: + incrementation
        b.markTargetStartTime();
        for(Integer i=0; i<1000000; i++) {
            y = y + 1;
        }
        b.markTargetEndTime();

        // Debug the results
        b.reportResults(1000000);
    }

}