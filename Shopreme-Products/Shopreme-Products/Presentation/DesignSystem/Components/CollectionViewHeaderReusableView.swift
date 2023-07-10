//
//  CollectionViewHeaderReusableView.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit

struct CollectionViewHeaderReusableViewModel {
    
    static var empty: CollectionViewHeaderReusableViewModel { CollectionViewHeaderReusableViewModel(title: "") }
    
    let title: String
}

extension CollectionViewHeaderReusableViewModel: UIContentConfiguration {
    func makeContentView() -> UIView & UIContentView {
        let view = CollectionViewHeaderReusableView()
        view.configuration = self
        return view
    }
    
    func updated(for state: UIConfigurationState) -> CollectionViewHeaderReusableViewModel {
        self
    }
}

final class CollectionViewHeaderReusableView: UICollectionReusableView, UIContentView {

    enum Constants {
        static var labelInset: CGFloat { 10 }
    }

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .color(.deep_black_1)
        view.font = Assets.Fonts.Black.title2
        return view
    }()

    // MARK: - Configuration

    var configuration: UIContentConfiguration {
        didSet {
            apply(configuration)
        }
    }
    
    private func apply(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? CollectionViewHeaderReusableViewModel else { return }
        titleLabel.text = configuration.title
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        self.configuration = CollectionViewHeaderReusableViewModel.empty
        super.init(frame: frame)
        apply(configuration)
        prepareView()
    }

    required init?(coder: NSCoder) {
        self.configuration = CollectionViewHeaderReusableViewModel.empty
        super.init(coder: coder)
        apply(configuration)
        prepareView()
    }
    
    private func prepareView() {
        backgroundColor = .clear
        prepareLabel()
    }

    private func prepareLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.labelInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.labelInset),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.labelInset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.labelInset)
        ])
    }
}
