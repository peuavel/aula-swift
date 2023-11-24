//
//  TabViewDesafio1.swift
//  Aula1
//
//  Created by Student12_02 on 21/11/23.
//
import SwiftUI

struct TabViewDesafio1: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                   Label("home", systemImage: "house")
                }
            
            PhotoView()
                .tabItem {
                Label("Photos",systemImage: "photo")

                }
            
            ProfileView()
                .tabItem {
                Label("Profile",systemImage: "person")
        
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        VStack{
            List (0..<16) {
                Text("Item \($0)")
            }
        }
    }
}

struct PhotoView: View {
    var body: some View {
        VStack { // Empilha as visualizações verticalmente.
            Image("caminhao") // Adiciona uma imagem chamada "caminhao".
                .resizable() // Permite redimensionamento da imagem.
                .aspectRatio(contentMode: .fit) // Define o modo de aspectRatio da imagem para .fit.
                .frame(width: 360, height: 400)
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack{
        Rectangle()
    .fill(Color.blue)
    .frame(width: 330, height: 200)
    .overlay(
        Text("Hello, Hackatruck!")
            .foregroundColor(.black)
            .font(.headline)
        )
        }
    }
}

struct TabViewDesafio1_Previews: PreviewProvider {
    static var previews: some View {
        TabViewDesafio1()
    }
}
