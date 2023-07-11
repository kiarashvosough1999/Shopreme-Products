//
//  ProductView.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit
import Combine

final class ProductCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static var backgroundColor: UIColor? { .color(.white) }
        static var cornerRadius: CGFloat { 16 }
        static var shadowColor: CGColor? { UIColor.color(.white)?.cgColor }
        static var shadowOpacity: Float { 1 }
        static var shadowOffset: CGSize { CGSize(width: 0, height: 3) }
        static var shadowRadius: CGFloat { 6 }

        static var verticalStackViewEdgeSpacing: CGFloat { 16 }
        static var verticalStackViewSpacing: CGFloat { 8 }
        static var titleLabelNumberOfLines: Int { 0 }
        static var titleLabelTextColor: UIColor? { .color(.deep_black_3) }
        static var titleLabelFont: UIFont { Assets.Fonts.Medium.title3 }
        static var horizontalStackViewSpacing: CGFloat { 8 }
        static var priceLabelNumberOfLines: Int { 1 }
        static var priceLabelTextColor: UIColor? { .color(.deep_black_2) }
        static var priceLabelFont: UIFont { Assets.Fonts.Black.body }
    }
    
    // MARK: - Views

    private lazy var verticalStackView: UIStackView = UIStackView()
    private lazy var imageView: AsyncUIImageView = AsyncUIImageView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var horizontalStackView: UIStackView = UIStackView()
    private lazy var priceLabel: UILabel =  UILabel()
    private lazy var strikeLabel: StrikeLabel = StrikeLabel()

    // MARK: - Properties

    private var cancellables: Set<AnyCancellable>
    var viewModel: ProductCollectionViewCellViewModelProtocol? {
        didSet {
            bindToViewModel()
        }
    }

    private func bindToViewModel() {
        guard let viewModel else { return }
        viewModel
            .imageLoadedPublisher
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .compactMap { UIImage(data: $0) }
            .assign(to: \.image, on: self.imageView)
            .store(in: &cancellables)

        self.titleLabel.text = viewModel.model.title
        self.priceLabel.text = viewModel.model.price
        self.strikeLabel.setText(beforeStrike: viewModel.model.strikePrefix, strike: viewModel.model.strikePrice)
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        cancellables = Set<AnyCancellable>()
        super.init(frame: frame)
        prepareViews()
    }

    required init?(coder: NSCoder) {
        cancellables = Set<AnyCancellable>()
        super.init(coder: coder)
        prepareViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll(keepingCapacity: true)
    }
    
    // MARK: - Preparing Views

    private func prepareViews() {
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowColor = Constants.shadowColor
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowRadius = Constants.shadowRadius

        prepareVerticalStackView()
        prepareImageView()
        prepareTitleLabel()
        prepareHorizontalStackView()
        preparePriceLabel()
        prepareStrikeLabel()
    }
    
    private func prepareVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 8
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStackView)
        
        verticalStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        verticalStackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.verticalStackViewEdgeSpacing),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalStackViewEdgeSpacing),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.verticalStackViewEdgeSpacing),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalStackViewEdgeSpacing),
        ])
    }
    
    private func prepareImageView() {
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        verticalStackView.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
    
    private func prepareTitleLabel() {
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        titleLabel.textAlignment = .left
        titleLabel.textColor = Constants.titleLabelTextColor
        titleLabel.font = Constants.titleLabelFont
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        verticalStackView.addArrangedSubview(titleLabel)
    }
    
    private func prepareHorizontalStackView() {
        horizontalStackView.spacing = Constants.horizontalStackViewSpacing
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        verticalStackView.addArrangedSubview(horizontalStackView)
    }
    
    private func preparePriceLabel() {
        priceLabel.numberOfLines = Constants.priceLabelNumberOfLines
        priceLabel.textAlignment = .left
        priceLabel.textColor = Constants.priceLabelTextColor
        priceLabel.font = Constants.priceLabelFont
        horizontalStackView.addArrangedSubview(priceLabel)
    }

    private func prepareStrikeLabel() {
        horizontalStackView.addArrangedSubview(strikeLabel)
    }
}
