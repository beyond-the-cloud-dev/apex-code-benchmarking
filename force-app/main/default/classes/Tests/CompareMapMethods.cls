@IsTest
public class CompareMapMethods {
  @IsTest
  static void compare() {
    Integer loops = 1000000;
    BenchmarkUtilTest b = new BenchmarkUtilTest();

    Map<Integer, List<Integer>> referenceMap = new Map<Integer, List<Integer>>();

    // First operation to compare: Map.containsKey
    b.markReferenceStartTime();
    for (Integer i = 0; i < loops; i++) {
      if (!referenceMap.containsKey(i)) {
        referenceMap.put(i, new List<Integer>());
      }

      referenceMap.get(i).add(i);
    }
    b.markReferenceEndTime();

    // Second operation to compare: Map.get
    b.markTargetStartTime();
    for (Integer i = 0; i < loops; i++) {
      if (referenceMap.get(i) == null) {
        referenceMap.put(i, new List<Integer>());
      }

      referenceMap.get(i).add(i);
    }
    b.markTargetEndTime();

    // Debug the results
    b.reportResults(loops);
  }
}
