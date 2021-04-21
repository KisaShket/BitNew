//
//  ViewController.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 29.03.2021.
//

import UIKit
class RepoTableViewController: UITableViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var loadingView: UIView!
    
    private var searchText: String?{
        searchBar.text
    }
    
    private let api = GithubApiService.shared
    private var repos: [RepoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        
    }
    
    private func fetchRepos() {
        guard let text = searchText else { return }
        tableView.tableFooterView = loadingView
        api.fetchContacts(withSearchText: text) { [weak self] result in
            
            switch result {
            case .success(let data):
                self?.repos.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: error.localizedDescription,
                                               message: nil,
                                               preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
                print(error.localizedDescription)
            }
        }
    }
    
    private func clearRepos(){
        api.resetPage()
        repos.removeAll()
        tableView.reloadData()
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.height
        if bottomEdge >= scrollView.contentSize.height - 100 {
            api.incrementPage()
            guard api.isPaginating == false && api.hasMore && searchText?.isEmpty == false else { return }
            tableView.tableFooterView = loadingView
            fetchRepos()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kRepoCellIdentifier,
                                                 for: indexPath) as! RepoTableViewCell
        cell.cellDelegate = self
        cell.configureCell(withRepoModel: repos[indexPath.row])
        return cell
    }
}

extension RepoTableViewController: cellDelegate {
    func clickedOnMapButton(_ tableViewCell: RepoTableViewCell, withRepoModel repo: RepoModel) {
        let mapVC = MapViewController()
        mapVC.repo = repo
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}

extension RepoTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty == false else {
            clearRepos()
            return
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearRepos()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchRepos()
    }
    
}





