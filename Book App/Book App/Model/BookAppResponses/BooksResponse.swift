//
//  BooksResponse.swift
//  Book App
//
//  Created by Can Yıldırım on 19.04.2023.
//

import Foundation

struct BooksResponse: Codable {
    
    let start, numFound: Int
    let docs: [DocsResponse]
    
    enum CodingKeys: String, CodingKey {
        case start
        case numFound = "num_found"
        case docs
    }
    
}
