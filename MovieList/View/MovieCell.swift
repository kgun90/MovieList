//
//  MovieCell.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import UIKit
import SnapKit
import Kingfisher

class MovieCell: UITableViewCell {
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var posterImage: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: Device.widthScale(80), height: Device.heightScale(104))
        return iv
    }()
    
    lazy var placeholder: UIImage = {
        let image = UIImage(systemName: "questionmark.folder")
        image?.withTintColor(.gray)
        return image!
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        
        return label
    }()
    
    lazy var actorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.tintColor = .systemGray
        btn.addTarget(self, action: #selector(actionFavorite(_:)), for: .touchUpInside)
        return btn
    }()
    
    var link = ""
    var data: MovieResponseItem?
    
    var movieData: MovieResponseItem? {
        didSet { configureData() }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    func actionFavorite(_ sender: UIButton) {
        guard let data = self.data else { return }
        if Favorite.checkItem(link: link) {
            Favorite.removeItem(item: data)
        } else {
            Favorite.storeItem(item: data)
        }
        reloadFavorite()
    }
        
    func configureData() {
        guard let data = movieData else { return }
        
        let url = URL(string: data.image ?? "")
    
        if data.image == "" {
            posterImage.contentMode = .scaleAspectFit
        }

        posterImage.kf.setImage(with: url, placeholder: placeholder)
        titleLabel.text = stringReplace(text: data.title)
        directorLabel.text = "감독: \(stringChange(text: data.director))"
        actorLabel.text = "출연: \(stringChange(text: data.actor))"
        userRatingLabel.text = "평점: \(data.userRating ?? "")"
        
        link = data.link ?? ""
        self.data = data
        reloadFavorite()
    }
    
    func reloadFavorite() {
        guard let data = self.data else { return }
        if Favorite.checkItem(link: data.link!) {
            favoriteButton.tintColor = .systemYellow
        } else {
            favoriteButton.tintColor = .systemGray
        }
    }
    
    func configureUI() {
        contentView.addSubview(background)
        
        background.addSubview(posterImage)
        background.addSubview(titleLabel)
        background.addSubview(directorLabel)
        background.addSubview(actorLabel)
        background.addSubview(userRatingLabel)
        background.addSubview(favoriteButton)
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(Device.screenWidth)
            $0.height.equalTo(Device.heightScale(104))
        }

        background.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.heightScale(104))
        }
        posterImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Device.widthScale(10))
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Device.widthScale(80))
            $0.height.equalTo(Device.heightScale(104))
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(posterImage.snp.top).offset(Device.heightScale(10))
        }
        
        directorLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(titleLabel.snp.bottom).offset(Device.heightScale(10))
        }
        
        actorLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(directorLabel.snp.bottom).offset(Device.heightScale(10))
            $0.width.equalTo(Device.screenWidth - Device.widthScale(100))
        }
        userRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(actorLabel.snp.bottom).offset(Device.heightScale(10))
        }
        favoriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(Device.widthScale(-10))
            $0.top.equalToSuperview().offset(Device.heightScale(10))
            $0.width.equalTo(Device.widthScale(15))
            $0.height.equalTo(Device.heightScale(15))
        }
    }
    
    func stringChange(text: String?) -> String {
        guard let text = text else { return "" }
        let removeLast = text.dropLast()
        return removeLast.replacingOccurrences(of: "|", with: ", ")
    }
    
    func stringReplace(text: String?) -> String {
        guard let text = text else { return "" }
        let first = "<b>"
        let last = "</b>"
        
        let removeFirst = text.replacingOccurrences(of: first, with: "")
        return removeFirst.replacingOccurrences(of: last, with: " ")
        
    }
}
