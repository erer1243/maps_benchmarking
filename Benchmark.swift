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

/*
  Ideas:
    * run many tests and take average
    * different test for each map depending on proper use case
*/

class BaseBenchmark {
	var startTimeMillis: Int64 = 0,
	    endTimeMillis: Int64 = 0,
	    allResults: [Int] = []
	
	let testSize = 1000
	var keys: [String]

	var elapsedMillis: Int {
		return Int(endTimeMillis - startTimeMillis)
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

    func getAverageMillis() -> Int {
        return allResults.reduce(0) {acc, i in acc + i} / allResults.count
    }

	/* virtual */ func doTest() {}
	/* virtual */ func printResults() {}
}

class LinearBenchmark : BaseBenchmark {
	override func doTest() {
		var linearMap = LinearMap<String, Int>()
		
		for key in keys {
			linearMap[key] = getRandomInt(range: 1000)
		}
	}
}

class BinaryBenchmark : BaseBenchmark {

}

class HashBenchmark : BaseBenchmark {

}
