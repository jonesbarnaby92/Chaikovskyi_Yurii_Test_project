*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    os






*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${BOOKING_AUTH_ENDPOINT}    /auth
${CREATE_BOOKING_ENDPOINT}    /booking



*** Test Cases ***
AutoAuthorization booking test
    ${REQUEST_AUTH_BODY}    create dictionary    username=admin     password=password123
    ${HEADER_AUTH}    create dictionary    Content-Type=application/json
    Create Session    Auth_createToken    ${BASE_URL}
    ${RESPONSE_AUTH}  post on session   Auth_createToken    ${BOOKING_AUTH_ENDPOINT}    json=${REQUEST_AUTH_BODY}   headers=${HEADER_AUTH}
    ${TOKEN}    get value from json    ${RESPONSE_AUTH.json()}    $.token
    log to console     ${TOKEN[0]}

Create bookingt test
    ${REQUEST_BODY_CREATE_BOOKING}    load json from file    rf/databooking.json
    #${HEADER_CREATE_BOOKING}    create dictionary    Content-Type=application/json
    #create session    create_booking    ${BASE_URL}
    #${RESPONSE_CREATE_BOOKING}    post on session    create_booking    ${CREATE_BOOKING_ENDPOINT}    json=${REQUEST_BODY_CREATE_BOOKING}    headers=${HEADER_CREATE_BOOKING}
    #${ID_USER_BOKING}    get value from json    ${RESPONSE_CREATE_BOOKING.json()}    $.bookingid
    #log to console     ${ID_USER_BOKING}