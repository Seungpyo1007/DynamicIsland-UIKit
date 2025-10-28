//
//  ViewController.swift
//  DynamicIsland-UIKit
//
//  Created by 홍승표 on 10/28/25.
//

import UIKit
import ActivityKit

class ViewController: UIViewController {
    
    @objc private var currentActivityID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "홈"
        view.backgroundColor = .systemBackground

        configureItems()
    }
    
    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: nil
        )
    }
    
    @IBAction func startButton(_ sender: Any) {
        startOrderActivity()
    }
    
    

    
    
    // MARK: - LiveActivity 활성화
    public func startOrderActivity() {
        // 기존 Activity가 있다면 먼저 종료합니다.
        if let id = currentActivityID {
            Task {
                await LiveActivityManager.endActivity(id)
            }
            currentActivityID = nil
        }
        
        do {
            // Live ActivityManager를 사용하여 Activity를 시작하고 ID를 저장합니다.
            // 최소한의 정보인 deliveryTime만 전달합니다.
            let id = try LiveActivityManager.startActivity()
            currentActivityID = id
            print("Live Activity Started with ID: \(id)")
        } catch {
            print(error.localizedDescription)
        }
    }
}

