//
//  DocsResponse.swift
//  Book App
//
//  Created by Can Yıldırım on 19.04.2023.
//

import Foundation

struct DocsResponse: Codable {
    
    let coverI: Int?
    let hasFulltext: Bool
    let editionCount: Int
    let title: String
    let authorName: [String]
    let firstPublishYear: Int
    let key: String
    let ia, authorKey: [String]?
    let publicScanB: Bool
    let ratingsAverage: Double?
    let firstSentence: [String]?


    enum CodingKeys: String, CodingKey {
        case coverI = "cover_i"
        case hasFulltext = "has_fulltext"
        case editionCount = "edition_count"
        case title
        case firstSentence = "first_sentence"
        case ratingsAverage = "ratings_average"
        case authorName = "author_name"
        case firstPublishYear = "first_publish_year"
        case key, ia
        case authorKey = "author_key"
        case publicScanB = "public_scan_b"
    }
}
