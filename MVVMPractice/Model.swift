import RxSwift
import Foundation
import UIKit

struct Repository{
    var title:String
}

protocol ModelProtocol {
    var view:UIViewController?{get set}
    func searchRepositories(keyword:String)->Single<[Repository]>
}
final class Model: ModelProtocol {
    var view: UIViewController?
    func searchRepositories(keyword: String)->Single<[Repository]> {
        return Single<[Repository]>.create { observer -> Disposable in
            let url = "https://api.github.com/search/repositories?q=\(keyword)"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { [weak self](data, res, err) in
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        let results = items.map{Repository(title: $0["full_name"] as? String ?? "")}
                        observer(.success(results))
                    }
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}
