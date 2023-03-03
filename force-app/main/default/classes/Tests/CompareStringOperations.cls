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
      b.markReferenceStartTime();
      String reference = '';
      for (String value : referenceValues) {
        reference += value + ',';
      }
      b.markReferenceEndTime();

      // Second operation to compare: String.join
      b.markTargetStartTime();
      String target = String.join(referenceValues, ',');
      b.markTargetEndTime();

      // Debug the results
      b.reportResults(1);
    }
}
