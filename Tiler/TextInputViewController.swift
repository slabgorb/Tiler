//
//  TextInputViewController.swift
//  Tiler
//
//  Created by Keith Avery on 4/20/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//


import UIKit


class TextInputViewController: UIViewController, UITextFieldDelegate {

    var textFieldPlaceHolderText:String?
    var emptySaveErrorMessage:String = "You have to provide an expression in your text area"
    var verticalContentOffset = CGFloat(0)

    let fadeAnimationDuration = 0.3
    let positionAnimationDuration = 0.6
    let delayBetweenAnimations = 0.15
    weak var delegate:TextInputViewControllerDelegate?

    @IBOutlet weak var theTextFieldYPosition: NSLayoutConstraint!

    // IBOutlets
    @IBOutlet weak var cancelButton: CircleColorButton!
    @IBOutlet weak var saveButton: CircleColorButton!
    @IBOutlet weak var theTextField: UITextField!

    @IBOutlet weak var buttonContainerViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.theTextFieldYPosition.constant = 800
        self.theTextField.delegate = self
        if let placeHolderText = self.textFieldPlaceHolderText  {
            self.theTextField.placeholder = placeHolderText
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextInputViewController.keyboardWillChangeFrame(_:)), name:UIKeyboardWillChangeFrameNotification, object: nil)
        if let presentedViewController = self.delegate as? UIViewController {
            let frame = self.view.frame
            self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, presentedViewController.view.frame.width, frame.height)
        }
        self.theTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.theTextField.layoutIfNeeded()

        self.startEntranceAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func cancelButtonTapped(sender: AnyObject) {

        if let delegate = self.delegate
        {
            self.theTextField.resignFirstResponder()
            delegate.textInputViewControllerCancelButtonTapped(self)
        }
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        if let textFieldText = self.theTextField.text {
            let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
            if textFieldText.stringByTrimmingCharactersInSet(whitespaceSet) == "" {
                return
            } else {
                if let delegate = self.delegate {
                    self.theTextField.resignFirstResponder()
                    delegate.textInputViewController(self, saveButtonTappedWithText: textFieldText)
                }
            }
        }
    }

    func startEntranceAnimation()  {
        self.fadeInViewAndMoveToOriginalPosition(self.theTextField, delay: self.delayBetweenAnimations,  originalPositionConstraint: self.theTextFieldYPosition) { (fadeFinished) -> Void in
        }
    }

    private func fadeInViewAndMoveToOriginalPosition(view:UIView, delay:Double, originalPositionConstraint:NSLayoutConstraint?, fadeFinished: ((Bool) -> Void)?) {
        originalPositionConstraint?.constant = 0
        UIView.animateWithDuration(self.fadeAnimationDuration, delay: delay, options: [], animations: { () -> Void in

            view.alpha = 1.0

        }) { (finished) -> Void in
        }

        let adjustedDelay = delay + self.fadeAnimationDuration / 4

        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            // do stuff
        }), completion: nil)


        UIView.animateWithDuration(self.positionAnimationDuration, delay: adjustedDelay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in

            view.layoutIfNeeded()

        }) { (finished) -> Void in
        }
    }

    // MARK: - NSNotifications

    func keyboardWillChangeFrame(notification:NSNotification) {
        let notificationInfo = notification.userInfo

        if let info = notificationInfo  {
            if let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? Double,
                curve = info[UIKeyboardAnimationCurveUserInfoKey] as? Int,
                frameEnd = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardEndOriginY = frameEnd.CGRectValue().origin.y - CGRectGetMinY(self.view.bounds)
                if keyboardEndOriginY == CGRectGetHeight(self.view.bounds) {
                    self.buttonContainerViewBottomConstraint.constant = 0
                } else {
                    let keyboardHeight = CGRectGetHeight(self.view.bounds) - keyboardEndOriginY + self.verticalContentOffset
                    self.buttonContainerViewBottomConstraint.constant = keyboardHeight
                }

                let curveOption = UIViewAnimationOptions(rawValue: UInt(curve))

                UIView.animateWithDuration(duration, delay: 0.0, options: curveOption, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveButtonTapped(self.saveButton)
        return true
    }



    
}
