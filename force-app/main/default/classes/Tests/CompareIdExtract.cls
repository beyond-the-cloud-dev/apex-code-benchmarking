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

        b.start(0);
        for (Integer i = 0; i < loops; i++) {
            Set<Id> ids = new Set<Id>();
            for (Account acc : accounts) {
                ids.add(acc.Id);
            }
        }
        b.end(0);

        b.start(1);
        for (Integer i = 0; i < loops; i++) {
            Set<Id> ids = new Map<Id, Account>(accounts).keySet();
        }
        b.end(1);

        b.reportAllResults();
    }
}
