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
    var photos: [SearchPhotos]?
    
    enum CodingKeys: CodingKey {
        case total_results
        case page
        case per_page
        case photos
    }
}

struct SearchPhotos: Codable {
    var id: Int?
    var photographer: String?
    var src: Src?
    
    enum CodingKeys: CodingKey {
        case id
        case photographer
        case src
    }
}

struct Src: Codable {
    var original: String?
    var large2x: String?
    var large: String?
    var medium: String?
    var small: String?
    var portrait: String?
    var landscape: String?
    var tiny: String?
    
    enum CodingKeys: CodingKey {
        case original
        case large2x
        case large
        case medium
        case small
        case portrait
        case landscape
        case tiny
    }
}
