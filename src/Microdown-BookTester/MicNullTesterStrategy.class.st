"
When there is no tag other than none or language, does not verify the code block.
"
Class {
	#name : 'MicNullTesterStrategy',
	#superclass : 'MicCodeBlockTesterStrategy',
	#category : 'Microdown-BookTester-Analysis',
	#package : 'Microdown-BookTester',
	#tag : 'Analysis'
}

{ #category : 'hook' }
MicNullTesterStrategy class >> handleKey [

	^ #language

]

{ #category : 'main API' }
MicNullTesterStrategy >> verify: aMicCodeBlock [ 
	

	
]
