//
//  ViewController.swift
//  Homework10
//
//  Created by Валентин Величко on 15.01.22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.cornerRadius = 20
        middleView.layer.cornerRadius = 20
        bottomView.layer.cornerRadius = 20
    }


}

