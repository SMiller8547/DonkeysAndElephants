//
//  ViewController.swift
//  DonkeyVsElephant
//
//  Created by Sterling Miller on 7/8/22.
//

import UIKit

class LandingPage: UIViewController {

    @IBOutlet weak var tweetKeywordTextBox: UITextField!
    var tweetManager = TweetManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetManager.delegate = self
        
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let searchTerm = tweetKeywordTextBox.text {
            tweetManager.performAPIRequest(with: searchTerm)
        } else {
            // TODO: Add default query call
        }
    }
    

}//End of class


//MARK: - TweetManagerDelegate Methods
extension LandingPage: TweetManagerDelegate {
    func didReturnTweetData(_ data: Data) {
        
    }
    
    func errorReturningTweetData(_ error: Error) {
        print("ERROR found \(error.localizedDescription)")
    }
    
    
}//End of TweetManager
