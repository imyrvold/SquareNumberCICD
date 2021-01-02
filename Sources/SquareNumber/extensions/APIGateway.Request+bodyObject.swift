import AWSLambdaEvents
import Foundation

extension APIGateway.V2.Request {
    func bodyObject<D: Decodable>() throws -> D {
        guard let jsonData = body?.data(using: .utf8) else { throw APIError.requestError }
        let decoder = JSONDecoder()
        
        let object = try decoder.decode(D.self, from: jsonData)
        return object
    }
}
