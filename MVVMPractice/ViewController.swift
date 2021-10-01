
import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController, UITextFieldDelegate {
    private let idTextField: UITextField! = UITextField()
    private let passwordTextField: UITextField! = UITextField()
    private let validationLabel: UILabel! = UILabel()

    private let vstack = UIStackView()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .equalSpacing
        vstack.addArrangedSubview(idTextField)
        vstack.addArrangedSubview(passwordTextField)
        vstack.addArrangedSubview(validationLabel)
        
        idTextField.layer.borderWidth = 1
        idTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        
        validationLabel.text = "validation"
        
        view.addSubview(vstack)
        NSLayoutConstraint.activate([
            idTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 200),
            vstack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            vstack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            vstack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -100)
        ])
    }
    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { me, color in
            me.validationLabel.textColor = color
        }
} }





