import AWSLambdaRuntime
import AWSLambdaRuntime
import AWSLambdaEvents
import NIO

//struct Input: Codable {
//    let number: Double
//}
//
//struct Output: Codable {
//    let result: Double
//}

struct Handler: EventLoopLambdaHandler {
    typealias In = APIGateway.Request
    typealias Out = APIGateway.Response

    func handle(context: Lambda.Context, event: In) -> EventLoopFuture<Out> {
        print("Handler handle event:", event)
        return context.eventLoop.makeSucceededFuture(APIGateway.Response(statusCode: .ok, headers: [:], multiValueHeaders: nil, body: "Heisan!", isBase64Encoded: false))
//        return context.eventLoop.makeSucceededFuture(Out(result: event.number * event.number))
    }
}
Lambda.run(Handler())

