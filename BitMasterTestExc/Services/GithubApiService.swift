//
//  GithubApiService.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 30.03.2021.
//

import Foundation

class GithubApiService {
    
    static let shared = GithubApiService()
    
    private let urlComponents = URLComponents()
    private let acceptableCodes = [200, 201, 202, 203, 304]
    private let perPage = 20
    
    private var totalCount = 1
    private var page = 1
    
    private var lastPage: Int {
        guard totalCount%perPage==0 else {
            return totalCount/perPage + 1
        }
        return totalCount/perPage
    }
    
    public var isPaginating: Bool = false
    public var hasMore: Bool{
        return page<=lastPage
    }
    
    // MARK: Private functions
    private func request(withSearchText text: String, completion: @escaping (Result<Data,NDError>)->()) {
        guard let url = createUrl(withSearchText: text, page: page) else {
            completion(.failure(.noUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                if let _ = error{
                    completion(.failure(.unableToComplete))
                    print("UNBL2")
                    return
                }
                
                if let response = response as? HTTPURLResponse,
                   self?.acceptableCodes.contains(response.statusCode) == false {
                    completion(.failure(.wrongRequest(statusCode: response.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.wrongData))
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }
    
    private func createUrl(withSearchText text: String, page: Int) -> URL?{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        components.queryItems = [
            URLQueryItem(name: "q", value: text + "+in:name"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        return components.url
    }
    
    
    // MARK: Public functions
    func fetchContacts(withSearchText text: String, complition: @escaping (Result<[RepoModel],NDError>) -> ()) {
        isPaginating = true
        guard hasMore else { return }
        request(withSearchText: text) { [weak self] result in
            switch result {
            case .success(let data):
                do{
                    let data = try JSONDecoder()
                        .decode(GitResponse.self, from: data)
                    guard let repos = data.items else {
                        throw NDError.wrongData
                    }
                    self?.totalCount = data.totalCount ?? 1
                    complition(.success(repos))
                    
                } catch {
                    complition(.failure(.wrongData))
                }
            case .failure(_):
                complition(.failure(.unableToComplete))
                print("UNBL1")
            }
            self?.isPaginating = false
        }
    }
    
    func incrementPage(){
        page += 1
    }
    
    func resetPage(){
        page = 1
        isPaginating = false
    }
}
