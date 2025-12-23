

import SwiftUI

struct ContentView: View {

    @StateObject private var vm = GrammarViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                TextEditor(text: $vm.inputText)
                    .frame(height: 160)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray.opacity(0.3))
                    )

                if vm.isLoading {
                    ProgressView()
                }

                if let error = vm.error {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                TextEditor(text: $vm.outputText)
                    .frame(height: 160)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.blue.opacity(0.4))
                    )

                HStack {
                    Button("Grammar Check") {
                        Task { await vm.process(action: .grammar) }
                    }

                    Button("Paraphrase") {
                        Task { await vm.process(action: .paraphrase) }
                    }
                    
                    Button("Improve") {
                        Task { await vm.process(action: .improve) }
                    }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("iGrammar Demo")
        }
    }
}
