//
//  SearchRequest.swift
//  Airlines
//
//  Created by Sai Voruganti on 5/6/25.
//

import Foundation


struct SearchRequest: Request {
    var baseUrl: String = "https://api.duckduckgo.com"
    var path: String = ""
    var httpMethod: HttpMethod = .get
    var params: [String : String]?
    var header: [String : String]? = nil
    

    static func createRequest(text: String)-> SearchRequest {
        let param = ["q":text, "format":"json", "pretty":"1"]
        let request = SearchRequest(params: param)
        return request
    }
}
