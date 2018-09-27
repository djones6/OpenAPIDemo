import Foundation
import TypeDecoder

//
// Use DummyKeyedCodingValueProvider to supply a valid string while
// being decoded by TypeDecoder
//
public class ValidatedType: Codable, DummyKeyedCodingValueProvider {

    let value: String

    required public init(from: Decoder) throws {
        self.value = try from.container(keyedBy: CodingKeys.self).decode(String.self, forKey: CodingKeys.value)
        // Validate the value
        guard self.value == "FOO" else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [CodingKeys.value], debugDescription: "Not FOO"))
        }
    }

    public static func dummyCodingValue(forKey key: CodingKey) -> Any? {
        switch key.stringValue {
        case "value":
            return "FOO"
        default:
            return nil
        }
    }
}

// A type with an embedded ValidatedType
public class TestTypeThree: NSObject, Codable {

    public var name: String?
    public var type: ValidatedType?

    private enum CodingKeys: String, CodingKey {
        case name
        case type
    }
}
