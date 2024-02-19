import UIKit
import Alamofire

struct Quote: Decodable {
    let quote: String
}

class ViewController: UIViewController {

    @IBOutlet weak var lblQuotes: UILabel!
    
    @IBAction func btnRefresh(_ sender: UIButton) {
        fetchQuote()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuote()
    }
    
    func fetchQuote() {
        // Alamofire GET request
        AF.request("https://ron-swanson-quotes.herokuapp.com/v2/quotes").responseString { response in
            switch response.result {
            case .success(let quote):
                // Update UI with quote on the main thread
                DispatchQueue.main.async {
                    self.lblQuotes.text = String(quote[quote.index(quote.startIndex, offsetBy: 2)..<quote.index(quote.endIndex, offsetBy: -2)])
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

