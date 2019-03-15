import LoggerAPI
import KituraContracts
import Foundation

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

    // Get a single person by ID
    app.router.get("/personById") { (id: Int, respondWith: @escaping (Person?, RequestError?) -> Void) in
        Person.find(id: id) { (person, error) in
            guard let person = person else {
                return respondWith(nil, error)
            }
            return respondWith(person, nil)
        }
    }

    // Swagger looks OK (no TSMW representation capability)
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
    // Create a Person and run validation
    app.router.post("/person") { (person: Person, respondWith: @escaping (Person?, RequestError?) -> Void) in

        // Sync validation
//        do {
//            try person.validate()
//            return person.save(respondWith)
//        } catch ValidationError.empty(let error) {
//            Log.error("Validation fail: \(error)")
//        } catch {
//            Log.error("Some other error: \(error)")
//        }
//        respondWith(nil, .badRequest)

        // Async validation
        person.validate { (error) in
            if let error = error {
                Log.error("Validation error: \(error)")
                return respondWith(nil, .badRequest)
            }
            person.save(respondWith)
        }
    }

    // Create a Person (different but compatible type for input)
    app.router.post("/personDifferentType") { (inputPerson: InputPerson, respondWith: @escaping (Person?, RequestError?) -> Void) in
        let person = Person(name: inputPerson.name, age: inputPerson.age, birthday: inputPerson.birthday)
        person.save(respondWith)
    }

    // Swagger looks OK
    // Create a Person
    app.router.post("/personTSMW") { (middleware: MyMiddleware, person: Person, respondWith: @escaping (Person?, RequestError?) -> Void) in
        person.save(respondWith)
    }

    // Fixed: https://github.com/IBM-Swift/Kitura/pull/1335
    // Get all Persons
    app.router.get("/people") { (respondWith: @escaping ([Person]?, RequestError?) -> Void) in
        Person.findAll(respondWith)
    }

    // Fixed: https://github.com/IBM-Swift/Kitura/pull/1347
    // Get all Persons with their ID
    app.router.get("/peopleId") { (respondWith: @escaping ([(Int, Person)]?, RequestError?) -> Void) in
        Person.findAll(respondWith)
    }

    // Fixed: https://github.com/IBM-Swift/Kitura/pull/1347
    // POST a person, returning the assigned Id
    app.router.post("/personId") { (person: Person, respondWith: @escaping (Int?, Person?, RequestError?) -> Void) in
        person.save(respondWith)
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
    // BUG: This ends up with idReturned=true in addPath
    app.router.get("/customIdentifier") { (id: MyIdentifier, respondWith: (Person?, RequestError?) -> Void) in
        respondWith(Person(name: "Fred", age: 3, birthday: Date()), nil)
    }

}
