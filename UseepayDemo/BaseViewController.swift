//
//  BaseViewController.swift
//  UseePayDemo
//
//  Created by shimingwei on 2025/5/25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 白色文字，适合深色背景
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.view.backgroundColor = .systemBlue
    }
}
