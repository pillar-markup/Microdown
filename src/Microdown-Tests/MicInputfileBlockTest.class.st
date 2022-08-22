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
	self assert: resourceReference path equals: '/chapters/withStyle.mic'
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
	| doc fileInputBlock |
	doc := parser parse: '<!inputFile|pa=fchapters/withStyle.mic!>'.
	fileInputBlock := doc children first.
	self 
		assert: fileInputBlock reference relativePath 
		equals: 'error: inputFile should have a path argument'
		
]
