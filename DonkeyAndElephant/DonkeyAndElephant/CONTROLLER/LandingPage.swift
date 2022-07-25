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
    var combinedTweetData: TweetDetails? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetManager.delegate = self
        tweetManager.generateTweetData()
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let searchTerm = tweetKeywordTextBox.text {
            print("starting tweet run")
            for val in combinedTweetData!.foxTweetData {
                print(val.text)
            }
            
            print("ending tweet run")
        } else {
            // TODO: Add default query call
        }
    }
    

}//End of class


//MARK: - TweetManagerDelegate Methods
extension LandingPage: TweetManagerDelegate {
    func didReturnTweetData(_ data: TweetDetails) {
        print("combined value added")
        combinedTweetData = data
    }
    
    func errorReturningTweetData(_ error: Error) {
        print("ERROR found \(error.localizedDescription)")
    }
    
    
}//End of TweetManager
