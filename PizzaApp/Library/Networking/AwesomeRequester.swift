//
//  NetworkRequester.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/03/18.
//  Copyright © 2018 ItsDayOff. All rights reserved.
//

import UIKit

public enum URLMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
    case PATCH
}

public enum AwesomeError: String {
    case url
    case timeOut
    case unknown
    case cancelled
    case generic
    case noConnection
    case unauthorized
}

enum AwesomeParserError: Error {
    case invalidPayload
    case unknown
}

public struct ErrorData {
    public var errorType: AwesomeError = .unknown
    public var message: String = "Wow ... you better run away, something terrible happened 😱"
    
    public init(_ errorType: AwesomeError, _ message: String) {
        self.errorType = errorType
        self.message = message
    }
}

public typealias AwesomeResponse = (Data?, ErrorData?) -> Void

public class AwesomeRequester: NSObject {
    
    // MARK:- Where the magic happens
    
    /*
     *   Fetch data from URL with NSUrlSession
     *   @param urlString: Url to fetch data form
     *   @param method: URL method to fetch data using URLMethod enum
     *   @param headerValues: Any header values to complete the request
     *   @param forceUpdate: When true it will force an update by fetching content from the given URL and storing it in URLCache.
     *   @param shouldCache: Cache fetched data, if on, it will check first for data in cache, then fetch if not found
     *   @param completion: Returns fetched NSData in a block
     */
    static func performRequest(
        _ urlString: String?,
        method: URLMethod? = .GET,
        bodyData: Data? = nil,
        headerValues: [[String]]? = nil,
        timeoutAfter timeout: TimeInterval = 15,
        completion:@escaping AwesomeResponse) -> URLSessionDataTask? {
        
        guard let urlString = urlString else {
            completion(nil, ErrorData(.url, "urlString can't be nil."))
            return nil
        }
        
        if urlString == "Optional(<null>)" {
            completion(nil, ErrorData(.url, "urlString can't be unwrapped."))
            return nil
        }
        
        guard let url = URL(string: urlString) else{
            completion(nil, ErrorData(.url, "Could not build URL with the given urlString."))
            return nil
        }
        
        // URL request configurations
        
        let urlRequest = NSMutableURLRequest(url: url)
        
        if let method = method {
            urlRequest.httpMethod = method.rawValue
        }
        
        if let bodyData = bodyData {
            urlRequest.httpBody = bodyData
        }
        
        if let headerValues = headerValues {
            for headerValue in headerValues {
                urlRequest.addValue(headerValue[0], forHTTPHeaderField: headerValue[1])
            }
        }
        
        if timeout > 0 {
            urlRequest.timeoutInterval = timeout
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let session = URLSession.shared
        let data = session.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            if let error = error {
                print("There was an error \(error)")
                
                let urlError = error as NSError
                if urlError.code == NSURLErrorTimedOut {
                    completion(nil, ErrorData(.timeOut, "Operation timmed out."))
                } else if urlError.code == NSURLErrorNotConnectedToInternet {
                    completion(nil, ErrorData(.noConnection, "Could not stablish connection to the Internet"))
                } else if urlError.code == URLError.cancelled.rawValue {
                    completion(nil, ErrorData(.cancelled, "this operation has been cancelled."))
                } else {
                    completion(nil, ErrorData(.unknown, "Unknown falure."))
                }
            }else{
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401  {
                    completion(nil, ErrorData(.unauthorized, "attempting to execute a request with an unauthorized token."))
                } else {
                    completion(data, nil)
                }
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        data.resume()
        
        return data
    }
    
}
