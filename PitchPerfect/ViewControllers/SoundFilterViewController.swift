//
//  SoundFilterViewController.swift
//  PitchPerfect
//
//  Created by Raphael Araújo on 2018-02-25.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//

import UIKit
import AVFoundation

class SoundFilterViewController: UIViewController {
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func stopAudioButtonTapped(sender: Any) {
        stopAudio()
    }
    
    @IBAction func playButtonTapped(sender: UIButton) {
        let buttonType: ButtonType = ButtonType(rawValue: sender.tag)!
        switch buttonType {
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        default:
            playSound(rate: 0.5)
        }
        configureUI(.playing)
    }
    
    @IBAction func recordAgainButtonTapped(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
