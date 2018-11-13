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
	let benchmarkName: String,
	    getsPerTest: Int,
	    setsPerTest: Int

	var startTimeMillis: Int64 = 0,
	    endTimeMillis: Int64 = 0,
	    getResults: [Int] = [],
	    setResults: [Int] = []

	var elapsedMillis: Int {
		return Int(endTimeMillis - startTimeMillis)
	}

	var averageGetTestMillis: Double {
		return Double(getResults.reduce(0, +)) / Double(getResults.count)
	}

	var averageSetTestMillis: Double {
		return Double(setResults.reduce(0, +)) / Double(setResults.count)
	}

	var numberTests: Int {
		return getResults.count
	}

	var resultString: String {
		return """
		\(benchmarkName) test results:
			Number tests run: \(numberTests)
			Number gets performed: \(numberTests * getsPerTest)
			Number sets performed: \(numberTests * setsPerTest)
			Average times (per test):
				get: \(averageGetTestMillis) ms
				set: \(averageSetTestMillis) ms
		"""
	}

	init(benchmarkName: String, getsPerTest: Int, setsPerTest: Int) {
		self.benchmarkName = benchmarkName
		self.getsPerTest = getsPerTest
		self.setsPerTest = setsPerTest
	}

	func startTimer() {
		startTimeMillis = getCurrentMillis()
	}

	func stopTimer() {
		endTimeMillis = getCurrentMillis()
	}

	func recordSet() {
		setResults.append(elapsedMillis)
	}

	func recordGet() {
		getResults.append(elapsedMillis)
	}

	func runTests(count: Int) {
		for _ in 0..<count {
			runSingleTest()
		}

		print(resultString)
	}

	/* It's up to runSingleTest to manage the timer, generate test data,
	enter results, etc. */
	/* virtual */ func runSingleTest() {}
}
