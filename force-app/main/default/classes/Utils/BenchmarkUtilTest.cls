@IsTest
public class BenchmarkUtilTest {
    private Integer referenceStartTime;
    private Integer referenceEndTime;
    private Integer targetStartTime;
    private Integer targetEndTime;

    private Integer referenceStartHeapSize;
    private Integer referenceEndHeapSize;
    private Integer targetStartHeapSize;
    private Integer targetEndHeapSize;

    public void startReferenceBenchmark() {
        markReferenceStartTime();
        markReferenceStartHeapSize();
    }

    public void endReferenceBenchmark() {
        markReferenceEndTime();
        markReferenceEndHeapSize();
    }

    public void startTargetBenchmark() {
        markTargetStartTime();
        markTargetStartHeapSize();
    }

    public void endTargetBenchmark() {
        markTargetEndTime();
        markTargetEndHeapSize();
    }

    public void markReferenceStartTime() {
        referenceStartTime = Limits.getCpuTime();
    }

    public void markReferenceEndTime() {
        referenceEndTime = Limits.getCpuTime();
    }

    public void markReferenceStartHeapSize() {
        referenceStartHeapSize = Limits.getHeapSize();
    }

    public void markReferenceEndHeapSize() {
        referenceEndHeapSize = Limits.getHeapSize();
    }

    public void markTargetStartTime() {
        targetStartTime = Limits.getCpuTime();
    }

    public void markTargetEndTime() {
        targetEndTime = Limits.getCpuTime();
    }

    public void markTargetStartHeapSize() {
        targetStartHeapSize = Limits.getHeapSize();
    }

    public void markTargetEndHeapSize() {
        targetEndHeapSize = Limits.getHeapSize();
    }

    public void reportResults(Integer loops) {
        reportCpuTimeResults(loops);
        reportCpuHeapSizeResults(loops);
    }

    private void reportCpuTimeResults(Integer loops) {
        if (targetEndTime == null) {
            this.markTargetEndTime();
        }

        Integer referenceDuration = referenceEndTime - referenceStartTime;
        Integer targetDuration = targetEndTime - targetStartTime;
        Integer benchmarkResults = targetDuration - referenceDuration;

        Decimal singleOperationInMicroseconds = benchmarkResults * 1000;
        singleOperationInMicroseconds /= loops;
        singleOperationInMicroseconds.setScale(2);

        Map<String, Object> log = new Map<String, Object>{
            'Single Operation [ms]:' => singleOperationInMicroseconds,
            'Benchmark Results [ms]: ' => benchmarkResults,
            'Target duration [ms]: ' => targetDuration,
            'Reference Duration [ms]: ' => referenceDuration
        };

        System.debug(LoggingLevel.Error, '------ CPU Time ------ \n' + JSON.serializePretty(log));
    }

    private void reportCpuHeapSizeResults(Integer loops) {
        if (targetEndHeapSize == null) {
            this.markTargetEndHeapSize();
        }

        Integer referenceHeapSize = (referenceEndHeapSize - referenceStartHeapSize) / 1024; //KB;
        Integer targetHeapSize = (targetEndHeapSize - targetStartHeapSize) / 1024; //KB
        Integer benchmarkResults = targetHeapSize - referenceHeapSize; //KB

        Decimal singleOperationInKilobytes = benchmarkResults;
        singleOperationInKilobytes /= loops;
        singleOperationInKilobytes.setScale(2);

        Map<String, Object> log = new Map<String, Object>{
            'Single Operation [kB]:' => singleOperationInKilobytes,
            'Benchmark Results [kB]: ' => benchmarkResults,
            'Target Heap Size [kB]: ' => targetHeapSize,
            'Reference Heap Size [kB]: ' => referenceHeapSize
        };

        System.debug(LoggingLevel.Error, '------ CPU Heap Size ------ \n' + JSON.serializePretty(log));
    }
}
