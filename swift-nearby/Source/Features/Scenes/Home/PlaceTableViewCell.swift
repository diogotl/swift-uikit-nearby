//
//  PlaceTableViewCell.swift
//  swift-nearby
//
//  Created by Diogo on 03/02/2026.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    static let identifier = "SimpleCustomCell"

    let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: ""))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.textSM
        label.textColor = Colors.gray500
        label.numberOfLines = 1
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.titleSM
        return label
    }()

    let logoCupons: UIImageView = {
        let logo = UIImageView(image: UIImage(systemName: "tag.fill"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.tintColor = .systemBlue
        logo.contentMode = .scaleAspectFit
        return logo
    }()


    let availableCupons: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.textXS
        label.textColor = Colors.gray400
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.gray200.cgColor
        self.clipsToBounds = true

        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(logoCupons)
        contentView.addSubview(availableCupons)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            image.widthAnchor.constraint(equalToConstant: 116),
            image.heightAnchor.constraint(equalToConstant: 104),

            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:8),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),

            logoCupons.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 4),
            logoCupons.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),

            availableCupons.leadingAnchor.constraint(equalTo: logoCupons.trailingAnchor, constant: 4),
            availableCupons.bottomAnchor.constraint(equalTo: logoCupons.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with place:Place) {
        titleLabel.text = place.name
        subtitleLabel.text = place.description
        availableCupons.text = "\(place.coupons) cupons"
        
        loadImage(from: place.cover)
    }
    
    private func loadImage(from urlString: String) {
        image.image = nil
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("Failed to create image from data")
                return
            }
            
            DispatchQueue.main.async {
                self?.image.image = downloadedImage
            }
        }.resume()
    }
}
