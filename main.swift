import Foundation

#if os(Linux)
	srandom(UInt32(time(nil)))
#endif

var lb = LinearBenchmark()
lb.runTests(count: 1)
