//
//  RecorderViewController.swift
//  PitchPerfect
//
//  Created by Raphael Araújo on 2018-02-22.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    private var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        
        if !self.recordButton.isSelected {
            if audioRecorder == nil {
                let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
                let recordingName = "recordedVoice.wav"
                let pathArray = [dirPath, recordingName]
                let filePath = URL(string: pathArray.joined(separator: "/"))
                let session = AVAudioSession.sharedInstance()
                try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
                do {
                    try audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
                    audioRecorder.isMeteringEnabled = true
                    audioRecorder.delegate = self
                } catch {
                    print("error")
                }
            }
            
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
            self.recordButton.tintColor = .red
            self.recordLabel.text = "Tap the button below to finish recording"
            self.recordButton.isSelected = true
        } else {
            audioRecorder.stop()
            let session = AVAudioSession.sharedInstance()
            try! session.setActive(false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "soundFilterSegue" {
            if let url = sender as? URL {
                let viewController = segue.destination as! SoundFilterViewController
                viewController.recordedAudioURL = url
            }
        }
    }
}

extension RecorderViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            self.recordLabel.text = "Tap the button below to start recording"
            self.recordButton.tintColor = .white
            self.recordButton.isSelected = false
            self.performSegue(withIdentifier: "soundFilterSegue", sender: audioRecorder.url)
        }
    }
}

