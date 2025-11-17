# ToDoList ✓📝

A clean and efficient iOS task management application with backend integration, featuring group-based organization and a modern swipe interface.

![iOS](https://img.shields.io/badge/iOS-11.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 📱 Overview

**ToDoList** is a feature-rich task management app that helps users organize their tasks into groups, sync with a backend server, and manage their productivity across devices. Built with Swift and following MVC architecture, it provides a clean interface for creating, organizing, and completing tasks.

## 🌟 Key Features

### Task Management
- ✅ **Create Tasks** with names and descriptions
- 📋 **Group Organization** - Organize tasks into custom groups
- ✓ **Toggle Completion** - Mark tasks as done/undone
- 🗑️ **Delete Tasks** - Remove completed or unwanted tasks
- 📝 **Task Details** - Add descriptions for context

### Backend Integration
- ☁️ **Cloud Sync** - Sync tasks across devices
- 🔄 **Real-time Updates** - Changes reflect immediately
- 🔐 **User Authentication** - Secure login system
- 💾 **Persistent Storage** - Data saved on server
- 📡 **RESTful API** - Clean backend communication

### User Interface
- 📱 **Swipe Navigation** - Modern collection view interface
- 🎨 **Custom Graphics** - Bear, heart, and leaf icons
- ⚡ **Loading States** - Visual feedback during operations
- 🔄 **Pull to Refresh** - Update tasks with swipe gesture
- 📊 **Grouped Display** - Tasks organized by categories

## 🏗️ Architecture

### Model-View-Controller (MVC)

```
ToDoList/
├── Data Model/
│   ├── TableDataModel.swift      # Task and group structures
│   ├── CellManager.swift          # UI data management
│   ├── PLDBManager.swift          # Local database
│   ├── PageDataModel.swift        # Page-level data
│   └── CelliTem.swift            # Cell item model
├── Controllers/
│   ├── HomeScreen.swift           # Main entry point
│   ├── SwipController.swift       # Swipe navigation
│   ├── TableViewController.swift  # Task list display
│   ├── LoginPageVC.swift          # Authentication
│   ├── NewLoginPage.swift         # Updated login UI
│   └── AddNewTaskView.swift       # Task creation
├── Connection/
│   ├── TalkToServer.swift         # API communication
│   └── TalkToServerGetTasksInAsyncMode.swift
└── Views/
    ├── Main.storyboard            # UI layouts
    └── HeaderUI.swift             # Header components
```

## 📊 Data Structure

```swift
struct TableDataModel {
    var groupData: (groupName: String, groupID: String)
    var tasksData: [(
        taskName: String,
        taskID: String,
        taskDescription: String,
        doneStatus: Bool
    )]
}
```

## 🔄 Data Flow

```
User Action → View Controller → TalkToServer → Backend API
                                      ↓
                                 Update Model
                                      ↓
                                 Reload UI
```

## 🛠️ Technologies Used

- **Swift 4.2** - Modern iOS programming
- **UIKit** - Native iOS UI framework
- **Alamofire** - HTTP networking library
- **SwiftyJSON** - JSON parsing
- **Collection View** - Grid-based swipe interface
- **Table View** - Task list display
- **RESTful API** - Backend communication

## 🚀 Installation

1. Clone the repository:
```bash
git clone https://github.com/mrsadri/ToDoList.git
cd ToDoList
```

2. Install dependencies (if using CocoaPods):
```bash
pod install
```

3. Open the project:
```bash
open ToDoList.xcodeproj
# or if using CocoaPods:
open ToDoList.xcworkspace
```

4. Configure backend API endpoint in `TalkToServer.swift`

5. Build and run in Xcode

## 📋 Requirements

- iOS 11.0+
- Xcode 10.0+
- Swift 4.2+
- Backend API server (for full functionality)

## 💡 Key Features Implementation

### Login System
```swift
TalkToServer.sharedObject.login(
    email: "user@example.com",
    password: "password"
)
```
User authentication with backend validation.

### Fetch Tasks
```swift
TalkToServer.sharedObject.getGroup()
```
Retrieves all groups and associated tasks from server.

### Create New Task
POST request to backend with:
- Task name
- Description
- Group ID
- Completion status

### Update Task Status
PATCH request to toggle task completion.

### Delete Task
DELETE request removes task from server and local data.

## 🎨 Custom Assets

The app includes custom graphics:
- 🐻 **bear_first.png** - Category icon
- ❤️ **heart_second.png** - Priority icon
- 🍃 **leaf_third.png** - Status icon

## 🔐 Authentication Flow

1. User enters email and password
2. App sends credentials to server
3. Server validates and returns token
4. Token stored locally for future requests
5. All API calls include authentication token

## 📱 User Interface

### Home Screen
- Loading indicator with countdown
- Automatic transition to main app
- Background data fetch

### Swipe Controller
- Horizontal swipe navigation
- Collection view with pages
- Smooth transitions between groups

### Table View Controller
- Displays tasks in selected group
- Swipe to delete functionality
- Tap to toggle completion
- Pull to refresh

### Add Task View
- Input fields for name and description
- Group selection
- Save and cancel buttons

## 🔄 Sync Mechanism

1. **Initial Load**: Fetch all data on login
2. **Real-time Updates**: Push changes immediately
3. **Conflict Resolution**: Server-side validation
4. **Offline Support**: Queue actions when offline (future)

## 🧪 Development Features

- **Debug Logging**: Track API calls and responses
- **Timer-based Loading**: Visual countdown during data fetch
- **Delegation Pattern**: Clean communication between components
- **Singleton Pattern**: Centralized API manager

## 📊 API Endpoints

Expected backend endpoints:
- `POST /login` - User authentication
- `GET /groups` - Fetch all groups
- `GET /tasks` - Fetch tasks for group
- `POST /tasks` - Create new task
- `PATCH /tasks/:id` - Update task
- `DELETE /tasks/:id` - Delete task

## 🎯 Use Cases

- **Personal Productivity**: Manage daily tasks
- **Project Organization**: Group related tasks
- **Team Collaboration**: Share task lists (with backend support)
- **Goal Tracking**: Monitor completion progress

## 🚧 Future Enhancements

Potential improvements:
- [ ] Offline mode with local caching
- [ ] Push notifications for reminders
- [ ] Task due dates and priorities
- [ ] Search and filter functionality
- [ ] Dark mode support
- [ ] Task sharing between users
- [ ] Analytics and productivity insights

## 🤝 Contributing

Contributions welcome! Areas for improvement:
- UI/UX enhancements
- Additional features
- Bug fixes
- Performance optimizations
- Documentation improvements

## 📄 License

This project is open source and available under the MIT License.

## 👤 Author

**Masih Sadri**
- GitHub: [@mrsadri](https://github.com/mrsadri)

## 🙏 Acknowledgments

- Alamofire for elegant networking
- SwiftyJSON for JSON parsing
- iOS development community
- Task management app inspiration

---

*Built in 2018 as a comprehensive iOS task management solution with cloud sync capabilities*

## 🚀 Quick Start

```swift
// 1. Configure API endpoint
let baseURL = "https://your-api.com"

// 2. Login
TalkToServer.sharedObject.login(
    email: "your@email.com",
    password: "password"
)

// 3. Fetch tasks
TalkToServer.sharedObject.getGroup()

// 4. Start managing your tasks!
```

**Stay organized! ✓📝**

