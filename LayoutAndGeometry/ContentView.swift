//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Eugene Evgen on 09/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(calculateColor(proxy: proxy, fullView: fullView))
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
        
        let scale = 1.0 - min(max(0, (viewHeight - minY) / viewHeight), 0.5)
        return max(0.5, scale)
    }
    
    func calculateColor(proxy: GeometryProxy, fullView: GeometryProxy) -> Color {
        let minY = proxy.frame(in: .global).minY
        let viewHeight = fullView.size.height
        
        // Map vertical position to hue (0 to 1)
        let hue = min(max(0, minY / viewHeight), 1)
        
        return Color(hue: hue, saturation: 0.8, brightness: 0.9)
    }
}

#Preview {
    ContentView()
}
