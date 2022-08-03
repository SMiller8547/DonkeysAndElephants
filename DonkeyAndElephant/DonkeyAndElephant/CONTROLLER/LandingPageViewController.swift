//
//  ViewController.swift
//  DonkeyVsElephant
//
//  Created by Sterling Miller on 7/8/22.
//

import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet weak var cnnTableView: UITableView!
    @IBOutlet weak var foxTableView: UITableView!
    
    @IBOutlet weak var tweetKeywordTextBox: UITextField!
    
    
    var tweetManager = TweetManager()
    var combinedTweetData: TweetDetails? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetManager.delegate = self
        tweetManager.generateTweetData()
        
        cnnTableView.delegate = self
        cnnTableView.dataSource = self
        
        foxTableView.delegate = self
        foxTableView.dataSource = self
       
        
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
//        if let searchTerm = tweetKeywordTextBox.text {
//            print("starting tweet run")
//            for val in combinedTweetData!.foxTweetData {
//                print(val.text)
//            }
//
//            print("ending tweet run")
//        } else {
//            // TODO: Add default query call
//        }
    }
    

}//End of class

//MARK: - TableViewDelegate
extension LandingPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}


//MARK: - TableViewDataSource
extension LandingPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == cnnTableView {
            return combinedTweetData?.cnnTweetData.count ?? 5
        }
        return combinedTweetData?.foxTweetData.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == cnnTableView {
            let cnnCell = tableView.dequeueReusableCell(withIdentifier: Constants.cnnCell, for: indexPath)
            var content = cnnCell.defaultContentConfiguration()
            content.text = "CNN Cell"
            cnnCell.contentConfiguration = content
            return cnnCell
        } else {
            let foxCell = tableView.dequeueReusableCell(withIdentifier: Constants.foxCell, for: indexPath)
            var content = foxCell.defaultContentConfiguration()
            content.text = "Fox Cell"
            foxCell.contentConfiguration = content
            return foxCell
        }
    }
    
    
}//EOE


//MARK: - TweetManagerDelegate Methods
extension LandingPageViewController: TweetManagerDelegate {
    func didReturnTweetData(_ tweetDetails: TweetDetails) {
        combinedTweetData = tweetDetails
//        for tweet in combinedTweetData!.foxTweetData {
//            print(tweet.text)
//        }
    }
    
    func errorReturningTweetData(_ error: Error) {
        print("ERROR found \(error.localizedDescription)")
    }
}//End of TweetManager
