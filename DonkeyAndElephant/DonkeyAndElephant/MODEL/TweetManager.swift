//
//  TweetManager.swift
//  DonkeyAndElephant
//
//  Created by Sterling Miller on 7/9/22.
//

import Foundation

protocol TweetManagerDelegate{
    func didReturnTweetData(_ data: Data)
    func errorReturningTweetData(_ error: Error)
}

class TweetManager{
    let twitterAPI = "https://api.twitter.com/2/users/1367531/tweets"
    let bearer_token = "AAAAAAAAAAAAAAAAAAAAAIEfegEAAAAAFZjI%2FV4JRca7WxnNea%2FG9u5cd8Y%3DXSC9ZZJ12NcoqJYjSdnhrCBBGnxAgN6JMQDdxmkzFpwfUoReBK"
    var delegate: TweetManagerDelegate?
    
    func createQueryString(with searchVal: String){
        
    }
    
    func performAPIRequest(with urlString: String)  {
        guard let validURL = URL(string: twitterAPI) else {
            fatalError("Invalid URL.")
        }
        
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.addValue("Bearer \(bearer_token)", forHTTPHeaderField: "Authorization")
        
        let task =  URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                self.delegate?.errorReturningTweetData(error!)
            }
            
            if let validData = data {
                print(String(data: validData, encoding: .utf8)!)
                
            } else {
                print("data not valid or is nil")
            }
        }
        
        task.resume()
        
      
        
        
    }
    
    
//    func parseTwitterJSON(_ tweetData: Data) -> {
//
//    }
    
}//EOC
