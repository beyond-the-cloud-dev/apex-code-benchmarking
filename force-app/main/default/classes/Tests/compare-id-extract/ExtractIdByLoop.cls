//sfdx force:apex:test:run --tests "ExtractIdByLoop.compare"
@IsTest
public class ExtractIdByLoop {
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

        b.start();
        for (Integer i = 0; i < loops; i++) {
            Set<Id> ids = new Set<Id>();
            for (Account acc : accounts) {
                ids.add(acc.Id);
            }
        }
        b.end();

        b.report();
    }
}
