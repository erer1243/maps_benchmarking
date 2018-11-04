// Sourced from https://en.wikipedia.org/wiki/Binary_search_algorithm
func binarySearch<K: Comparable>(elements: [K], target: K) -> Int? {
	switch (elements.count) {
	case 0:
		return nil
	case 1:
		return (elements[0] == target) ? 0 : nil
	default:
		break
	}

	var lower_bound = 0,
	    upper_bound = elements.count - 1

	while (lower_bound <= upper_bound) {
		let middle = Int((lower_bound + upper_bound) / 2)

		if elements[middle] < target {
			lower_bound = middle + 1
		} else if elements[middle] > target {
			upper_bound = middle - 1
		} else {
			return middle
		}
	}

	return nil
}
