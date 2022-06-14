//
//  MailTextField.swift
//  TestProject2
//
//  Created by Erzhan Kasymov on 25/4/22.
//

import Foundation
import UIKit

protocol ActionsMailTextFieldProtocol: AnyObject{
    func typingText(text: String)
    func cleanOutTextField()
}

class MailTextField:UITextField {
    
    weak var textFieldDelegate: ActionsMailTextFieldProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = .white
        borderStyle = .none
        layer.cornerRadius = 10
        textColor = .black
        leftView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 15,
                                        height: self.frame.height))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        placeholder = "Enter mail!"
        font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        tintColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    
}

extension MailTextField: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let rangeText = Range(range, in: text){
            let updateText = text.replacingCharacters(in: rangeText, with: string)
            textFieldDelegate?.typingText(text: updateText)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textFieldDelegate?.cleanOutTextField()
        return true
    }
}
