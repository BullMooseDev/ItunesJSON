import Foundation

struct itemsValue: Codable {
    
    let name: String?
    var artist: String?
    var artworkURL: URL?
    var currency: String?
    var artistIds: [Int]?
    var artistId: Int?
    var artistName: String?
    var genres: [String]?
    var price: Double?
    var description: String
    var genreIds: [String]?
    var releaseDate: String?
    var artworkUrl100: String?
    var artistViewUrl: String?
    var trackViewUrl: String?
    var trackCensoredName: String?
    var fileSizeBytes: Int?
    var formattedPrice: String?
    var artworkUrl60: String?
    var trackId: Int?
    var trackName: String?
    var kind: String
    var averageUserRating: Double?
    var userRatingCount: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try? values.decode(String.self, forKey: CodingKeys.name)
        self.currency = try? values.decode(String.self, forKey: CodingKeys.currency)
        self.artistIds = try? values.decode([Int].self, forKey: CodingKeys.artistIds)
        self.artistId = try? values.decode(Int.self, forKey: CodingKeys.artistId)
        self.artistName = try? values.decode(String.self, forKey: CodingKeys.artistName)
        self.genres = try? values.decode([String].self, forKey: CodingKeys.genres)
        self.price = try? values.decode(Double.self, forKey: CodingKeys.price)
        self.description = try values.decode(String.self, forKey: CodingKeys.description)
        self.genreIds = try? values.decode([String].self, forKey: CodingKeys.genreIds)
        self.releaseDate = try? values.decode(String.self, forKey: CodingKeys.releaseDate)
        self.artworkUrl100 = try? values.decode(String.self, forKey: CodingKeys.artworkUrl100)
        self.artistViewUrl = try? values.decode(String.self, forKey: CodingKeys.artistViewUrl)
        self.trackViewUrl = try? values.decode(String.self, forKey: CodingKeys.trackViewUrl)
        self.trackCensoredName = try? values.decode(String.self, forKey: CodingKeys.trackCensoredName)
        self.fileSizeBytes = try? values.decode(Int.self, forKey: CodingKeys.fileSizeBytes)
        self.formattedPrice = try? values.decode(String.self, forKey: CodingKeys.formattedPrice)
        self.artworkUrl60 = try? values.decode(String.self, forKey: CodingKeys.artworkUrl60)
        self.trackId = try? values.decode(Int.self, forKey: CodingKeys.trackId)
        self.trackName = try? values.decode(String.self, forKey: CodingKeys.trackName)
        self.kind = try values.decode(String.self, forKey: CodingKeys.kind)
        self.averageUserRating = try? values.decode(Double.self, forKey: CodingKeys.averageUserRating)
        self.userRatingCount = try? values.decode(Int.self, forKey: CodingKeys.userRatingCount)
    }
}
