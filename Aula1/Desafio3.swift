//
//  Desafio3.swift
//  Aula1
//
//  Created by Student12_02 on 16/11/23.
//

import SwiftUI

struct Desafio3: View {
    @State private var name = ""
    var body: some View {
        VStack {
            TextField("Digite seu nome", text: $name)
                .offset(x: 134, y:-300) //
            Text("Bem Vindo, \(name)")
                .offset(y: -380)
        }
    }
}

struct Desafio3_Previews: PreviewProvider {
    static var previews: some View {
        Desafio3()
    }
}
