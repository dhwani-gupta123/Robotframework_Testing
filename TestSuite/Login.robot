*** Settings ***
Resource    ../Keywords/Demokeywords.robot
Resource    ../TestData/CommonTestData.robot

Test Setup      Launch Browser
Test Teardown   Close Browser Session


*** Test Cases ***

Valid Login Test
    Click Login Link
    Wait Until Login Page Visible
    ${email}    Enter Login Credentials    ${useremail}    ${password}
    Log    ${email}
    Click Login Button
    Verify Login Successful


Invalid Login Test - Wrong Password
    Click Login Link
    Wait Until Login Page Visible
    Enter Login Credentials    testuser@test.com    wrongpass
    Click Login Button
    Page Should Contain    Login was unsuccessful


Invalid Login Test - Invalid Email
    Click Login Link
    Wait Until Login Page Visible
    Enter Login Credentials    invalid@test.com    Password123
    Click Login Button
    Page Should Contain    Login was unsuccessful