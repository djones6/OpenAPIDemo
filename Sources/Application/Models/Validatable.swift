// Prototype Validatable protocol
public protocol Validatable {
    func validate() throws
}

public protocol ValidatableAsync {
    func validate(completion: @escaping (ValidationError?) -> Void)
}

public struct ValidationError: Error {
    let reason: String
    public init(_ reason: String) {
        self.reason = reason
    }
}
