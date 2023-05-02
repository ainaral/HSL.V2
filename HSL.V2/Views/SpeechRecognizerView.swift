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

    let speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Text(NSLocalizedString("StartTalking", comment: ""))
                .font(.system(size: 25))
                .foregroundColor(Color.theme.accent)
                .multilineTextAlignment(.center)
            
            Text(NSLocalizedString("Hint", comment: ""))
                .font(.subheadline)
                .foregroundColor(Color.theme.gray)
                .padding(.top, 20)
            
            ZStack {
                Circle()
                    .fill(Color.theme.blue)
                    .frame(width: 160, height: 160)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isRecording)
                Circle()
                    .stroke(Color.theme.lightBlue, lineWidth: 20)
                    .frame(width:180, height: 180)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isRecording)
                Circle()
                    .stroke(Color.theme.moreLightBlue, lineWidth: 20)
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
                        .foregroundColor(Color.theme.accent)
                        .scaleEffect(isRecording ? 1.2 : 1.0) // Apply scale effect when recording
                        .animation(isRecording ? .none : .spring(), value: isRecording) 
                }
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.theme.moreLightBlue)
                        .frame(width: 300, height: 120)
                        .cornerRadius(15)
                        .overlay(
                            VStack {
                                Text(speechRecognizer.transcribedText)
                                    .foregroundColor(Color.theme.accent)
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

