//
//  ViewController.swift
//  AppDioNews
//
//  Created by Mrpay on 15/03/24.
//

import UIKit

class NewsListViewController: UIViewController {
        
    @IBOutlet weak var newsListTableView: UITableView!
    private var newsList:[NewsModel]?{
        didSet{
            self.newsListTableView.reloadData()
        }
    }
    var dataProvider:NewsListDataProvider?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.initDataProvider()
    }
    private func initDataProvider(){
        self.dataProvider = NewsListDataProvider()
        self.dataProvider?.delegate = self
        self.dataProvider?.getNewsList()
    }
    override func  prepare(for segue: UIStoryboardSegue,sender:Any?){
        if segue.identifier == "showNewsViewController",let destination = segue.destination as?
            NewsViewController{
            destination.news = sender as? NewsModel
        }
    }
    func setupTableView(){
        self.newsListTableView.delegate = self
        self.newsListTableView.dataSource = self
        self.newsListTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
}
extension NewsListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsList = newsList else {
            fatalError("The selected news was not found!")
        }
        performSegue(withIdentifier: "showNewsViewController", sender: newsList[indexPath.row])
    }
}
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell",for:  indexPath) as? NewsTableViewCell else{
            fatalError("Unable to dequeue subclassed cell")
        }
        guard let newsList = newsList else {
            fatalError("Does not have a news list")
        }
        cell.news = newsList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
extension NewsListViewController:NewsListDataProviderProcotol{
    func success(model: Any) {
        self.newsList = model as? [NewsModel]
        self.newsListTableView.reloadData()
    }
    
    func errorData(_ provide: DataProviderProcotol?, error: Error) {
        print("error:\(error.localizedDescription)")
    }
}
