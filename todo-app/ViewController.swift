//
//  ViewController.swift
//  todo-app
//
//  Created by Darianne Salinas on 5/26/22.
//

import UIKit

struct Todo {
   var name: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var todos = [
        Todo(name: "Do the dishes"),
        Todo(name: "Make a recording of a lesson"),
        Todo(name: "Mow the lawn")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//need to set up datasource and delegate
        
        tableView.delegate = self
        tableView.dataSource = self

    }

    @IBAction func didPressAddButton(_ sender: Any) {
        //First we want to get the indexPath that the inserted row is going to end up at
        //take advantage that current count of todos is going to be the index that we want to insert at
        //created indexPath
        //append todo
        //have to tell tableView that we have inserted some rows
        let indexPath = IndexPath(row: todos.count, section: 0)
        todos.append(Todo(name: "Eat a JDawg"))
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    @IBAction func didPressEditButton(_ sender: Any) {
        //whatever tableView is doing, do the opposite --> tableView.isEditing, animated true?
        //this allows for EditButton on top right corner to change to "Done" when we are done editing the cells
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressEditButton(_:)))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didPressEditButton(_:)))
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].name
        return cell

    }
    //implement delegate functions we need to get functionality of edit and add buttons
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    //this function is a callback coming back from tableview telling us that while in editing mode, our user moved our row from this index path to another index path
    // when moving rows, the tableview is informing us that a row has been moved from a certain source, cell is already in the UI and in a new spot
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let todo = todos[sourceIndexPath.row]
        todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }
    
    //here we are informed that user is trying to delete a row
    //we have to delete it from the datasource and the tableview
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            //remove item from current indexPath
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            break
        case .none:
            break
            
        }
    }
    
    
}

