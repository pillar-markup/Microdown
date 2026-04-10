Class {
	#name : 'MicFileResult',
	#superclass : 'MicResult',
	#category : 'Microdown-BookTester-References',
	#package : 'Microdown-BookTester',
	#tag : 'References'
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
