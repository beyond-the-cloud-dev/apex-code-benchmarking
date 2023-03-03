@IsTest
public class CompareFieldExtract {
  @TestSetup
  static void makeData() {
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < 5000; i++) {
      accounts.add(new Account(Name = 'Test ' + i));
    }
    insert accounts;
  }

  @IsTest
  static void compare() {
    Integer loops = 100;
    BenchmarkUtilTest b = new BenchmarkUtilTest();

    List<Account> accounts = [SELECT Id, Name FROM Account];

    // First operation to compare: loop and get
    b.markReferenceStartTime();
    for (Integer i = 0; i < loops; i++) {
      Set<String> names = new Set<String>();
      for (Account acc : accounts) {
        names.add(acc.Name);
      }
    }
    b.markReferenceEndTime();

    // Second operation to compare: transform to map and keySet
    List<AggregateResult> aggregate = [SELECT Name Id FROM Account GROUP BY Name];
    b.markTargetStartTime();
    for (Integer i = 0; i < loops; i++) {
      Set<String> names = new Map<String, SObject>(aggregate).keySet();
    }
    b.markTargetEndTime();

    // Debug the results
    b.reportResults(loops);
  }
}
