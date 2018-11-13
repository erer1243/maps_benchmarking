import Foundation

class LinearBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "LinearBenchmark", getsPerTest: 1000, setsPerTest: 1000)
	}

	override func runSingleTest() {
		var map = LinearMap<String, String>()
		let data = getRandomStringArray(size: 1000, stringSize: 8)

		// Set test
		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		recordSet()

		// Get test
		startTimer()
		for s in data {
			_ = map[s]
		}
		stopTimer()
		recordGet()
	}
}

class BinaryBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "BinaryBenchmark", getsPerTest: 1000, setsPerTest: 100)
	}

	override func runSingleTest() {
		var map = BinaryMap<String, String>()
		let data = getRandomStringArray(size: 100, stringSize: 8)

		// Set test
		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		recordSet()

		// Get test
		startTimer()
		for _ in 0..<10 {
			for s in data {
				_ = map[s]
			}
		}
		stopTimer()
		recordGet()
	}
}

class HashBenchmark : BaseBenchmark {
	override func runSingleTest() {

	}
}
