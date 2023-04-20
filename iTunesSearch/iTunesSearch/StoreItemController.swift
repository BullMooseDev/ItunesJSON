import Foundation

class StoreItemController {
    
    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        let baseURL = URL(string: "https://itunes.apple.com/search")!
        
        let url = baseURL.withQueries(query)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        // below line mismatch type creating error?
        let storeItems = try jsonDecoder.decode(SearchResponse.self, from: data)
        return storeItems.results
    }
    
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
