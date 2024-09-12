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
	#superclass : 'MicResult',
	#instVars : [
		'text',
		'fragmentedText',
		'isExpectedFailure'
	],
	#classInstVars : [
		'allMessages'
	],
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
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
	  'isExpectedFailure?  ',
	  self isExpectedFailure asString ,
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
	isExpectedFailure := false.
	message := 'Test failed without raising an exception'.
	text := 'here we should get an expression'
]

{ #category : 'accessing' }
MicBookTestResult >> isExpectedFailure [

	^ isExpectedFailure
]

{ #category : 'accessing' }
MicBookTestResult >> isExpectedFailure: anObject [

	isExpectedFailure := anObject
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
MicBookTestResult >> stonFormatExplanation [
	
	^ '{', String cr , '"status" : "',
	  (self class allMessages at: self status asString) asString ,'",',
     String cr , 
	  '"isExpectedFailure" : "',
	  self isExpectedFailure asString ,'",',
	  String cr ,
     '"Description" : "' ,
	 self message asString ,'",',
	 String cr ,
	 '"codeBlock" : "',
	 self text  , '",',
	 String cr ,
	'"sourceFile" : "' ,
	self source asString , '"',
	String cr , '}'
   	  

	
]

{ #category : 'accessing' }
MicBookTestResult >> text [

	^ text 
]

{ #category : 'accessing' }
MicBookTestResult >> text: aText [

	text := aText
]
