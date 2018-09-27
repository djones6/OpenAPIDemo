import LoggerAPI
import KituraContracts

func initializeTestRoutes(app: App) {

    // Check that objects that descend from NSObject are correctly represented
    app.router.get("/nsObjectDescendent") { (respondWith: @escaping (TestType?, RequestError?) -> Void) in
        let test = TestType()
        respondWith(test, nil)
    }

    app.router.get("/nsObjectDescendentTwo") { (query: MySimpleParams, completion: @escaping ([TestTypeTwo]?, RequestError?) -> Void ) in
        completion(nil, nil)
    }

    // BUG: Swagger describes ref to Array<TestTypeTwo>
    app.router.get("/nsObjectDescendentTwo2") { (id: String, completion: @escaping ([TestTypeTwo]?, RequestError?) -> Void ) in
        completion(nil, nil)
    }

    // Test that TypeDecoder can process a type that performs validation
    app.router.get("/nsObjectDescendentThree") { (completion: @escaping ([TestTypeThree]?, RequestError?) -> Void ) in
        completion(nil, nil)
    }

}
