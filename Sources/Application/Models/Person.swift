import SwiftKueryORM
import Foundation

struct Person: Model, Validatable, ValidatableAsync {
    let name: String
    let age: Int
    let birthday: Date

    func validate(completion: @escaping (ValidationError?) -> Void) {
        guard !name.isEmpty else {
            return completion(ValidationError("Name cannot be empty"))
        }
        completion(nil)
    }

    func validate() throws {
        guard !name.isEmpty else {
            throw ValidationError("Name cannot be empty")
        }
    }

}
