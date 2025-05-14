//
//  AirlineViewModel.swift
//  Airlines
//
//  Created by Amruth Kallyam on 5/13/25.
//

import Foundation

class AirlineViewModel {
    var  networkManager: Servicable?
    var results: [SearchResult] = []
    var relatedTopics: [SearchResult] = []
    var onUpdate: (() -> Void)?
    func search(text: String) {
        Task {
            do {
                if let searchResponse = try await networkManager?.excute(request: SearchRequest.createRequest(text: text), modelName: SearchResponse.self) {
                    self.results = searchResponse.results
                    self.relatedTopics = searchResponse.relatedTopics
                    onUpdate?()
                }
            } catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
            return section == 0 ? results.count : relatedTopics.count
        }

        // Returns item for a given index path
        func item(at indexPath: IndexPath) -> SearchResult? {
            if indexPath.section == 0 {
                guard indexPath.row < results.count else { return nil }
                return results[indexPath.row]
            } else {
                guard indexPath.row < relatedTopics.count else { return nil }
                return relatedTopics[indexPath.row]
            }
        }
}
