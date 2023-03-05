//sfdx force:apex:test:run --tests "CompareIdExtract.compare"
@IsTest
public class CompareIdExtract {
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

        List<Account> accounts = [SELECT Id FROM Account]; // 5000

        // First operation to compare: loop and get
        b.startReferenceBenchmark();
        for (Integer i = 0; i < loops; i++) {
            Set<Id> ids = new Set<Id>();
            for (Account acc : accounts) {
                ids.add(acc.Id);
            }
        }
        b.endReferenceBenchmark();

        // Second operation to compare: transform to map and keySet
        b.startTargetBenchmark();
        for (Integer i = 0; i < loops; i++) {
            Set<Id> ids = new Map<Id, Account>(accounts).keySet();
        }
        b.endTargetBenchmark();

        b.reportResults(loops);
    }
}
