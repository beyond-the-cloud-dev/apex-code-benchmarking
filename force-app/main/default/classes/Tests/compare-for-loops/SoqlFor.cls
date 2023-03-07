//sfdx force:apex:test:run --tests "SoqlFor.compare"
@IsTest
public class SoqlFor {
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
            for (Account acc : [SELECT Name FROM Account]) {
                System.debug(acc.Name);
            }
        b.end();

        b.report();
    }
}
