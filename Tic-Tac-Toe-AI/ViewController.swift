//
//  ViewController.swift
//  Tic-Tac-Toe-AI
//
//  Created by Louis An on 4/09/2016.
//  Copyright © 2016 Louis An. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ticTacImage1: UIImageView!
    @IBOutlet var ticTacImage2: UIImageView!
    @IBOutlet var ticTacImage3: UIImageView!
    @IBOutlet var ticTacImage4: UIImageView!
    @IBOutlet var ticTacImage5: UIImageView!
    @IBOutlet var ticTacImage6: UIImageView!
    @IBOutlet var ticTacImage7: UIImageView!
    @IBOutlet var ticTacImage8: UIImageView!
    @IBOutlet var ticTacImage9: UIImageView!

    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    
    @IBAction func resetBtn(sender: AnyObject) {
        reset()
    }
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    @IBAction func UIButtonClicked(sender: UIButton){
        userMessage.hidden = true
        if (((plays[sender.tag] == nil))){
            if (!aiDeciding){
                if (!done){
                    setImageForSpot(sender.tag, player: 1)
                }
            }
        }
        
        checkForWin()
        aiTurn()
    }
    
    
    func setImageForSpot(spot:Int, player:Int) {
        // if player = 1, then do "x" otherwise do "o"
        let playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot {
        case 1:
            ticTacImage1.image = UIImage(named: playerMark)
        case 2:
            ticTacImage2.image = UIImage(named: playerMark)
        case 3:
            ticTacImage3.image = UIImage(named: playerMark)
        case 4:
            ticTacImage4.image = UIImage(named: playerMark)
        case 5:
            ticTacImage5.image = UIImage(named: playerMark)
        case 6:
            ticTacImage6.image = UIImage(named: playerMark)
        case 7:
            ticTacImage7.image = UIImage(named: playerMark)
        case 8:
            ticTacImage8.image = UIImage(named: playerMark)
        case 9:
            ticTacImage9.image = UIImage(named: playerMark)
        default:
            ticTacImage5.image = UIImage(named: playerMark)
        }
    }
    
    func checkForWin(){
        let whoWon = ["I":0, "You":1]
        for (key,value) in whoWon {
            if ((plays[7] == value && plays[8] == value && plays[9] == value) || // across the bottom
            (plays[4] == value && plays[5] == value && plays[6] == value) || // across the middle
            (plays[1] == value && plays[2] == value && plays[3] == value) || // across the top
            (plays[1] == value && plays[4] == value && plays[7] == value) || // down the left
            (plays[2] == value && plays[5] == value && plays[8] == value) || // down the middle
            (plays[3] == value && plays[6] == value && plays[9] == value) || // down the left
            (plays[1] == value && plays[5] == value && plays[9] == value) || //diagonal
            (plays[3] == value && plays[5] == value && plays[7] == value)) { // diagonal
                
            let alert = UIAlertController(title: "Tic-Tac-Toe", message: "\(key) won!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            done = true
                
            }
        }
    }
    
    func checkBottom(value:Int) -> (location:String,patern:String) {
        return ("bottom",checkFor(value,inList: [7,8,9]))
    }
    func checkMiddleAcross(value:Int) -> (location:String,patern:String) {
        return ("MiddleHorz",checkFor(value,inList: [4,5,6]))
    }
    func checkTop(value:Int) -> (location:String,patern:String) {
        return ("top",checkFor(value,inList: [1,2,3]))
    }
    func checkLeft(value:Int) -> (location:String,patern:String) {
        return ("left",checkFor(value,inList: [1,4,7]))
    }
    func checkMiddleDown(value:Int) -> (location:String,patern:String) {
        return ("middleVert",checkFor(value,inList: [2,5,8]))
    }
    func checkRight(value:Int) -> (location:String,patern:String) {
        return ("right",checkFor(value,inList: [3,6,9]))
    }
    func checkDiagLeftRight(value:Int) -> (location:String,patern:String) {
        return ("diagLeftRight",checkFor(value,inList: [3,5,7]))
    }
    func checkDiagRightLeft(value:Int) -> (location:String,patern:String) {
        return ("diagRightLeft",checkFor(value,inList: [1,5,9]))
    }
    
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList{
            if plays[cell] == value{
                conclusion += "1"
            }else{
                conclusion += "0"
            }
        }
        return conclusion
    }
    
