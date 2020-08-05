//
//  HomeViewController.swift
//  Xpense
//
//  Created by Surjit on 25/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    class func instantiateVC() -> HomeViewController {
        guard let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return HomeViewController()
        }
        return vc
    }
    
    @IBOutlet var profilebutton: UIButton!
    @IBOutlet var homeCollectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    let apiOperationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profilebutton.layer.cornerRadius = 16.0
        profilebutton.clipsToBounds = true
        profilebutton.imageView?.layer.cornerRadius = 16.0
        profilebutton.imageView?.clipsToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.homeCollectionView.register(UINib(nibName: ChartsCollectionViewCell.idenfier, bundle: nil), forCellWithReuseIdentifier: ChartsCollectionViewCell.idenfier)
        self.homeCollectionView.register(UINib(nibName: EmptyStateCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: EmptyStateCollectionViewCell.identifier)
        self.homeCollectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.identifier)
        self.homeCollectionView.scrollsToTop = true
        
        self.makeRequestForData()
    }
    
    private func makeRequestForData() {
        self.viewModel.transactions.removeAll()
        self.homeCollectionView.reloadData()
        let transactionBlock = BlockOperation {
            self.viewModel.getAllTransactions { [weak self] _ in
                DispatchQueue.main.async {
                    self?.homeCollectionView.reloadData()
                }
                
            }
        }
        apiOperationQueue.addOperation(transactionBlock)
        
    }
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        let vc = ProfileViewController.instantiateVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getSectionCount()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = self.viewModel.getSection(for: indexPath.section) else { preconditionFailure("Failded to create Chart Cell") }
        switch section {
        case .Chart:
            guard let chartCell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartsCollectionViewCell.idenfier, for: indexPath) as? ChartsCollectionViewCell else {
                preconditionFailure("Failded to create Chart Cell")
            }
            
            chartCell.setUpPieChart(for: self.viewModel.transactions)
            return chartCell
        case .Transaction:
            if viewModel.transactions.isEmpty {
                guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyStateCollectionViewCell.identifier, for: indexPath) as? EmptyStateCollectionViewCell else {
                    preconditionFailure("Failed to create Empty Cell")
                }
                emptyCell.showLoading()
                return emptyCell
            }
            guard let transactionCell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCollectionViewCell.identifier, for: indexPath) as? TransactionCollectionViewCell else {
                preconditionFailure("Failed to create Chart Cell")
            }
            let transaction = viewModel.getAllTransactions(index: indexPath.row)
            transactionCell.configureCell(transaction)
            return transactionCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if UICollectionView.elementKindSectionHeader == kind {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.identifier, for: indexPath) as? HomeHeaderView else { preconditionFailure("Failed to creted Home Header") }
            let headerName = viewModel.getHeader(for: indexPath.section)
            header.configureHeader(with: headerName)
            return header
        }
        
        preconditionFailure("Failed to create Home Header")
    }
 
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 30
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = self.viewModel.getSection(for: indexPath.section) else { return CGSize.zero }
        
        switch section {
        case .Chart:
            let width = collectionView.bounds.width
            let height: CGFloat = width / 1
            return CGSize(width: width, height: height)
        case .Transaction:
            if viewModel.transactions.isEmpty {
                let width = collectionView.bounds.width
                let height: CGFloat = width * 2 / 3
                return CGSize(width: width, height: height)
            }
            let width = collectionView.bounds.width
            let height: CGFloat = 60
            return CGSize(width: width, height: height)
        }
        
    }
}

extension HomeViewController: UITextViewDelegate {
 
}
