import UIKit

final class FirstViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "레이블"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "추가 +", style: .plain, target: self, action: #selector(buttonTouched(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        setupViews()
    }
    
    private func setupViews() {

        self.navigationItem.rightBarButtonItem = addButton
        let safeLayout = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeLayout.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: safeLayout.heightAnchor, multiplier: 0.07)
        ])
    }

    @objc private func buttonTouched(_ sender: Any) {
        let nextViewController = SecondViewController(viewModel: SecondViewModel())
        nextViewController.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

