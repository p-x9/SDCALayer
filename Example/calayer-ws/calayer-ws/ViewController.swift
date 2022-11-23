//
//  ViewController.swift
//  calayer-ws
//
//  Created by p-x9 on 2022/11/16.
//  
//

import UIKit
import SDCALayer

class ViewController: UIViewController {

    let urlSession = URLSession(configuration: .default)

    var hostIP: String = "ws://192.168.0.3:8765"
    var webSocketTask: URLSessionWebSocketTask?

    var pingTimer: Timer?
    var receiveMessageTask: Task<(), Never>?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        webSocketTask?.resume()
    }

    private func setupNavigationBar() {
        let connectButtonItem = UIBarButtonItem(title: "Connect",
                                                style: .plain,
                                                target: self,
                                                action: #selector(handleConnectButton(_:)))
        navigationItem.leftBarButtonItem = connectButtonItem
    }

    func receiveMessage() async {
        guard let webSocketTask else { return }

        do {
            let message = try await webSocketTask.receive()

            switch message {
            case let .string(response):
                print(response)
                self.handle(message: response)
                await receiveMessage()
            default:
                break
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func handle(message: String) {
        DispatchQueue.main.async {
            guard let model = SDCALayer.load(from: message),
                  let layer = model.convertToLayer() else {
                return
            }
            self.view.layer.sublayers?.forEach {
                $0.removeFromSuperlayer()
            }

            self.view.layer.addSublayer(layer)

            layer.setNeedsLayout()
            layer.setNeedsDisplay()
        }
    }

    func connect(to host: String) {
        pingTimer?.invalidate()
        receiveMessageTask?.cancel()
        webSocketTask?.cancel()

        guard let url = URL(string: host) else { return }

        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()

        receiveMessageTask = Task {
            await receiveMessage()
        }

        pingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.webSocketTask?.send(.string("ping")) { error in
                guard let error else { return }
                print(error.localizedDescription)
            }
        }
    }

    @objc
    func handleConnectButton(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController(title: "Enter websocket host",
                                        message: "ip address and port number",
                                        preferredStyle: .alert)

        alertVC.addTextField { textField in
            textField.placeholder = "ws://192.168.0.3:8765"
            textField.text = self.hostIP
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            guard let textField = alertVC.textFields?.first else {
                return
            }
            guard let hostIP = textField.text else {
                return
            }

            self.hostIP = hostIP

            self.connect(to: hostIP)
        }

        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)

        self.present(alertVC, animated: true, completion: nil)
    }

}
