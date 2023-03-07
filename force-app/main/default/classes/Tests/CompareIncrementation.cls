@IsTest
public class CompareIncrementation {
  /**
   * This test compares the performance of two incrementation methods.
   * The first method uses the ++ operator, the second method uses the standard + operator.
   */
  @IsTest
  static void compareTwoIncrementationMethods() {
    Integer x = 0;
    Integer y = 0;
    Integer loops = 1000000;
    BenchmarkUtilTest b = new BenchmarkUtilTest();

    // First operation to compare: ++ incrementation
    b.start(0);
    for (Integer i = 0; i < loops; i++) {
      x++;
    }
    b.end(0);

    // Second operation to compare: + incrementation
    b.start(1);
    for (Integer i = 0; i < loops; i++) {
      y = y + 1;
    }
    b.end(1);

    // Debug the results
    b.reportAllResults();
  }
}
