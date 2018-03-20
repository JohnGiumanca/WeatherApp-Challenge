//
//  AlarmListController.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit
import CoreLocation

class AlarmListController: BaseController, UITableViewDelegate, UITableViewDataSource, AlarmCellDelegate {
    // MARK: Constants
    private let ALARM_DETAILS_SEGUE = "SegueToAlarmDetails"
    private let TODAY_SEGUE = "SegueToToday"
    private let ALARM_CELL_IDENTIFIER = "AlarmCell"
    
    private let TABLE_INSETS = UIEdgeInsetsMake(24, 0, 8, 0)
    
    // MARK: UI Elements
    
    @IBOutlet var alarmsTableView: UITableView!
    @IBOutlet var nowInfoView: NowInfoView!
    
    // MARK: Variables
    
    var alarms:[Alarm]?
    let alarmDA = AlarmDA()
    
    var locationManager: LocationManager?
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "WeatherWake"
        
        alarmsTableView.contentInset = TABLE_INSETS
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alarms = alarmDA.getAllAlarms()
        alarmsTableView.reloadData()
        
        locationManager = LocationManager(controller: self, handler: { (location) in
            self.updateWeatherState(location)
        })
        locationManager!.requestLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == ALARM_DETAILS_SEGUE) {
            if (sender != nil) {
                let detailsController = segue.destination as! AlarmDetailsController
                detailsController.alarm = (sender as! Alarm)
            }
        }
    }
    
    func updateWeatherState(_ location: CLLocation) {
        let weatherAPI: WeatherAPI = WeatherAPI()
        
        let myLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )
        
        
        weatherAPI.requestWeather(myLocation, success: { (weather) in
            self.updateWeatherCondition(weather)
        }) { (error) in
            let apiErrorAlert = AlertHelper.createAlert("API Error", message: "The weather API doesn't respond, the app may not be fully functional.")
            self.present(apiErrorAlert, animated: true, completion: nil)
        }
    }
    
    func updateWeatherCondition(_ condition: WeatherCondition) {
        nowInfoView.loadWeatherCondition(condition)
    }
    
    // MARK: UI Actions
    
    @IBAction private func onNewAlarmTapped() {
        self.performSegue(withIdentifier: ALARM_DETAILS_SEGUE, sender: nil)
    }
    
    
    @IBAction private func onTodayTapped() {
        self.performSegue(withIdentifier: TODAY_SEGUE, sender: nil)
        
    }
    

    // MARK: TableView Datasource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ALARM_CELL_IDENTIFIER) as! AlarmCell
        cell.loadAlarm(alarms![indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (alarms?.count)!
    }

    // MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedAlarm = alarms![indexPath.row]
        self.performSegue(withIdentifier: ALARM_DETAILS_SEGUE, sender: selectedAlarm)
    }

    // MARK: AlarmCell Delegate
    
    func didChangeAlarmState(_ alarm: Alarm, isOn: Bool) {
        alarm.isOn = NSNumber(value: isOn as Bool)
        
        if (isOn) {
            NotificationsScheduler.scheduleAlarm(alarm)
        } else {
            NotificationsScheduler.removeAlarm(alarm)
        }
        
        alarmDA.save()
    }
}
