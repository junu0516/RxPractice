import UIKit

final class CustomForm: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private (set)var textField: UITextField
    
    init(title: String, textField: UITextField) {
        self.titleLabel.text = title
        self.textField = textField
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let safeLayout = self.safeAreaLayoutGuide
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeLayout.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalTo: safeLayout.widthAnchor, multiplier: 0.3),
            titleLabel.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor, constant: -10)
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeLayout.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textField.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor, constant: -15),
            textField.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor, constant: -10)
        ])
    }
}
