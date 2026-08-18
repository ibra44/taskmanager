*** Settings ***
Library                SeleniumLibrary
Resource               resources/keywords.resource
Suite Setup            Open Login Page
Suite Teardown         Close Browser
Test Setup             User Logged In


*** Test Cases ***
Test Connexion
    [Setup]          No Operation
    User Logged In

Test create a task with valid title and valid description
    [Documentation]            Verify the creation of a task with valid values
    ${title}=                  Set Variable    Lorem ipsum
    ${description}=            Set Variable    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi at tellus elit.
    Create a new task
    Enter task title           ${title}
    Enter Task Description     ${description}
    Add Task
    Check Task Created         ${title}    ${description}
