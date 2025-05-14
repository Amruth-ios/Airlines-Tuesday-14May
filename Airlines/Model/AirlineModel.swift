//
//  SearchResponse.swift
//  AirlineSearch
//
//  Created by Mac on 02/05/25.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [SearchResult]
    let relatedTopics: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
       case results = "Results"
       case relatedTopics = "RelatedTopics"
    }
}

struct SearchResult: Decodable {
    let firstUrl: String
    let result: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
       case firstUrl = "FirstURL"
       case result = "Result"
       case text = "Text"
    }   
}
