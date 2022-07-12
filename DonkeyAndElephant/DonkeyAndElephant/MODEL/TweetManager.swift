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
    let twitterAPI = "https://api.twitter.com/2/tweets/:id"
    var delegate: TweetManagerDelegate?
    
    func createQueryString(with searchVal: String){
        
    }
    
    func performAPIRequest(with urlString: String)  {
        guard let validURL = URL(string: urlString) else {
            fatalError("Invalid URL.")
        }
        
        let session = URLSession.shared.dataTask(with: validURL) { data, response, error in
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
        
        session.resume()
        
      
        
        
    }
    
}//EOC
