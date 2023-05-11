# Network

Network is a Swift package that simplifies the task of making network requests in your applications. It provides an interface to manage URL requests, fetch data and handle bearer tokens for authorization.

## Overview

The main components of Network are:

- `Requestable`: A protocol that represents a URL request. It includes all the necessary components such as the path, headers, parameters, and request type.

- `BearTokenize`: A protocol that represents bearer token information for authorization.

- `RequestManaging`: A protocol for managing requests. It includes a function `perform(request:, bearTokenize:)` for performing requests, handling authorization, and returning decodable data.

- `RequestManager`: A class that conforms to `RequestManaging`. It performs a request and returns the parsed data.

## Installation

You can add Network to an iOS project by adding it as a package dependency in Xcode:

1. From the **File** menu, select **Swift Packages > Add Package Dependency...**
2. Enter the URL of the Network repository in the dialog box.
3. Follow the on-screen instructions.

## Usage

To make a network request, create a class or struct that conforms to the `Requestable` and `BearTokenize` protocols. Here is an example:

```swift
struct MyRequest: Requestable {
    // implement the required properties and methods here
}

struct MyToken: BearTokenize {
    // implement the required properties here
}
```
Then, create an instance of `RequestManager` and use it to perform the request:
```swift
let requestManager = RequestManager()
let request = MyRequest()
let token = MyToken()

do {
    let result: MyDecodableType = try await requestManager.perform(request: request, bearTokenize: token)
    // handle result
} catch {
    // handle error
}
```
Replace `MyDecodableType` with the type of the data you're expecting to receive.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.
