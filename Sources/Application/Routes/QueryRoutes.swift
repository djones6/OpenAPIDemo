import LoggerAPI
import KituraContracts

func initializeQueryRoutes(app: App) {

    // Swagger looks OK
    // Get a single Person from a query
    app.router.get("/person") { (params: MySimpleParams, respondWith: @escaping (Person?, RequestError?) -> Void) in
        Person.findAll(matching: params) { (results, error) in
            guard let results = results, let person = results.first else {
                return respondWith(nil, error)
            }
            if results.count != 1 {
                return respondWith(nil, .badRequest)
            }
            return respondWith(person, nil)
        }
    }

    // Swagger looks OK
    // Get a single Person from a query
    app.router.get("/personTSMW") { (middleware: MyMiddleware, params: MySimpleParams, respondWith: @escaping (Person?, RequestError?) -> Void) in
        Person.findAll(matching: params) { (results, error) in
            guard let results = results, let person = results.first else {
                return respondWith(nil, error)
            }
            if results.count != 1 {
                return respondWith(nil, .badRequest)
            }
            return respondWith(person, nil)
        }
    }

    // Swagger looks OK
    // Create a Person
    app.router.post("/person") { (person: Person, respondWith: @escaping (Person?, RequestError?) -> Void) in
        person.save(respondWith)
    }

    // Create a Person (different but compatible type for input)
    app.router.post("/personDifferentType") { (inputPerson: InputPerson, respondWith: @escaping (Person?, RequestError?) -> Void) in
        let person = Person(name: inputPerson.name, age: inputPerson.age)
        person.save(respondWith)
    }

    // Swagger looks OK
    // Create a Person
    app.router.post("/personTSMW") { (middleware: MyMiddleware, person: Person, respondWith: @escaping (Person?, RequestError?) -> Void) in
        person.save(respondWith)
    }

    // TODO: Bug: Swagger doesn't define the return type as an array
    // Get all Persons
    app.router.get("/people") { (respondWith: @escaping ([Person]?, RequestError?) -> Void) in
        Person.findAll(respondWith)
    }

    // Swagger looks OK (each param is "required": false)
    // Get a single Person from a query
    app.router.get("/personOpt") { (params: MyOptionalParams, respondWith: @escaping (Person?, RequestError?) -> Void) in
        Person.findAll(matching: params) { (results, error) in
            guard let results = results, let person = results.first else {
                return respondWith(nil, error)
            }
            if results.count != 1 {
                return respondWith(nil, .badRequest)
            }
            return respondWith(person, nil)
        }
    }

    // Swagger cannot represent the all-or-none nature of an optional QueryParams,
    // each param is (individually) "required": false
    // Get a single Person from a query
    app.router.get("/personAllOpt") { (params: MySimpleParams?, respondWith: @escaping (Person?, RequestError?) -> Void) in
        Person.findAll(matching: params) { (results, error) in
            guard let results = results, let person = results.first else {
                return respondWith(nil, error)
            }
            if results.count != 1 {
                return respondWith(nil, .badRequest)
            }
            return respondWith(person, nil)
        }
    }

    // Custom Identifier type
    app.router.get("/customIdentifier") { (id: MyIdentifier, respondWith: (Person?, RequestError?) -> Void) in
        respondWith(Person(name: "Fred", age: 3), nil)
    }

}
