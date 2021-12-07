//
//  Game1A2BViewController.swift
//  Homework33GuessNumber
//
//  Created by 黃柏嘉 on 2021/12/7.
//

import UIKit

class Game1A2BViewController: UIViewController {
    
    //time
    @IBOutlet weak var timeLabel: UILabel!
    //game
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var showResultTextView: UITextView!
    
    var topic = ""
    var timer:Timer?
    var time = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //生成題目
        makeNewTopic()
        //計時器
        gameTimer()
        //TextView
        showResultTextView.text = "start!!!\n"
        
    }
    //猜數字
    @IBAction func guessNumber(_ sender: UIButton) {
        if inputTextField.text?.count == 4{
            if let input = inputTextField.text{
               let result = checkNumber(input: input, topic: topic)
                showResultTextView.text += "\(input):\(result.0)A\(result.1)B\n"
                inputTextField.text = ""
            }
        }else{
            alert(title: "輸入有誤", message: "輸入內容未達四位數")
        }
    }
    
    
    @IBAction func restart(_ sender: UIButton) {
        showResultTextView.text = "start!!!\n"
        time = 0.0
        gameTimer()
        inputTextField.text = ""
        topic = ""
        makeNewTopic()
    }
    //使用者輸入過程提醒規則
    @IBAction func checkInputNumber(_ sender: UITextField) {
        if let input = sender.text{
            let arrayInput = Array(input)
            let setInput = Set(input)
            if arrayInput.count != setInput.count{
                alert(title: "輸入有誤", message: "請輸入無重複的四位數字")
                sender.text?.removeLast()
            }
        }
        if sender.text?.count == 5{
            alert(title: "輸入有誤", message: "密碼僅四位數字")
            sender.text?.removeLast()
        }
    
    }
    //獲得題目
    func makeNewTopic(){
        var number = ["0","1","2","3","4","5","6","7","8","9"]
        for _ in 0...3{
            let Index = Int.random(in: 0..<number.count)
            topic += number[Index]
            number.remove(at: Index)
        }
        print(topic)
    }
    //判斷幾A幾B
    func checkNumber(input:String,topic:String)->(Int,Int){
        var resultA = 0
        var resultB = 0
        let inputArray = Array(input)
        let topicArray = Array(topic)
        for i in 0...3{
            for j in 0...3{
                if topicArray[i] == inputArray[j] && i == j{
                    resultA += 1
                }else if topicArray[i] == inputArray[j]{
                    resultB += 1
                }
            }
        }
            if resultA == 4{
                timer?.invalidate()
                let timeText = String(format: "%.1f", time)
                alert(title: "恭喜答對了", message: "一共耗時\(timeText)秒")
            }
            return(resultA,resultB)
        }
    
    
    //計時器
    func gameTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(updatTimer) , userInfo: nil, repeats: true)
    }
    //計時器功能
    @objc func updatTimer(){
        time += 0.1
        timeLabel.text = String(format: "%.1f", time)
    }
    //警示器
    func alert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { okAction in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
