//
//  NetworkManager.swift
//  Tech News
//
//  Created by willhcodes on 6/27/23.
//

import Foundation


struct Root: Decodable {
    let hits: [HitpostData]
}

struct HitpostData: Decodable, Identifiable {
    
    var id: String {
        return objectID
    }
    let num_comments: Int
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}

