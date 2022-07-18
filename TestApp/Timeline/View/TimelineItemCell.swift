//
//  TimelineItemCell.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 17.07.2022.
//

import UIKit

final class TimelineItemCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var subsiteIconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var subsiteNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.setContentCompressionResistancePriority(.defaultHigh + 2, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.65)
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }
    
    private func makeCoverImageView() -> WebImageView {
        let imageView = WebImageView()
        return imageView
    }
    
    private lazy var commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "commentsIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black.withAlphaComponent(0.65)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    override func prepareForReuse() {
        subsiteIconImageView.image = nil
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.preservesSuperviewLayoutMargins = false
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(contentStackView)

        containerView.addSubview(subsiteIconImageView)
        containerView.addSubview(subsiteNameLabel)
        containerView.addSubview(authorNameLabel)
        containerView.addSubview(dateLabel)
        
        containerView.addSubview(commentsImageView)
        containerView.addSubview(commentsLabel)
        containerView.addSubview(likesLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            subsiteIconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            subsiteIconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            subsiteIconImageView.heightAnchor.constraint(equalToConstant: 22),
            subsiteIconImageView.widthAnchor.constraint(equalToConstant: 22),

            subsiteNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            subsiteNameLabel.leadingAnchor.constraint(equalTo: subsiteIconImageView.trailingAnchor, constant: 8),

            authorNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            authorNameLabel.leadingAnchor.constraint(equalTo: subsiteNameLabel.trailingAnchor, constant: 12),
            
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16),
            
            contentStackView.topAnchor.constraint(equalTo: subsiteNameLabel.bottomAnchor, constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            commentsImageView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 12),
            commentsImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            commentsImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            commentsImageView.heightAnchor.constraint(equalToConstant: 24),
            commentsImageView.widthAnchor.constraint(equalToConstant: 24),
            
            commentsLabel.leadingAnchor.constraint(equalTo: commentsImageView.trailingAnchor, constant: 4),
            commentsLabel.centerYAnchor.constraint(equalTo: commentsImageView.centerYAnchor),
            
            likesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            likesLabel.centerYAnchor.constraint(equalTo: commentsImageView.centerYAnchor)
        ])
    }
    
    func configure(with viewModel: TimelineItemViewModel) {
        subsiteIconImageView.loadImage(url: "https://leonardo.osnova.io/\(viewModel.model.data.subsite.avatar.data.uuid)")
        subsiteNameLabel.text = viewModel.model.data.subsite.name
        authorNameLabel.text = viewModel.model.data.author.name
        dateLabel.text = formatDate(date: viewModel.model.data.date)
        contentView.directionalLayoutMargins = viewModel.margins
        setupContentStackView(data: viewModel.model.data)
        commentsLabel.text = String(viewModel.model.data.counters.comments)
        likesLabel.text = String(viewModel.model.data.likes.counter)
    }
    
    private func formatDate(date: Int) -> String {
        let timeInterval = Date().timeIntervalSince(Date(timeIntervalSince1970: TimeInterval(date)))
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.day, .hour]
        return formatter.string(from: timeInterval) ?? ""
    }
    
    private func setupContentStackView(data: TimelineItemDataModel) {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        if !data.title.isEmpty {
            let titleLabel = makeTitleLabel()
            titleLabel.text = data.title
            contentStackView.addArrangedSubview(titleLabel)
        }
        data.blocks.filter { $0.cover }.forEach {
            switch $0.data {
            case let .text(model):
                let descriptionLabel = makeDescriptionLabel()
                descriptionLabel.text = model.text
                contentStackView.addArrangedSubview(descriptionLabel)
            case let .media(model):
                model.items.forEach { item in
                    let coverImageView = makeCoverImageView()
                    coverImageView.loadImage(url: "https://leonardo.osnova.io/\(item.image.data.uuid)")
                    contentStackView.addArrangedSubview(coverImageView)
                }
            case let .telegram(model):
                print(model)
            case .unknown:
                break
            }
        }
    }
}
