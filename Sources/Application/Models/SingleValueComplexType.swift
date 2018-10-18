// A model nested as a single value within another type
public struct ComplexThing: Codable {
    let foo: String
    let bar: Int
}

// BUG: SwaggerGenerator generates a ref to this type, but only models
// the ComplexThing type.
//
// We should either:
//  a) refer to the ComplexThing type directly, or
//  b) model SingleValueComplexType with ComplexThing's structure
//
// TODO: debug further, then raise issue
public struct SingleValueComplexType: Codable {
    let thing: ComplexThing
    let a: String
    public init(thing: ComplexThing) {
        self.thing = thing
        self.a = "a"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.thing = try container.decode(ComplexThing.self)
        self.a = "a"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(thing)
    }
}

// Similar to UUID: only one value encoded, and has a basic type (String)
public struct SingleValueStringType: Codable {
    let thing: String
    let a: String
    public init(thing: String) {
        self.thing = thing
        self.a = "a"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.thing = try container.decode(String.self)
        self.a = "a"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(thing)
    }
}

public struct SingleValueStringTypeContainer: Codable {
    let containing: SingleValueStringType
}
