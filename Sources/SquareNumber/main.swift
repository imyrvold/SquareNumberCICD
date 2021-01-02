import AWSLambdaRuntime
import AWSLambdaEvents
import NIO
import Foundation

struct Input: Codable {
    let number: Double
}

struct Output: Codable {
    let result: Double
}

struct SquareNumberHandler: EventLoopLambdaHandler {
    typealias In = APIGateway.V2.Request
    typealias Out = APIGateway.V2.Response
    

    func handle(context: Lambda.Context, event: In) -> EventLoopFuture<APIGateway.V2.Response> {
        guard let input: Input = try? event.bodyObject() else {
            return context.eventLoop.makeSucceededFuture(APIGateway.V2.Response(with: APIError.requestError, statusCode: .badRequest))
        }
        let output = Output(result: input.number * input.number)
        let apigatewayOutput = APIGateway.V2.Response(with: output, statusCode: .ok)
        
        return context.eventLoop.makeSucceededFuture(apigatewayOutput)
    }
}
Lambda.run(SquareNumberHandler())

