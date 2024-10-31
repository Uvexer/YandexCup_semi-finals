import SwiftUI

struct StratumView: View {
    @Binding var isPresented: Bool
    var frames: [UIImage]
    var onFrameSelected: (UIImage) -> Void

    var body: some View {
        VStack {
            Text("Stratum View")
                .font(.largeTitle)
                .padding()

            ScrollView {
                ForEach(frames, id: \.self) { frame in
                    Image(uiImage: frame)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                        .onTapGesture {
                            onFrameSelected(frame)
                            isPresented = false    
                        }
                }
            }

            Spacer()
        }
        .background(Color.gray.opacity(0.2))
        .onTapGesture {
            isPresented = false
        }
    }
}
