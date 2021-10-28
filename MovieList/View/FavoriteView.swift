//
//  FavoriteView.swift
//  MovieList
//
//  Created by Geon Kang on 2021/10/27.
//

import UIKit
import SnapKit

class FavoriteView: UIViewController {
    var viewModel = FavoriteViewModel()
    private var data = [MovieResponseItem]()
    
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
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .systemGray
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
    
    lazy var favoriteTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MovieCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.getFavoriteData()
        bind()
        configureData()
        configureUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoriteData()
        reloadTableView()
        
    }
    
    func configureData() {
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
    }
    
    func configureUI() {
        view.addSubview(titleView)
        view.addSubview(favoriteTableView)
       
        titleView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.navigationBarHeight)
            $0.top.equalToSuperview().offset(Device.statusBarHeight)
            $0.centerX.equalToSuperview()
        }
        
        favoriteTableView.snp.makeConstraints {
            $0.width.equalTo(Device.screenWidth)
            $0.top.equalTo(titleView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc
    func dismissAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func moveToMoveDetail(data: MovieResponseItem) {
        let vc = MovieDetailView()
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func bind() {
        viewModel.favoriteData.bind { [weak self] items in
            self?.data = items
            self?.reloadTableView()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
}

extension FavoriteView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.favoriteTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MovieCell
        cell.movieData = data[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Device.heightScale(104)
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToMoveDetail(data: data[indexPath.row])
    }
}
