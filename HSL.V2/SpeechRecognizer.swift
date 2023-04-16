//
//  SpeechRecognizer.swift
//  HSL.V2
//
//  Created by iosdev on 14.4.2023.
//

import AVFoundation
import Speech

class SpeechRecognizer {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var transcribedText: String = ""
    
    func startRecording(completion: @escaping (String?, Error?) -> Void) {
        // request permission
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                // if permission is granted then start recording
                let inputNode = self.audioEngine.inputNode
                self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                guard let recognitionRequest = self.recognitionRequest else {
                    completion(nil, NSError(domain: "SpeechRecognizerErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to create recognition request."]))
                    return
                }
                recognitionRequest.shouldReportPartialResults = true
                
                self.recognitionTask = self.speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                    var isFinal = false
                    if let result = result {
                        self.transcribedText = result.bestTranscription.formattedString
                        isFinal = result.isFinal
                    }
                    if error != nil || isFinal {
                        self.audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.recognitionRequest = nil
                        self.recognitionTask = nil
                        completion(self.transcribedText, error)
                    }
                }
                
                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                    self.recognitionRequest?.append(buffer)
                }
                
                self.audioEngine.prepare()
                do {
                    try self.audioEngine.start()
                } catch {
                    completion(nil, error)
                }
            default:
                completion(nil, NSError(domain: "SpeechRecognizerErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Speech recognition not authorized."]))
            }
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
}

