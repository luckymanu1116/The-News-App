//
//  Created by Manoj Reddy on 12/3/22.
//

import UIKit

class CNNHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CNNCell.identifier) as! CNNCell

        let article = articles[indexPath.row]
        cell.load(article: article, downloader: ImageDownloader.shared)

        return cell
    }

}
