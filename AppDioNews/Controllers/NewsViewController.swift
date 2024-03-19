//
//  newsViewController.swift
//  AppDioNews
//
//  Created by Mrpay on 18/03/24.
//

import WebKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsWebView: WKWebView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    var news: NewsModel? {
        didSet{
            self.title = news?.source.name
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupWebView()
    }
    private func setupWebView(){
        guard let news = news, let url = URL(string: news.url) else {return}
        self.newsWebView.navigationDelegate = self
        self.newsWebView.load(URLRequest(url: url))
        self.newsWebView.allowsBackForwardNavigationGestures = true
        
    }
}
extension NewsViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.loadingActivityIndicator.startAnimating()
        self.loadingView.isHidden = false
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingActivityIndicator.stopAnimating()
        self.loadingView.isHidden = true
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingActivityIndicator.stopAnimating()
        self.loadingView.isHidden = true
    }
}
