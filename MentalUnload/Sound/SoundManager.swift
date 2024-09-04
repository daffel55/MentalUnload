//
//  SoundManager.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import Foundation
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playMySound() {
        
        guard let url = Bundle.main.url(forResource: "bell", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
}

