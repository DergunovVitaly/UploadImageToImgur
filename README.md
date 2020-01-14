# UploadImageToImgur

Coding Exercise

Create the following iOS app on Xcode framework, using Swift:
Capabilities:

● The app should support iPhone and iPad devices.
● The app should support portrait and landscape modes.
● Target OS version - iOS 10 and above

Flow:
//1. The main screen should have a visible navigation controller.
//2. On launch, the app should display all images from user’s device gallery, within the root view controller in the navigation controller.
//3. The user’s images should be displayed as squares; 3 columns on portrait, and 5
on landscape.
4. Upon tapping an image, a loading spinner should be displayed on the image, and the original image should be uploaded to “imgur”
(https://apidocs.imgur.com/#58306db8-0a6f-4aa1-a021-bdad565f153e)
      //  a. Note that as long as the image is uploaded, the spinner should be displayed on
        the correct image, even on scrolling the screen down and up.
        b. Images should be uploaded on a queue, one by one.
    //    c. In case of an upload failure, and the images screen is visible, display an alert.
//5. On the top right of the navigation bar, add a “links” button which will push a table list of all urls to images uploaded by the app.
//6. The urls list should be persistent; re-running the app should display the list as it was the last run.
//7. Tapping a url on the list, should open the native browser with the url, displaying the uploaded image on the web.

What do we expect?
● Object Oriented code is required
● The app should be built by a strict conventional design pattern as you choose ● No memory leaks should occur in the app
● Interface Builder should be used correctly to define UI
● No compilation errors or warnings
● Smooth performance even with a large amount of photos
● Documentation and comments are highly appreciated
