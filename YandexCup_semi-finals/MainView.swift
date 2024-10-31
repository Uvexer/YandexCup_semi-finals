
import SwiftUI

struct MainView: View {
    @State private var activeImage: String? = nil
    @State private var isStratumViewPresented = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 10)
            
            ToolbarView(
                clearAction: {
                    activeImage = "trash"
                },
                undoAction: {
                    activeImage = "left"
                },
                redoAction: {
                    activeImage = "right"
                },
                stratumAction: {
                    isStratumViewPresented = true
                }
            )
            
            Spacer(minLength: 20)
            
            CanvasView(
                activeImage: $activeImage,
                undoAction: {},
                redoAction: {}
            )
            
            Spacer(minLength: 40)
            
            ToolSelectorView(activeImage: $activeImage)
        }
        .sheet(isPresented: $isStratumViewPresented) {
            StratumView(isPresented: $isStratumViewPresented)
                .presentationDetents([.fraction(0.7)])
        }
    }
}
