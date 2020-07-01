//
//  NoteViewController.swift
//  Notes
//
//  Created by Nikhil  Agrawal on 7/1/20.
//  Copyright © 2020 Nikhil Agrawal. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    var note : Note?
    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note?.contents
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        guard var note = note else {return}
        note.contents = textView.text
        NoteManager.main.save(note: note)
    }
    
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
        guard let note = note else {return}
        NoteManager.main.delete(withNoteId: note.id)
        navigationController?.popViewController(animated: true)
    }
}
