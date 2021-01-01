import AWSLambdaRuntime
import AWSLambdaEvents
import NIO

struct Input: Codable {
    let number: Double
}

struct Output: Codable {
    let result: Double
}

struct Handler: EventLoopLambdaHandler {
    typealias In = Input
    typealias Out = Output

    func handle(context: Lambda.Context, event: Input) -> EventLoopFuture<Output> {
        print("Handler handle event:", event)
        return context.eventLoop.makeSucceededFuture(Out(result: event.number * event.number))
    }
}
Lambda.run(Handler())

