//
//  MainView.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    //    MARK: - Properties
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
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .line
        tf.clearButtonMode = .whileEditing
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var movieTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
        return tv
    }()

    //    MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.requestMovieAPI(count: 10)
      
        viewModel.setUserDefaults()
        bind()
        configureData()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        reloadTableView()
        
    }
    
    //    MARK: - Selectors
    @objc
    func actionFavorite() {
        let vc = FavoriteView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    MARK: - Helper
    func configureData() {
        searchTextField.delegate = self
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    func configureUI() {
        view.addSubview(titleView)
        view.addSubview(searchTextField)
        view.addSubview(movieTableView)
        
        titleView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(Device.navigationBarHeight)
            $0.top.equalToSuperview().offset(Device.statusBarHeight)
            $0.centerX.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Device.widthScale(10))
            $0.trailing.equalToSuperview().offset(Device.widthScale(-10))
            $0.height.equalTo(Device.heightScale(30))
            $0.top.equalTo(titleView.snp.bottom)
        }
        
        movieTableView.snp.makeConstraints {
            $0.width.equalTo(Device.screenWidth)
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    func moveToMoveDetail(data: MovieResponseItem) {
        let vc = MovieDetailView()
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func endEditing() {
        self.view.endEditing(false)
    }
    // 키보드 영역 이외 터치시 키보드 해제
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismissKeyboard()
    }
}

extension MainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.keyword = textField.text!
        viewModel.requestMovieAPI(count: 10)
        viewModel.movieData.value = [MovieResponseItem]()
        dismissKeyboard()        
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        viewModel.movieData.value = [MovieResponseItem]()
        return true
    }
}

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath as IndexPath) as! MovieCell
        cell.keyword = viewModel.keyword
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
