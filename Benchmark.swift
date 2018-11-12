import Foundation

/*
linear test pseudo code
map = new linearmap()
test sets:
	startTimer
	for x in randomdata {
		map[x] = x
	}
	stopTimer
	append data to setResults

test gets:
	startTimer
	for _ in randomdata {

	}
	stopTimer
	append data to getResults
*/

/*
	getResults = how long [operationsPerTest] get operations took in ms
*/

class LinearBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "LinearBenchmark", operationsPerTest: 1000)
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
	override func runSingleTest() {

	}
}

class HashBenchmark : BaseBenchmark {
	override func runSingleTest() {

	}
}
