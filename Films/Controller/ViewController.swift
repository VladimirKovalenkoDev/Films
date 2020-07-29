//
//  ViewController.swift
//  Films
//
//  Created by Владимир Коваленко on 29.07.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController {
    
    var titleFilm = ""
    
    @IBOutlet weak var watchTimePicker: UIDatePicker!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        watchTimePicker.minimumDate = Date()
        print(titleFilm)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let filmTitle = titleFilm
        let watchdate = watchTimePicker.date
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let watchTime = WatchTime(context: context)
        watchTime.watchtime = watchdate
        watchTime.filmtitle = filmTitle
        watchTime.watchtimeid = UUID().uuidString
  // MARK: - CoreData manipulations
        do{
            try context.save()
            // MARK: - Notifications methods
            let message = "Hey! Today is films day! Don't forget to watch \(filmTitle)"
            print(message)
            let content = UNMutableNotificationContent()
             content.body = message
             content.sound = UNNotificationSound.default
            let dateComponents = Calendar.current.dateComponents([.month, .day,.hour,.minute], from: watchdate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            if let identifier = watchTime.watchtimeid {
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
                                        
            }
        }
            catch let error{
            print("cannot save : \(error)")
        }
        dismiss(animated: true, completion: nil)
    }
    
   

}
