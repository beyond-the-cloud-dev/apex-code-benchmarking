//sfdx force:apex:test:run --tests "MapContainsKeyBenchmark.compare"
@IsTest
public class MapContainsKeyBenchmark {
    @IsTest
    static void compare() {
        Integer loops = 100000;

        BenchmarkUtilTest b = new BenchmarkUtilTest();

        Map<Integer, List<Integer>> referenceMap = new Map<Integer, List<Integer>>();

        b.start();
        for (Integer i = 0; i < loops; i++) {
            if (!referenceMap.containsKey(i)) {
                referenceMap.put(i, new List<Integer>());
            }

            referenceMap.get(i).add(i);
        }
        b.end();

        b.report();
    }
}
