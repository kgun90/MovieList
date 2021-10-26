//
//  FavoriteView.swift
//  MovieList
//
//  Created by Geon Kang on 2021/10/27.
//

import UIKit

class FavoriteView: UIViewController {
    var viewModel = FavoriteViewModel()
    
    lazy var background: UIView = {
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
        tv.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
        return tv
    }()
    
    private var data = [MovieResponseItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.getFavoriteData()
        bind()
        configureData()
        configureUI()
    }

    func configureData() {
        favoriteTableView.dataSource = self
        favoriteTableView.dataSource = self
    }
    
    func configureUI() {
        view.addSubview(background)
       
        view.addSubview(favoriteTableView)
        
        background.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.navigationBarHeight)
            $0.centerX.top.equalToSuperview()
        }
        
      
        favoriteTableView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(Device.navigationBarHeight)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func bind() {
        viewModel.favoriteData.bind { [weak self] items in
            self?.data = items
            self?.reloadTableView()
        }
    }
    
    @objc
    func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
}

extension FavoriteView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = UserDefaults.items else { return 0 }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.favoriteTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath as IndexPath) as! MovieCell
        cell.movieData = UserDefaults.items![indexPath.row]

        return cell
    }
}
