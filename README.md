## Getting Started with Flutter

This project is a starting point for a Flutter application.

**To start development and setup flutter properly, follow the instructions in these links:**
https://docs.flutter.dev/get-started/install/windows/mobile?tab=later-start
https://docs.flutter.dev/get-started/editor?tab=vscode
https://docs.flutter.dev/tools/vs-code

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Gallery Cleaner:
Our app is designed to help you reclaim your precious storage space by identifying and grouping similar images, allowing you to easily browse through them and delete unnecessary duplicates, all from one convenient location.

With our app, the days of endlessly searching through your gallery to make room for new memories are over. Simply select the photos you want to group, press the button, and let our app do the rest. Be patient as your images are grouped, and finally, delete all unnecessary photos from your gallery with ease!

Our team was inspired to develop a solution that leverages our newly acquired knowledge of Algorithms & Data Structures to create something practical for everyday use. By employing techniques such as average hash and other data structures, we can efficiently optimize storage space. Our application comprises four key components: Frontend, Image Retrieval, Image Comparator, and Image Deletion.

While there are similar downloadable applications available, such as Remo Duplicate Photo Remove, our app offers unique capabilities tailored to the specific needs of organizing and optimizing image storage.

## Technical Background:
  **Frontend:
    The application is designed with three primary pages: the Home Page, Loading Page, and Grouping Display Page, each serving a distinct purpose. The Home Page features buttons for selecting and grouping images, presenting them in a grid view for easy review. Transitioning to the Loading Page, users encounter a circular progress indicator, signaling ongoing backend computations while offering a momentary pause for processing. Finally, the Grouping Display Page organizes images into sublists, displaying them in rows labeled with their respective group numbers. This page also provides a "trash" button for each group, facilitating efficient deletion of redundant images, thereby streamlining the process of managing and optimizing storage space on devices.
    
  **Backend Image Comparter:
    This process aims to categorize a list of images into groups based on their similarities. It utilizes the compareImages(src1, src2, algorithm) library function to compare images. Initially, the return value contains a single list with the first image from the input list. Then, each image in the list is compared with the first image in each existing sublist. If the comparison result suggests sufficient similarity, the image is added to the corresponding sublist. This iterative process ensures the effective grouping of similar images, resulting in a structured representation of related images within the collection.
    
  **Backend Image Delation:
    The objective of this process is to remove all images from a provided list except for the first element. Initially, the user is prompted for permission to delete images from the media store if such consent has not already been granted. Subsequently, the algorithm iterates through the list of images, starting from the second element, and proceeds to delete each image from the media store. By executing this sequence of steps, the algorithm ensures that only the first image in the list remains, effectively removing any redundant images and streamlining the collection to contain solely the desired content.
    
  **Backend Image Retrival: 
    The goal is to efficiently collect chosen images from a mobile device. It starts by initializing a list to store these images. Then, it handles permissions using permission_handler and retrieves image assets with photo_manager. The algorithm iterates through the assets, checking each against set criteria. If an asset meets the criteria, it's added to the selected images list. This method ensures only relevant images are gathered, streamlining the process on the mobile device.

## Team Roles:
  Ben Walsh
    - Sketch and developed front end and user interface
    - Helped write backend algorithm
    - Devolped loading page
    
  Caleb Beversdorf
    - Worked on image retrieval and deletion
    - Worked on proof of concepts in flet and flutter
    - Helped fine tune duplicate detection algorithim
    
  Hussain Razvi
    - Worked On Image Retrival
    - Set up Date Filter
    - Helped on XMF data for files
    
  Aaryan Shukla
    - Helped with ideas and implementation regarding image comparator and with gallery frontend.

## Installation & Setup:
    1. Access the Git release on our page:
          - Use an emulator or an Android device to access the Git release.
    2. Follow the instructions on Android Authority(https://www.androidauthority.com/how-to-install-apks-31494/):
          - Visit Android Authority and follow the required permissions outlined on the page.
          - Choose the appropriate version for your device:
            - For ARM 64 devices (phones): Download app-arm64-v8a-release.apk.
            - For x86_64 emulators: Download app-x86_64-release.apk.
    3. Download the APK:
          - Depending on your device type, download the corresponding APK file.
    4. Run the Application:
          - Install and run the application.
          - Ensure to configure settings smartly.
