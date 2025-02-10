Class {
	#name : 'MicFileResult',
	#superclass : 'MicResult',
	#category : 'Microdown-BookTester-Results',
	#package : 'Microdown-BookTester',
	#tag : 'Results'
}

{ #category : 'accessing' }
MicFileResult >> explanation [

	^ 'File input ', self what,' (in file ', source fullName , ') does not exist.'
	
]

{ #category : 'accessing' }
MicFileResult >> stonFormatExplanation [

	^ '"', self what,'" : "', source , '"'
	
]

{ #category : 'accessing' }
MicFileResult >> what [

	^ self subclassResponsibility 
]
