//
//  Created by Kushagra & jaskirat on 4/2/22.
//

import UIKit

class NYTHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NYTCell.identifier) as! NYTCell

        let article = articles[indexPath.row]
        cell.load(article: article, downloader: ImageDownloader.shared)

        return cell
    }

}
