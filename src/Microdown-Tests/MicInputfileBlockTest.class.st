Class {
	#name : #MicInputfileBlockTest,
	#superclass : #MicAnnotationSubclassTest,
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfileIsNotRelativeFilePath [
	| mic resourceReference |
	"a path starting with / should give an absolute file reference"
	mic := parser parse: '<!inputFile|path=/chapters/withStyle.mic!>'.
	resourceReference := mic children first reference.
	self assert: resourceReference isRelative not.
	self assert: resourceReference uriString equals: 'file:///chapters/withStyle.mic'
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfileIsRelativeFilePath [
	| mic infileReference |
	mic := parser parse: '<!inputFile|path=chapters/withStyle.mic!>'.
	infileReference := mic children first reference.
	self assert: infileReference isRelative.
	self assert: infileReference relativePath equals: 'chapters/withStyle.mic'
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfilePath [
	| mic infileReference |
	mic := parser parse: '<!inputFile|path=chapters/withStyle.mic!>'.
	infileReference := mic children first reference.
	self assert: infileReference relativePath equals: 'chapters/withStyle.mic' 
]

{ #category : #tests }
MicInputfileBlockTest >> testMicInputfilePathError [
	[parser parse: '<!inputFile|path:errror=fchapters/withStyle.mic!>']
		on: MicParsingError
		do: [:error |
			^ self 
				assert: error line 
				equals: 'inputFile|path:errror=fchapters/withStyle.mic must have path argument'].
	self fail.
		
]
