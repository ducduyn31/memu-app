//
//  SupabaseService.swift
//  memu-app
//
//  Created by Jonathan on 10/6/2024.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://nqoqcwftrvbqelynyuuw.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xb3Fjd2Z0cnZicWVseW55dXV3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc2NjUzNzIsImV4cCI6MjAzMzI0MTM3Mn0.G7Q16PDlLCLMrIZtRozkNlXlLShbH1nmd8TFhjH8iPI"
)
