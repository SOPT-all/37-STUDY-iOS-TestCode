//
//  Asynchronous_Test.swift
//  SOPT-Test-Code-StudyTests
//
//  Created by 이승준 on 12/11/25.
//

import XCTest
@testable import SOPT_Test_Code_Study

final class Asynchronous_Test: XCTestCase {

    var fileManager: ExampleFileManager?

    override func setUpWithError() throws {
        fileManager = ExampleFileManager()
    }

    override func tearDownWithError() throws {
        
    }

    func testDownloadWebDataWithConcurrency() async throws {
        // Create a URL for a webpage to download.
        let url = URL(string: "https://apple.com")!
        
        // Use an asynchronous function to download the webpage.
        let dataAndResponse: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: url, delegate: nil)
        
        // Assert that the actual response matches the expected response.
        let httpResponse = try XCTUnwrap(dataAndResponse.response as? HTTPURLResponse, "Expected an HTTPURLResponse.")
        XCTAssertEqual(httpResponse.statusCode, 200, "Expected a 200 OK response.")
    }

    func testFileManager() {
        
        let expectation = XCTestExpectation(description: "Open a file asynchronously.")
        
        fileManager!.openFileAsync(with: "testPath/file.txt") { file, error in
            // Assert that the asynchronous task worked.
            XCTAssertNotNil(file, "Expected to load a file.")
            
            // Assert that no errors occurred opening the file asynchronously.
            XCTAssertNil(error, "Expected no errors loading a file.")
            
            // Fulfill the expectation.
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
