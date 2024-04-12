//
//  ViewController.swift
//  XInterview
//
//  Created by Aman Shah on 4/12/24.
//

import UIKit

class ViewController: UIViewController{
    var gameOver = false
    var board = [[String]](repeating: [String](repeating: "", count: 3), count: 3)
    var playerX = true


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButtons()
        setupPlayAgainButton()
        
    }
    
    func isGameOver() -> Bool {
        //cases to chekc: 3 in row, 3 in column, 3 diagonal left to right, 3 right to left diagonal
        if threeCol() {
            return true
        }
        for row in board {
            if threeRow(row: row) {
                return true
            }
            for col in row {
                if col == "" {
                    print("continue game")
                    return false;
                }
            }

            
        }
        print("it's a draw")
        return true;
    }
    func threeRow (row: [String]) -> Bool{
        if row[0] == "" {
            return false;
        }
        
        if (row[0] == row[1] && row[1] == row[2]) {
            print(row[0] + " won 3 in row")
            return true;
        }
        return false;
        
    }
    func threeCol() -> Bool{
        var cols = [String]()
        var count = 0
        while count < 3 {
            cols = [board[0][count], board[1][count], board[2][count]]
            if cols[0] != "" {
                if (cols[0] == cols[1] && cols[1] == cols[2]) {
                    print(cols[0] + " won 3 in col")
                    return true;
                }
            }

            count += 1
        }
        return false;
        
    }

    @objc func boardTap (x: Int, y: Int) {
        if playerX {
            board[x][y] = "X"
        }
        
        else {
            board[x][y] = "O"
        }
        if let tappedButton = view.viewWithTag(x * 3 + y) as? UIButton {
            tappedButton.setTitle(board[x][y], for: .normal)
        }
        
        if isGameOver() {
            print("Game over.")
        }
        playerX = !playerX
    
    }
    func setupButtons() {
        let buttonSize: CGFloat = 50
        let spacing: CGFloat = 10
        for row in 0..<3 {
            for col in 0..<3 {
                let button = UIButton(type: .system)
                button.backgroundColor = .red
                button.setTitleColor(.black, for: .normal)
                button.setTitle("", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.tag = row * 3 + col
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                view.addSubview(button)
                
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing + CGFloat(row) * (buttonSize + spacing)),
                    button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing + CGFloat(col) * (buttonSize + spacing)),
                    button.widthAnchor.constraint(equalToConstant: buttonSize),
                    button.heightAnchor.constraint(equalToConstant: buttonSize)
                ])
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let row = sender.tag / 3
        let col = sender.tag % 3
        boardTap(x: row, y: col)
        
        
    }
    func setupPlayAgainButton() {
        let playAgainButton = UIButton(type: .system)
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.addTarget(self, action: #selector(playAgainButtonTapped), for: .touchUpInside)
        view.addSubview(playAgainButton)

        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc func playAgainButtonTapped() {
        let newViewController = ViewController()
        newViewController.modalPresentationStyle = .fullScreen

        self.present(newViewController, animated: true, completion: nil)

    }

    
    


}

