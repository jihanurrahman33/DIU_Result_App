DIU Result App

The DIU Result App is a Flutter-based mobile application designed to help students access their results from DIU (Daffodil International University). The app integrates with DIU’s open APIs to fetch real-time student information and semester results. It allows users to enter their unique student ID to view their personal details, semester-wise CGPA, and other relevant academic data.

Features

	•	Student Information Display: Enter your unique student ID and fetch details such as name, ID, batch, and program.
	•	Semester Results: View CGPA and semester-wise details using DIU’s open APIs.
	•	Search Functionality: Search by student ID to retrieve relevant data from the DIU API.
	•	Shimmer Loading Effects: Display shimmer loading effects during data retrieval for a smooth experience.
	•	Responsive UI: The app is designed to work on both mobile and tablet devices.
	•	Local State Management: Uses GetX for state management to handle user input and display data dynamically.

Technologies Used

	•	Flutter: A cross-platform framework for building natively compiled applications for mobile.
	•	GetX: A lightweight and powerful state management solution for Flutter.
	•	Shimmer: A package to add shimmer effects for loading states.
	•	DIU Open APIs: APIs provided by DIU to fetch student-related data such as personal information and results.

Installation

To get started with the DIU Result App, follow these steps:
	1.	Clone the repository:
        git clone https://github.com/yourusername/diu-result-app.git

    2.	Install dependencies:Run the following command to install all required dependencies:
        flutter pub get

    3.	Configure DIU API (If required):
            •	Ensure you have the proper access or API keys to connect to the DIU APIs. You can obtain the necessary credentials from the official DIU API documentation.
	4.	Run the app:Use the following command to run the app on an emulator or physical device:
            flutter run

Usage

	•	On the home screen, enter your student ID in the input field and click the “search” button.
	•	If the student information is available, it will display details such as name, ID, batch, and program.
	•	Below the personal information, semester-wise results (like CGPA) will be displayed in a grid format.
	•	The app shows a shimmer loading effect while fetching data from DIU APIs.

Contributing

    Contributions are welcome! If you want to contribute to this project, please open an issue or submit a pull request. Please follow the code style guidelines and include tests for any new features.

License

    This project is licensed under the MIT License - see the LICENSE file for details.