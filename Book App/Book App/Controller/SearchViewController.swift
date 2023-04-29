//
//  SearchViewController.swift
//  Book App
//
//  Created by Can Yıldırım on 20.04.2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var docs = [DocsResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchTextField.textColor = .lightGray

        }
 
    }

extension SearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        BookAppClient.getBooks(search: searchText) { response, error in

            
            self.docs = response


            DispatchQueue.main.async {

                self.tableView.reloadData()
            }

        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
   
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        
        let doc = docs[indexPath.row]
        
        cell.textLabel?.text = doc.title
        cell.detailTextLabel?.text = "\(doc.firstPublishYear)"
        
        BookAppClient.getCovers(coverId: doc.coverI ?? -1) { data, error in
            
            if let data = data {
                
                cell.imageView?.image = UIImage(data: data)
                
            } else {
                
                print(error!)
            }
            
        }
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        let doc = docs[indexPath.row]
        storyboard.doc = doc

        navigationController?.pushViewController(storyboard, animated: true)
        present(storyboard, animated: true)
        
    }
    
}
