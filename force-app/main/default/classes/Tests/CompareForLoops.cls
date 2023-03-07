//sfdx force:apex:test:run --tests "CompareForLoops.compare"
@IsTest
public class CompareForLoops {
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
        Integer loops = 3;
        BenchmarkUtilTest b = new BenchmarkUtilTest();

        b.start(0);
        for (Integer k = 0; k < loops; k++) {
            for (Account acc : [SELECT Name FROM Account]) {
                System.debug(acc.Name);
            }
        }
        b.end(0);

        b.start(1);
        for (Integer k = 0; k < loops; k++) {
            for (List<Account> accs : [SELECT Name FROM Account]) {
                for (Account acc : accs) {
                    System.debug(acc.Name);
                }
            }
        }
        b.end(1);

        b.start(2);
        for (Integer k = 0; k < loops; k++) {
            List<Account> accs = [SELECT Name FROM Account];
            Integer max = accs.size();
            for (Integer i = 0; i < max; i++) {
                System.debug(accs[i].Name);
            }
        }
        b.end(2);

        b.reportAllResults();
    }
}
