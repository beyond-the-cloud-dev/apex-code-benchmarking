//sfdx force:apex:test:run --tests "CompareMapMethods.compare"
@IsTest
public class CompareMapMethods {
    @IsTest
    static void compare() {
        Integer loops = 100000;

        BenchmarkUtilTest getBenchmark = new BenchmarkUtilTest();

        Map<Integer, List<Integer>> getMap = new Map<Integer, List<Integer>>();

        getBenchmark.start();

        for (Integer i = 0; i < loops; i++) {
            if (getMap.get(i) == null) {
                getMap.put(i, new List<Integer>());
            }

            getMap.get(i).add(i);
        }
        getBenchmark.end();

        getBenchmark.report();

        BenchmarkUtilTest containsKeyBenchmark = new BenchmarkUtilTest();

        Map<Integer, List<Integer>> containsKeyMap = new Map<Integer, List<Integer>>();

        containsKeyBenchmark.start();

        for (Integer i = 0; i < loops; i++) {
            if (!containsKeyMap.containsKey(i)) {
                containsKeyMap.put(i, new List<Integer>());
            }

            containsKeyMap.get(i).add(i);
        }
        containsKeyBenchmark.end();

        containsKeyBenchmark.report();
    }
}
