import SwiftUI
import AbrovaTrace

struct SecondView: View {
    @State private var statusMessage = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("This view tests auto navigation breadcrumbs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                DemoButton(title: "Capture Error from Second View", color: .blue) {
                    let error = NSError(
                        domain: "ir.abrova.trace.example",
                        code: 2001,
                        userInfo: [NSLocalizedDescriptionKey: "Error from SecondView"]
                    )

                    AbrovaTrace.shared.captureError(
                        error,
                        extra: ["screen": "second_view"]
                    ) { success in
                        DispatchQueue.main.async {
                            statusMessage = success ? "Error captured from SecondView!" : "Failed to capture"
                        }
                    }
                }

                DemoButton(title: "Add Navigation Breadcrumb", color: .green) {
                    AbrovaTrace.shared.addNavigationBreadcrumb(from: "SecondView", to: "DetailView")
                    statusMessage = "Navigation breadcrumb added"
                }

                if !statusMessage.isEmpty {
                    Text(statusMessage)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Second View")
        .onAppear {
            AbrovaTrace.shared.addNavigationBreadcrumb(from: "ContentView", to: "SecondView")
        }
    }
}
