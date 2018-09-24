import Foundation

public class TestTypeTwo: NSObject, Codable {
    public var a: String?
    public var b: String?
    public var c: String?
    public var d: String?
    public var e: String?
    public var f: String?
    public var g: String?
    public var h: String?
    public var i: String?
    public var j: Int?
    public var k: Int?
    public var l: [String: String]?
    public var m: String?
    public var n: Double?
    public var o: String?
    public var isK: Bool {
        get {
            guard let k = k else {
                return false
            }
            return NSNumber(value: k).boolValue
        }
    }
    public var isJ: Bool {
        get {
            guard let j = j else {
                return false
            }
            return NSNumber(value: j).boolValue
        }
        set(newState) {
            j = newState ? 1 : 0
        }
    }
}
