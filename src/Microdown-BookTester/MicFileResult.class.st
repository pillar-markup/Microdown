Class {
	#name : 'MicFileResult',
	#superclass : 'MicResult',
	#instVars : [
		'micElement'
	],
	#category : 'Microdown-BookTester-References',
	#package : 'Microdown-BookTester',
	#tag : 'References'
}

{ #category : 'accessing' }
MicFileResult >> detail [ ^ nil
]

{ #category : 'accessing' }
MicFileResult >> explanation [

	^ 'File input ', self what,' (in file ', source fullName , ') does not exist.'
	
]

{ #category : 'accessing' }
MicFileResult >> micElement [

	^ micElement
]

{ #category : 'accessing' }
MicFileResult >> micElement: anElement [

	micElement := anElement
]

{ #category : 'accessing' }
MicFileResult >> stonFormatExplanation [

	^ '"', self what,'" : "', source , '"'
	
]

{ #category : 'accessing' }
MicFileResult >> what [

	^ self subclassResponsibility 
]
