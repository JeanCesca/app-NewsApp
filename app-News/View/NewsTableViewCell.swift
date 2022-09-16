//
//  NewsTableViewCell.swift
//  app-News
//
//  Created by Jean Ricardo Cesca on 05/09/22.
//

import Foundation
import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -14),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: newsTitleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: newsTitleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor),
            
            newsImageView.topAnchor.constraint(equalTo: newsTitleLabel.topAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
//            newsImageView.heightAnchor.constraint(equalToConstant: 160),
            newsImageView.widthAnchor.constraint(equalToConstant: 145)
        ])
    }
    
    public func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                viewModel.imageData = data
                
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    
}
