//
//  ViewController.swift
//  RedditClient
//
//  Created by erwin robles jr on 09/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import UIKit
import Foundation

class CommunityViewController: UIViewController {
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var subRedditsTableView: UITableView!
    private var apiManager: APIManager?
    private var subReddit: SubReddit?
    private var subReddits: [Children]?
    private var subRedditTitles: [String]?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        subRedditsTableView.dataSource = self
        subRedditsTableView.delegate = self
        subRedditsTableView.sectionIndexBackgroundColor = UIColor.clear
        subRedditsTableView.sectionIndexTrackingBackgroundColor = UIColor.clear
        subRedditsTableView.sectionIndexColor = UIColor.gray
        subRedditsTableView.register(UINib(nibName: "SubReddit", bundle: nil), forCellReuseIdentifier: "subRedditIdentifier")
        apiManager = APIManager()
        apiManager?.delegate = self
        apiManager?.getDefaultSubreddits(getDefaultSubredditsParameters: GetDefaultSubredditsParameters())
        subRedditsTableView.keyboardDismissMode = .onDrag
        navigationController?.navigationBar.isHidden = true
        subRedditsTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.noDataLabel.isHidden = true
    }

}

extension CommunityViewController{
    
    @objc private func refreshData(_ sender: Any) {
        apiManager?.getDefaultSubreddits(getDefaultSubredditsParameters: GetDefaultSubredditsParameters())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewcontroller = segue.destination as? SubredditPostsViewController{
            viewcontroller.urlString = sender as? String
        }
    }
}

extension CommunityViewController: UITableViewDelegate & UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subRedditIdentifier", for: indexPath) as! SubRedditTableViewCell
        if let key = subReddit?.subredditDictionary.getTitles()[indexPath.section], let values = subReddit?.subredditDictionary[key]{
            cell.configure(children: values[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return subReddit?.subredditDictionary.getTitles().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var url = ""
        if let key = subReddit?.subredditDictionary.getTitles()[indexPath.section], let values = subReddit?.subredditDictionary[key]{
            url = values[indexPath.row].data?.url ?? ""
        }
        performSegue(withIdentifier: Defaults.subredditPostsIdentifier, sender: "\(Defaults.baseUrl)\(url)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let key = subReddit?.subredditDictionary.getTitles()[section], let values = subReddit?.subredditDictionary[key]{
            return values.count
        }
        return 0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return subReddit?.subredditDictionary.getTitles()
    }
}

extension CommunityViewController: APIManagerDelegate{
    func onGetDefaultSubredditsSuccess(subreddit: SubReddit) {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.refreshControl.endRefreshing()
            self.subReddit = subreddit
            self.subReddits = subreddit.data?.children
            self.subReddits?.sort { $0.data?.display_name?.lowercased() ?? "" < $1.data?.display_name?.lowercased() ?? "" }
            self.subRedditsTableView.reloadData()
            self.noDataLabel.isHidden = subreddit.subredditDictionary.count > 0
        }
    }
    
    func onGetDefaultSubredditsFailed(errorString: String) {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.noDataLabel.isHidden = self.subReddit?.subredditDictionary.count ?? 0 > 0
            self.refreshControl.endRefreshing()
            self.showAlert(message: errorString)
        }
    }
}
