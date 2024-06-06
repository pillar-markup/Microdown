"
I represent a Microdown codeblock once it has been tested.

I am composed of a text, a result and an explanation.

The text shows the text of the codeblock I am linked to, the result is a boolean stating if the test has passed or not and the explanation is either 'Test passed', 'Test failed without raising an exception' or the exception raised by the test.

For example:
/`/`/`example=true 
3+4
>>> 7
/`/`/`

Given this codeblock, the associated MicrodownBookTestResult's instance variable would be: 
text: ''3+4'
result: true 
explanation: 'Test passed'

The fragmentedText instance variable is used by method or test definitions to keep class and method names. For example:
`/ `/ `/ methodDefinition
Plop >> plop1
   ^ '1'
`/ `/ `/

text: 'Plop >> plop1
		 ^ ''1'''
fragmentedText: #('Plop' 'plop1' '^ ''1''')


"
Class {
	#name : 'MicBookTestResult',
	#superclass : 'Object',
	#instVars : [
		'text',
		'fragmentedText',
		'status',
		'explanation'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'accessing' }
MicBookTestResult >> explanation [

	^ explanation
]

{ #category : 'accessing' }
MicBookTestResult >> explanation: anException [

	explanation := anException
]

{ #category : 'accessing' }
MicBookTestResult >> fragmentedText [

	^ fragmentedText
]

{ #category : 'accessing' }
MicBookTestResult >> fragmentedText: aText [
	"The Array contains: 
		-Class Name
		-Method Name
		-Method Body"
	fragmentedText := aText
]

{ #category : 'initialization' }
MicBookTestResult >> initialize [

	super initialize.
	status := true.
	explanation := 'Test failed without raising an exception'
]

{ #category : 'testing' }
MicBookTestResult >> isFailed [

	^ status not
]

{ #category : 'testing' }
MicBookTestResult >> isValid [

	^ status 
]

{ #category : 'accessing' }
MicBookTestResult >> status [ 
	"true means that the test is valid, false means that the test got a problem or failed"
	
	^ status
]

{ #category : 'accessing' }
MicBookTestResult >> status: aBoolean [
	"true means that the test is valid, false means that the test got a problem or failed"
	
	status := aBoolean
]

{ #category : 'accessing' }
MicBookTestResult >> text [

	^ text 
]

{ #category : 'accessing' }
MicBookTestResult >> text: aText [

	text := aText
]
