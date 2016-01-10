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
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWasShown:", name:"UIKeyboardDidShowNotification", object:nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeHidden:", name:"UIKeyboardWillHideNotification", object:nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector:"userTappedOnField:", name:"UITextFieldTextDidBeginEditingNotification", object:nil)

        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target:self, action:"hideKeyBoard")

        viewInsideScroll?.addGestureRecognizer(tapGesture)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func hideKeyBoard(){
        self.view.endEditing(true)
    }
    
    func userTappedOnField(txtSelected: NSNotification){
        if txtSelected.object is UITextField {
           selectedField = txtSelected.object as? UITextField
        }
    }
    
    // View readjust actions
    func keyboardWasShown(notification: NSNotification) {
    
        let info:NSDictionary = notification.userInfo!
        
        let keyboardSize:CGSize = (info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size)!
        
        let txtFieldView:CGPoint = selectedField!.frame.origin;
        
        let txtFieldViewHeight:CGFloat = selectedField!.frame.size.height;
        
        var visibleRect:CGRect = viewInsideScroll!.frame;
        
        visibleRect.size.height -= keyboardSize.height;
        
        
        if !CGRectContainsPoint(visibleRect, txtFieldView) {
            let scrollPoint:CGPoint = CGPointMake(0.0, txtFieldView.y - visibleRect.size.height + (txtFieldViewHeight * 1.5))
            
            scrollView?.setContentOffset(scrollPoint, animated: true)
        }
    
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        scrollView?.setContentOffset(CGPointZero, animated: true)
    }

}

