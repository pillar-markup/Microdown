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
	#name : 'MicrodownBookTestResult',
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
MicrodownBookTestResult >> explanation [

	^ explanation
]

{ #category : 'accessing' }
MicrodownBookTestResult >> explanation: anException [

	explanation := anException
]

{ #category : 'accessing' }
MicrodownBookTestResult >> fragmentedText [

	^ fragmentedText
]

{ #category : 'accessing' }
MicrodownBookTestResult >> fragmentedText: aText [
	"The Array contains: 
		-Class Name
		-Method Name
		-Method Body"
	fragmentedText := aText
]

{ #category : 'initialization' }
MicrodownBookTestResult >> initialize [

	super initialize.
	status := true.
	explanation := 'Test failed without raising an exception'
]

{ #category : 'testing' }
MicrodownBookTestResult >> isFailed [

	^ status not
]

{ #category : 'testing' }
MicrodownBookTestResult >> isValid [

	^ status 
]

{ #category : 'accessing' }
MicrodownBookTestResult >> status [ 
	"true means that the test is valid, false means that the test got a problem or failed"
	
	^ status
]

{ #category : 'accessing' }
MicrodownBookTestResult >> status: aBoolean [
	"true means that the test is valid, false means that the test got a problem or failed"
	
	status := aBoolean
]

{ #category : 'accessing' }
MicrodownBookTestResult >> text [

	^ text 
]

{ #category : 'accessing' }
MicrodownBookTestResult >> text: aText [

	text := aText
]
