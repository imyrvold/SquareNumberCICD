FROM public.ecr.aws/o8l5c1i1/swift:5.3.2-amazonlinux2 as build
WORKDIR /src
COPY . .
RUN swift build --product SquareNumber -c release -Xswiftc -static-stdlib

FROM public.ecr.aws/lambda/provided:al2
COPY --from=build /src/.build/release/SquareNumber /main
ENTRYPOINT [ "/main" ]
