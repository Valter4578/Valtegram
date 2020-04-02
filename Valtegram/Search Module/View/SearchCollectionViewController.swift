//
//  SearchCollectionViewController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 01.04.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {
    // MARK:- Properties
    let cellId = "searchCell"
    var presenter: SearchOutput!
    
    // MARK:- Views
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Username"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
            
        setupSearchBar()
        searchBar.delegate = self
        
        presenter?.fetchUsers {
            self.collectionView.reloadData()
        }
    }
    
    // MARK:- Setups
    private func setupSearchBar() {
        navigationController?.navigationBar.addSubview(searchBar)

        guard let navBar = navigationController?.navigationBar else { return }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 0),
            searchBar.rightAnchor.constraint(equalTo: navBar.rightAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: navBar.leftAnchor, constant: 10),
            searchBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
        ])
    }
    
    // MARK:- CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.filteredUsers.count
    }
    
    // MARK:- CollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCollectionViewCell
        
        cell.user = presenter.filteredUsers[indexPath.item]
        
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

// MARK:- UISearchBarDelegate
extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.filteredUsers = presenter.users
        } else {
            presenter.users = presenter.users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }

        collectionView.reloadData()
    }
}
