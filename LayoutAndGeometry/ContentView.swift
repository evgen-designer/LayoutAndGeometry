//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Eugene Evgen on 09/12/2024.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(calculateOpacity(proxy: proxy, fullView: fullView))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func calculateOpacity(proxy: GeometryProxy, fullView: GeometryProxy) -> Double {
        let minY = proxy.frame(in: .global).minY
        let fadeStart: CGFloat = 200 // Starts fading from 200 points from the top
        let fadeRange: CGFloat = 100 // Fade completely over 100 points
        
        if minY < fadeStart {
            return max(0, 1 - (fadeStart - minY) / fadeRange)
        }
        return 1
    }
}

#Preview {
    ContentView()
}
