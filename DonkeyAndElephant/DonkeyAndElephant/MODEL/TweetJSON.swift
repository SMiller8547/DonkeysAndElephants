//
//  TweetJSONData.swift
//  DonkeyAndElephant
//
//  Created by Sterling Miller on 7/17/22.
//

import Foundation

struct TweetJSON: Decodable {
    let data: [Data]
}

struct Data: Decodable{
    //Tags that represent content of tweet
    let context_annotations: [Context_annotations]
    //id for specific tweet
    let id: String
    //Actual text of tweet
    let text: String
}

struct Context_annotations: Decodable {
    let domain: Domain
    let entity: Entity
}


struct Domain: Decodable{
    let id: String
    let name: String
    let description: String?
}

struct Entity: Decodable {
    let id: String
    let name: String
    let description: String?
}
