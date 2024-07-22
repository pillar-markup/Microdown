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
		'explanation',
		'message',
		'source'
	],
	#classInstVars : [
		'allMessages'
	],
	#category : 'Microdown-BookTester',
	#package : 'Microdown-BookTester'
}

{ #category : 'initialization' }
MicBookTestResult class >> allMessages [
   	^ allMessages ifNil: [ 
		allMessages := Dictionary new.
		allMessages
		   at: #false put: 'Failed' ;
		   at: #true put: 'Passed' .
		^ allMessages ]
]

{ #category : 'initialization' }
MicBookTestResult class >> reset [
	<script>
	allMessages := nil
]

{ #category : 'accessing' }
MicBookTestResult >> concernedElement [
"just to have a Global API between this and MicResult Object but we still have the spesific api for the same case " 

	^ text 
]

{ #category : 'accessing' }
MicBookTestResult >> explanation [
	
	^ 'test status: ',
	  (self class allMessages at: self status asString) asString ,
     String cr , 
     'Description of the test result : ' ,
	 self message asString ,
	 String cr ,
	 'the concerned code Block  :  ',
	 self text  , 
	 String cr ,
	'from the source file:  ' ,
   	 self source asString 

	
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
	message := 'Test failed without raising an exception'
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
MicBookTestResult >> message [

	^ message
]

{ #category : 'accessing' }
MicBookTestResult >> message: anObject [

	message := anObject
]

{ #category : 'accessing' }
MicBookTestResult >> source [

	^ source
]

{ #category : 'accessing' }
MicBookTestResult >> source: anObject [

	source := anObject
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
