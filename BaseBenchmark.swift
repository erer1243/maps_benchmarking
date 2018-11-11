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
func getRandomString(size: Int) -> String {
	let chars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
	var result = ""
	for _ in 0..<size {
		let char = chars[getRandomInt(range: chars.count)]
		result += String(char)
	}
	return result
}

func getRandomStringArray(size: Int, stringSize: Int) -> [String] {
	return [String](repeating: "", count: size)
		.map{ _ in getRandomString(size: stringSize) }
}

class BaseBenchmark {
	var startTimeMillis: Int64 = 0,
	    endTimeMillis: Int64 = 0,
	    allResults: [Int] = []

	var averageMillis: Double {
		return Double(allResults.reduce(0, {$0 + $1})) / Double(allResults.count)
	}

	var testCount: Int {
		return allResults.count
	}

	var resultString: String {
		return """
		Test results:
			Number of tests run:   \(testCount)
			Average time (millis): \(averageMillis)
		"""
	}

	func startTimer() {
		startTimeMillis = getCurrentMillis()
	}

	func stopTimer() {
		endTimeMillis = getCurrentMillis()
		allResults.append(Int(endTimeMillis - startTimeMillis))
	}

	func runTests(count: Int) {
		for _ in 0..<count {
			runSingleTest()
		}
	}

	/* virtual */ func runSingleTest() {}
}
