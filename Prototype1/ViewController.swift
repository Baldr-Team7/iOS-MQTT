//
//  ViewController.swift
//  Prototype1
//
//  Created by LiangZhanou on 2016-10-14.
//  Copyright © 2016 LiangZhanou. All rights reserved.
//

import UIKit
import CocoaMQTT


class ViewController: UIViewController {
    var mqtt: CocoaMQTT?
    var animal: String?
    var message : String?
    
    @IBOutlet weak var button: UIButton!
         
    
    
    func settingMQTT() {
       // message = "Hi"
        let clientIdPid = "CocoaMQTT" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientId: clientIdPid, host: "tann.si", port: 8883)
        if let mqtt = mqtt {
            mqtt.username = "test"
            mqtt.password = "public"
            mqtt.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
            mqtt.keepAlive = 90
            mqtt.delegate = self
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingMQTT()
        mqtt!.connect()
    }
    @IBAction func pub(_ sender: AnyObject) {
        self.button.titleLabel!.text = "omg"
        mqtt?.publish("testing", withString: "ghjkh")
    }
    
}

    
extension ViewController: CocoaMQTTDelegate {
        
        func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
            print("didConnect \(host):\(port)")
        }
        
        func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
//            //print("didConnectAck \(ack.rawValue)")
//            if ack == .accept {
//                mqtt.subscribe("chat/room/animals/client/+", qos: CocoaMQTTQOS.qos1)
//                mqtt.ping()
//                
////                let lightViewController = storyboard?.instantiateViewController(withIdentifier: "LightViewController") as? LightViewController
////                lightViewController?.mqtt = mqtt
////                navigationController!.pushViewController(lightViewController!, animated: true)
//            }
//            
        }
        
        func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
            print("didPublishMessage with message: \(message.string)")
        }
        
        func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
            print("didPublishAck with id: \(id)")
        }
        
        func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
            print("didReceivedMessage: \(message.string) with id \(id)")
        }
        
        func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
            print("didSubscribeTopic to \(topic)")
        }
        
        func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
            print("didUnsubscribeTopic to \(topic)")
        }
        
        func mqttDidPing(_ mqtt: CocoaMQTT) {
            print("didPing")
        }
        
        func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
            _console("didReceivePong")
        }
        
        func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: NSError?) {
            _console("mqttDidDisconnect")
        }
        
        func _console(_ info: String) {
            print("Delegate: \(info)")
        }
        
}


