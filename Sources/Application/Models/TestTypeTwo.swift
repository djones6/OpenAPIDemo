import Foundation

public class TestTypeTwo: NSObject, Codable {
    public var a: String?
    public var b: [String: String]?
    public var nestedType: NestedType
    public var nestedOptional: NestedAsOptionalType?
    public var nestedTypeArray: [NestedInArrayType]
    public var stringArray: [String]
    public var dictStringArray: [[String:String]]
    public var optStringArray: [String?]
    public var cyclicArray: [TestTypeTwo]
    // BUG: Types that are only nested within a dictionary are not modelled
    public var dictNestedTypeArray: [[String:NestedInDictionaryArrayType]]
    public var dictNestedType: [String: NestedInDictionaryType]
}

public class NestedType: Codable {
    public var foo: String
}

public class NestedInArrayType: Codable {
    public var bar: String
}

public class NestedInDictionaryArrayType: Codable {
    public var bat: String
}

public class NestedInDictionaryType: Codable {
    public var qux: String
}

public class NestedAsOptionalType: Codable {
    public var baz: String
}
