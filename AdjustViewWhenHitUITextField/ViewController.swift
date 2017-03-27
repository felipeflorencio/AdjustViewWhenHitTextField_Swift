//
//  ViewController.swift
//  AdjustViewWhenHitUITextField
//
//  Created by Felipe Florencio Garcia on 1/10/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var likeButton: UIButton!
    @IBOutlet var txtFirstField: UITextField!
    @IBOutlet var txtSecondTextField: UITextField!
    @IBOutlet var btnNext: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var viewInsideScroll: UIView!;
    
    var selectedField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set observer for receive keyboard notifications
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.keyboardWasShown(_:)), name:NSNotification.Name(rawValue: "UIKeyboardDidShowNotification"), object:nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.keyboardWillBeHidden(_:)), name:NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object:nil)

        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.userTappedOnField(_:)), name:NSNotification.Name(rawValue: "UITextFieldTextDidBeginEditingNotification"), object:nil)

        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target:self, action:#selector(ViewController.hideKeyBoard))

        viewInsideScroll?.addGestureRecognizer(tapGesture)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func hideKeyBoard(){
        self.view.endEditing(true)
    }
    
    func userTappedOnField(_ txtSelected: Notification){
        if txtSelected.object is UITextField {
           selectedField = txtSelected.object as? UITextField
        }
    }
    
    // View readjust actions
    func keyboardWasShown(_ notification: Notification) {
    
        let info:NSDictionary = notification.userInfo! as NSDictionary
        
        let keyboardSize:CGSize = ((info.object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject).cgRectValue.size)
        
        let txtFieldView:CGPoint = selectedField!.frame.origin;
        
        let txtFieldViewHeight:CGFloat = selectedField!.frame.size.height;
        
        var visibleRect:CGRect = viewInsideScroll!.frame;
        
        visibleRect.size.height -= keyboardSize.height;
        
        
        if !visibleRect.contains(txtFieldView) {
            let scrollPoint:CGPoint = CGPoint(x: 0.0, y: txtFieldView.y - visibleRect.size.height + (txtFieldViewHeight * 1.5))
            
            scrollView?.setContentOffset(scrollPoint, animated: true)
        }
    
    }
    
    func keyboardWillBeHidden(_ notification: Notification) {
        scrollView?.setContentOffset(CGPoint.zero, animated: true)
    }

}

