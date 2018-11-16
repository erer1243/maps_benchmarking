import Foundation

#if os(Linux)
	srandom(UInt32(time(nil)))
#endif

let testCount = 10

EmptyLinearBenchmark().runTests(count: testCount)
PreFilledLinearBenchmark().runTests(count: testCount)
print("###############\n")

PreFilledBinaryBenchmark().runTests(count: testCount)
EmptyBinaryBenchmark().runTests(count: testCount)
print("###############\n")

LargeArrayHashBenchmark().runTests(count: testCount)
SmallArrayHashBenchmark().runTests(count: testCount)
print("###############\n")
