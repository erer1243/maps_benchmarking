struct LinearMap<K: Hashable, V> : CustomStringConvertible {
	var keys = [K](),
	    vals = [V](),
	    count = 0

	private func findKeyIndex(_ key: K) -> Int? {
		for i in 0 ..< count {
			if keys[i] == key {
				return i
			}
		}

		return nil
	}

	func get(_ key: K) -> V? {
		if let i = findKeyIndex(key) {
			return vals[i]
		} else {
			return nil
		}
	}

	mutating func set(_ key: K, _ val: V) {
		if let i = findKeyIndex(key) {
			vals[i] = val
		} else {
			keys.append(key)
			vals.append(val)
			count += 1
		}
	}

	mutating func remove(_ key: K) {
		if let i = findKeyIndex(key) {
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
		var desc = "LinearMap[\n"

		for i in 0 ..< count {
			desc += "  \(keys[i]) : \(vals[i])\n"
		}

		return desc + "]"
	}
}
