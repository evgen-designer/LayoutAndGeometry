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
                            .scaleEffect(calculateScale(proxy: proxy, fullView: fullView))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func calculateOpacity(proxy: GeometryProxy, fullView: GeometryProxy) -> Double {
        let minY = proxy.frame(in: .global).minY
        let fadeStart: CGFloat = 200
        let fadeRange: CGFloat = 100
        
        if minY < fadeStart {
            return max(0, 1 - (fadeStart - minY) / fadeRange)
        }
        return 1
    }
    
    func calculateScale(proxy: GeometryProxy, fullView: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .global).minY
        let viewHeight = fullView.size.height
        
        // Minimum scale of 0.5 (50%), maximum of 1.0 (100%)
        let scale = 1.0 - min(max(0, (viewHeight - minY) / viewHeight), 0.5)
        return max(0.5, scale)
    }
}

#Preview {
    ContentView()
}
