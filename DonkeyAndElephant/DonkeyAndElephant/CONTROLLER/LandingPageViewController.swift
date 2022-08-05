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
    var combinedTweetData: TweetDetails? = nil {
        didSet{
            Task{
                await MainActor.run {
                    filterShownTweets()
                }
            }
        }
    }
    var cnnFilteredTweets: [String] = []
    var foxFilteredTweets: [String] = []
    
    
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
        if let searchTerm = tweetKeywordTextBox.text {
            filterShownTweets(with: searchTerm)
        } else {
            filterShownTweets()
        }
    }
    
    func filterShownTweets(with filterTerm: String? = nil){
        cnnFilteredTweets = []
        foxFilteredTweets = []
        
        guard let combinedTweetData = combinedTweetData else {
            print("Error filtering tweets")
            return
        }
        
        if let validFilter = filterTerm {
            for val in combinedTweetData.cnnTweetData {
                if val.text.contains(validFilter) {
                    cnnFilteredTweets.append(val.text)
                }
            }
            for val in combinedTweetData.foxTweetData {
                if val.text.contains(validFilter) {
                    foxFilteredTweets.append(val.text)
                }
            }
        } else {
            for val in combinedTweetData.cnnTweetData {
                cnnFilteredTweets.append(val.text)
            }
            for val in combinedTweetData.foxTweetData {
                foxFilteredTweets.append(val.text)
            }
        }
                
        cnnTableView.reloadData()
        foxTableView.reloadData()

    }
    

}//End of class

//MARK: - TableViewDelegate
extension LandingPageViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       //open webpage with tweetURL 
//    }
}


//MARK: - TableViewDataSource
extension LandingPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cnnTableView {
            return cnnFilteredTweets.count
        }
        return foxFilteredTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cnnTableView {
            let cnnCell = tableView.dequeueReusableCell(withIdentifier: Constants.cnnCell, for: indexPath)
            var content = cnnCell.defaultContentConfiguration()
            content.text = cnnFilteredTweets[indexPath.row]
            cnnCell.contentConfiguration = content
            return cnnCell
        } else {
            let foxCell = tableView.dequeueReusableCell(withIdentifier: Constants.foxCell, for: indexPath)
            var content = foxCell.defaultContentConfiguration()
            content.text = foxFilteredTweets[indexPath.row]
            foxCell.contentConfiguration = content
            return foxCell
        }
    }
    
    
}//EOE


//MARK: - TweetManagerDelegate Methods
extension LandingPageViewController: TweetManagerDelegate {
    func didReturnTweetData(_ tweetDetails: TweetDetails) {
        combinedTweetData = tweetDetails
    }
    
    func errorReturningTweetData(_ error: Error) {
        print("ERROR found \(error.localizedDescription)")
    }
}//End of TweetManager
