//: [Previous](@previous)

import Foundation

class CoordinatorOutput {
    var helloBobby: (() -> Void) = {
        print("Hello Bobby!")
    }

    deinit {
        print("Deinit CoordinatorOutput")
    }
}

class Coordinator {

    var controller: Controller
    var output = CoordinatorOutput()

    init(controller: Controller) {
        self.controller = controller

        self.controller.viewModel.output.onAction = output.helloBobby

//        self.controller.viewModel.output.onAction = { [weak self] in
//            self?.helloBobby()
//        }
    }

    func helloBobby() {
        print("Hello Bobby!")
    }

    deinit {
        print("Deinit coordinator")
    }
}

class Controller {
    var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    deinit {
        print("Deinit controller")
    }
}

class ViewModel {
    var output: Output

    init(output: Output) {
        self.output = output
    }

    deinit {
        print("Deinit viewModel")
    }
}

class Output {
    var onAction: (() -> Void) = { print("Impl") }

    deinit {
        print("Deinit output")
    }
}

class Test {

    init() {
        let output: Output = Output()
        let viewModel: ViewModel = ViewModel(output: output)
        let controller: Controller = Controller(viewModel: viewModel)
        var coordinator: Coordinator? = Coordinator(controller: controller)

        output.onAction()

        //output = nil
        //viewModel = nil
        //controller = nil
        //coordinator?.controller = nil
        coordinator = nil
    }
}

var test = Test()

//: [Next](@next)
