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

class TweetManager{
    let twitterAPI = "https://api.twitter.com/2/users/759251/tweets?max_results=100&tweet.fields=context_annotations&exclude=retweets,replies"
    let bearer_token = "AAAAAAAAAAAAAAAAAAAAAIEfegEAAAAAFZjI%2FV4JRca7WxnNea%2FG9u5cd8Y%3DXSC9ZZJ12NcoqJYjSdnhrCBBGnxAgN6JMQDdxmkzFpwfUoReBK"
    let foxNewsID = "1367531"
    let cnnNewsID = "759251"
    let oldElon = "44196397"
    var delegate: TweetManagerDelegate?
    
    
    func createQueryString(with searchVal: String){
    }
    
    func performAPIRequest(with searchTerm: String)  {
        guard let validURL = URL(string: twitterAPI) else {
            fatalError("Invalid URL.")
        }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.addValue("Bearer \(bearer_token)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession(configuration: .default)
                
        let task =  urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                print("error self in nil")
                return
            }
            if error != nil {
                print(error!.localizedDescription)
                self.delegate?.errorReturningTweetData(error!)
            }
            
            if let safeData = data {
              //print(String(data: validData, encoding: .utf8)!)
                if let tweetData = self.parseTwitterJSON(safeData, searchTerm) {
                    self.delegate?.didReturnTweetData(tweetData)
                }
            } else {
                print("data not valid or is nil")
            }
        }
        
        task.resume()
    }
    
    
    func parseTwitterJSON(_ tweetData: Foundation.Data, _ searchTerm: String) -> TweetDetails?{
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(TweetJSON.self, from: tweetData)
            let tweetData = decodedData.data
            
            print("starting search")
            
            for val in tweetData {
                if val.text.contains(searchTerm){
                    print(val.text)
                }
            }
            print("search finished")
            
            return nil
        } catch {
            self.delegate?.errorReturningTweetData(error)
            return nil
        }
    }
    
}//EOC
