import Foundation

#if os(Linux)
	srandom(UInt32(time(nil)))
#endif