//    func rowCheck(value:Int) -> (location:String, patern:String)?{
//        var acceptableFinds = [ "011","110","101"]
//        var findFuncs = [checkTop, checkBottom, checkLeft, checkRight, checkMiddleAcross, checkMiddleDown, checkDiagLeftRight, checkDiagRightLeft]
//        for algorithm in findFuncs {
//            var algorithmResults = algorithm(value: value)
//            if find(acceptableFinds,algorithmResults.patern) {
//                return algorithmResults
//            }
//        }
//        return nil
//    }
    
    func checkThis(value: Int) -> [String]{
        return ["right","0"]
    }
    
    func rowCheck(value:Int) -> [String]? {
        let acceptableFinds = ["011","110","101"]
        var findFuncs = [self.checkThis]
        var algorthmResults = findFuncs[0](value)
        
        for algorthm in findFuncs{
            var algorthmResults = algorthm(value)
            let findPattern = acceptableFinds.indexOf(algorthmResults[1])
            if findPattern != nil {
                return algorthmResults
            }
        }
        return nil
    }

    
    func aiTurn(){
        if done {
            return
        }
        aiDeciding = true
        
        //We (the computer) have two in a row
        if let result = rowCheck(0) {
            let  whereToPlayResult = whereToPlay(result[0],pattern:result[1])
            if !isOccupied(whereToPlayResult){
                setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
            }
        }
        
        //The player has two in a row
        if let result = rowCheck(1) {
            let whereToPlayResult = whereToPlay(result[0],pattern:result[1])
            if !isOccupied(whereToPlayResult){
                setImageForSpot(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
            }
        }
        
        // Is center available?
        if !isOccupied(5){
            setImageForSpot(5, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        
        func firstAvailable(isCorner: Bool) -> Int?{
            let spots = isCorner ? [1,3,7,9] : [2,4,6,8]
            for spot in spots {
                if !isOccupied(spot){
                    return spot
                }
            }
            return nil
        }
        
        //is a corner available
        if let cornerAvailable = firstAvailable(true) {
            setImageForSpot(cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        //is a side available
        if let sideAvailable = firstAvailable(false) {
            setImageForSpot(sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }

        let alert = UIAlertController(title: "Tic-Tac-Toe", message: "It's a tie!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        done = true
        aiDeciding = true
    }
    
    
    func isOccupied(spot: Int) -> Bool {
        print("occupied \(spot)")
        if plays[spot] != nil {
            return true
        }else{
            return false
        }
    }
    
    func whereToPlay(location:String,pattern:String) -> Int {
        let leftPattern = "011"
        let rightPattern = "110"
        let middlePattern = "101"
        
        switch location{
            case "top":
                if pattern == leftPattern{
                    return 1
                }else if pattern == rightPattern{
                    return 3
                }else{
                    return 2
            }
            
        case "top":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 3
            }else{
                return 2
            }
            
        case "bottom":
            if pattern == leftPattern{
                return 7
            }else if pattern == rightPattern{
                return 9
            }else{
                return 8
            }
            
        case "left":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 7
            }else{
                return 4
            }
        case "right":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern{
                return 9
            }else{
                return 6
            }
        case "middleVert":
            if pattern == leftPattern{
                return 2
            }else if pattern == rightPattern{
                return 8
            }else{
                return 5
            }
        case "middleHorz":
            if pattern == leftPattern{
                return 4
            }else if pattern == rightPattern{
                return 6
            }else{
                return 5
            }
        case "diagRightLeft":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern{
                return 7
            }else{
                return 5
            }
        case "diagLeftRight":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern{
                return 9
            }else{
                return 5
            }
            
        default:
            return 4
        }
    }
    
    func reset() {
        plays = [:] // RESET DICTIONARY
        ticTacImage1.image = nil
        ticTacImage2.image = nil
        ticTacImage3.image = nil
        ticTacImage4.image = nil
        ticTacImage5.image = nil
        ticTacImage6.image = nil
        ticTacImage7.image = nil
        ticTacImage8.image = nil
        ticTacImage9.image = nil
        done = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

