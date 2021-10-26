//
//  MovieCell.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import UIKit
import SnapKit

class MovieCell: UITableViewCell {
    lazy var posterImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.fill.questionmark")
        iv.frame = CGRect(x: 0, y: 0, width: Device.widthScale(80), height: Device.heightScale(104))
        return iv
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
    
    var movieData: MovieResponseItem? {
        didSet { configureData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.frame = CGRect(x: 0, y: 0, width: Device.screenWidth, height: Device.heightScale(104))
        contentView.backgroundColor = .white
        configureUI()
    }
    
    func configureData() {
        guard let data = movieData else { return }
        titleLabel.text = data.title ?? ""
        directorLabel.text = "감독: \(data.director ?? "")"
        actorLabel.text = "출연: \(data.actor ?? "")"
        userRatingLabel.text = "평점: \(data.userRating ?? "")"
    }
    
    func configureUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(directorLabel)
        contentView.addSubview(actorLabel)
        contentView.addSubview(userRatingLabel)
        
        posterImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Device.widthScale(10))
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Device.widthScale(80))
            $0.height.equalTo(Device.heightScale(104))
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(posterImage.snp.top)
        }
        
        directorLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(titleLabel.snp.bottom).offset(Device.heightScale(10))
        }
        
        actorLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(directorLabel.snp.bottom).offset(Device.heightScale(10))
        }
        userRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(actorLabel.snp.bottom).offset(Device.heightScale(10))
        }
    }
    
    
    
}
