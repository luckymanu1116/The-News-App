//
//  NewsViewController.swift
//  TheNews
//
//  Created by Naresh on 11/23/22.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    var viewTable: UITableView!

    var handlerAppleNews = AppleNewsHandler()
    
    
    var handlerBBC = BBCHandler()
    
    var handlerCNN = CNNHandler()
    
    var handlerNYT = NYTHandler()
    

    var viewCollection: UICollectionView!

    

    var viewModel: NewsViewModel!

    let downloader = ImageDownloader()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = NewsViewModel(controller: self)
        configure()
        viewModel.load()
    }

    func load(title thisTitle: String) {
        title = thisTitle
    }

    func load(articles: [Article]) {
        handlerAppleNews.articles = articles
        
        handlerBBC.articles = articles
        
        handlerCNN.articles = articles
        
        handlerNYT.articles = articles
        
    }

    func load(_ style: NewsViewModel.Style) {
        updateVisibility(style)

        if style.isTable {
            updateTable(style)
        } else {
            updateCollection(style)
        }
    }

}

private extension NewsViewController {

    func configure() {
        view.backgroundColor = .systemGray6
        configureNavigation()
        configureViewTable()
        configureViewCollection()
    }

    func configureNavigation() {
        let styleImage = UIImage(systemName: "textformat.size")
        let styleBarbutton = UIBarButtonItem(title: nil, image: styleImage, primaryAction: nil, menu: viewModel.styleMenu)
        styleBarbutton.tintColor = .systemGray
        navigationItem.rightBarButtonItem = styleBarbutton

        let categoryImage = UIImage(systemName: "list.dash")
        let categoryBarButton = UIBarButtonItem(title: nil, image: categoryImage, primaryAction: nil, menu: viewModel.categoryMenu)
        categoryBarButton.tintColor = .systemGray
        navigationItem.leftBarButtonItem = categoryBarButton
    }

    func configureViewCollection() {
        let identifiers = NewsViewModel.Style.allCases
            .filter { !$0.isTable }
            .flatMap { $0.identifiers }
        viewCollection = UICollectionView(frame: .zero, direction: .horizontal, identifiers: identifiers)
        viewCollection.isHidden = true
        viewCollection.showsHorizontalScrollIndicator = false

        view.addSubviewForAutoLayout(viewCollection)
        NSLayoutConstraint.activate([
            viewCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureViewTable() {
        let identifiers = NewsViewModel.Style.allCases
            .filter { $0.isTable }
            .flatMap { $0.identifiers }
        viewTable = UITableView(frame: .zero, style: .plain, identifiers: identifiers)
        viewTable.isHidden = true
        viewTable.separatorInset = .zero
        viewTable.rowHeight = UITableView.automaticDimension
        viewTable.cellLayoutMarginsFollowReadableWidth = true

        view.addSubviewForAutoLayout(viewTable)
        NSLayoutConstraint.activate([
            viewTable.topAnchor.constraint(equalTo: view.topAnchor),
            viewTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func updateCollection(_ style: NewsViewModel.Style) {
        switch style {
        
        default:
            break
        }

        viewCollection.reloadData()
    }

    func updateTable(_ style: NewsViewModel.Style) {
        switch style {
        case .applenews:
            viewTable.dataSource = handlerAppleNews
            viewTable.delegate = handlerAppleNews
        
        
        case .bbc:
            viewTable.dataSource = handlerBBC
            viewTable.delegate = handlerBBC
        
        case .cnn:
            viewTable.dataSource = handlerCNN
            viewTable.delegate = handlerCNN
        
        case .thenyt:
            viewTable.dataSource = handlerNYT
            viewTable.delegate = handlerNYT
        
            break
        }

        viewTable.reloadData()

        guard viewTable.numberOfSections > 0,
              viewTable.numberOfRows(inSection: 0) > 0 else { return }

        viewTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }

    func updateVisibility(_ style: NewsViewModel.Style) {
        switch style {
       
        default:
            viewCollection.isHidden = true
            viewTable.isHidden = false
        }
    }

}
