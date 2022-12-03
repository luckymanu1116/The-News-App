//
//  Created by Kushagra & jaskirat on 4/2/22.
//

import UIKit

class NewsViewModel {

    var controller: NewsViewController

    var style: Style = Settings.shared.style

    var categoryName: String = ""

    init(controller: NewsViewController) {
        self.controller = controller
    }

    func load() {
        loadArticles()
        controller.load(style)
    }

    func loadArticles(category: String = Settings.shared.category.rawValue) {
        let url = NewsApi.urlForCategory(category)
        NewsApi.getArticles(url: url) { [weak self] (articles) in
            guard let articles = articles,
                  let style = self?.style else { return }
            self?.controller.load(articles: articles)
            self?.controller.load(style)
        }

        categoryName = category.capitalized

        let title = style.display + " - " + categoryName
        controller.load(title: title)
    }

    func select(_ category: String) {
        loadArticles(category: category)

        guard let newsCategory = NewsCategory(rawValue: category) else { return }
        Settings.shared.category = newsCategory
    }

    func select(_ aStyle: Style) {
        style = aStyle
        controller.load(style)

        let title = style.display + " - " + categoryName
        controller.load(title: title)

        Settings.shared.style = style
    }

    var categoryMenu: UIMenu {
        let menuActions = NewsCategory.allCases.map({ (item) -> UIAction in
            let name = item.rawValue
            return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemName)) { (_) in
                self.select(name)
            }
        })

        return UIMenu(title: "Change Category", children: menuActions)
    }

    var styleMenu: UIMenu {
        let menuActions = NewsViewModel.Style.allCases.map { (style) -> UIAction in
            return UIAction(title: style.display, image: nil) { (_) in
                self.select(style)
            }
        }

        return UIMenu(title: "Change Style", children: menuActions)
    }

    enum Style: String, CaseIterable, Codable {

        case
             applenews,
             
             bbc,
             
             cnn,
             
             thenyt
             

        var display: String {
            switch self {
            case .applenews:
                return "Apple News"
           
            
            case .thenyt:
                return "The New York Times"
            
            case .bbc, .cnn:
                return self.rawValue.uppercased()
            
            }
        }

        var isTable: Bool {
            switch self {
            
            default:
                return true
            }
        }

        var identifiers: [String] {
            switch self {
            
            case .applenews:
                return [AppleNewsCellLarge.identifier, AppleNewsCell.identifier, AppleNewsCellStacked.identifier]
            
            case .bbc:
                return [BBCCell.identifier]
            
            case .cnn:
                return [CNNCell.identifier]
            
                
           
            case .thenyt:
                return [NYTCell.identifier]
            
           
            }
        }

    }

}
