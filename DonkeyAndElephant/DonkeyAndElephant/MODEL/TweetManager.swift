//
//  TweetManager.swift
//  DonkeyAndElephant
//
//  Created by Sterling Miller on 7/9/22.
//

import Foundation

protocol TweetManagerDelegate{
    func didReturnTweetData(_ tweetDetails: TweetDetails)
    func errorReturningTweetData(_ error: Error)
}

struct TweetManager{
    let bearer_token = "AAAAAAAAAAAAAAAAAAAAAIEfegEAAAAAFZjI%2FV4JRca7WxnNea%2FG9u5cd8Y%3DXSC9ZZJ12NcoqJYjSdnhrCBBGnxAgN6JMQDdxmkzFpwfUoReBK"
    let cnnNewsID = "759251"
    let foxNewsID = "1367531"
    var delegate: TweetManagerDelegate?
    
    
    func generateTweetData(){
        
        Task{
            let cnnData = try await performAPIRequest(with: cnnNewsID)
            let foxData = try await performAPIRequest(with: foxNewsID)
            let tweetDetails = TweetDetails(cnnTweetData: cnnData.data, foxTweetData: foxData.data)
            delegate?.didReturnTweetData(tweetDetails)
        }
        
    }
    
    func performAPIRequest(with user: String) async throws -> TweetJSON {
        let twitterAPI = "https://api.twitter.com/2/users/\(user)/tweets?max_results=100&tweet.fields=context_annotations&exclude=retweets,replies"
        let url = URL(string: twitterAPI)!
        var urlRequest = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        
        urlRequest.addValue("Bearer \(bearer_token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await urlSession.data(for: urlRequest)
        let tweetJSON = parseTwitterJSON(data)!
        
        for val in tweetJSON.data {
            print(val.text)
        }
        return tweetJSON
    }
    
    
    func parseTwitterJSON(_ tweetData: Foundation.Data) -> TweetJSON?{
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(TweetJSON.self, from: tweetData)
            return decodedData
        } catch let errorGenerated{
            self.delegate?.errorReturningTweetData(errorGenerated)
            return nil
        }
    }
    
}//EOC
