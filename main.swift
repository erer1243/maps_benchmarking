import Foundation

#if os(Linux)
	srandom(UInt32(time(nil)))
#endif

var lb = LinearBenchmark()
lb.runTests(count: 20)

var bb = BinaryBenchmark()
bb.runTests(count: 20)

var hb = HashBenchmark()
hb.runTests(count: 20)
