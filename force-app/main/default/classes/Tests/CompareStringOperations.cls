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

        b.start(0);
        String reference = '';
        for (String value : referenceValues) {
            reference += value + ',';
        }
        b.end(0);

        b.start(1);
        String target = String.join(referenceValues, ',');
        b.end(1);

        b.reportAllResults();
    }
}
