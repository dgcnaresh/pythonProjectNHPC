*** Settings ***
Library  RequestsLibrary
Library    Collections
Library    OperatingSystem
Library  json
Library    JSONLibrary
Variables    calculatetax.py
Variables    Age.py

*** Variables ***
${base_url}  http://localhost:8080



*** Test Cases ***
Post_Hero_data_Tax_Relief
    create session  mysession   ${base_url}
    ${body}=    Load JSON from file    ${CURDIR}/Applicationfiles/data.json
    ${header}=  create dictionary   Content-Type=application/json
    #${responsevalue}=   post request  mysession  /calculator/insert  data=${body}  headers=${header}

    #log to console  ${responsevalue.status_code}
    #log to console  ${responsevalue.content}
    log to console  ${body}[gender]

   #${the data}=    Evaluate    json.loads($body)    json

    log to console  ${body}
    ${salary}   Get Value From Json    ${body}    $.[:1].salary
    #set to dictionary    ${salary}    dp=the new value
    ${salaryvalue}=  Convert To String  ${salary}
    log to console   ${salaryvalue}

    #Validations
    #${status_code}=  convert to string  ${responsevalue.status_code}
    #Should be equal  ${status_code}  202

    ${responsevalue}=  Get Request  mysession  /calculator/taxRelief
    #to validate the content of the response body
    log to console  ${responsevalue}
    #Validation point to validate the hero id added in the database.
    ${jsonarr_object}=   To Json    ${responsevalue.content}
    ${json_name}   Get Value From Json    ${jsonarr_object}    $.[:1].relief
    ${taxcodefromapi}=  convert to string  ${json_name}
    Log To Console    ${body}[gender]
    ${gendervalue}=  convert to string  ${body}[gender]

    Log To Console    ${body}[birthday][0:2]
    Log To Console    ${body}[birthday][2:4]
    Log To Console    ${body}[birthday][4:8]

    ${resultage}=  evaluate  calculatetax.getAge(${body}[birthday][4:8], ${body}[birthday][2:4], ${body}[birthday][0:2])  modules=calculatetax
    Log To Console    ${resultage}

    ${result}=  evaluate  calculatetax.calculate(${body}[salary],${resultage},${body}[tax] ,"${gendervalue}")  modules=calculatetax

   #${result}=  evaluate  calculatetax.calculate(1000, 36, 10, "M")  modules=calculatetax
    ${taxcode}=  convert to string  ${result}
    log to console  convert to string  ${taxcode}
    log to console  convert to string  ${taxcodefromapi}
    Should Be Equal    ${taxcodefromapi}    ${taxcode}













