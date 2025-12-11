//
//  ExampleFileManager.swift
//  SOPT-Test-Code-Study
//
//  Created by 이승준 on 12/11/25.
//

import Foundation

class ExampleFileManager {
    
    var shouldSucceed: Bool = false
    var mockData = "Mock file content for testing."
    var mockError: Error? = nil
    
    func openFileAsync(with path: String, completion: @escaping (String?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self else { return }
            if self.shouldSucceed {
                completion(self.mockData, nil)
            } else {
                let error = NSError(domain: "ExampleFileManagerError", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found during mock test."])
                completion(nil, error)
            }
        }
    }
}
