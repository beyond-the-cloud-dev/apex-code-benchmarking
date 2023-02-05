# apex-code-benchmarking

This repo contains util class for benchmarking apex performance. It is based on the (Advanced Apex Programming)[https://advancedapex.com/] book written by Dan Appleman. 



## How to use
1. Deploy (BenchmarkUtilTest)[force-app\main\default\classes\Utils\BenchmarkUtilTest.cls] class to your org.
2. Set Debug Log Level and Trace flag as following:

| Log Category   | Log Level     |
| -------------- | ------------- |
| Apex Code      | ERROR         |
| Apex Profiling | NONE          |
| Callout        | NONE          |
| Database       | NONE          |
| System         | NONE          |
| Validation     | NONE          |
| Visualforce    | NONE          |
| Workflow       | NONE          |

3. Write a test checking performance of your operation:

```java
    //get instance of BenchmarkUtil
    BenchmarkUtilTest b = new BenchmarkUtilTest();

    //set the number of loops (how many times the operation will be repeated)
    //the more loops the more accurate the result
    Integer loops = 1000000;

    //set reference operation, If you want to compare the performance of two operations 
    b.markReferenceStartTime();
    for(Integer i = 0; i < loops; i++) {
        //your reference operation
        //if you want just to measure the performance of one operation, leave this loop empty.
        //(do not remove it, to get more accurate results) 
    }
    b.markReferenceEndTime();

    // target operation, or second operation to compare
    b.markTargetStartTime();
    for(Integer i=0; i< loops; i++) {
        //your target operation
    }
    b.markTargetEndTime();

    // Debug the results
    b.reportResults(loops);

```

4. Run the test and check the debug log for the results

```
USER_DEBUG [36]|ERROR|Reference Duration: 574 Target duration: 600 Benchmark Results: 26ms or 0.026 μs per operation 
```

## Examples
Check the (CompareIncrementation)[force-app\main\default\classes\Tests\CompareIncrementation.cls] class for example of comparing performance of incrementation operations.