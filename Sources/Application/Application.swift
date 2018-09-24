import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraOpenAPI
import SwiftKueryORM
import SwiftKueryPostgreSQL

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

class Persistence {
    static func setUp() {
        let pool = PostgreSQLConnection.createPool(host: "localhost", port: 5432, options: [.databaseName("test")], poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50, timeout: 10000))
        Database.default = Database(pool)
    }
}

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()

    public init() throws {
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        // Static file server
        router.all(middleware: StaticFileServer())
        // OpenAPI
        let openApiConfig = KituraOpenAPIConfig(apiPath: "/demoapi", swaggerUIPath: "/demoapi/ui")
        KituraOpenAPI.addEndpoints(to: router, with: openApiConfig)
        initializeHealthRoutes(app: self)
        initializeQueryRoutes(app: self)
        initializeTestRoutes(app: self)
        Persistence.setUp()
        do {
            try Person.createTableSync()
        } catch let error {
            print("Table already exists. Error: \(String(describing: error))")
        }
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
