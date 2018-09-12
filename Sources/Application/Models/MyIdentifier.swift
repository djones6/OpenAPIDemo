import KituraContracts

struct MyIdentifier: Identifier {
    init(value: String) throws {
        self.value = value
    }

    var value: String

}
