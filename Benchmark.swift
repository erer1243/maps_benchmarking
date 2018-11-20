import Foundation

/*	LinearMap doesn't have a best/worst case.
	- To prove it, run empty and with pre-filled maps
*/
class EmptyLinearBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "Empty LinearMap benchmark")
	}

	override func runSingleTest(data: [String]) -> (Int, Int) {
		var map = LinearMap<String, String>()

		// Insert new data
		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		let setTime = elapsedMillis

		startTimer()
		for s in data {
			_ = map[s]
		}
		stopTimer()
		let getTime = elapsedMillis

		return (getTime: getTime, setTime: setTime)
	}
}

class PreFilledLinearBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "Prefilled LinearMap benchmark")
	}

	override func runSingleTest(data: [String]) -> (Int, Int) {
		var map = LinearMap<String, String>()

		// Prefill map with data
		for s in data {
			map[s] = ""
		}

		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		let setTime = elapsedMillis

		startTimer()
		for s in data {
			_ = map[s]
		}
		stopTimer()
		let getTime = elapsedMillis

		return (getTime: getTime, setTime: setTime)
	}
}

/*	Best case for BinaryMap:
	- Few inserts
	- Many sets to keys that already exist

	Get shouldn't change
	- To prove it, run prefilled/not like LinearMap
*/
class PreFilledBinaryBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "Pre filled BinaryMap benchmark (best case)")
	}

	override func runSingleTest(data: [String]) -> (Int, Int) {
		var map = BinaryMap<String, String>()

		// Prefill map with data so insert isn't happening
		for s in data {
			map[s] = ""
		}

		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		let setTime = elapsedMillis

		startTimer()
		for s in data {
			_ = map[s]
		}
		stopTimer()
		let getTime = elapsedMillis

		return (getTime: getTime, setTime: setTime)
	}
}

/*	Worst case for BinaryMap:
	- Many inserts
	- Few sets to keys that already exist
*/
class EmptyBinaryBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "Empty BinaryMap benchmark (worst case)")
	}

	override func runSingleTest(data: [String]) -> (Int, Int) {
		var map = BinaryMap<String, String>()

		// Insert lots of new data
		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		let setTime = elapsedMillis

		// Run get again to prove it doesn't change
		startTimer()
		for s in data {
			_ = map[s]
		}
		stopTimer()
		let getTime = elapsedMillis

		return (getTime: getTime, setTime: setTime)
	}
}

/*	Best case for HashMap:
	- Large internal array, few operations using the LinearMap
*/
class LargeArrayHashBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "Large internal array HashMap benchmark (best case)")
	}

	override func runSingleTest(data: [String]) -> (Int, Int) {
		// Internal array size 2x as large as data set
		var map = HashMap<String, String>(size: data.count * 2)

		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		let setTime = elapsedMillis

		startTimer()
		for s in data {
			_ = map[s]
		}
		stopTimer()
		let getTime = elapsedMillis

		return (getTime: getTime, setTime: setTime)
	}
}

/*	Worst case for HashMap:
	- Small internal array, many operations using the LinearMap
*/
class SmallArrayHashBenchmark : BaseBenchmark {
	init() {
		super.init(benchmarkName: "Small internal array HashMap benchmark (worst case)")
	}

	override func runSingleTest(data: [String]) -> (Int, Int) {
		// Internal array 0.5 x as large as data set
		var map = HashMap<String, String>(size: Int(data.count/2))

		startTimer()
		for s in data {
			map[s] = s
		}
		stopTimer()
		let setTime = elapsedMillis

		startTimer()
		for s in data {
			_ = map[s]
		}
		stopTimer()
		let getTime = elapsedMillis

		return (getTime: getTime, setTime: setTime)
	}
}
