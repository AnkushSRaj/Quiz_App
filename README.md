# Quiz App

A Flutter mobile application that generates quiz questions dynamically using GROQ.com's LLM APIs. The app features a modern UI and uses Riverpod for state management.

## Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/AnkushSRaj/Quiz_App.git
   ```
2. Navigate into the project directory:
   cd Quiz_App
3. Install the dependencies:
   flutter pub get
4. Usage:
   flutter run

## Features

- Dynamic quiz question generation using GROQ.com's LLM APIs
- Beautiful and modern UI with gradient backgrounds
- Multiple-choice questions with immediate feedback
- Score tracking and percentage calculation
- Option to retry with new questions
- State management using Riverpod
- Error handling and loading states

## Instruction

- By opening the app you reach the home page
- Here you can start the quiz, with easy, medium and hard difficulty levels
- Aftering starting the quiz, you'll have to finish 5 questions
- Each question needs to be completed in 45 seconds
- You'll reach results page, here your score and history will be displayed
- From here you can either try quiz of the same difficulty level, or visit home page

## Project Structure

```
lib/
  ├── models/
  │   ├── quiz_question.dart
  |   └── score_history.dart

  ├── providers/
  │   ├── quiz_provider.dart
  │   └── score_provider.dart

  ├── screens/
  │   ├── home_screen.dart
  │   ├── quiz_screen.dart
  │   └── result_screen.dart
  ├── services/
  │   ├── quiz_service.dart
  │   └──    score_storage_service.dart
  └── main.dart
```

## API Integration

The app uses GROQ.com's LLM APIs to generate quiz questions. The API key is configured in the `QuizService` class. Make sure to replace it with your own API key.
