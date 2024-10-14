//
//  ViewController.swift
//  lesson_5
//
//  Created by Мак on 14.10.2024.
//

import UIKit

class RadiusButtons: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}

class ViewController: UIViewController {

    var numberFromScreen: Double = 0
    var firstNum: Double = 0
    var operation: Int = 0
    var mathSign: Bool = false
    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func digits(_ sender: UIButton) {
        if mathSign == true {
            result.text = String(sender.tag)
            mathSign = false
        }
        else {
            result.text = result.text! + String(sender.tag)
        }
        
        numberFromScreen = Double(result.text!)!
    }
    @IBAction func buttons(_ sender: UIButton) {
        if result.text != "" && sender.tag != 10 && sender.tag != 15 {
            firstNum = Double(result.text!)!
            if sender.tag == 11 { // деление
                result.text = "/"
            }
            else if sender.tag == 12 { // умножение
                result.text = "*"
            }
            else if sender.tag == 13 { // вычитание
                result.text = "-"
            }
            else if sender.tag == 14 { // добавление
                result.text = "+"
            }
            
            operation = sender.tag
            mathSign = true
        }
        else if sender.tag == 15 { // посчитать все
            if operation == 11 {
                result.text = String(firstNum / numberFromScreen)
            }
            else if operation == 12 {
                result.text = String(firstNum * numberFromScreen)
            }
            else if operation == 13 {
                result.text = String(firstNum - numberFromScreen)
            }
            else if operation == 14 {
                result.text = String(firstNum + numberFromScreen)
            }
        }
        else if sender.tag == 10 {
            result.text = ""
            firstNum = 0
            numberFromScreen = 0
            operation = 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
