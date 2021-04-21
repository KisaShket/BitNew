//
//  RepoTableViewCell.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 30.03.2021.
//

import UIKit

protocol cellDelegate {
    func clickedOnMapButton(_ tableViewCell: RepoTableViewCell, withRepoModel repo: RepoModel)
}

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var bodyView: UIView!
    @IBOutlet private weak var repoName: UILabel!
    @IBOutlet private weak var stars: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    var cellDelegate: cellDelegate?
    private var repo: RepoModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadowView()
        setupBodyView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(withRepoModel model: RepoModel){
        repo = model
        repoName.text = model.name
        if let stargazers = model.stargazersCount {
            stars.text = String(stargazers.intValue)
        }
    }
    
    private func setupShadowView() {
        shadowView.backgroundColor = UIColor.clear
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowRadius = 2.6
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    private func setupBodyView() {
        bodyView.layer.cornerRadius = 14.0
        bodyView.clipsToBounds = true
    }
    
    @IBAction func onMapClicked(_ sender: UIButton) {
        guard let repo = repo else { return }
        cellDelegate?.clickedOnMapButton(self, withRepoModel: repo)
    }
}
