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

struct Handler: EventLoopLambdaHandler {
    typealias In = APIGateway.Request
    typealias Out = APIGateway.Response

    func handle(context: Lambda.Context, event: In) -> EventLoopFuture<Out> {
           return context.eventLoop.makeSucceededFuture(APIGateway.Response(
            statusCode: .ok,
            headers: [:],
            multiValueHeaders: nil,
            body: "Hello",
            isBase64Encoded: false
        ))
    }
}

struct SquareNumberHandler: EventLoopLambdaHandler {
    typealias In = APIGateway.Request
    typealias Out = APIGateway.Response
    

    func handle(context: Lambda.Context, event: In) -> EventLoopFuture<APIGateway.Response> {
        guard let input: Input = try? event.bodyObject() else {
            return context.eventLoop.makeSucceededFuture(APIGateway.Response(with: APIError.requestError, statusCode: .badRequest))
        }
        let output = Output(result: input.number * input.number)
        let apigatewayOutput = APIGateway.Response(with: output, statusCode: .ok)
        print("Handler handle event:", event)
        
        return context.eventLoop.makeSucceededFuture(apigatewayOutput)
    }
}
Lambda.run(SquareNumberHandler())

