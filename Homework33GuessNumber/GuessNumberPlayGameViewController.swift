//
//  GuessNumberPlayGameViewController.swift
//  Homework33GuessNumber
//
//  Created by 黃柏嘉 on 2021/12/7.
//

import UIKit
enum Mode{
    case normal
    case gameOver
}

class GuessNumberPlayGameViewController: UIViewController {
    
    //chanceImage
    @IBOutlet var chanceImage: [UIImageView]!
    @IBOutlet weak var userInputTextfield: UITextField!
    @IBOutlet weak var rangeLabel: UILabel!
    //前一頁的值
    var modeNumber:Int!
    
    //預設值
    var maxNumber = 0
    var minNumber = 0
    var answer = 0
    var wrong = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let modeNumber = modeNumber {
            maxNumber = modeNumber
            rangeLabel.text = "Range:\(minNumber)~\(maxNumber)"
            answer = Int.random(in: minNumber...maxNumber)
            print(answer)
        }
        
    }
    //猜數字
    @IBAction func guessNumber(_ sender: UIButton) {
        if let numberText = userInputTextfield.text,let number = Int(numberText){
            checkGuessNumber(number:number)
        }
        
    }
    
    //檢查數字
    func checkGuessNumber(number:Int){
        if number < minNumber || number > maxNumber{
            alert(title: "輸入有誤", message: "請輸入範圍內的數字", mode: .normal)
        }else{
            if number == answer{
                alert(title: "恭喜答對了", message: "請重新開始", mode: .gameOver)
            }else if number < answer{
                minNumber = number
                rangeLabel.text = "Range:\(minNumber)~\(maxNumber)"
                loseChance(wrong: wrong)
                wrong += 1
            }else if number > answer{
                //數字大於答案
                maxNumber = number
                rangeLabel.text = "Range:\(minNumber)~\(maxNumber)"
                loseChance(wrong: wrong)
                wrong += 1
            }
            if wrong == 5{
                alert(title: "挑戰失敗", message: "次數過多，請重新開始", mode: .gameOver)
                
            }
        }
       
    }
    //答錯扣機會
    func loseChance(wrong:Int){
        for i in 0...wrong{
            chanceImage[i].tintColor = .lightGray
        }
    }
    //警示器
    func alert(title:String,message:String,mode:Mode){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { okAction in
            if mode == .normal{
                alert.dismiss(animated: true, completion: nil)
            }else if mode == .gameOver{
                alert.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
