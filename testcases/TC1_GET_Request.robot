*** Settings ***
Library  RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${base_url}  	http://localhost:8080
${city}  Delhi


*** Test Cases ***
Tax Relief API Automation
    create session  mysession    ${base_url}
    #AC1: a GET endpoint which returns a list consist of natid, tax relief  #amount and name
    ${response}=  Get Request  mysession  /calculator/taxRelief
    ${jsonarr_object}=   To Json    ${response.content}
    ${json_name}   Get Value From Json    ${jsonarr_object}    $.[:1].natid
    Log To Console    ${json_name}


    ${status_code}=  convert to string  ${json_name}
    Log To Console    ${status_code}.mask.count()








