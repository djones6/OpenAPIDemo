import Kitura

struct MyMiddleware: TypeSafeMiddleware {

    static func handle(request: RouterRequest, response: RouterResponse, completion: @escaping (MyMiddleware?, RequestError?) -> Void) {
        completion(MyMiddleware(), nil)
    }

}
