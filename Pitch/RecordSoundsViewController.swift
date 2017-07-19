//
//  RecordSoundsViewController.swift
//  Pitch
//
//  Created by Weimu on 2017/7/17.
//  Copyright © 2017年 Weimu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController ,AVAudioRecorderDelegate{

    @IBOutlet var recordingLabel: UILabel!
 
    @IBOutlet var stopRecordButton: UIButton!
    
    @IBOutlet var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordButton.isEnabled = false
        
    }

  //  override func didReceiveMemoryWarning() {
  //      super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}

    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Processing"
        stopRecordButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string:pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord,with : AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url : filePath! , settings:[:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func StopRecording(_ sender: Any) {
    
        recordingLabel.text = "Tap 2 Record"
        stopRecordButton.isEnabled = false
        recordButton.isEnabled = true
        audioRecorder.stop()
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print(" record failed!")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let url = sender as! URL
            print(url)
            playSoundsVC.recordedAudioURL = url
        }
    }
}

