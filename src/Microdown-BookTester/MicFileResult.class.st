Class {
	#name : 'MicFileResult',
	#superclass : 'MicResult',
	#category : 'Microdown-BookTester-Checker-References',
	#package : 'Microdown-BookTester',
	#tag : 'Checker-References'
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
