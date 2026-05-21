*** Settings ***
Resource    ../Keywords/Demokeywords.robot

Test Setup      Launch Browser
Test Teardown   Close Browser Session

*** Test Cases ***
TC01_New_User_Registration
    [Documentation]    Validate registration error when email already exist
    Navigate To Registration Link
    Provide Already Existing Email Id
    ...    John
    ...    Doe
    ...    john1@test.com
    ...    Password
    Verified that User Is Unable To Register With Already Resitered Email Id
    Capture Page Screenshot    register.png


