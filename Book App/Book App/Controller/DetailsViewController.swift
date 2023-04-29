//
//  DetailsViewController.swift
//  Book App
//
//  Created by Can Yıldırım on 19.04.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var publishYear: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var doc : DocsResponse!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         getCovers()
        
         bookTitle.text = doc.title
         publishYear.text = "\(doc.firstPublishYear)"
         rating.text = String(format: "%.1f", doc.ratingsAverage ?? 0.0)
         textView.text = doc.firstSentence?.first
        
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)

    }
    
    
    func getCovers() {
        
        BookAppClient.getCovers(coverId: doc.coverI ?? -1) { data, error in
            
            if let data = data {
                
                self.imageView.image = UIImage(data: data)
                
            } else {
                
                print(error!)
            }
            
        }
        
    }
  
}


