//
//  ViewController.swift
//  媒体文件播放_Swift
//
//  Created by Space Zhong on 2020/8/5.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

import UIKit
import AVKit
class ViewController: UIViewController {
    
    var playViewVC:AVPlayerViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlayView()
        playViewVC.player?.play()
//        playViewVC =
        // Do any additional setup after loading the view.
    }
    
    
    func setUpPlayView(){
        guard let url = Bundle.main.path(forResource:"src", ofType:"")else{return}
        let newUlr = url + "/video/笑傲江湖MP4.mp4"
        let realUrl:NSURL = NSURL(fileURLWithPath: newUlr)
        playViewVC = AVPlayerViewController()
        playViewVC.player = AVPlayer(url: realUrl as URL)
        playViewVC.view.frame = view.bounds
        view.addSubview(playViewVC.view)
    }


}

