//
//  NotesViewController.swift
//  Notes
//
//  Created by Nikhil  Agrawal on 6/30/20.
//  Copyright © 2020 Nikhil Agrawal. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var notes = [Note]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reload()
    }
    
    @IBAction func createNote(_ sender: UIBarButtonItem) {
        let _  = NoteManager.main.create()
        reload()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].contents
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteId = notes[indexPath.row].id
            notes.remove(at: indexPath.row)
            NoteManager.main.delete(withNoteId: noteId)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func reload() {
        notes = NoteManager.main.getAllNotes()
        self.tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteSegue", let destination = segue.destination as? NoteViewController {
            destination.note = notes[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }


}
