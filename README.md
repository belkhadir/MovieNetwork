# Network

Network is a Swift package that simplifies the task of making network requests toward [Movie Database](https://www.themoviedb.org) in your applications. It provides an interface to manage URL requests and fetching data. 

## Overview

The main components of Network are:

- `Requestable`: A protocol that represents a URL request. It includes all the necessary components such as the path, headers, parameters, bearer token and request type.

- `RequestManaging`: A protocol for managing requests. It includes a function `perform(request:)` for performing requests and returning decodable data.

- `RequestManager`: A class that conforms to `RequestManaging`. It performs a request and returns the parsed data.

## Installation

You can add Network to an iOS project by adding it as a package dependency in Xcode:

1. From the **File** menu, select **Swift Packages > Add Package Dependency...**
2. Enter the URL of the Network repository in the dialog box.
3. Follow the on-screen instructions.

## Usage

To make a network request, create a class or struct that conforms to the `Requestable` protocol. Here is an example:

```swift
struct MyRequest: Requestable {
    // implement the required properties and methods here
}
```
Then, create an instance of `RequestManager` and use it to perform the request:
```swift
let requestManager = RequestManager()
let request = MyRequest()

do {
    let result: MyDecodableType = try await requestManager.perform(request: request)
    // handle result
} catch {
    // handle error
}
```
