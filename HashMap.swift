struct HashMap<K: Hashable, V> : CustomStringConvertible {
	let size: Int
	var keys: [K?],
	    vals: [V?],
	    collisions = LinearMap<K, V>(),
	    numberCollisions = 0,
	    count = 0

	init(size: Int = 100) {
		self.size = size
		keys = [K?](repeating: nil, count: self.size)
		vals = [V?](repeating: nil, count: self.size)
	}

	func getNumberCollisions() -> Int {
		return numberCollisions
	}

	// get must be mutating because numberCollisions is incremented when a collision is read
	mutating func get(_ key: K) -> V? {
		let index = abs(key.hashValue) % size

		// Have key in keys[]
		if let stored_key = keys[index] {
			// Not a collision
			if stored_key == key {
				return vals[index]
			}

			// Is a collision
			else {
				numberCollisions += 1
				return collisions[key]
			}
		}

		// Key not int keys[]
		return nil
	}

	mutating func set(_ key: K, _ val: V) {
		let index = abs(key.hashValue) % size

		// Have key in keys[]
		if let stored_key = keys[index] {
			// Not a collision
			if stored_key == key {
				vals[index] = val
				return
			}

			// Is a collision
			else {
				// If key not in collisions yet
				if collisions[key] == nil {
					count += 1
				}

				collisions[key] = val
				numberCollisions += 1
				return
			}
		}

		// Key not in keys[]
		else {
			keys[index] = key
			vals[index] = val
			count += 1
		}
	}

	subscript(key: K) -> V? {
		mutating get {
			return self.get(key)
		}

		set(val) {
			self.set(key, val!)
		}
	}

	var description: String {
		var desc = "HashMap[\n"

		// Elements stored via hash
		for i in 0 ..< keys.count where keys[i] != nil {
			desc += "\t\(keys[i]!) : \(vals[i]!)\n"
		}

		// Elements stored in LinearMap (collisions)
		for i in 0 ..< collisions.count {
			desc += "\t\(collisions.keys[i]) : \(collisions.vals[i])\n"
		}

		return desc + "]"
	}
}
