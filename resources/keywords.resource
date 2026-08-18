*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}     https://taskmanager.stl-training.fr
${email}        jorge.penaramirez2026@campus-eni.fr
${password}     jorge1234


*** Keywords ***
Open Login Page
    Open Browser    ${BASE_URL}        firefox

User Logged In
    [Documentation]            Authenticate a user on the website
    Input Text                 id=mat-input-0                            ${email}      
    Input Password             id=mat-input-1                           ${password}
    Click Button               //button[.//span[text()='Login']]
    Wait Until Page Contains   Tasks

Create a new task
    Click Button                //taskmanager-tasks/button[@mat-fab]

Enter task title
    [Arguments]                  ${title}
    Input Text                   id=mat-input-2                               ${title}

Enter task description
    [Arguments]                  ${description}
    Input Text                   id=mat-input-3                               ${description}

Add Task
    Click Button                //button[.//span[text()='Add Task']]

Check task created
    [Arguments]                ${title}    ${description}
    Wait Until Page Contains Element    //mat-list-item
    Page Should Contain        ${title}
    Page Should Contain        ${description}