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
<img width="1136" alt="Screen Shot 2565-07-20 at 22 49 43" src="https://user-images.githubusercontent.com/57714919/180026787-a6c00148-3006-49da-95c1-20581d9844b5.png">

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

## Setup View for WatchListViewController.swift

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

## Extension.swift

    import Foundation
    import UIKit

    // MARK: - Framing

    extension UIView {
        /// Width of view
        var width: CGFloat {
            frame.size.width
        }

        /// Height of view
        var height: CGFloat {
            frame.size.height
        }

        /// Left edge of view
        var left: CGFloat {
            frame.origin.x
        }

        /// Right edge of view
        var right: CGFloat {
            left + width
        }

        /// Top edge of view
        var top: CGFloat {
            frame.origin.y
        }

        /// Bottom edge of view
        var bottom: CGFloat {
            top + height
        }
    }

## Setup View for SearchResultsViewController.swift

<img width="389" alt="Screen Shot 2565-07-19 at 22 56 34" src="https://user-images.githubusercontent.com/57714919/179795388-7b9ce684-98ed-41df-952d-2ba038d0efc3.png">


    import UIKit

    /// Delegate for search resutls
    protocol SearchResultsViewControllerDelegate: AnyObject {
        /// Notify delegate of selection
        /// - Parameter searchResult: Result that was picked
        func SearchResultsViewControllerDidSelect(searchResult: String)
    }

    class SearchResultsViewController: UIViewController {

        weak var delegate: SearchResultsViewControllerDelegate?

        private var results: [String] = []

        private let tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
            return tableView

        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        }

        private func setupTableView() {
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.contentInsetAdjustmentBehavior = .never

        }
  
        public func update(with results: [String]) {
            self.results = results
            tableView.reloadData()
        }
    }

    extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier, for: indexPath)

            cell.textLabel?.text = "AAPL"
            cell.detailTextLabel?.text = "Apple Inc."

            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            delegate?.SearchResultsViewControllerDidSelect(searchResult: "AAPL")
        }

    }

##### Setup View for SearchResultsTableViewCell.swift
    import UIKit

    class SearchResultsTableViewCell: UITableViewCell {

        static let identifier = "SearchResultsTableViewCell"

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }

## Passing data from View for SearchResultsViewController.swift to WatchListViewController.swift
We passing data when select SearchResultsTableViewCell to WatchListViewController to display details.

<img width="772" alt="Screen Shot 2565-07-19 at 23 01 27" src="https://user-images.githubusercontent.com/57714919/179796479-8105ead1-77b7-4111-8195-400e6936abbf.png">

<img width="940" alt="Screen Shot 2565-07-19 at 23 01 41" src="https://user-images.githubusercontent.com/57714919/179796529-359dcc87-841a-4c51-9544-de35eed10e1f.png">

<img width="1149" alt="Screen Shot 2565-07-19 at 23 02 37" src="https://user-images.githubusercontent.com/57714919/179796712-2d0a438b-3e7f-429d-a57f-940b9c7b3530.png">

## Passing data from View for WatchListViewController.swift to SearchResultsViewController.swift
Passing query data to SearchResultsViewController to display search result in SearchResultsTableViewCell.
<img width="1144" alt="Screen Shot 2565-07-19 at 23 03 59" src="https://user-images.githubusercontent.com/57714919/179797009-d02ea5a2-431b-48d4-a812-c8b70a0bbb22.png">

Call update function from SearchResultsViewController.swift
```
resultVC.update(with: ["AAPL"])
```
<img width="578" alt="Screen Shot 2565-07-19 at 23 04 38" src="https://user-images.githubusercontent.com/57714919/179797139-730f5006-db2d-4f6e-bef1-4ec29757d032.png">

# Building Safe URL in Swift Using URLQueryItem
Given a struct with constants to URL endpoints.
<img width="715" alt="Screen Shot 2565-07-20 at 22 41 53" src="https://user-images.githubusercontent.com/57714919/180025141-6c0a4cd9-0b71-4ada-b29a-ec766e55b58e.png">

