//
//  MainView.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    var viewModel = MovieViewModel()
    
    private var data = [MovieResponseItem]()
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(favoriteButton)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Device.widthScale(10))
            $0.centerY.equalToSuperview()
        }
        favoriteButton.snp.makeConstraints {
            $0.width.equalTo(Device.widthScale(80))
            $0.height.equalTo(Device.heightScale(40))
            $0.trailing.equalToSuperview().offset(Device.widthScale(-10))
            $0.centerY.equalToSuperview()
        }
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "네이버 영화 검색"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    lazy var favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("즐겨찾기", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(actionFavorite), for: .touchUpInside)
        return btn
    }()
    
    lazy var movieTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestMovieAPI(keyword: "내일", count: 10)
        view.backgroundColor = .white
        configureNavigationBar()
        bind()
        configureData()
        configureUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureUI() {
        view.addSubview(titleView)
        view.addSubview(movieTableView)
        
        titleView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.navigationBarHeight)
            $0.top.equalToSuperview().offset(Device.statusBarHeight)
            $0.centerX.equalToSuperview()
        }

        movieTableView.snp.makeConstraints {
            $0.width.equalTo(Device.screenWidth)
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureData() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    @objc
    func actionFavorite() {
        Log.any("favorite")
        let vc = FavoriteView()
        self.present(vc, animated: true, completion: nil)
    }
    
    func bind() {
        viewModel.movieData.bind { [weak self] items in
            self?.data = items
            self?.reloadTableView()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
    func moveToMoveDetail(data: MovieResponseItem) {
        let vc = MovieDetailView()
        vc.movieData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = true
        navigationItem.backButtonTitle = ""
    }
}

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath as IndexPath) as! MovieCell
        cell.movieData = data[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToMoveDetail(data: data[indexPath.row])
    }
}
