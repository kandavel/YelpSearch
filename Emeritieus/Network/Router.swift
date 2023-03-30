//
//  EndPoint.swift
//  Walmart-WaIE
//
//  Created by kandavel on 02/03/23.
//

import Foundation
import UIKit

protocol BaseAPIRouter {
    var httpHeaders: [String : String]? { get }
    var scheme: String { get }
    var host: String { get }
    var versionPath : String { get }
}

extension BaseAPIRouter {
    var httpHeaders: [String : String]? {
       return ["Authorization" : "Bearer 3PW75iXnNgFsSrArLrQrtC5SHnilq7lNSVJ4LL-TSFiy19LLZJWh7zFv6F-_W9d9drKzoymoBSMQeVadhbcBA2cWWpfzQQCdmc0OIAEdZ1Pq1fjFFbTVxgK6L-YrY3Yx"]
    }
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.yelp.com"
    }
    
    var versionPath : String {
        "/v3/businesses"
    }
    
}


protocol APIRouter : BaseAPIRouter {
    var request: URLRequest? { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    
    
}

extension APIRouter {
    func request(forEndpoint endpoint: String) -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval  = 30
       // request.cachePolicy  = .returnCacheDataDontLoad
        
        if let httpHeaders = httpHeaders {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}


