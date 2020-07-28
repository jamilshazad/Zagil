//
//  APIClient.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 22/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import PromiseKit

class APIClient {
    
    // MARK: - Class Properties
    
    private static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()
    
    
    // MARK: - Private Methods
    
    class func decode<T: Decodable>(response: JSON) throws -> Promise<T> {
        return Promise<T> { seal in
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let model = try decoder.decode(T.self, from: data)
                seal.fulfill(model)
            } catch(let error) {
                print(error.localizedDescription)
                seal.reject(error)
            }
        }
    }
    
}
