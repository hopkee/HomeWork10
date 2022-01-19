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
    @IBOutlet weak var volumeLevelProgressBar: UIProgressView!
    @IBOutlet weak var volumeLevelSlider: UISlider!
    @IBOutlet weak var volumeLevelManualChange: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerSet(_ sender: UIDatePicker) {
    }
    @IBAction func setThisTimeClick(_ sender: UIButton) {
    }
    @IBAction func clearButtonClick(_ sender: UIButton) {
    }
    @IBOutlet weak var activeTimer: UILabel!
    
    @IBAction func timerSwitcher(_ sender: UISwitch) {
    }


    @IBAction func volumeChanged(_ sender: UITextField) {
        setVolume()
    }


    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        volumeLevelProgressBar.setProgress(volumeLevelSlider .value / 10, animated: true)
        volumeLevelManualChange.placeholder = "\(volumeLevelSlider.value)"
    }
    
    private func volumeBarSettings() {
        volumeLevelSlider.minimumValue = 0
        volumeLevelSlider.maximumValue = 10
        volumeLevelSlider.value = 5
    }
    
    private func viewsSettings() {
        topView.layer.cornerRadius = 20
        middleView.layer.cornerRadius = 20
        bottomView.layer.cornerRadius = 20
    }
    
    private func setVolume() {
        guard let volumeLevel = volumeLevelManualChange.text, let volume = Float(volumeLevel) else { return }
        volumeLevelSlider.setValue((volume > 10 ? 10 : volume), animated: true)
        volumeLevelProgressBar.setProgress((volume > 10 ? 10 : volume) / 10, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        volumeBarSettings()
        viewsSettings()
    }

}

