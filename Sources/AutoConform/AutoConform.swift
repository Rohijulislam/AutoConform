
import Foundation

// MARK: - CustomAutoEquatable

// Custom Equatable protocol
public protocol CustomAutoEquatable: Equatable {
    var equatableProperties: [any Equatable] { get }
}

extension CustomAutoEquatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    fileprivate func isEqual(to other: Self) -> Bool {
        guard equatableProperties.count == other.equatableProperties.count else {
            return false
        }
        
        return zip(equatableProperties, other.equatableProperties).allSatisfy { lhs, rhs in
            guard let lhsValue = lhs as? AnyHashable,
                  let rhsValue = rhs as? AnyHashable else {
                return false
            }
            return lhsValue == rhsValue
        }
    }
}

// MARK: - CustomAutoHashable

// Custom Hashable protocol
public protocol CustomAutoHashable: Hashable {
    var hashableProperties: [AnyHashable] { get }
}

extension CustomAutoHashable {
    public func hash(into hasher: inout Hasher) {
        hashableProperties.forEach { hasher.combine($0) }
    }
}

// MARK: - CustomAutoComparable

// Custom Comparable protocol
public protocol CustomAutoComparable: Comparable, CustomAutoEquatable {
    var comparableProperties: [any Comparable] { get }
}

extension CustomAutoComparable {
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return rhs.isSmaller(than: lhs)
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.isSmaller(than: rhs)
    }
    
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs) || rhs.isSmaller(than: lhs)
    }
    
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs) || lhs.isSmaller(than: rhs)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    public var equatableProperties: [any Equatable] {
        return self.comparableProperties
    }
}

// MARK: - Helper Extensions

extension CustomAutoComparable {
    private func isSmaller(than other: Self) -> Bool {
        var isSmaller = true
        for (lhs, rhs) in zip(comparableProperties, other.comparableProperties) {
            if let result = compareValues(lhs, rhs), result >= 0 {
                isSmaller = false
                break
            } else {
                // If we can't compare these properties, consider them equal and continue
                continue
            }
        }
        
        return isSmaller
    }
    
    private func compareValues(_ lhs: Any, _ rhs: Any) -> Int? {
        switch (lhs, rhs) {
        case let (l as Int, r as Int):
            return l.compare(r)
        case let (l as Double, r as Double):
            return l.compare(r)
        case let (l as Float, r as Float):
            return l.compare(r)
        case let (l as String, r as String):
            return l.compare(r).rawValue
        case let (l as Character, r as Character):
            return l.compare(r)
        default:
            return nil
        }
    }
}

extension Comparable {
    func compare(_ other: Self) -> Int {
        if self < other { return -1 }
        if self > other { return 1 }
        return 0
    }
}
