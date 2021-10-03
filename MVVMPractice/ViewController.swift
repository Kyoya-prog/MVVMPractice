
import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController, UITextFieldDelegate {
    private let searchTextField = UITextField()
    private let repositoriesView = UITableView()
    
    private let input: Input
    private let output: Output
    private let disposeBag = DisposeBag()
    
    init(viewModel: Input & Output = ViewModel()) {
        self.input = viewModel
        self.output = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubViews()
        inputBind()
        outputBind()
    }
    
    private func setUpSubViews(){
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.layer.cornerRadius = 5
        searchTextField.layer.borderWidth = 1
        view.addSubview(searchTextField)
        
        repositoriesView.translatesAutoresizingMaskIntoConstraints = false
        repositoriesView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        //repositoriesView.dataSource = self
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
    
    private func inputBind(){
        searchTextField.rx.text.orEmpty.asObservable().bind(to: input.searchKeyword).disposed(by: disposeBag)
    }
    
    private func outputBind(){
        output.repositories.bind(to: repositoriesView.rx.items(cellIdentifier: "test")){_, repository, cell in
            cell.textLabel?.text = repository.title
        }.disposed(by: disposeBag)
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





