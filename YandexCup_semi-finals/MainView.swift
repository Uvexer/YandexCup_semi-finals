import SwiftUI

struct MainView: View {
    @State private var activeImage: String? = nil
    var body: some View {
        VStack {
            Spacer(minLength: 10)
            
            HStack {
                HStack(spacing: 20) {
                    Image("left")
                    Image("right")
                }
                Spacer(minLength: 40)
                
                HStack(spacing: 20) {
                    Image("trash")
                    Image("adds")
                    Image("stratum")
                }
                Spacer(minLength: 40)
                
                HStack(spacing: 20) {
                    Image("stop")
                    Image("play")
                }
            }
            .padding(.horizontal, 40)
            
            Spacer(minLength: 20)
            
            Image("paper")
                .frame(maxWidth: .infinity, maxHeight: 1000)
                .cornerRadius(20)
                .padding(.horizontal, 16)
            
            Spacer(minLength: 40)
            
            HStack {
                Image(activeImage == "pencil" ? "penciltap" : "pencil")
                    .onTapGesture {
                        activeImage = (activeImage == "pencil") ? nil : "pencil"
                    }
                
                Spacer()
                
                Image(activeImage == "brush" ? "brushtap" : "brush")
                    .onTapGesture {
                        activeImage = (activeImage == "brush") ? nil : "brush"
                    }
                
                Spacer()
                
                Image(activeImage == "eraser" ? "erasertap" : "eraser")
                    .onTapGesture {
                        activeImage = (activeImage == "eraser") ? nil : "eraser"
                    }
                
                Spacer()
                
                Image(activeImage == "eclipsik" ? "eclipsiktap" : "eclipsik")
                    .onTapGesture {
                        activeImage = (activeImage == "eclipsik") ? nil : "eclipsik"
                    }
        
            }
            
            .padding(.horizontal, 40)
        }
    }
}

