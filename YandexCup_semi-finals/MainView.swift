
import SwiftUI

struct MainView: View {
    @State private var activeImage: String? = nil
    
    var body: some View {
        VStack {
            Spacer(minLength: 10)
            
            ToolbarView(clearAction: {
                activeImage = "trash" 
            })
            
            Spacer(minLength: 20)
            
            CanvasView(activeImage: $activeImage)
            
            Spacer(minLength: 40)
            
            ToolSelectorView(activeImage: $activeImage)
        }
    }
}

