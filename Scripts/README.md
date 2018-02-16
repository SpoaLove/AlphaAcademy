# Format for Script

<strong>This Document describes how the Script should be formatted</strong>

## Script Structure

<strong> Every main chapters' script must follow the Structure below:</Strong>

<strong>Initial Scripts</strong>
<strong>Quizes</strong>
<strong>Post Quiz Scripts</strong>


## Script identifyer

<strong>Every Route in the Script will have it's identifyer</strong>

<strong>The identify number should be written at the start of the script</strong>

<strong>The Format for the Script Number is:</strong>

\# ChapterId.SectionsId.RouteId

a '.' is used to show the script is a sub route

<strong>Example:</strong>

\# 1.Quizes.2


## Dialog

<strong>A line of dialog should be written like following:</strong>

CharacterName: "text"

<strong>Example:</strong>

A-Chan: "Hello, World!"

## User text inputs

<strong>if there is user text inputs use the following format:</strong>

//User Text Inputs

-Variable Name- Title: "Title of Text"

* Discriptions: "Discriptions fot user inputs"

//User Text Inputs

<strong>Example:</strong>

//User Text Inputs

-userName- Title: "Name?"

* Discriptions: "Please enter your Name:"

//User Text Inputs

## user popup inputs

<strong>if there is popup inputs (such as multiple choice questions) use the following format:</strong>

//Popups

Title: "Title of the Question"

1. "Name of First Choice" -> Script Number that is linked to

2. "Name of Second Choice" -> Script Number that is linked to

//Popups

<strong>Example:</strong>

//Popups

Title: "Coffee or Tea?"

1. "Coffee" -> \# 0.0.1

2. "Tea" -> \# 0.0.2

//Popups
