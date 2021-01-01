import AWSLambdaRuntime

struct Input: Codable {
    let number: Double
}

struct Output: Codable {
    let result: Double
}

Lambda.run { (context, input: Input, callback: @escaping (Result<Output, Error>) -> Void) in
print("Lambda input:", input)
    callback(.success(Output(result: input.number * input.number)))
}

