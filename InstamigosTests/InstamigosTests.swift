//
//  InstamigosTests.swift
//  InstamigosTests
//
//  Created by Cáren Sousa on 18/05/23.
//

import XCTest
@testable import Instamigos

class NetworkTests: XCTestCase {
    
    var sessionStub: URLSessionStub!
    var network: Network!
    
    override func setUp() {
        super.setUp()
        sessionStub = URLSessionStub()
        network = Network(session: sessionStub)
    }
    
    override func tearDown() {
        super.tearDown()
        sessionStub = nil
        network = nil
    }
    
    func testFetchRequest_postUser_SuccessfulResponse() {
        
        let responseData = """
            {
              "token": "23rg8cSx5n8UNkItcoYWqA==",
              "user": {
                "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                "name": "string",
                "email": "user@example.com",
                "avatar": "string"
              }
            }
        """.data(using: .utf8)
        
        let successResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080/users")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sessionStub.responseData = responseData
        sessionStub.response = successResponse
        
        let requestBody = CreateUserRequest(name: "string", email: "user@example.com", password: "string123")
        
        let expectation = XCTestExpectation(description: "Test Fetch Request")
        
        network.fetchRequest(urlPath: "/users", requestBody: requestBody, authentication: nil, httpMethod: .post, contentType: .json) { (responseData: SessionUserResponse?, statusCode) in
            
            XCTAssertEqual(statusCode, 200)
            
            XCTAssertNotNil(responseData)
            XCTAssertEqual(responseData?.token, "23rg8cSx5n8UNkItcoYWqA==")
            XCTAssertEqual(responseData?.user?.id, "3fa85f64-5717-4562-b3fc-2c963f66afa6")
            XCTAssertEqual(responseData?.user?.name, "string")
            XCTAssertEqual(responseData?.user?.email, "user@example.com")
            XCTAssertEqual(responseData?.user?.avatar, "string")
            
            XCTAssertEqual(self.sessionStub.receivedRequest?.url?.path, "/users")
            XCTAssertEqual(self.sessionStub.receivedRequest?.httpMethod, "POST")
            
            guard let httpBody = self.sessionStub.receivedRequest?.httpBody else { return XCTFail("httpBody is nil") }
            
            let jsonObject = try? JSONSerialization.jsonObject(with: httpBody, options: [])
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject!, options: .prettyPrinted)
            let requestBodyString = String(data: jsonData!, encoding: .utf8)
            XCTAssertEqual(requestBodyString, """
                                            {
                                              "name" : "string",
                                              "email" : "user@example.com",
                                              "password" : "string123"
                                            }
                                            """)
        
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchRequest_postUser_ErrorResponse() {
        
        let responseData = """
            {
              "token": "23rg8cSx5n8UNkItcoYWqA==",
              "user": {
                "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                "name": "string",
                "email": "user@example.com",
                "avatar": "string"
              }
            }
        """.data(using: .utf8)
        
        let response = HTTPURLResponse(url: URL(string: "http://localhost:8080/users")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sessionStub.response = response
        sessionStub.responseData = responseData
        sessionStub.error = NSError(domain: "Error", code: -1)
        
        let expectation = XCTestExpectation(description: "Test Fetch Request")

        network.fetchRequest(urlPath: "/users", requestBody: nil, authentication: nil, httpMethod: .get, contentType: .json) { (responseData: SessionUserResponse?, statusCode) in
            
            XCTAssertNil(responseData)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchRequest_postCreatePost_SuccessfulResponse() {
        
        let responseData = """
            {
              "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
              "content": "string",
              "user_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
              "created_at": "2023-05-24T15:06:52.055Z",
              "updated_at": "2023-05-24T15:06:52.055Z"
            }
        """.data(using: .utf8)
        
        let successResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080/posts")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        sessionStub.response = successResponse
        sessionStub.responseData = responseData
    
        let token = "23rg8cSx5n8UNkItcoYWqA=="
        let post = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend, justo a cursus commodo, erat odio tristique tellus, eget pellentesque lectus risus ac nunc."
        
        let expectation = XCTestExpectation(description: "Test Fetch Request")
       
        network.fetchRequest(urlPath: "/posts", requestBody: nil, authentication: .bearer(token: token), httpMethod: .post, contentType: .textPlain(content: post)) { (responseData: PostResponse?, statusCode) in
            XCTAssertEqual(statusCode, 200)
            
            XCTAssertNotNil(responseData)
            XCTAssertEqual(responseData?.id, "3fa85f64-5717-4562-b3fc-2c963f66afa6")
            XCTAssertEqual(responseData?.content, "string")
            XCTAssertEqual(responseData?.user_id, "3fa85f64-5717-4562-b3fc-2c963f66afa6")
            XCTAssertEqual(responseData?.created_at, "2023-05-24T15:06:52.055Z")
            XCTAssertEqual(responseData?.updated_at, "2023-05-24T15:06:52.055Z")
            
            XCTAssertEqual(self.sessionStub.receivedRequest?.url?.path, "/posts")
            XCTAssertEqual(self.sessionStub.receivedRequest?.httpMethod, "POST")
            
            guard let httpBody = self.sessionStub.receivedRequest?.httpBody else { return XCTFail("httpBody is nil") }
            let requestBodyString = String(data: httpBody, encoding: .utf8)
            XCTAssertEqual(requestBodyString, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend, justo a cursus commodo, erat odio tristique tellus, eget pellentesque lectus risus ac nunc.")
            
            XCTAssertEqual((self.sessionStub.receivedRequest?.value(forHTTPHeaderField: "Authorization")), "Bearer 23rg8cSx5n8UNkItcoYWqA==")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}


class URLSessionStub: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var responseData: Data?
    var response: URLResponse?
    var error: Error?
    
    var receivedRequest: URLRequest?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        receivedRequest = request
        
        let task = URLSessionDataTaskStub()
        
        task.completionHandler = { [weak self] in
            completionHandler(self?.responseData, self?.response, self?.error)
        }
        
        return task
    }
}

class URLSessionDataTaskStub: URLSessionDataTask {
    var completionHandler: (() -> Void)?
    
    override func resume() {
        completionHandler?()
    }
    
    override func cancel() {}
}

