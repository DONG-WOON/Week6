//
//  Example2ViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

class Example2ViewController: UIViewController {
    
    var user: User
    
    let backgroundImageView = UIImageView(image: UIImage(named: "churros"))
    lazy var closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(closeButtonDidTapped))
    lazy var shopButton = UIBarButtonItem(image: UIImage(systemName: "shippingbox.circle"),
                                          style: .done,
                                          target: self,
                                          action: #selector(shopButtonDidTapped))
    lazy var qrCodeButton = UIBarButtonItem(image: UIImage(systemName: "qrcode.viewfinder"),
                                            style: .done,
                                            target: self,
                                            action: #selector(qrCodeButtonDidTapped))
    lazy var settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.circle"),
                                             style: .done,
                                             target: self,
                                             action: #selector(settingButtonDidTapped))
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 35
        return imageView
    }()
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    let profileMessageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    let separateBar = UIView(.lightGray)
    let chatWithMeButton = KakaoProfileButton(image: UIImage(systemName: "message.fill"),
                                              title: "나와의 채팅",
                                              imagePadding: 15)
    let profileEditButton = KakaoProfileButton(image: UIImage(systemName: "pencil"),
                                               title: "프로필 편집",
                                               imagePadding: 15)
    let kakaoStoryButton = KakaoProfileButton(image: UIImage(systemName: "apple.logo"),
                                              title: "카카오스토리",
                                              imagePadding: 15)
    lazy var stackView = UIStackView(arrangedSubviews: [chatWithMeButton, profileEditButton, kakaoStoryButton])
    
    init() {
        self.user = User(nickname: "Jack", profileImageURL: "", backgroundImageURL: "", profileMessage: "프로필 상태메세지")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureViews()
        configureViewConstraints()
        
        update(data: user)
    }
    
    func update(data: User) {
        nicknameLabel.text = data.nickname
        profileMessageLabel.text = data.profileMessage
        profileImageView.image = UIImage(named: "person_noImage")
    }
    
    @objc func closeButtonDidTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func shopButtonDidTapped() {
        
    }
    
    @objc func qrCodeButtonDidTapped() {
        
    }
    
    @objc func settingButtonDidTapped() {
        
    }
}

extension Example2ViewController: ConfigureViewProtocol {
    
    func configureViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(profileImageView)
        view.addSubview(nicknameLabel)
        view.addSubview(profileMessageLabel)
        view.addSubview(separateBar)
        view.addSubview(stackView)
        
        stackView.spacing = 10
        stackView.distribution = .fillEqually
    }
    
    func configureViewConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
        }
        
        profileMessageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
        }
        
        separateBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(profileMessageLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(separateBar.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureNavigation() {
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItems = [settingButton, qrCodeButton, shopButton]
    }
}
