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
    @State private var isRecording = false
    @State private var isAnimating = false
    
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
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isRecording)
                Circle()
                    .stroke(lightBlue, lineWidth: 20)
                    .frame(width:180, height: 180)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isRecording)
                Circle()
                    .stroke(moreLightBlue, lineWidth: 20)
                    .frame(width:220, height: 220)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isRecording)
                
                Button(action: {
                    isRecording.toggle()
                    if isRecording {
                        isAnimating = isRecording
                        speechRecognizer.startRecording { result, error in
                            DispatchQueue.main.async {
                                if let error = error {
                                    speechRecognizer.transcribedText = error.localizedDescription
                                } else {
                                    speechRecognizer.transcribedText = result ?? ""
                                }
                            }
                        }
                    } else {
                        withAnimation {
                            isAnimating = false
                            speechRecognizer.stopRecording()
                        }
                    }
                }) {
                    Image(systemName: "mic")
                        .font(.system(size: 80))
                        .foregroundColor(darkBlue)
                        .scaleEffect(isRecording ? 1.2 : 1.0) // Apply scale effect when recording
                        .animation(isRecording ? .none : .spring(), value: isRecording) 
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
                            }
                        )
                }
            }
        }
    }
}

struct SpeechRecognizerView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognizerView()
    }
}

