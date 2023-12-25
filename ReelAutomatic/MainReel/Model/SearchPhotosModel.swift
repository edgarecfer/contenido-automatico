//
//  SearchPhotosModel.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 04/12/23.
//

import Foundation

struct SearchPhotosModel: Codable {
    var total_results: Int?
    var page: Int?
    var per_page: Int?
    var videos: [SearchPhotos]?
    
    enum CodingKeys: CodingKey {
        case total_results
        case page
        case per_page
        case videos
    }
}

struct SearchPhotos: Codable {
    var id: Int?
    var image: String?
    var user: User?
    var video_files: [Video]?
    
    enum CodingKeys: CodingKey {
        case id
        case image
        case user
        case video_files
    }
}

struct User: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
}

struct Video: Codable {
    var id: Int?
    var quality: String?
    var link: String?
    
    enum CodingKeys: CodingKey {
        case id
        case quality
        case link
    }
}
