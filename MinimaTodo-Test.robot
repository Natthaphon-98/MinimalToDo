*** Settings ***
Library                 AppiumLibrary
Suite Setup             Open Application MinimalTodo
Suite Teardown          Close Application

*** Variables ***
${SERVER_URL}            http://localhost:4723
${PLATFORM}              Android
${PLATFORM_VERSION}      14
${DEVICE_NAME}           emulator-5558
${APP_APK}               ${CURDIR}/MinimalTodo.apk

${TASK_NAME}             AutomateTest
${TASK_NAME_EDIT}        AutomateTest_Edit

*** Keywords ***
Open Application MinimalTodo
    Open Application    ${SERVER_URL}    
    ...                 platformName=${PLATFORM}  
    ...                 platformVersion=${PLATFORM_VERSION}   
    ...                 deviceName=${DEVICE_NAME}
    ...                 automationName=UiAutomator2
    ...                 app=${APP_APK}

Wait And Click Element 
    [Arguments]         ${locator}          ${timeout}=10s
    Wait Until Element Is Visible           ${locator}      ${timeout}
    Click Element                           ${locator}
    Sleep     3s

*** Test Cases ***
Create New Task
    [Documentation]    Test Case for adding a new task
    Wait And Click Element           id=com.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB
    Wait Until Element Is Visible    id=com.avjindersinghsekhon.minimaltodo:id/userToDoEditText
    Input Text                       id=com.avjindersinghsekhon.minimaltodo:id/userToDoEditText         ${TASK_NAME}
    Wait And Click Element           id=com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton
    Page Should Contain Text         ${TASK_NAME}

Edit Task
    [Documentation]    Test Case for Edit a task
    Wait And Click Element           xpath=//android.widget.TextView[@text="${TASK_NAME}"]
    Wait Until Element Is Visible    id=com.avjindersinghsekhon.minimaltodo:id/userToDoEditText
    Clear Text                       id=com.avjindersinghsekhon.minimaltodo:id/userToDoEditText
    Input Text                       id=com.avjindersinghsekhon.minimaltodo:id/userToDoEditText         ${TASK_NAME_EDIT}
    Wait And Click Element           id=com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton
    Page Should Contain Text         ${TASK_NAME_EDIT}

Mark Task Complete
    [Documentation]    Test Case for marking a task as complete
    Wait And Click Element           xpath=//android.widget.TextView[@text="${TASK_NAME}"]
    Wait And Click Element           id=com.avjindersinghsekhon.minimaltodo:id/markToDoDone
    Page Should Contain Text         Complete

Delete Task
    [Documentation]    Test Case for deleting an existing task
    Wait And Click Element           xpath=//android.widget.TextView[@text="${TASK_NAME}"]
    Wait And Click Element           id=com.avjindersinghsekhon.minimaltodo:id/deleteToDoItem
    Page Should Not Contain Text     ${TASK_NAME}