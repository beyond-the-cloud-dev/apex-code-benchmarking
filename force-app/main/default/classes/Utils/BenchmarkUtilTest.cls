@IsTest
public class BenchmarkUtilTest {
    private Map<Integer, Benchmark> idToBenachmark = new Map<Integer, Benchmark>();

    public void start(Integer id) {
        idToBenachmark.put(id, new Benchmark(id));
    }

    public void end(Integer id) {
        idToBenachmark.get(id).end();
    }

    public void reportAllResults() {
        for (Integer id : idToBenachmark.keySet()) {
            idToBenachmark.get(id).report();
        }
    }

    public void reportResults(Integer id) {
        idToBenachmark.get(id).report();
    }

    private class Benchmark {
        private Integer id;
        private Integer startCpuTime;
        private Integer endCpuTime;
        private Integer startHeapSize;
        private Integer endHeapSize;

        public Benchmark(Integer benchmarkId) {
            id = benchmarkId;
            start();
        }

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
                '\nBenchmark Id: ' + id +
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
    }
}
