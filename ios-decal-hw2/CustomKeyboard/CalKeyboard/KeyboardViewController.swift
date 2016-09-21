//
//  KeyboardViewController.swift
//  CalKeyboard
//
//  Created by Gene Yoo on 9/15/15.
//  Copyright © 2015 iOS Decal. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {


    
//    @IBOutlet var nextKeyboardButton: UIButton!

    @IBOutlet weak var Space: UIButton!
    @IBOutlet weak var nextKeyboardButton: UIButton!
    @IBOutlet weak var retroflexT: UIButton!
    @IBOutlet weak var retroflexD: UIButton!
    @IBOutlet weak var palatalF: UIButton!
    @IBOutlet weak var littleG: UIButton!
    @IBOutlet weak var glottalStop: UIButton!
    @IBOutlet weak var PhraynFric: UIButton!
    @IBOutlet weak var labioM: UIButton!
    @IBOutlet weak var retroN: UIButton!
    @IBOutlet weak var palatalN: UIButton!
    @IBOutlet weak var velarN: UIButton!
    @IBOutlet weak var bigN: UIButton!
    @IBOutlet weak var bigR: UIButton!
    @IBOutlet weak var bigB: UIButton!
    @IBOutlet weak var rTap: UIButton!
    @IBOutlet weak var theta: UIButton!
    @IBOutlet weak var f: UIButton!
    @IBOutlet weak var beta: UIButton!
    @IBOutlet weak var psi: UIButton!
    @IBOutlet weak var retroR: UIButton!
    @IBOutlet weak var eth: UIButton!
    @IBOutlet weak var sha: UIButton!
    @IBOutlet weak var zha: UIButton!
    @IBOutlet weak var retroFricS: UIButton!
    @IBOutlet weak var retroFricZ: UIButton!
    @IBOutlet weak var palatalC: UIButton!
    @IBOutlet weak var palatalJ: UIButton!
    @IBOutlet weak var velarFricY: UIButton!
    @IBOutlet weak var velarFricX: UIButton!
    @IBOutlet weak var frenchR: UIButton!
    @IBOutlet weak var crossH: UIButton!
    @IBOutlet weak var lateralL: UIButton!
    @IBOutlet weak var voicedLateralL: UIButton!
    @IBOutlet weak var littleV: UIButton!
    @IBOutlet weak var upsidedownR: UIButton!
    @IBOutlet weak var wh: UIButton!
    @IBOutlet weak var hookedl: UIButton!
    @IBOutlet weak var upsidedowny: UIButton!
    @IBOutlet weak var littleL: UIButton!
    @IBOutlet weak var returnKey: UIButton!
    @IBOutlet weak var deleteKey: UIButton!

    var keyboardView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

    func loadInterface() {
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        keyboardView.frame = view.frame
        view.addSubview(keyboardView)
        view.backgroundColor = keyboardView.backgroundColor
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside) // advanceToNextInputMode is already defined in template

        
//        loadAllButtons()
        
//    }

    
//    func loadAllButtons() {
        Space.addTarget(self, action: "SpaceInsert", forControlEvents: .TouchUpInside)
        deleteKey.addTarget(self, action: "DeleteChar", forControlEvents: .TouchUpInside)
        returnKey.addTarget(self, action: "newLine", forControlEvents: .TouchUpInside)


    }

    @IBAction func buttonPressed(sender: UIButton) {
        var strInsert = ""
        let proxy = self.textDocumentProxy as UIKeyInput
        strInsert = sender.titleLabel!.text!
        
        
        proxy.insertText(strInsert)

    }
    
    
    func newLine() {
        (textDocumentProxy as UIKeyInput).insertText("\n")

    }
    
    func SpaceInsert() {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    func DeleteChar() {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }

}
