import Foundation

func getCurrentMillis() -> Int64 {
	return Int64(NSDate().timeIntervalSince1970 * 1000)
}

// Preprocessor trick from the internet
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
	    operationsPerTest: Int

	var startTimeMillis: Int64 = 0,
	    endTimeMillis: Int64 = 0,
	    results = Dictionary<Int, Array<(Int, Int)>>()

	var elapsedMillis: Int {
		return Int(endTimeMillis - startTimeMillis)
	}

	func averageMicrosFromMillis(dataSize: Int, data: [(getTime: Int, setTime: Int)]) -> (Double, Double) {
		let getTimes = data.map{ $0.getTime }, // Extract get times
		    setTimes = data.map{ $0.setTime } // Extract set times

		let averageGetMicros = getTimes.map{ (1000 * Double($0)) / Double(dataSize) } // Compute average per test
			.reduce(0.0, +) / Double(data.count) // Compute average of all tests

		let averageSetMicros = setTimes.map{ (1000 * Double($0)) / Double(dataSize) } // Compute average per test
			.reduce(0.0, +) / Double(data.count) // Compute average of all tests

		return (getMicros: averageGetMicros, setMicros: averageSetMicros)
	}

	init(benchmarkName: String, operationsPerTest: Int = 1000) {
		self.benchmarkName = benchmarkName
		self.operationsPerTest = operationsPerTest
	}

	func startTimer() {
		startTimeMillis = getCurrentMillis()
	}

	func stopTimer() {
		endTimeMillis = getCurrentMillis()
	}

	func runTests(count: Int, dataSizes: [Int]) {
		print("Running \(benchmarkName)")
		for size in dataSizes {
			results[size] = []
			for _ in 0..<count {
				results[size]!.append(runSingleTest(data: getRandomStringArray(size: size, stringSize: 8)))
			}
		}

		printResults()
	}

	func printResults() {
		let sortedResults = results.sorted(by: { $0.key < $1.key })

		print("\(benchmarkName) test results:")
		for res in sortedResults {
			let micros: (getMicros: Double, setMicros: Double) = averageMicrosFromMillis(dataSize: res.key, data: res.value)
			print("""
				dataSize \(res.key)
					get micros \(micros.getMicros)
					set micros \(micros.setMicros)
			""")
		}
	}

	/* It's up to runSingleTest to manage the timer, generate test data,
	return results, etc. */
	/* virtual */ func runSingleTest(data: [String]) -> (Int, Int) { return (-1, -1) }
}
