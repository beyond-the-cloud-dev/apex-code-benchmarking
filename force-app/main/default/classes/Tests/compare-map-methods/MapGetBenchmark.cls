//sfdx force:apex:test:run --tests "MapGetBenchmark.compare"
@IsTest
public class MapGetBenchmark {
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
    }
}
