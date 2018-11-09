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

/*
  Ideas:
    * run many tests and take average
    * different test for each map depending on proper use case
*/

class BaseBenchmark {
	var startTimeMillis: Int64 = 0,
	    endTimeMillis: Int64 = 0,
	    allResults: [Int] = []

	var elapsedMillis: Int {
		return Int(endTimeMillis - startTimeMillis)
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

	}
}

class BinaryBenchmark : BaseBenchmark {

}

class HashBenchmark : BaseBenchmark {

}
