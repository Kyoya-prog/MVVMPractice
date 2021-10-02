
import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController, UITextFieldDelegate {
    private let searchTextField = UITextField()
    private let repositoriesView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
    }
    
    private func setUpSubViews(){
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.layer.cornerRadius = 5
        searchTextField.layer.borderWidth = 1
        view.addSubview(searchTextField)
        
        repositoriesView.translatesAutoresizingMaskIntoConstraints = false
        repositoriesView.dataSource = self
        view.addSubview(repositoriesView)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 40),
            searchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -40),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            repositoriesView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            repositoriesView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            repositoriesView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            repositoriesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }
    
    
}





