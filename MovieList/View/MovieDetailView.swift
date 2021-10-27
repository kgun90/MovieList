//
//  MovieDetailView.swift
//  MovieList
//
//  Created by 강건 on 2021/10/27.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailView: UIViewController {
    var data: MovieResponseItem?
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(dismissButton)
        view.addSubview(titleLabel)
        
        dismissButton.snp.makeConstraints {
            $0.width.equalTo(Device.widthScale(30))
            $0.height.equalTo(Device.heightScale(30))
            $0.leading.equalToSuperview().offset(Device.widthScale(20))
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        return view
    }()
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "즐겨찾기 목록"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    
    lazy var movieInfoView: UIView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureData()
        configureUI()
    }
    
    @objc
    func actionFavorite(_ sender: UIButton) {
        guard let data = self.data else { return }
        
        if Favorite.checkItem(link: data.link ?? "") {
            Favorite.removeItem(item: data)
        } else {
            Favorite.storeItem(item: data)
        }
        
        reloadFavorite()
    }
        
    func reloadFavorite() {
        guard let data = self.data else { return }
        if Favorite.checkItem(link: data.link ?? "") {
            favoriteButton.tintColor = .systemYellow
        } else {
            favoriteButton.tintColor = .systemGray
        }
    }
    @objc
    func dismissAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureData() {
        guard let data = self.data else { return }

        let url = URL(string: data.image ?? "")
    
        if data.image == "" {
            posterImage.contentMode = .scaleAspectFit
        }

        posterImage.kf.setImage(with: url, placeholder: placeholder)
        
        titleLabel.text = data.title?.removeTag() ?? ""
        directorLabel.text = "감독: \(data.director?.replaceBar() ?? "")"
        actorLabel.text = "출연: \(data.actor?.replaceBar() ?? "")"
        userRatingLabel.text = "평점: \(data.userRating ?? "")"
        
        reloadFavorite()
    }
    
    func configureUI() {
        view.addSubview(titleView)
        view.addSubview(movieInfoView)
        
        movieInfoView.addSubview(posterImage)
        movieInfoView.addSubview(directorLabel)
        movieInfoView.addSubview(actorLabel)
        movieInfoView.addSubview(userRatingLabel)
        movieInfoView.addSubview(favoriteButton)

        titleView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.navigationBarHeight)
            $0.top.equalToSuperview().offset(Device.statusBarHeight)
            $0.centerX.equalToSuperview()
        }
        
        movieInfoView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.heightScale(104))
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleView.snp.bottom)
        }
        
        posterImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Device.widthScale(10))
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Device.widthScale(80))
            $0.height.equalTo(Device.heightScale(104))
        }
      
        directorLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.bottom.equalTo(actorLabel.snp.top).offset(Device.heightScale(-15))
        }
        actorLabel.snp.makeConstraints {
            $0.width.equalTo(Device.screenWidth - Device.widthScale(100))
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.centerY.equalToSuperview()
        }
        
        userRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.trailing).offset(Device.widthScale(10))
            $0.top.equalTo(actorLabel.snp.bottom).offset(Device.heightScale(15))
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(Device.widthScale(-10))
            $0.top.equalToSuperview().offset(Device.heightScale(10))
            $0.width.equalTo(Device.widthScale(20))
            $0.height.equalTo(Device.heightScale(20))
        }
    }
}
