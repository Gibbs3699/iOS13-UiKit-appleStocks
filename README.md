# iOS13-UiKit-appleStocks

# Reuseable APICaller
  
    import Foundation

    final class APICaller {
        static let shared = APICaller()

        private struct Constant {
            let apiKey = ""
            let sandboxApiKey = ""
            let baseURL = ""
        }

        private init() {

        }

        // MARK: - Public

        // MARK: - Private

        private enum EndPoint: String {
            case search
        }

        private enum APIError: Error {
            case invalidURL
            case noDataReturned
        }

        private func url(for endPoint: EndPoint, queryParams: [String: String] = [:]) -> URL? {

            return nil
        }

        private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

            guard let url = url else {
                completion(.failure(APIError.invalidURL))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch  {
                completion(.failure(error))
            }
        }

        task.resume()

    }

}

# Search Result & TitleView

<img width="419" alt="Screen Shot 2565-07-19 at 17 24 52" src="https://user-images.githubusercontent.com/57714919/179728947-027cf1b8-88ea-439d-910e-3111ebb2ae81.png">

## Search Result

      import UIKit

      class WatchListViewController: UIViewController {

          override func viewDidLoad() {
              super.viewDidLoad()
              // Do any additional setup after loading the view.
              view.backgroundColor = .systemBackground

              setupSearchController()
              setupTitle()
          }


          private func setupTitle() {
              let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: navigationController?.navigationBar.height ?? 100))

              let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width-20 , height: titleView.height))

              label.text = "Stocks"
              label.font = .systemFont(ofSize: 40, weight: .medium)
              titleView.addSubview(label)

              navigationItem.titleView = titleView
          }

          private func setupSearchController() {
              let resultVC = SearchResultsViewController()
              let searchVC = UISearchController(searchResultsController: resultVC)
              searchVC.searchResultsUpdater = self
              navigationItem.searchController = searchVC
          }
      }

      extension WatchListViewController: UISearchResultsUpdating {
          func updateSearchResults(for searchController: UISearchController) {
                guard let query = searchController.searchBar.text,
                    let resultVC = searchController.searchResultsController as? SearchResultsViewController, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }

            }
        }



