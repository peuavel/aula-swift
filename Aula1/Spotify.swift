import SwiftUI
import AVKit

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    @Published var isPlaying = false {
        didSet {
            if isPlaying {
                audioPlayer?.play()
            } else {
                audioPlayer?.pause()
            }
        }
    }
    
    func playAudio(named filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
    }
}

struct Song {
    var id: Int
    var name: String
    var artist: String
    var duration: String
    var imageName: String
}

struct Spotify: View {
    let songs: [Song] = [
        Song(id: 1, name: "Agora é só esperar", artist: "Lana", duration: "3:30", imageName: "lana"),
        Song(id: 2, name: "Outra música", artist: "Artista 2", duration: "4:00", imageName: "lana"),
        // adicionar mais músicas aqui, se desejar
    ]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.02745098039, green: 0, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("lana2")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFit()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sou fã de Lana Del Ray")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Image("gedro")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .offset(x: 10)
                            Text("Gedro")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .offset(x: -15)
                        }
                    }
                    .padding(.top, 10)

                    ScrollView {
                        ForEach(songs, id: \.id) { song in
                            NavigationLink(destination: SongDetailView(song: song)) {
                                SongRow(song: song)
                                    .padding(.vertical, 8)
                                    .buttonStyle(SpotifyButtonStyle())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .padding(.horizontal)

                    Spacer()
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .navigationBarItems(
                    leading: Button(action: {
                    }) {
                        Image(systemName: "shuffle")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                )
            }
        }
        .accentColor(.white)
    }
}

struct SongRow: View {
    var song: Song

    var body: some View {
        HStack {
            Image(song.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
                .offset(x: 10)

            VStack(alignment: .leading, spacing: 4) {
                Text(song.name)
                    .font(.headline)
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(song.duration)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
    }
}

struct SongDetailView: View {
    var song: Song
    @StateObject private var audioManager = AudioManager.shared

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.02745098039, green: 0, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Image(song.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 200)
                    .clipped()

                VStack {
                    Text(" \(song.name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(.white)
                    Text(" \(song.artist)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .foregroundColor(.white)
                }

                HStack(spacing: 30) {
                    Button(action: {
                        withAnimation {
                            // Ação para reprodução aleatória
                        }
                    }) {
                        Image(systemName: "shuffle")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        // Ação para retroceder a música
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        withAnimation {
                            audioManager.isPlaying.toggle()
                        }
                    }) {
                        Image(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        // Ação para avançar a música
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        // Ação para repetir a música
                    }) {
                        Image(systemName: "repeat")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
            .accentColor(.white)
        }
        .onAppear {
            audioManager.playAudio(named: "lanadelray")
            audioManager.isPlaying = true
        }
        .onDisappear {
            audioManager.isPlaying = false
        }
    }
}

struct SpotifyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
    }
}

struct Spotify_Previews: PreviewProvider {
    static var previews: some View {
        Spotify()
    }
}
