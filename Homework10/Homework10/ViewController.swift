//
//  ViewController.swift
//  Homework10
//
//  Created by Валентин Величко on 15.01.22.
//

import UIKit
import AVFoundation
import MediaPlayer

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}

class ViewController: UIViewController {

    var player: AVAudioPlayer!
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
        setTimer()
    }
    @IBAction func clearButtonClick(_ sender: UIButton) {
        timerDefaultState()
    }
    @IBOutlet weak var activeTimer: UILabel!
    
    @IBAction func timerSwitcher(_ sender: UISwitch) {
        if !isTimerSetted {
            timerToggle.setOn(false, animated: true)
            return
        }
        alarmActivate()
    }


    @IBAction func volumeChanged(_ sender: UITextField) {
        setVolume()
    }

    
    @IBOutlet weak var timerToggle: UISwitch!
    

    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        volumeLevelProgressBar.setProgress(volumeLevelSlider .value / 10, animated: true)
        volumeLevelManualChange.placeholder = "\(volumeLevelSlider.value)"
        MPVolumeView.setVolume(volumeLevelSlider.value / 10)
    }

    
    private var isTimerSetted = false
    private var alarmHour = 0
    private var alarmMinute = 0
    
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
    
    private func timerDefaultState() {
        activeTimer.textColor = .placeholderText
        activeTimer.text = "00:00"
        timerToggle.setOn(false, animated: true)
        isTimerSetted = false
    }
    
    private func setVolume() {
        guard let volumeLevel = volumeLevelManualChange.text, let volume = Float(volumeLevel) else { return }
        volumeLevelSlider.setValue((volume > 10 ? 10 : volume), animated: true)
        volumeLevelProgressBar.setProgress((volume > 10 ? 10 : volume) / 10, animated: true)
    }
    
    private func setTimer() {
        let selectedDate = datePicker.date
        let calendar = Calendar.current
        if let hour = calendar.dateComponents([.hour], from: selectedDate).hour,
            let minutes = calendar.dateComponents([.minute], from: selectedDate).minute {
            activeTimer.text = (hour < 10 ? "0\(hour)" : "\(hour)") + ":" + (minutes < 10 ? "0\(minutes)" : "\(minutes)")
            alarmHour = hour
            alarmMinute = minutes
            
        }
        activeTimer.textColor = .black
        isTimerSetted = true
        
    }
    
    private func alarmActivate() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.getCurrentTime().hour == self.alarmHour && self.getCurrentTime().minute == self.alarmMinute && self.timerToggle.isOn {
                self.ring()
                timer.invalidate()
            }
        }
    }
    
    private func getCurrentTime() -> DateComponents {
        let now = Date()
        let calendar = Calendar.current
        return calendar.dateComponents([.hour, .minute], from: now)
    }
    
    private func ring() {
        guard let path = Bundle.main.url(forResource: "alarmSound", withExtension: "wav") else {
                return
            }
        player = try! AVAudioPlayer(contentsOf: path)
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        volumeBarSettings()
        viewsSettings()
        timerDefaultState()
    }

}

