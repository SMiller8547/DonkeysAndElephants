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
    let twitterAPI = "https://api.twitter.com/2/users/44196397/tweets?max_results=100&tweet.fields=context_annotations&exclude=retweets,replies"
    let bearer_token = "AAAAAAAAAAAAAAAAAAAAAIEfegEAAAAAFZjI%2FV4JRca7WxnNea%2FG9u5cd8Y%3DXSC9ZZJ12NcoqJYjSdnhrCBBGnxAgN6JMQDdxmkzFpwfUoReBK"
    let foxNewsID = "1367531"
    let cnnNewsID = "759251"
    var delegate: TweetManagerDelegate?
    
    
    func createQueryString(with searchVal: String){
    }
    
    func performAPIRequest(with urlString: String)  {
        guard let validURL = URL(string: twitterAPI) else {
            fatalError("Invalid URL.")
        }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.addValue("Bearer \(bearer_token)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession(configuration: .default)
        
//        let task2 = urlSession.dataTask(with: urlRequest) { data, response, error in
//                print("test")
//        }
        
        let task =  urlSession.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                self.delegate?.errorReturningTweetData(error!)
            }
            
            if let safeData = data {
//                print(String(data: validData, encoding: .utf8)!)
                if let tweetData = self.parseTwitterJSON(safeData) {
                    self.delegate?.didReturnTweetData(tweetData)
                }
                
            } else {
                print("data not valid or is nil")
            }
        }
        
        task.resume()
    }
    
    
    func parseTwitterJSON(_ tweetData: Foundation.Data) -> TweetDetails?{
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(TweetJSON.self, from: tweetData)
            let tweetData = decodedData.data[0].text
            print(tweetData)
            
            
            
            return nil
        } catch {
            self.delegate?.errorReturningTweetData(error)
            return nil
        }
    }
    
}//EOC
