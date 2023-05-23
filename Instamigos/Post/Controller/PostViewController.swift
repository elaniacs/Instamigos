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
    var postViewModel: PostViewModel?
    var afterDismiss: (() -> Void)?
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        customDismiss()
    }
    
    @IBAction func postButtonAction(_ sender: UIButton) {
        createPost()
        customDismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        contentTextView.text = UserDefaults.standard.string(forKey: "PostContet")
        
        if contentTextView.text.isEmpty {
            textPlaceholderStyle()
        }
    }
    
    func customDismiss() {
        self.dismiss(animated: true) {
            self.afterDismiss?()
        }
    }
    
    func textPlaceholderStyle() {
        contentTextView.text = "What is on your mind?"
        contentTextView.textColor = UIColor.lightGray
    }
    
    func createPost() {
        let content = contentTextView.text ?? ""
        postViewModel?.createPost(content: content) {
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
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
    
    func textViewDidChange(_ textView: UITextView) {
        postViewModel?.savePostChanges(postContent: textView.text)
    }
}


