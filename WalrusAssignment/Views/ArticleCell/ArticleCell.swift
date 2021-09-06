//
//  ArticleCellTableViewCell.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.
//

import UIKit


protocol  ArticleCellDelegate: NSObject {
    func didSeeFullNewsPressed(url: String, title: String)
}

class ArticleCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var content: UILabel!
    
    weak var delegate: ArticleCellDelegate?
    private var viewModel: ArticleCellViewModel?
    private var parentViewModel: ArticleListViewModel?
    private var url: String?
    private var articletitle: String?
    
    func update(with viewModel: ArticleCellViewModel) {
        self.viewModel = viewModel
        title.text = viewModel.title
        author.text = viewModel.author
        let url = URL(string: viewModel.image)
        thumbnail.cf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo"))
        content.text = viewModel.content
        self.url = viewModel.url
        self.articletitle = viewModel.title
    }
    
    @IBAction func didSeeFullNewsPressed(_ sender: Any) {
        if let url = url, let title = articletitle {
            delegate?.didSeeFullNewsPressed(url: url, title: title)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
