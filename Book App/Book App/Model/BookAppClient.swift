//
//  BookAppClient.swift
//  Book App
//
//  Created by Can Yıldırım on 19.04.2023.
//

import Foundation


class BookAppClient {
    
    
    enum EndPoints {
        
        static let base = "https://openlibrary.org/search.json?q="
        
        
        case getBooks(String)
        case getCovers(Int)
        
        
        var url: URL {
            
            return URL(string: stringValue)!
        }
        
        var stringValue: String {
            
            switch self {
                
            case .getBooks(let search) : return EndPoints.base + (search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            case .getCovers(let coverId) : return "https://covers.openlibrary.org/b/id/" + "\(coverId)" + "-L.jpg"
                
            }
            
        }

    }
    
    class func getCovers(coverId: Int, completion: @escaping (Data?, Error?) -> Void)
    
    {
        
        let task = URLSession.shared.dataTask(with: EndPoints.getCovers(coverId).url) { data, response, error in
        
            DispatchQueue.main.async {
                completion(data,error)
            }
           
        }

        task.resume()

    }
    
    class func getBooks(search: String, completion: @escaping ([DocsResponse], Error?) -> Void) {
        
        taskForGetRequest(url: EndPoints.getBooks(search).url, responseType: BooksResponse.self) { response, error in
            
            if let response = response {
                
                completion(response.docs, nil)
                
            } else {
                
                completion([], error)
                
            }
   
        }

    }
    
    class func taskForGetRequest<ResponseType: Decodable> (url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                
                DispatchQueue.main.async {
                    completion(nil, error)

                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                
            }
            
        }
        
        task.resume()
      
    }
    
}
