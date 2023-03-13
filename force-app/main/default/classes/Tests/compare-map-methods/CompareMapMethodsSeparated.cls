@IsTest
public class CompareMapMethodsSeparated {

    @IsTest
    static void compareContainsKey() {
        Integer loops = 100000;

        BenchmarkUtilTest containsKeyBenchmark = new BenchmarkUtilTest();

        Map<Integer, List<Integer>> referenceMap = new Map<Integer, List<Integer>>();

        containsKeyBenchmark.start();
        for (Integer i = 0; i < loops; i++) {
            if (!referenceMap.containsKey(i)) {
                referenceMap.put(i, new List<Integer>());
            }

            referenceMap.get(i).add(i);
        }
        containsKeyBenchmark.end();

        containsKeyBenchmark.report();
    }

    @IsTest
    static void compareGet() {
        Integer loops = 100000;

        BenchmarkUtilTest getBenchmark = new BenchmarkUtilTest();

        Map<Integer, List<Integer>> referenceMap = new Map<Integer, List<Integer>>();

        getBenchmark.start();
        for (Integer i = 0; i < loops; i++) {
            if (referenceMap.get(i) == null) {
                referenceMap.put(i, new List<Integer>());
            }

            referenceMap.get(i).add(i);
        }
        getBenchmark.end();

        getBenchmark.report();
    }
}
