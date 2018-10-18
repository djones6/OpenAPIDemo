import Foundation
import TypeDecoder

// Types that perform validation as part of their init() and rely on DummyCodingKeyProvider
// (exposed from TypeDecoder) to make compatible

// A type with embedded types that require validation
public class ContainsValidations: NSObject, Codable {

    public var name: String?
    public var fruit: Fruit?
    public var person: YoungAdult?

    private enum CodingKeys: String, CodingKey {
        case name
        case fruit
        case person
    }
}

//
// Use DummyCodingValueProvider to supply a valid string while
// being decoded by TypeDecoder
//
public enum Fruit: String, Codable {
    case apple, banana, orange, pear
}

extension Fruit: ValidSingleCodingValueProvider {
    // Provide one of the cases as a dummy value
    public static func validCodingValue() -> Any? {
        return self.apple.rawValue
        //return "spanner"
    }
}

// A top-level type to contain a Fruit (single String value)
public struct FruitContainer: Codable {
    let fruit: Fruit
}


//
// Use DummyKeyedCodingValueProvider to supply a valid string while
// being decoded by TypeDecoder
//
public class YoungAdult: Codable {

    let name: String
    let age: Int

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.age = try container.decode(Int.self, forKey: CodingKeys.age)
        // Validate the value
        guard self.age >= 18, self.age <= 30 else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Age \(self.age) is outside the permitted range of 18-30"))
        }
    }
}

extension YoungAdult: ValidKeyedCodingValueProvider {
    // Provide a value for age while decoding that satisfies the validation criteria
    public static func validCodingValue(forKey key: CodingKey) -> Any? {
        switch key.stringValue {
        case self.CodingKeys.age.stringValue:
            return 20
            //return 12345
        default:
            return nil
        }
    }
}
