SWIFT := swift
SWIFTFLAGS := build
EXEC := benchmark

build: .build/debug/$(EXEC)

.build/debug/$(EXEC): main.swift BinaryMap.swift binarySearch.swift HashMap.swift LinearMap.swift Benchmark.swift
	$(SWIFT) $(SWIFTFLAGS)

test: build
	.build/debug/$(EXEC)

clean:
	rm -rf .build
