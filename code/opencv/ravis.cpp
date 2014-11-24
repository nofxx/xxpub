/**
 * @function findContours_Demo.cpp
 * @brief Demo code to find contours in an image
 * @author OpenCV team
 */

#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

using namespace cv;
using namespace std;

Mat src; Mat src_gray;
int thresh = 100;
int max_thresh = 255;
RNG rng(12345);

/// Function header
void thresh_callback(int, void* );

/**
 * @function main
 */
int main( int, char** argv )
{
  CvCapture* capture;
//    Mat frame;

//    //-- 1. Load the cascades
//    // if( !face_cascade.load( face_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; };
//    // if( !eyes_cascade.load( eyes_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; };

//    //-- 2. Read the video stream
	capture = cvCaptureFromCAM( -1 );
//    if( capture )
//    {
		  /// Create Window
	src = cvQueryFrame( capture );
			cvtColor( src, src_gray, COLOR_BGR2GRAY );
			blur( src_gray, src_gray, Size(3,3) );

  const char* source_window = "Source";
  namedWindow( source_window, WINDOW_AUTOSIZE );
	imshow( source_window, src );

  createTrackbar( " Canny thresh:", "Source", &thresh, max_thresh, thresh_callback );
  thresh_callback( 0, 0 );


	 while( true ) {
		 src = cvQueryFrame( capture );
		 
		 cvtColor( src, src_gray, COLOR_BGR2GRAY );
		 blur( src_gray, src_gray, Size(3,3) );

		 imshow( source_window, src );
		 thresh_callback( 0, 0 );
		 // 		/// Convert image to gray and blur it
		 int c = waitKey(10);
		 if( (char)c == 'c' ) { break; }			
	 }
	 waitKey(0);
  return(0);
}

/**
 * @function thresh_callback
 */
void thresh_callback(int, void* )
{
  Mat canny_output;
  vector<vector<Point> > contours;
  vector<Vec4i> hierarchy;

  /// Detect edges using canny
  Canny( src_gray, canny_output, thresh, thresh*2, 3 );
  /// Find contours
  findContours( canny_output, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, Point(0, 0) );

  /// Draw contours
  Mat drawing = Mat::zeros( canny_output.size(), CV_8UC3 );
  for( size_t i = 0; i< contours.size(); i++ )
     {
       Scalar color = Scalar( rng.uniform(0, 255), rng.uniform(0,255), rng.uniform(0,255) );
       drawContours( drawing, contours, (int)i, color, 2, 8, hierarchy, 0, Point() );
     }

  /// Show in a window
  namedWindow( "Contours", WINDOW_AUTOSIZE );
  imshow( "Contours", drawing );
}


// #include <stdio.h>
// #include <opencv2/opencv.hpp>

// #include "opencv2/objdetect/objdetect.hpp"
// #include "opencv2/highgui/highgui.hpp"
// #include "opencv2/imgproc/imgproc.hpp"


// // #include "opencv2/text.hpp"
// // #include "opencv2/core/utility.hpp"
// // #include "opencv2/features2d.hpp"

// #include <iostream>



//  using namespace std;
//  using namespace cv;

//  /** Function Headers */
//  void detectAndDisplay( Mat frame );

//  /** Global variables */
//  String face_cascade_name = "haarcascade_frontalface_alt.xml";
//  String eyes_cascade_name = "haarcascade_eye_tree_eyeglasses.xml";
//  CascadeClassifier face_cascade;
//  CascadeClassifier eyes_cascade;
//  string window_name = "Capture - Face detection";
//  RNG rng(12345);

//  /** @function main */
//  int main( int argc, const char** argv )
//  {
//    CvCapture* capture;
//    Mat frame;

//    //-- 1. Load the cascades
//    // if( !face_cascade.load( face_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; };
//    // if( !eyes_cascade.load( eyes_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; };

//    //-- 2. Read the video stream
//    capture = cvCaptureFromCAM( -1 );
//    if( capture )
//    {
//      while( true )
//      {
//    frame = cvQueryFrame( capture );

//    //-- 3. Apply the classifier to the frame
//        if( !frame.empty() )
//        { detectAndDisplay( frame ); }
//        else
//        { printf(" --(!) No captured frame -- Break!"); break; }

//        int c = waitKey(10);
//        if( (char)c == 'c' ) { break; }
//       }
//    }
//    return 0;
//  }

// /** @function detectAndDisplay */
// void detectAndDisplay( Mat frame )
// {
//   std::vector<Rect> faces;
//   Mat frame_gray;

//   cvtColor( frame, frame_gray, CV_BGR2GRAY );
//   equalizeHist( frame_gray, frame_gray );

//   //-- Detect faces
//   // face_cascade.detectMultiScale( frame_gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, Size(30, 30) );

//   // for( size_t i = 0; i < faces.size(); i++ )
//   // {
//   //   Point center( faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5 );
//   //   ellipse( frame, center, Size( faces[i].width*0.5, faces[i].height*0.5), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );

//   //   Mat faceROI = frame_gray( faces[i] );
//   //   std::vector<Rect> eyes;

//   //   //-- In each face, detect eyes
//   //   eyes_cascade.detectMultiScale( faceROI, eyes, 1.1, 2, 0 |CV_HAAR_SCALE_IMAGE, Size(30, 30) );

//   //   for( size_t j = 0; j < eyes.size(); j++ )
//   //    {
//   //      Point center( faces[i].x + eyes[j].x + eyes[j].width*0.5, faces[i].y + eyes[j].y + eyes[j].height*0.5 );
//   //      int radius = cvRound( (eyes[j].width + eyes[j].height)*0.25 );
//   //      circle( frame, center, radius, Scalar( 255, 0, 0 ), 4, 8, 0 );
//   //    }
//   // }
//   //-- Show what you got
//   imshow( window_name, frame );
//  }
