import Foundation

public class TestTypeTwo: NSObject, Codable {
    public var a: String?
    public var b: [String: String]?
    public var nestedType: NestedType
    public var nestedOptional: NestedAsOptionalType?
    public var nestedTypeArray: [NestedInArrayType]
    public var stringArray: [String]

    // TODO: What happens with Sets?

    // BUG: The type is described as '[String:String', it should be an Object with associated type String
    // TODO: raise issue
    public var dictStringArray: [[String:String]]

    // BUG: The type is described as String?, it should be an array of String where the value is not required
    // (can this be expressed in Swagger?)
    // TODO: raise issue
    public var optStringArray: [String?]

    public var cyclicArray: [TestTypeTwo]

    // BUG: Types that are only nested within a dictionary within an array are not modelled
    public var dictNestedTypeArray: [[String:NestedInDictionaryArrayType]]

    public var dictNestedType: [String: NestedInDictionaryType]

    // Test other permutations with Optionals

    // BUG: This is not marked as required
    // TODO: raise issue
    public var dictNestedOptionalType: [String: NestedInDictionaryOptionalType?]

    // BUG: Type is described as '[String:NestedInDictionaryOptionalArrayType'
    // BUG: NestedInDictionaryOptionalArrayType not modelled
    // TODO: raise issue
    public var dictNestedOptionalTypeArray: [[String:NestedInDictionaryOptionalArrayType?]]

    // BUG: Type is described as '[String:NestedInDictionaryArrayOptionalType'
    // BUG: NestedInDictionaryArrayOptionalType not modelled
    public var dictNestedTypeArrayOptional: [[String:NestedInDictionaryArrayOptionalType]?]
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
public class NestedInDictionaryOptionalType: Codable {
    public var wibble: String
}
public class NestedInDictionaryOptionalArrayType: Codable {
    public var flibble: String
}
public class NestedInDictionaryArrayOptionalType: Codable {
    public var flabble: String
}
