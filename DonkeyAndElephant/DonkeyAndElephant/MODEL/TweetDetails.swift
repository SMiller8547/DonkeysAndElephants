//
//  TweetDataDetails.swift
//  DonkeyAndElephant
//
//  Created by Sterling Miller on 7/18/22.
//

import Foundation
class TweetDetails {
    var cnnTweetData: [Data]
    var foxTweetData: [Data]
    
    init(cnnTweetData: [Data], foxTweetData: [Data]) {
        self.cnnTweetData = cnnTweetData
        self.foxTweetData = foxTweetData
    }
}
