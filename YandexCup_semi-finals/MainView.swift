
import SwiftUI

struct MainView: View {
    @State private var activeImage: String? = nil
    @State private var lines: [[CGPoint]] = [[]]

    var body: some View {
        VStack {
            Spacer(minLength: 10)
            
            ToolbarView()
            
            Spacer(minLength: 20)
            
            CanvasView(lines: $lines, activeImage: $activeImage)
            
            Spacer(minLength: 40)
            
            ToolSelectorView(activeImage: $activeImage)
        }
    }
}

