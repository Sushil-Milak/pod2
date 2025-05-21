//
//  MeetingMessage.swift
//  
//
//  Created by sushil on 5/21/25.
//
import AVFoundation
import SwiftUI

import AzureCommunicationCalling
import AzureCommunicationChat


struct MeetingMessage: Identifiable {
    let id: String
      let date: Date
      let content: String
      let displayName: String

      static func fromTrouter(event: ChatMessageReceivedEvent) -> MeetingMessage {
        let displayName: String = event.senderDisplayName ?? "Unknown User"
        let content: String = event.message.replacingOccurrences(
          of: "<[^>]+>", with: "",
          options: String.CompareOptions.regularExpression
        )
        return MeetingMessage(
          id: event.id,
          date: event.createdOn?.value ?? Date(),
          content: content,
          displayName: displayName
        )
      }
}
