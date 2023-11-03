//sfdx force:apex:test:run --tests "SizeSoqlFor.compare"
@IsTest
public class SizeSoqlFor {
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
        List<Account> accs = [SELECT Name FROM Account];
        Integer max = accs.size();
        for (Integer i = 0; i < max; i++) {
            System.debug(accs[i].Name);
        }
        b.end();

        b.report();
    }
}
