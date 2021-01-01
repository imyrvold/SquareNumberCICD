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
    typealias In = APIGateway.Request
    typealias Out = APIGateway.Response
    

    func handle(context: Lambda.Context, event: In) -> EventLoopFuture<APIGateway.Response> {
        print("Handler handle event:", event)
        guard let input: Input = try? event.bodyObject() else {
            return context.eventLoop.makeSucceededFuture(APIGateway.Response(with: APIError.requestError, statusCode: .badRequest))
        }
        let output = Output(result: input.number * input.number)
        let apigatewayOutput = APIGateway.Response(with: output, statusCode: .ok)
        
        return context.eventLoop.makeSucceededFuture(apigatewayOutput)
    }
}
Lambda.run(SquareNumberHandler())

