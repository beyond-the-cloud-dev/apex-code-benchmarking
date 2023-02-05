@IsTest
public with sharing class BenchmarkUtilTest {

    private static Integer referenceStartTime;
    private static Integer referenceEndTime;
    private static Integer targetStartTime;
    private static Integer targetEndTime;

    public void markReferenceStartTime() {
        referenceStartTime = Limits.getCpuTime();
    }

    public void markReferenceEndTime() {
        referenceEndTime = Limits.getCpuTime();
    }

    public void markTargetStartTime() {
        targetStartTime = Limits.getCpuTime();
    }

    public void markTargetEndTime() {
        targetEndTime = Limits.getCpuTime();
    }

    public void reportResults(Integer loops) {
        if(targetEndTime == null) {
            this.markTargetEndTime();
        }
        Integer referenceDuration = referenceEndTime - referenceStartTime;
        Integer targetDuration = targetEndTime - targetStartTime;
        Integer benchmarkResults = targetDuration - referenceDuration;

        Decimal singleOperationInMicroseconds = benchmarkResults * 1000;
        singleOperationInMicroseconds /= loops;
        singleOperationInMicroseconds.setScale(2);
        System.debug(LoggingLevel.Error,
                'Reference Duration: ' + referenceDuration +
                        ' Target duration: ' + targetDuration +
                        ' Benchmark Results: ' + benchmarkResults +
                        'ms or ' + singleOperationInMicroseconds + ' μs per operation');
    }
}