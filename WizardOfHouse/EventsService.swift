//
//  EventsService.swift
//  WizardOfHouse
//
//  Created by Reza on 7/26/24.
//

import Foundation
import Combine

class EventsService {
    // MARK: - Properties
    let gptClient: GPTClient
    let appState: AppState
    var streams: Set<AnyCancellable>
    
    // MARK: Initialization
    init(gptClient: GPTClient, appState: AppState) {
        self.gptClient = gptClient
        self.appState = appState
        self.streams = Set<AnyCancellable>()
    }
    
    // MARK: - Methods
    func fetchNewEvents() {
        let prompt = generatePrompt()
        let message = GPTMessage(content: prompt, role: .user)
        gptClient.completion(for: [message])
            .receive(on: RunLoop.main)
            .sink { receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    break
                case .failure(let error):
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            } receiveValue: { receivedMessage in
                let event = WTEvent(description: receivedMessage, timestamp: Date())
                self.appState.events.append(event)
            }
            .store(in: &streams)

    }
    
    func callSmartHome() {
        let firstprompt = generatePrompt()
        let prompt = firstprompt + "Provide the current state of all smart home devices based on rules, make sure to provide the sensor value, do not provide extra information just return device name and state like Oven is Off, or IF DEVICE IS SENSOR RETURN DEVICE NAME is the predicted value of sensors"
        let message = GPTMessage(content: prompt, role: .user)
        gptClient.completion(for: [message])
            .receive(on: RunLoop.main)
            .sink { receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    break
                case .failure(let error):
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            } receiveValue: { receivedMessage in
                self.parseDeviceStates(response: receivedMessage)
            }
            .store(in: &streams)

    }
    
    // MARK: - Helper Methods
    private func parseDeviceStates(response: String) {
        let lines = response.split(separator: "\n").map { String($0) }
        
        for line in lines {
            let components = line.components(separatedBy: " is ")
            guard components.count == 2 else {
                print("Unexpected line format: \(line)")
                continue
            }
            
            let deviceName = components[0]
            let stateOrValueComponent = components[1]
            
            if let index = appState.devices.firstIndex(where: { $0.name.lowercased() == deviceName.lowercased() }) {
                let device = appState.devices[index]
                
                var eventDescription = ""
                
                switch device.type {
                case .onOff:
                    // For on/off devices, change the state based on the response
                    let isDeviceOn = stateOrValueComponent.lowercased() == "on"
                    appState.devices[index].type = .onOff(isOn: isDeviceOn)
                    eventDescription = "\(deviceName) is now \(isDeviceOn ? "On" : "Off")"
                    
                case .sensor:
                    // For sensor devices, update the value based on the response
                    appState.devices[index].type = .sensor(value: stateOrValueComponent)
                    eventDescription = "\(deviceName) value is \(stateOrValueComponent)"
                }
                
                if !eventDescription.isEmpty {
                    // Creating a new event for the update
                    let newEvent = WTEvent(description: eventDescription, timestamp: Date())
                    appState.events.append(newEvent)
                }
            } else {
                #if DEBUG
                print("Device named \(deviceName) not found.")
                #endif
            }
        }
    }
    
    private func generatePrompt() -> String {
        var prompt = "Given the following devices, people, and rules in a smart home, with the current time of day and location, provide updates on device states and any new events:\n\n"
        prompt += "Devices:\n"
        
        for device in appState.devices {
            let deviceTypeDescription = device.typeDescription
            let stateOrValueDescription = device.stateOrValueDescription
            prompt += "- \(device.name) (\(deviceTypeDescription), Interface: \(device.interface)) is \(stateOrValueDescription)\n"
        }
        
        prompt += "\nPeople:\n"
        
        for person in appState.people {
            prompt += "- \(person.name): \(person.bio)\n"
        }
        
        prompt += "\nRules:\n"
        for rule in appState.rules {
            prompt += "- \(rule.description)\n"
        }
        
        prompt += "\nTime of Day: \(formatCurrentTime())"
        prompt += "Location: \(appState.address)"
        
        return prompt
    }
    
    private func formatCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
}
