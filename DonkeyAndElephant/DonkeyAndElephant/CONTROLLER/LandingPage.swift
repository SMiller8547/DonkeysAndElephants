//
//  ViewController.swift
//  DonkeyVsElephant
//
//  Created by Sterling Miller on 7/8/22.
//

import UIKit

class LandingPage: UIViewController {

    
    var tweetManager = TweetManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetManager.delegate = self
    }


}


extension LandingPage: TweetManagerDelegate {
    func didReturnTweetData(_ data: Data) {
        
    }
    
    func errorReturningTweetData(_ error: Error) {
        print("ERROR found \(error.localizedDescription)")
    }
    
    
}
