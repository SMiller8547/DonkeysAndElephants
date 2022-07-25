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
        var cnnJSONData: TweetJSON? = nil
        var foxJSONData: TweetJSON? = nil
        performAPIRequest(with: cnnNewsID) { tweetJSON, error in
            if let tweetJSON = tweetJSON {
                cnnJSONData = tweetJSON
            }
            if let e = error {
                print("Error generating CNN tweet data. \(e.localizedDescription)")
            }
            
        }
        performAPIRequest(with: foxNewsID) { tweetJSON, error in
            if let tweetJSON = tweetJSON {
                foxJSONData = tweetJSON
            }
            if let e = error {
                print("Error generating Fox tweet data. \(e.localizedDescription)")
            }
        }
        if let cnnSafeData = cnnJSONData, let foxSafeData = foxJSONData {
            let tweetDetails = TweetDetails(cnnTweetData: cnnSafeData.data, foxTweetData: foxSafeData.data)
            self.delegate?.didReturnTweetData(tweetDetails)
        }
    }
    
    func performAPIRequest(with user: String, apiCompletionHandler: @escaping (TweetJSON?, Error?) -> Void) {
        let twitterAPI = "https://api.twitter.com/2/users/\(user)/tweets?max_results=100&tweet.fields=context_annotations&exclude=retweets,replies"
        guard let validURL = URL(string: twitterAPI) else {
            fatalError("Invalid URL.")
        }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.addValue("Bearer \(bearer_token)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession(configuration: .default)
                
        let task =  urlSession.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                self.delegate?.errorReturningTweetData(error!)
            }
            
            if let safeData = data {
              //print(String(data: validData, encoding: .utf8)!)
                if let tweetData = self.parseTwitterJSON(safeData) {
                    apiCompletionHandler(tweetData, nil)
                }
            } else {
                print("urlRequest returned nil data")
            }
        }
        task.resume()
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
