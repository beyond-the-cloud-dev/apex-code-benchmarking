//sfdx force:apex:test:run --tests "CompareMapMethods.compare"
@IsTest
public class CompareMapMethods {
    @IsTest
    static void compare() {
        Integer loops = 100000;

        BenchmarkUtilTest b = new BenchmarkUtilTest();

        Map<Integer, List<Integer>> referenceMap = new Map<Integer, List<Integer>>();

        b.start();
        for (Integer i = 0; i < loops; i++) {
            if (referenceMap.get(i) == null) {
                referenceMap.put(i, new List<Integer>());
            }

            referenceMap.get(i).add(i);
        }
        b.end();

        b.report();

        Map<Integer, List<Integer>> targetMap = new Map<Integer, List<Integer>>();

        BenchmarkUtilTest b2 = new BenchmarkUtilTest();

        b2.start();

        for (Integer i = 0; i < loops; i++) {
            if (targetMap.get(i) == null) {
                targetMap.put(i, new List<Integer>());
            }

            targetMap.get(i).add(i);
        }
        b2.end();

        b2.report();

    }
}
