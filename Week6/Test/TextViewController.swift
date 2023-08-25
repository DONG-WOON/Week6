//
//  TextViewController.swift
//  Week6
//
//  Created by 서동운 on 8/22/23.
//

import UIKit

class TextViewController: UIViewController {
    
    // 이미지 피커
    let picker = UIImagePickerController()
    
    // 폰트 피커
    let fontPicker = UIFontPickerViewController()
    
    // 컬러 피커
    let colorPicker = UIColorPickerViewController()
    
    // Closure
    let closureView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    // Computed Property
    var computedView: UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    // Lazy
    lazy var lazyView = setView()
    
    // init
    let photoImageView = UIImageView(.red)
    
    let titleTextField = CustomTextField(placeholder: "타이틀")
    
    let secondTitleTextField = CustomTextField(placeholder: "서브타이틀")
    
    let dateTextField = UITextField()
    
    override func loadView() {
        super.loadView()
        
        view = UIView(.white)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        view.addSubview(secondTitleTextField)
        
        photoImageView.contentMode = .scaleAspectFit
        
        photoImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        // margin
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(50)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        // no margin
        secondTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        // 2. available
//        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//            return
//        }
//
//        picker.allowsEditing = true
//        picker.sourceType = .camera //.photoLibrary
//        picker.delegate = self
//
//        present(picker, animated: true)
//    }
    
    func setView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
}

// MARK: - 재민님 익스텐션

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
    
    // 사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoImageView.image = image
            dismiss(animated: true)
        }
    }
}
