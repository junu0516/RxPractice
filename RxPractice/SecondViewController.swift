import UIKit
import RxSwift
import RxCocoa

final class SecondViewController: UIViewController {
    
    private var titleForm: CustomForm = {
        let textField = UITextField()
        textField.placeholder = "필수 입력"
        
        let form = CustomForm(title: "제목", textField: textField)
        form.translatesAutoresizingMaskIntoConstraints = false
        form.backgroundColor = .white
        return form
    }()
    
    private var descriptionForm: CustomForm = {
        let textField = UITextField()
        textField.placeholder = "선택 사항"
        
        let form = CustomForm(title: "설명", textField: textField)
        form.translatesAutoresizingMaskIntoConstraints = false
        form.backgroundColor = .white
        return form
    }()
    
    private let randomColors: [String] = ["#FFFFFF", "#3DDCFF", "#2F2F2F", "#DDDDDD"]
    private lazy var colorForm: CustomForm = {
        let textField = UITextField()
        textField.text = "#FFFFFF"
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.sizeToFit()
        button.addAction(UIAction(handler:{ _ in
            textField.text = self.randomColors.randomElement()
        }), for: .touchDown)
        
        textField.rightViewMode = .always
        textField.rightView = button
        
        let form = CustomForm(title: "배경색", textField: textField)
        form.translatesAutoresizingMaskIntoConstraints = false
        form.backgroundColor = .white
        return form
    }()
    
    private var formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private var labelBox: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var previewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "레이블"
        label.backgroundColor = .blue
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let disposeBag = DisposeBag()
    private var viewModel: SecondViewModel
    init(viewModel: SecondViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.navigationItem.title = "새로운 레이블"
        self.setupViews()
        self.bind()
    }
    
    private func bind() {
        /*
            - titleForm의 textField에 입력된 문자열을 읽어들임(input)
            - 읽어들인 문자열을 뷰모델의 Observable한 속성에 바인딩
         */
        self.titleForm
            .textField.rx.text.orEmpty
            .bind(to: viewModel.titleValue)
            .disposed(by: disposeBag)
        
        /*
            - 뷰모델의 속성변화를 감지
            - 뷰모델의 변화된 속성값을 읽어들여 뷰에 출력
         */
        self.viewModel.titleValue
            .bind(to: previewLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        let safeLayout = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(formStackView)
        formStackView.addArrangedSubview(titleForm)
        formStackView.addArrangedSubview(descriptionForm)
        formStackView.addArrangedSubview(colorForm)
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: safeLayout.topAnchor, constant: 20),
            formStackView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor)
        ])
        
        self.view.addSubview(labelBox)
        NSLayoutConstraint.activate([
            labelBox.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 20),
            labelBox.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor, constant: 20),
            labelBox.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor, constant: -20),
            labelBox.heightAnchor.constraint(equalTo: safeLayout.heightAnchor, multiplier: 0.3)
        ])
        
        self.labelBox.addSubview(previewLabel)
        NSLayoutConstraint.activate([
            previewLabel.centerXAnchor.constraint(equalTo: labelBox.centerXAnchor),
            previewLabel.centerYAnchor.constraint(equalTo: labelBox.centerYAnchor),
            previewLabel.heightAnchor.constraint(equalTo: labelBox.heightAnchor, multiplier: 0.13)
        ])
    }
}
