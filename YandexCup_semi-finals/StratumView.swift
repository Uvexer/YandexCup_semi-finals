import SwiftUI

struct StratumView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Stratum View")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .onTapGesture {
            isPresented = false
        }
    }
}
