//
//  TimelineItemCell.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 17.07.2022.
//

import UIKit
import Kingfisher

final class TimelineItemCell: UITableViewCell {
    
    weak var delegate: TimelineViewDelegate?
    
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
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var subsiteIconImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    private func makeTitleLabel() -> PaddingLabel {
        let label = PaddingLabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return label
    }
    
    private func makeDescriptionLabel() -> PaddingLabel {
        let label = PaddingLabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return label
    }
    
    private func makeCoverImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none
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
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
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
    
    @objc private func imageViewTapped(_ sender: UITapGestureRecognizer) {
        let imageView = contentStackView.arrangedSubviews.first { $0 is UIImageView } as? UIImageView
        if let image = imageView?.image {
            delegate?.openImage(image: image)
        }
    }
    
    func configure(with viewModel: TimelineItemViewModel) {
        contentView.directionalLayoutMargins = viewModel.margins
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        setupSubsiteIcon(imageUid: viewModel.subsiteIconUid)
        subsiteNameLabel.text = viewModel.subsiteName
        authorNameLabel.text = viewModel.authorName
        dateLabel.text = viewModel.date
        addTitleBlock(text: viewModel.title)
        viewModel.blocks.forEach {
            switch $0.data {
            case let .text(model):
                addDescriptionBlock(text: model.text)
            case let .media(model):
                model.items.forEach {
                    addImageBlock(model: $0)
                }
            case .telegram, .unknown:
                break
            }
        }
        commentsLabel.text = viewModel.comments
        likesLabel.text = viewModel.likes
    }
    
    private func setupSubsiteIcon(imageUid: String) {
        if let url = URL(string: "https://leonardo.osnova.io/\(imageUid)"), !imageUid.isEmpty {
            subsiteIconImageView.kf.setImage(with: url)
        }
    }

    private func addTitleBlock(text: String) {
        guard !text.isEmpty else { return }
        let titleLabel = makeTitleLabel()
        titleLabel.text = text
        contentStackView.addArrangedSubview(titleLabel)
    }
    
    private func addDescriptionBlock(text: String) {
        guard !text.isEmpty else { return }
        let descriptionLabel = makeDescriptionLabel()
        descriptionLabel.text = text
        contentStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func addImageBlock(model: BlockMediaItemModel) {
        let coverImageView = makeCoverImageView()
        if let url = URL(string: "https://leonardo.osnova.io/\(model.image.data.uuid)"), !model.image.data.uuid.isEmpty {
            coverImageView.kf.setImage(with: url)
        }
        coverImageView.heightAnchor.constraint(
            lessThanOrEqualTo: coverImageView.widthAnchor,
            multiplier: CGFloat(model.image.data.height / model.image.data.width)
        ).isActive = true
        contentStackView.addArrangedSubview(coverImageView)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(TimelineItemCell.imageViewTapped(_:)))
        contentStackView.addGestureRecognizer(recognizer)
    }
}
