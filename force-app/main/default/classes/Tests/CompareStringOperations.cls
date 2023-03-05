//sfdx force:apex:test:run --tests "CompareStringOperations.compare"
@IsTest
public class CompareStringOperations {
    @IsTest
    static void compare() {
        BenchmarkUtilTest b = new BenchmarkUtilTest();

        List<String> referenceValues = new List<String>();
        for (Integer i = 0; i < 10000; i++) {
            referenceValues.add(String.valueOf(i));
        }

        // First operation to compare: String +=
        b.startReferenceBenchmark();
        String reference = '';
        for (String value : referenceValues) {
            reference += value + ',';
        }
        b.endReferenceBenchmark();

        // Second operation to compare: String.join
        b.startTargetBenchmark();
        String target = String.join(referenceValues, ',');
        b.endReferenceBenchmark();

        b.reportResults(1);
    }
}
