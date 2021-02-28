*** Settings ***
Library      AppiumLibrary
Resource     ../Resources/password.robot
*** Variables ***
${USER-DETAILS-EMAIL}    ${USER-EMAIL}
${USER-DETAILS-PASSWORD}    ${PASSWORD}
${LOGIN-EMAIL-FIELD}    id=com.instagram.android:id/login_username
${LOGIN-PASSWORD-FIELD}    id=com.instagram.android:id/password
${LOGIN-SIGNIN-BUTTON}    id=com.instagram.android:id/button_text
${LOGIN-BUTTON}    id=com.instagram.android:id/log_in_button
${LOGIN-MAIN-PAGE}    //android.widget.TextView[@text="Your Story"]
${PROFILE-MAIN-PAGE}    //android.widget.TextView[@text="Posts"]
${PROFILE-AVATAR}    id=com.instagram.android:id/tab_avatar
${GO-BACK-HOME-PAGE}    //android.widget.Button[@content-desc="Home"]/android.widget.ImageView
*** Test Cases ***

USER CAN SURF BETWEEN HOME PAGE and PROFILE PAGE
  [Setup]    Open Test Application
  Login With Correct Credentials
  Go To Profile
  Go To Home
  [Teardown]  Quit Application

Login success
  [Setup]    Open Test Application
  Login With Correct Credentials
  [Teardown]  Quit Application

Login Failure
  [Setup]    Open Test Application
  Login With Bad Credentials
  [Teardown]  Quit Application

*** keywords ***
Open Test Application
  Open Application	http://localhost:4723/wd/hub	platformName=Android	platformVersion=7.0     deviceName=Pixel 4 API 24	appPackage=com.instagram.android	appActivity=com.instagram.mainactivity.MainActivity
  Wait Until Page Contains Element    ${LOGIN-BUTTON}
Login With Correct Credentials
  Click Element    ${LOGIN-BUTTON}
  sleep    5s
  input text    ${LOGIN-EMAIL-FIELD}    ${USER-DETAILS-EMAIL}
  input password    ${LOGIN-PASSWORD-FIELD}    ${USER-DETAILS-PASSWORD}
  Click Element    ${LOGIN-SIGNIN-BUTTON}
  sleep    5s
  Wait Until Page Contains Element    ${PROFILE-AVATAR}
Login With Bad Credentials
  Click Element    ${LOGIN-BUTTON}
  sleep    5s
  input text    ${LOGIN-EMAIL-FIELD}    dump
  input password    ${LOGIN-PASSWORD-FIELD}    dump
  Click Element    ${LOGIN-SIGNIN-BUTTON}
  Wait Until Page Contains    "Try Again"
Go To Profile
  Click Element    ${PROFILE-AVATAR}
  sleep    5s
  Wait Until Page Contains Element    ${PROFILE-MAIN-PAGE}
Go To Home
  Click Element    ${GO-BACK-HOME-PAGE}
  Wait Until Page Contains Element    ${PROFILE-AVATAR}