@IsTest
public class CompareIdExtract {
  @IsTest
  static void compare() {
    Integer loops = 100000;
    BenchmarkUtilTest b = new BenchmarkUtilTest();

    List<Account> accounts = [SELECT Id FROM Account LIMIT 500];

    // First operation to compare: loop and get
    b.markReferenceStartTime();
    for (Integer i = 0; i < loops; i++) {
      Set<Id> ids = new Set<Id>();
      for (Account acc : accounts) {
        ids.add(acc.Id);
      }
    }
    b.markReferenceEndTime();

    // Second operation to compare: transform to map and keySet
    b.markTargetStartTime();
    for (Integer i = 0; i < loops; i++) {
      Set<Id> ids = new Map<Id, Account>(accounts).keySet();
    }
    b.markTargetEndTime();

    // Debug the results
    b.reportResults(loops);
  }
}
