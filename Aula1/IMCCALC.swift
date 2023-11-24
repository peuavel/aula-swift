//
//  IMCCALC.swift
//  Aula1
//
//  Created by Student12_02 on 20/11/23.
//

import SwiftUI

struct IMCCALC: View {
    @State private var peso = ""
    @State private var altura = ""
    @State private var categoriaIMC = ""
    var body: some View {
        ZStack{
            corDoFundo(categoriaIMC)
                .ignoresSafeArea() 
        VStack{
        Text("Calculadora de IMC")
        .font(.system(size: 30))
            TextField("Digite seu peso", text: $peso)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .multilineTextAlignment(.center)
        .padding()
    TextField("Digite sua altura", text: $altura)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .multilineTextAlignment(.center)
        .padding()
    
    Button(action: {
        if let pesoDouble = Double(peso), let alturaDouble = Double(altura), alturaDouble > 0 {
            let imc = pesoDouble / (alturaDouble * alturaDouble)
            if imc > 30 {categoriaIMC = "Obesidade"} else if imc >= 25 && imc <= 29.99 {
                categoriaIMC = "Sobrepeso"
            } else if imc >= 18.5 && imc <= 24.99 {categoriaIMC = "Normal"} else {categoriaIMC = "Baixo peso"}
            
        } else {categoriaIMC = "Preencha corretamente peso e altura"
        }
    }) {
        Text("Calcular")
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
    }
    
    Text(categoriaIMC)
        .padding()
        .foregroundColor(.green)
    Spacer()
    Image("tabela-IMC") // Adiciona uma imagem chamada "caminhao".
        .resizable() // Permite redimensionamento da imagem.
        .aspectRatio(contentMode: .fit) // Define o modo de aspectRatio da imagem para .fit.
        .frame(width: 490, height: 450) // Define o tamanho do quadro da imagem.
                
            }
        }
    }
    func corDoFundo(_ categoria: String) -> Color {
        switch categoria {
        case "Baixo peso":
            return Color("BaixoPeso")
        case "Normal":
            return Color("Normal")
        case "Sobrepeso":
            return Color("Sobrepeso")
        case "Obesidade":
            return Color("Obesidade")
        default:
            return Color("Padrao")
        }
    }
}

    struct IMCCALC_Previews: PreviewProvider {
        static var previews: some View {
            IMCCALC()
        }
    }