Then create a search function that takes the query as an input, which will call the URL function to return the URL string and SearchResponse model to encode the JSON response as an object.

<img width="408" alt="Screen Shot 2565-07-20 at 22 59 20" src="https://user-images.githubusercontent.com/57714919/180028695-8e162fcd-d426-4d47-85be-30af3c14eeaa.png">

<img width="1160" alt="Screen Shot 2565-07-20 at 22 43 03" src="https://user-images.githubusercontent.com/57714919/180025417-176e9a7e-017f-44f5-aa6a-207e3e6d83e6.png">

<img width="1104" alt="Screen Shot 2565-07-20 at 22 45 52" src="https://user-images.githubusercontent.com/57714919/180025999-0f082db0-7aca-4714-bab2-e4464565832b.png">

Make the search API request in WatchListViewController.swift, and add a timer to optimize to reduce the number of searches for when user stops typing.

<img width="656" alt="Screen Shot 2565-07-20 at 22 53 45" src="https://user-images.githubusercontent.com/57714919/180027500-de41d009-5e3d-4cee-aee5-beeed4ea7c9e.png">

<img width="1132" alt="Screen Shot 2565-07-20 at 22 50 04" src="https://user-images.githubusercontent.com/57714919/180026839-12b9599e-fa71-42f2-ba95-a487cf40a764.png">

In SearchResultsViewController.swift, change from an array of string type to SearchResult, then update tableviewcell to display the actual results from API response.

```
private var results: [SearchResult] = []
```
<img width="1166" alt="Screen Shot 2565-07-20 at 22 57 52" src="https://user-images.githubusercontent.com/57714919/180028383-e86d9858-e4ec-4e65-8ee1-78749065472e.png">

# Present select search results

<img width="852" alt="Screen Shot 2565-07-20 at 23 11 36" src="https://user-images.githubusercontent.com/57714919/180031014-e1573e48-68a8-4573-9a82-36d9c4f71825.png">

# Create FloatingPanel using cocopods
Pod install FloatingPanel, then create setupFloatingPanel and extent WatchListViewController with FloatingPanelControllerDelegate
delegate to set the changing state of the floating panel.

<img width="733" alt="Screen Shot 2565-07-22 at 14 27 36" src="https://user-images.githubusercontent.com/57714919/180386896-92ca21a4-0833-4349-81b7-89a32a781c31.png">

<img width="857" alt="Screen Shot 2565-07-22 at 14 27 54" src="https://user-images.githubusercontent.com/57714919/180386937-178055f4-b75c-4dde-adfc-85e1386bf82b.png">

<img width="808" alt="Screen Shot 2565-07-22 at 14 28 05" src="https://user-images.githubusercontent.com/57714919/180386972-00d98f26-8f37-44c5-8102-a647153b426a.png">

# Create Child Component

# Date Formatter
    // MARK: - DateFormatter

    extension DateFormatter {
        static let dateformatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            return formatter
        }()
    }

# News Custom Cells
<img width="366" alt="Screen Shot 2565-07-31 at 22 56 23" src="https://user-images.githubusercontent.com/57714919/182034771-0c02c524-a679-403a-85dd-4be894abcac4.png">

# News ViewModels & Wire Up
<img width="426" alt="Screen Shot 2565-08-01 at 14 57 42" src="https://user-images.githubusercontent.com/57714919/182101097-7aa22f72-7c15-4af9-9902-9334c2989e79.png">

# Open News
<img width="419" alt="Screen Shot 2565-08-01 at 15 09 57" src="https://user-images.githubusercontent.com/57714919/182103323-256433f7-ec3b-4c80-8e71-d2ae44e738c1.png">

# Swipe To Delete
<img width="427" alt="Screen Shot 2565-08-06 at 00 18 33" src="https://user-images.githubusercontent.com/57714919/183128418-7e0e7ff9-0862-48c8-bd3d-5605361e9380.png">

# Create Stock Detail View
<img width="395" alt="Screen Shot 2565-08-06 at 16 58 19" src="https://user-images.githubusercontent.com/57714919/183244080-e81624eb-d903-4899-896c-241aa04281f1.png">

