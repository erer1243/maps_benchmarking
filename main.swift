import Foundation

#if os(Linux)
	srandom(UInt32(time(nil)))
#endif

let testCount = 3
let sizes = [500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000]

EmptyLinearBenchmark().runTests(count: testCount, dataSizes: sizes)
PreFilledLinearBenchmark().runTests(count: testCount, dataSizes: sizes)
print("###############\n")

PreFilledBinaryBenchmark().runTests(count: testCount, dataSizes: sizes)
EmptyBinaryBenchmark().runTests(count: testCount, dataSizes: sizes)
print("###############\n")

LargeArrayHashBenchmark().runTests(count: testCount, dataSizes: sizes)
SmallArrayHashBenchmark().runTests(count: testCount, dataSizes: sizes)
print("###############\n")
