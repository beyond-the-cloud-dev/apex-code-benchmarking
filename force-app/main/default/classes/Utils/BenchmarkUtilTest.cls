public class BenchmarkUtilTest {
    private Integer startCpuTime;
    private Integer endCpuTime;
    private Integer startHeapSize;
    private Integer endHeapSize;

    public void start() {
        startCpuTime = Limits.getCpuTime();
        startHeapSize = Limits.getHeapSize();
    }

    public void end() {
        endCpuTime = Limits.getCpuTime();
        endHeapSize = Limits.getHeapSize();
    }

    public void report() {
        System.debug(LoggingLevel.Error,
            '\n' + reportCpuTime() +
            '\n' + reportHeapSize()
        );
    }

    public String reportCpuTime() {
        Integer duration = endCpuTime - startCpuTime;
        return 'CPU Duration [ms]: ' + duration;
    }

    public String reportHeapSize() {
        Integer usedHeapSize = (endHeapSize - startHeapSize) / 1024; //KB
        return 'Used Heap Size [KB]: ' + usedHeapSize;
    }

    public static void report(List<BenchmarkUtilTest> benchmarks) {
        for (BenchmarkUtilTest benchmark : benchmarks) {
            benchmark.report();
        }
    }
}
