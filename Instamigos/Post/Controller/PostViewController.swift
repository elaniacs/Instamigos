//
//  PostViewController.swift
//  Instamigos
//
//  Created by Cáren Sousa on 20/05/23.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    weak var mainCoordinator: MainCoordinator?
    let postViewModel = PostViewModel()
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func postButtonAction(_ sender: UIButton) {
        createPost()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        textPlaceholderStyle()
    }
    
    func textPlaceholderStyle() {
        contentTextView.text = "What is on your mind?"
        contentTextView.textColor = UIColor.lightGray
    }
    
    func createPost() {
        let content = contentTextView.text ?? ""
        postViewModel.createPost(content: content)
        
        
    }
}

extension PostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What is on your mind?"
            textView.textColor = UIColor.lightGray
        }
    }
}


