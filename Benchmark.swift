import Foundation

func getCurrentMillis() -> Int64 {
	return Int64(NSDate().timeIntervalSince1970 * 1000)
}

func getRandomInt(range: Int) -> Int {
	#if os(macOS)
		return Int(arc4random_uniform(UInt32(range)))
	#elseif os(Linux)
		return Int(rand()) % range
	#endif
}

class BaseBenchmark {
	var startTimeMillis: Int64 = 0,
	    endTimeMillis: Int64 = 0

	var elapsedMillis: Int {
		return Int(endTimeMillis - startTimeMillis)
	}

	func startTimer() {
		startTimeMillis = getCurrentMillis()
	}

	func stopTimer() {
		endTimeMillis = getCurrentMillis()
	}
}
