struct BinaryMap<K: Comparable, V> : CustomStringConvertible {
	var keys = [K](),
	    vals = [V](),
	    count = 0

	func get(_ key: K) -> V? {
		if let i = binarySearch(elements: keys, target: key) {
			return vals[i]
		} else {
			return nil
		}
	}

	mutating func set(_ key: K, _ val: V) {
		if let i = binarySearch(elements: keys, target: key) {
			vals[i] = val
		} else {
			insert(key, val)
			count += 1
		}
	}

	private mutating func insert(_ key: K, _ val: V) {
		switch (count) {
		case 0:
			keys.append(key)
			vals.append(val)
			return

		case 1:
			if key > keys[0] {
				keys.append(key)
				vals.append(val)
			} else {
				keys.insert(key, at: 0)
				vals.insert(val, at: 0)
			}
			return

		// 2+ elements
		default:
			// Key should be first
			if key < keys[0] {
				keys.insert(key, at: 0)
				vals.insert(val, at: 0)
				return
			}

			// Key should be somewhere in the middle
			for i in 1 ..< count {
				if key > keys[i-1] && key < keys[i] {
					keys.insert(key, at: i)
					vals.insert(val, at: i)
					return
				}
			}

			// Key should be last
			keys.append(key)
			vals.append(val)
		}
	}

	mutating func remove(_ key: K) {
		if let i = binarySearch(elements: keys, target: key) {
			keys.remove(at: i)
			vals.remove(at: i)
			count -= 1
		}
	}

	subscript(key: K) -> V? {
		get {
			return self.get(key)
		}

		set(val) {
			self.set(key, val!)
		}
	}

	var description: String {
		var desc = "BinaryMap[\n"

		for i in 0 ..< count {
			desc += "  \(keys[i]) : \(vals[i])\n"
		}

		return desc + "]"
	}
}
