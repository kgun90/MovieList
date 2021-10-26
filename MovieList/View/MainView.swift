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
    
    var data = [MovieResponseItem]()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var movieTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.keyword = "무간도"
        viewModel.requestMovieAPI()
        view.backgroundColor = .white
        
        bind()
        configureData()
        configureUI()
    }
    
    func configureUI() {
//        view.addSubview(label)
        view.addSubview(movieTableView)
     
        movieTableView.snp.makeConstraints {
            $0.center.edges.equalToSuperview()
        }
    }
    
    func configureData() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
        
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


}
