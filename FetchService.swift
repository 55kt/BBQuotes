import Foundation

struct FetchService {
    enum FetchError: Error {
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // Fetch URL
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Create Request
        var request = URLRequest(url: quoteURL)
        request.httpMethod = "GET"
        
        // Send Request
        
        // Fetch Data
        
        // Handle Response
        
        // Decode data
        
        // Return Quote
    }
}
