//
//  MicView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//


import AVFoundation
import Speech
import SwiftUI

struct SpeechRecognizerView: View {
    let lightBlue = Color.blue.opacity(0.7)
    let moreLightBlue = Color.blue.opacity(0.4)
    let darkBlue = Color(red: 0.0, green: 0.0, blue: 0.5)
    
    let speechRecognizer = SpeechRecognizer()
    @State private var transcribedText: String = ""
    @State private var isRecording = false
    
    var body: some View {
        VStack {
            Text("Click on the mic icon and start talking.")
                .font(.system(size: 25))
                .foregroundColor(darkBlue)
                .multilineTextAlignment(.center)
            
            Text("Hint:\n \"Notify me when bus 510 is 1 stop away\"")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 20)
            
            ZStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 160, height: 160)
                Circle()
                    .stroke(lightBlue, lineWidth: 20)
                    .frame(width:180, height: 180)
                Circle()
                    .stroke(moreLightBlue, lineWidth: 20)
                    .frame(width:220, height: 220)
                
                Button(action: {
                    isRecording.toggle()
                    if isRecording {
                        speechRecognizer.startRecording { result, error in
                            DispatchQueue.main.async {
                                if let error = error {
                                    transcribedText = error.localizedDescription
                                } else {
                                    transcribedText = result ?? ""
                                }
                            }
                        }
                    } else {
                        speechRecognizer.stopRecording()
                    }
                }) {
                    Image(systemName: "mic")
                        .font(.system(size: 80))
                        .foregroundColor(darkBlue)
                }
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(moreLightBlue)
                        .frame(width: 300, height: 120)
                        .cornerRadius(15)
                        .overlay(
                            VStack {
                                Text(speechRecognizer.transcribedText)
                                    .foregroundColor(.black)
                                Spacer()
                                HStack {
                                    Button(action: {
                                        // code to handle "Edit" button tapped
                                    }) {
                                        Text("Edit")
                                            .foregroundColor(.black)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 10)
                                    .padding()
                                    .background(lightBlue)
                                    .cornerRadius(30)
                                    
                                    Button(action: {
                                        // code to handle "Save" button tapped
                                    }) {
                                        Text("Save")
                                            .foregroundColor(.black)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 10)
                                    .padding()
                                    .background(lightBlue)
                                    .cornerRadius(30)
                                }
                            }
                        )
                }
            }
        }
    }
}


/*
                      // code to start speech recognition
// request permission
SFSpeechRecognizer.requestAuthorization{ status in
    switch status {
    case .authorized:
        // if permission is granted then start recording
        startRecording()
    default:
        // permission not granted, show alert
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Speech Recognition Not Authorized", message: "Please enable speech recognition in Settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.parent?.present(alert, animated: true, completion: nil)
        }
    }
}
 */
/*
func startRecording() {
    // code
    
    let recognizer = SFSpeechRecognizer()
    
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(.record, mode: .measurement, options: [.duckOthers, .defaultToSpeaker])
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    } catch {
        print("Failed to set up audio session: \(error.localizedDescription)")
        return
    }
    
    let request = SFSpeechRecognitionRequest()
    
    // start recognition
    recognizer?.recognitionTask(with: request) { [weak self] result, error in
        guard let self = self else { return }
        
        if let result = result {
            self.transcribedText = result.bestTranscription.formattedString
        } else if let error = error {
            print("Speech recognition error: \(error.localizedDescription)")
        }
    }
}
 */
struct SpeechRecognizerView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognizerView()
    }
}



