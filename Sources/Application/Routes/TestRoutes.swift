import LoggerAPI
import KituraContracts

func initializeTestRoutes(app: App) {

    // Check that objects that descend from NSObject are correctly represented
    // and that TypeDecoder can process a type that performs validations (with
    // the appropriate exposure of DummyCodingKeyProvider protocols)
    app.router.get("/testTypeSingular") { (respondWith: @escaping (ContainsValidations?, RequestError?) -> Void) in
        respondWith(nil, nil)
    }

    app.router.get("/testTypeArrayByQuery") { (query: MySimpleParams, completion: @escaping ([ContainsValidations]?, RequestError?) -> Void ) in
        completion(nil, nil)
    }

    app.router.get("/testTypeArray") { (completion: @escaping ([ContainsValidations]?, RequestError?) -> Void ) in
        completion(nil, nil)
    }

    // Test that a variety of ways of nesting Swift types within different TypeDecoder
    // cases (such as an array, Dictionary value, array of Dictionary) work properly
    // (all types represented).
    //
    // BUG: Type of value for dictionary embedded in array is not modelled
    //
    app.router.get("/testTypeTwoAll") { (completion: @escaping ([TestTypeTwo]?, RequestError?) -> Void ) in
        completion(nil, nil)
    }

    // Get by ID cannot return an array of results, however it can return a result which
    // is an array (since [Codable] is Codable). This should be defined in Swagger as an
    // array return type with a $ref to the Codable type model.
    //
    // BUG 1: Swagger does not generate model for TestTypeTwo from this route if this is
    //        the only place that it appears.
    //
    // BUG 2: Swagger describes a ref to Array<TestTypeTwo> because it does not know that
    //        the return type as an array.
    //
    app.router.get("/testTypeTwoById") { (id: String, completion: @escaping ([TestTypeTwo]?, RequestError?) -> Void ) in
        completion(nil, nil)
    }

}
