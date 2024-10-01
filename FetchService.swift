import Foundation

struct FetchService {
    enum FetchError: Error {
        case badResponse
    }
    
    // Base URL variable
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    // MARK: - Quote Function
    func fetchQuote(from show: String) async throws -> Quote {
        // Fetch URL
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Create Request
        var request = URLRequest(url: quoteURL)
        request.httpMethod = "GET"
        
        // Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle Response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return Quote
        return quote
    }
    
    // MARK: - Character Function
    func fetchCharacter(_ name: String) async throws -> Character {
        // Fetch URL
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        // Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle Response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
    
    // MARK: - Death Function
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        // Fetch Data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle Response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        return nil
    }
}
