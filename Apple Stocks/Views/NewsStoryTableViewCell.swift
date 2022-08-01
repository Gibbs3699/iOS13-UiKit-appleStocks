//
//  NewsStoryTableViewCell.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 31/7/2565 BE.
//

import UIKit
import SDWebImage

class NewsStoryTableViewCell: UITableViewCell {

    static let preferredHeight: CGFloat = 140
    
    static let identifier = "NewsStoryTableViewCell"
    
    struct ViewModel {
        let source: String
        let headline: String
        let dateString: String
        let imageUrl: URL?
        
        init(model: NewsStory) {
            self.source = model.source
            self.headline = model.headline
            self.dateString = .string(from: model.datetime)
            self.imageUrl = URL(string: model.image)
        }
    }
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondaryLabel
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = nil
        backgroundColor = nil
        addSubviews(sourceLabel, headlineLabel, dateLabel, storyImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height/1.4
        storyImageView.frame = CGRect(
            x: contentView.width-imageSize-10,
            y: (contentView.height - imageSize) / 2,
            width: imageSize,
            height: imageSize
        )
        
        //Layout labels
        let availableWidth: CGFloat = contentView.width - separatorInset.left - imageSize - 15
        sourceLabel.sizeToFit()
        sourceLabel.frame = CGRect(x: separatorInset.left , y: 4, width: availableWidth, height: sourceLabel.height)
        
        headlineLabel.frame = CGRect(x: separatorInset.left , y: sourceLabel.bottom + 5, width: availableWidth, height: contentView.height - sourceLabel.bottom - dateLabel.height - 10)
        
        dateLabel.frame = CGRect(x: separatorInset.left , y: contentView.height - 40, width: availableWidth, height: 40)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceLabel.text = nil
        headlineLabel.text = nil
        dateLabel.text = nil
        storyImageView.image = nil
    }

    public func configure(with viewModel: ViewModel) {
        sourceLabel.text = viewModel.source
        headlineLabel.text = viewModel.headline
        dateLabel.text = viewModel.dateString
        storyImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
    }
}
