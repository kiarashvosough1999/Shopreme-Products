//
//  LabledActivityView.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit

struct LabledActivityViewModel {
    let loadingDescription: String
}

extension LabledActivityViewModel: UIContentConfiguration {
    
    static var empty: LabledActivityViewModel { LabledActivityViewModel(loadingDescription: "") }
    
    func makeContentView() -> UIView & UIContentView {
        LabledActivityView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> LabledActivityViewModel {
        self
    }
}

final class LabledActivityView: UIView, UIContentView {

    enum Constants {
        static var activityIndicatorViewColor: UIColor? { .color(.light_gray) }
        static var titleLabelNumberOfLines: Int { 1 }
        static var titleLabelTextColor: UIColor? { .color(.light_gray) }
        static var titleLabelFont: UIFont { Assets.Fonts.Regular.body }
    }
    
    // MARK: - Configuration

    var configuration: UIContentConfiguration {
        didSet {
            apply(configuration)
        }
    }
    
    private func apply(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? LabledActivityViewModel else { return }
        titleLabel.text = configuration.loadingDescription
    }
    
    // MARK: - Views

    private lazy var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private lazy var titleLabel: UILabel = UILabel()

    // MARK: - LifeCycle

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        prepareViews()
        apply(configuration)
    }
    
    required init?(coder: NSCoder) {
        self.configuration = LabledActivityViewModel.empty
        super.init(coder: coder)
        prepareViews()
    }

    deinit {
        activityIndicatorView.stopAnimating()
    }
    
    // MARK: - Preparing Views

    private func prepareViews() {
        prepareActivityIndicatorView()
        prepareTitleLabel()
    }

    private func prepareActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = Constants.activityIndicatorViewColor

        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func prepareTitleLabel() {
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        titleLabel.textAlignment = .center
        titleLabel.textColor = Constants.titleLabelTextColor
        titleLabel.font = Constants.titleLabelFont

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
