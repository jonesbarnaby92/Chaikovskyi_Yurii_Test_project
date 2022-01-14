*** Settings ***
Resource    APITestingresources.robot

*** Variables ***


*** Test Cases ***


AutoAuthorization booking test
#AutoAuthorization booking
    ${REQUEST_AUTH_BODY}    create dictionary    username=admin     password=password123
    ${HEADER_AUTH}    create dictionary    Content-Type=application/json
    Create Session    Auth_createToken    ${BASE_URL}
    ${RESPONSE_AUTH}  post on session   Auth_createToken    ${BOOKING_AUTH_ENDPOINT}    json=${REQUEST_AUTH_BODY}   headers=${HEADER_AUTH}
    ${TOKEN_VALUE}    get value from json    ${RESPONSE_AUTH.json()}    $.token
    ${TOKEN_VALUE_DELETE}    convert to string     ${TOKEN_VALUE[0]}
    ${RESPONSE_AUTH_STATUS_CODE}    convert to string    ${RESPONSE_AUTH.status_code}
    log to console    ${RESPONSE_AUTH_STATUS_CODE}
    should be equal    ${RESPONSE_AUTH_STATUS_CODE}   200
    log to console     ${TOKEN_VALUE[0]}


#Create bookingt test
    ${REQUEST_BODY_CREATE_BOOKING}    jsonlibrary.load json from file    data/book.json
    ${HEADER_CREATE_BOOKING}    create dictionary    Content-Type=application/json
    create session    create_booking    ${BASE_URL}
    ${RESPONSE_CREATE_BOOKING}    post on session    create_booking    ${CREATE_BOOKING_ENDPOINT}    json=${REQUEST_BODY_CREATE_BOOKING}    headers=${HEADER_CREATE_BOOKING}
    ${ID_USER_BOKING}    get value from json    ${RESPONSE_CREATE_BOOKING.json()}    $.bookingid
    ${ID}  convert to string    ${ID_USER_BOKING[0]}
    ${RESPONSE_CREATE_BOOKING_STATUS_CODE}   convert to string    ${RESPONSE_CREATE_BOOKING.status_code}
    log to console    ${RESPONSE_CREATE_BOOKING_STATUS_CODE}
    should be equal    ${RESPONSE_CREATE_BOOKING_STATUS_CODE}   200
    log to console   ${ID_USER_BOKING[0]}


#Check booking test (1)
    Create Session    check_booking    ${BASE_URL}
    ${RESPONSE_CHECK_BOOKING}    get on session    check_booking    ${CREATE_BOOKING_ENDPOINT}${ID}
    ${RESPONSE_CHECK_BOOKING_STATUS_CODE}    convert to string    ${RESPONSE_CHECK_BOOKING.status_code}
    log to console    ${RESPONSE_CHECK_BOOKING_STATUS_CODE}
    should be equal    ${RESPONSE_CHECK_BOOKING_STATUS_CODE}    200



#Delete booking
    ${HEADER_DELETE_BOOKING}    create dictionary    Content-Type=application/json    cookie=${token2}${TOKEN_VALUE_DELETE}
    Create Session    delete_booking    ${BASE_URL}
    ${RESPONSE_DELETE_BOOKING}    delete on session    delete_booking     ${CREATE_BOOKING_ENDPOINT}${ID}      headers=${HEADER_DELETE_BOOKING}
    ${RESPONSE_DELETE_BOOKING_STATUS_CODE}    convert to string    ${RESPONSE_DELETE_BOOKING.status_code}
    log to console    ${RESPONSE_DELETE_BOOKING_STATUS_CODE}
    should be equal    ${RESPONSE_DELETE_BOOKING_STATUS_CODE}    201
    ${RESPONSE_DELETE_BOOKING_TEXT}    convert to string    ${RESPONSE_DELETE_BOOKING.content}
    should contain       ${RESPONSE_DELETE_BOOKING_TEXT}    Created



#Check    booking test (2)
    Create Session    check booking    ${BASE_URL}
    ${RESPONSE_CHECK_BOOKING}    get request    check_booking    ${CREATE_BOOKING_ENDPOINT}${ID}
    ${RESPONSE_CHECK_BOOKING_TEXT}    convert to string    ${RESPONSE_CHECK_BOOKING.content}
    log to console    ${RESPONSE_CHECK_BOOKING_TEXT}
    should be equal    ${RESPONSE_CHECK_BOOKING_TEXT}    Not Found


