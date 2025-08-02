import Combine
import Foundation
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true


class ViewModel {
    @Published var isLoading: Bool = false
    
    @Published var text: String? = nil
    
    @Published var error: String? = nil
    
    private var subs = Set<AnyCancellable>()
    
    init() {
        self.observe()
    }
    
    func observe() {
        $isLoading.sink { state in
            print("New state \(state)")
        }.store(in: &subs)
        
        $text.sink { text in
            if let text {
                print("Got new text: \(text)")
            }
        }.store(in: &subs)
        
        $error.sink { err in
            if let err {
                print("An error occured: \(err)")
            }
        }.store(in: &subs)
    }
    
    
    // Downloading simulation
    func fetch() async {
        isLoading = true
        defer {isLoading = false}
        
        do {
            try await Task.sleep(for: .seconds(4))
            text = "fetched value"
        } catch let err {
            error = "Something went wrong! \(err)"
        }
        
    }
}


Task {
    let vm = ViewModel()
    await vm.fetch()
}
