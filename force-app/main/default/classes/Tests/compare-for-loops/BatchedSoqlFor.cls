//sfdx force:apex:test:run --tests "BatchedSoqlFor.compare"
@IsTest
public class BatchedSoqlFor {
    @TestSetup
    static void makeData() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10000; i++) {
            accounts.add(new Account(Name = 'Test ' + i));
        }
        insert accounts;
    }

    @IsTest
    static void compare() {
        BenchmarkUtilTest b = new BenchmarkUtilTest();

        b.start();
        for (List<Account> accs : [SELECT Name FROM Account]) {
            for (Account acc : accs) {
                System.debug(acc.Name);
            }
        }
        b.end();

        b.report();
    }
}
