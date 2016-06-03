//
//  ViewController.swift
//  06_MusicGame
//
//  Created by kztskawamu on 2016/06/02.
//  Copyright © 2016年 cazcawa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var hanteiLabel:UILabel!
    
    var count: Float = 0.0
    var timer: NSTimer = NSTimer()
    
    var speed: Float = 0.0
    
    //@IBOutletを使わずにラベルを宣言
    var targetLabel: UILabel = UILabel()
    
    var audio: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !timer.valid {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01,
                                                           target: self,
                                                           selector: #selector(self.up),
                                                           userInfo: nil,
                                                           repeats: true)
        }
        
        //インスタンスを作り、初期化
        targetLabel = UILabel(frame: CGRectMake(0, 0, 50, 50))
        targetLabel.text = ""
        targetLabel.font = UIFont.systemFontOfSize(50)
        targetLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(targetLabel)
        
        let appframe: CGRect = UIScreen.mainScreen().bounds     //デバイスの画面の大きさを取得
        speed = Float(appframe.size.height) / 1.2               //デバイスの画面の高さより、スピードを決める
        
        //音楽ファイルの設定
        if let audioPath = NSBundle.mainBundle().URLForResource("music", withExtension: "mp3") {
            //audioPathに値がはいったら
            do {
                //audioが生成できる時はaudioを初期化、準備
                audio = try AVAudioPlayer(contentsOfURL: audioPath)
                //音楽を再生するメソッド
                audio.play()
            } catch {
                //audioが生成できない時エラーになる
                fatalError("プレイヤーがつくれませんでした。")
            }
        } else {
            //audioPathに値がはいらなかったらエラー
            fatalError("audioPathに値がはいりませんでした。")
        }
    }
    
    func up() {
        count = count + 0.01
        timeLabel.text = String(format: "%.2f", count)
        
        if 10.0 - 1.2 <= count {
            targetLabel.text = "■"
            let appframe: CGRect = UIScreen.mainScreen().bounds
            let x = appframe.size.width / 2 - 25
            let y = CGFloat((count - 10.0 + 1.2) * speed - 75)
            targetLabel.frame = CGRectMake(x, y, 50, 50)
        }
    }
    
    func hantei(number: Float) -> String {
        if count > number - 0.20 && count < number + 0.20 {         //もし経過時間が9.8秒~10.2秒だったら
            return "PERFECT!"                                       //"PERFECT!"を返す
        } else if count > number - 0.30 && count < number + 0.30 {  //もし経過時間が9.7秒~10.3秒だったら
            return "GREAT!"                                         //"GREAT!"を返す
        } else if count > number - 0.50 && count < number + 0.50 {  //もし経過時間が9.5秒~10.5秒だったら
            return "GOOD!"                                          //"GOOD!"を返す
        } else {                                                    //もしそれ以外だったら
            return "BAD!"                                           //"BAD!"を返す
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushButton() {
        hanteiLabel.text = self.hantei(10.0)
    }


}

