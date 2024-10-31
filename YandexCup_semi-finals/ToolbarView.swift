
import SwiftUI

struct ToolbarView: View {
    let clearAction: () -> Void
    let undoAction: () -> Void
    let redoAction: () -> Void
    let saveFrameAction: () -> Void
    let stratumAction: () -> Void

    var body: some View {
        HStack {
            HStack(spacing: 20) {
                Image("left")
                    .onTapGesture {
                        undoAction()
                    }
                Image("right")
                    .onTapGesture {
                        redoAction()
                    }
            }
            Spacer(minLength: 40)

            HStack(spacing: 20) {
                Image("trash")
                    .onTapGesture {
                        clearAction()
                    }
                Image("adds")
                    .onTapGesture {
                        saveFrameAction() 
                    }
                Image("stratum")
                    .onTapGesture {
                        stratumAction()
                    }
            }
            Spacer(minLength: 40)

            HStack(spacing: 20) {
                Image("stop")
                Image("play")
            }
        }
        .padding(.horizontal, 40)
    }
}
