//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by sun on 12/26/25.
//

import UIKit

import SnapKit
import Then

final class CalculatorViewController: UIViewController {

    private let viewModel: CalculatorViewModel

    private let displayLabel = UILabel().then {
        $0.text = "0"
        $0.font = .systemFont(ofSize: 72, weight: .light)
        $0.textAlignment = .right
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.4
        $0.textColor = .label
        $0.numberOfLines = 1
    }

    private let mainStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .fillEqually
    }

    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Calculator"
    }

    required init?(coder: NSCoder) {
        let service: CalculatorServicing = CalculatorService()
        let vm = CalculatorViewModel(service: service)
        self.viewModel = vm
        super.init(coder: coder)
        self.title = "Calculator"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        bind()
        render(viewModel.output)
    }

    private func bind() {
        viewModel.onOutputChanged = { [weak self] output in
            self?.render(output)
        }
    }

    private func render(_ output: CalculatorViewModel.Output) {
        displayLabel.text = output.displayText
        displayLabel.accessibilityLabel = "Display \(output.displayText)"
    }

    private func layout() {
        view.addSubview(displayLabel)
        view.addSubview(mainStack)

        displayLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }

        mainStack.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(displayLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        let rows: [[CalculatorButton]] = [
            [.clear, .sign, .percent, .operation(.divide)],
            [.digit(7), .digit(8), .digit(9), .operation(.multiply)],
            [.digit(4), .digit(5), .digit(6), .operation(.subtract)],
            [.digit(1), .digit(2), .digit(3), .operation(.add)],
            [.digit(0), .decimal, .equals]
        ]

        for row in rows {
            let rowStack = UIStackView().then {
                $0.axis = .horizontal
                $0.spacing = 12
                $0.distribution = .fillEqually
            }

            if row.count == 3, row.contains(.digit(0)) {
                let zero = makeButton(.digit(0))
                let dot = makeButton(.decimal)
                let eq = makeButton(.equals)

                rowStack.addArrangedSubview(zero)
                rowStack.addArrangedSubview(dot)
                rowStack.addArrangedSubview(eq)

                zero.snp.makeConstraints { make in
                    make.width.equalTo(dot.snp.width).multipliedBy(2.0).offset(12)
                }
            } else {
                row.forEach { rowStack.addArrangedSubview(makeButton($0)) }
            }

            mainStack.addArrangedSubview(rowStack)
        }
    }

    private func makeButton(_ button: CalculatorButton) -> UIButton {
        let b = UIButton(type: .system).then {
            $0.setTitle(button.title, for: .normal)
            $0.setTitleColor(button.titleColor, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 32, weight: .medium)
            $0.backgroundColor = button.backgroundColor
            $0.layer.cornerRadius = 36
            $0.clipsToBounds = true
            $0.accessibilityLabel = "Button \(button.title)"
        }

        b.snp.makeConstraints { make in
            make.height.equalTo(72)
        }

        if case .decimal = button {
            b.isEnabled = false
            b.alpha = 0.35
            return b
        }

        b.addAction(UIAction { [weak self] _ in
            self?.viewModel.onTap(button)
        }, for: .touchUpInside)

        return b
    }
}
