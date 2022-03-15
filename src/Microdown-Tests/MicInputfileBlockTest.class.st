Class {
	#name : #MicInputfileBlockTest,
	#superclass : #MicAnnotationSubclassTest,
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfileIsNotRelativeFilePath [
	| mic |
	mic := parser parse: '{!inputFile|path=/chapters/withStyle.mic!}'.
	self assert: mic children first children first path path equals: '/chapters/withStyle.mic'
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfileIsRelativeFilePath [
	| mic |
	mic := parser parse: '{!inputFile|path=chapters/withStyle.mic!}'.
	mic children first children first path: mic children first children first originalPath.
	self assert: mic children first children first path path equals: 'chapters/withStyle.mic'
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfilePath [
	| mic |
	mic := parser parse: '{!inputFile|path=chapters/withStyle.mic!}'.
	self assert: mic children first children first path path equals: 'chapters/withStyle.mic' 
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfilePathError [
	[parser parse: '{!inputFile|path:errror=fchapters/withStyle.mic!}']
		on: MicParsingError
		do: [:error |
			^ self 
				assert: error line 
				equals: 'inputFile|path:errror=fchapters/withStyle.mic must have path argument'].
	self fail.
		
]
