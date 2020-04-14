//
//  SubredditPostsViewController.swift
//  RedditClient
//
//  Created by erwin robles jr on 13/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import UIKit
import WebKit

class SubredditPostsViewController: UIViewController{
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var forwardItem: UIBarButtonItem!
    @IBOutlet weak var backItem: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: WKWebView!
    var urlString: String?
    let textField = UITextField()
    
    override func viewDidLoad() {
        let url = URL(string: urlString ?? "")
        if let url = url{
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
        webView.navigationDelegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        textField.delegate = self
        backItem.isEnabled = false
        forwardItem.isEnabled = false
        progressView.isHidden = true
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(progressView.progress)
            progressView.isHidden = progressView.progress == 1
            self.progressView.progress = Float(self.webView.estimatedProgress);
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func onCloseTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @IBAction func onForwardTapped(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        webView.reload()
    }
}

extension SubredditPostsViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.textField.text = self.urlString
        navigationBar.topItem?.titleView = textField
        backItem.isEnabled = webView.canGoBack
        forwardItem.isEnabled = webView.canGoForward
        progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
}

extension SubredditPostsViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
