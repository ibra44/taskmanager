*** Settings ***
Library                     SeleniumLibrary
Library                     String
Resource                    resources/keywords.resource
Suite Setup                 Open Login Page
Suite Teardown              Close Browser
Test Setup                  User Logged In


*** Test Cases ***
Test Login
    [Setup]          No Operation
    User Logged In

Test create a task with valid title and valid description
    [Documentation]            Verify the creation of a task with valid values
    ${valid_title}=            Generate Random String    3-80     [LETTERS]
    ${valid_desc}=             Generate Random String    3-450    [LETTERS]
    Create a new task
    Enter task title           ${valid_title}
    Enter Task Description     ${valid_desc}
    Add Task
    Check Task Created         ${valid_title}    ${valid_desc}


Logging out
    Logout