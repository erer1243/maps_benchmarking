import Foundation

func getCurrentMillis() -> Int64 {
	return Int64(NSDate().timeIntervalSince1970 * 1000)
}

class Benchmark {
	var startTimeMillis: Int64 = 0
	var endTimeMillis: Int64 = 0

}
