*** Settings ***
Resource    ../Keywords/Demokeywords.robot
Resource    ../TestData/CommonTestData.robot

Test Setup      Launch Browser
Test Teardown   Close Browser Session


*** Test Cases ***

Valid Login Test
    [Tags]    TC_001    TC
    Click Login Link
    Wait Until Login Page Visible
    Capture Page Screenshot
    Enter Login Credentials    ${useremail}    ${PASSWORD}
    Click Login Button
    Verify Login Successful


Invalid Login Test - Wrong Password
    [Tags]    TC_002    TC
    Click Login Link
    Wait Until Login Page Visible
    Enter Login Credentials    testuser@test.com    wrongpass
    Click Login Button
    Page Should Contain    Login was unsuccessful    10s
    Capture Page Screenshot


Invalid Login Test - Invalid Email
    [Tags]    TC_003    TC
    Click Login Link
    Wait Until Login Page Visible
    Enter Login Credentials    invalid@test.com    Password123
    Click Login Button
    Page Should Contain    Login was unsuccessful