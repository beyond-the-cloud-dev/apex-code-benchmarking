//sfdx force:apex:test:run --tests "CompareMapMethods.compare"
@IsTest
public class CompareMapMethods {
    @IsTest
    static void compare() {
        Integer loops = 100000;
        BenchmarkUtilTest b = new BenchmarkUtilTest();

        Map<Integer, List<Integer>> referenceMap = new Map<Integer, List<Integer>>();

        // First operation to compare: Map.containsKey
        b.startReferenceBenchmark();
        for (Integer i = 0; i < loops; i++) {
            if (!referenceMap.containsKey(i)) {
                referenceMap.put(i, new List<Integer>());
            }

            referenceMap.get(i).add(i);
        }
        b.endReferenceBenchmark();

        // Second operation to compare: Map.get
        b.startTargetBenchmark();
        for (Integer i = 0; i < loops; i++) {
            if (referenceMap.get(i) == null) {
                referenceMap.put(i, new List<Integer>());
            }

            referenceMap.get(i).add(i);
        }
        b.endReferenceBenchmark();

        b.reportResults(loops);
    }
}
