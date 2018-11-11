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
	let chars = Array("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.")
	var result = ""
	for _ in 0..<size {
		let char = chars[getRandomInt(range: chars.count)]
		result += String(char)
	}
	return result
}

class BaseBenchmark {
	var startTimeMillis: Int64 = 0,
	    endTimeMillis: Int64 = 0,
	    allResults: [Int] = []

	let testSize = 1000
	var keys: [String]

	var elapsedMillis: Int {
		return Int(endTimeMillis - startTimeMillis)
	}

	var averageMillis: Double {
		return Double(allResults.reduce(0, {$0 + $1})) / Double(allResults.count)
	}

	init() {
		// Create keys at init to not affect test time
		keys = []
		for _ in 0..<testSize {keys.append(getRandomString(size: 10))}
	}

	func startTimer() {
		startTimeMillis = getCurrentMillis()
	}

	func stopTimer() {
		endTimeMillis = getCurrentMillis()
		allResults.append(elapsedMillis)
	}

	/* virtual */ func doTest() {}
	/* virtual */ func printResults() {}
}
