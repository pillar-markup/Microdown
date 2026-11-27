Class {
	#name : 'MicExerciseStudentBodyGenerator',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'builder',
		'chapterNumber',
		'sourceFile'
	],
	#category : 'Microdown-ExerciseHider',
	#package : 'Microdown-ExerciseHider'
}

{ #category : 'accessing' }
MicExerciseStudentBodyGenerator >> chapterNumber [

	^ chapterNumber
]

{ #category : 'accessing' }
MicExerciseStudentBodyGenerator >> chapterNumber: anObject [

	chapterNumber := anObject
]

{ #category : 'visiting' }
MicExerciseStudentBodyGenerator >> contents [
	^ builder contents
]

{ #category : 'initialization' }
MicExerciseStudentBodyGenerator >> initialize [
	super initialize.
	builder := MicMicrodownTextualBuilder new.
]

{ #category : 'removing' }
MicExerciseStudentBodyGenerator >> removeIndentationFromCodeBlocks: content [
	| lines result stream trimmed |
	lines := content lines.
	result := String streamContents: [ :aStream |
		stream := aStream.
		lines do: [ :line |
			trimmed := line trimLeft.
			(trimmed beginsWith: '```')
				ifTrue: [ stream nextPutAll: trimmed ]
				ifFalse: [ stream nextPutAll: line ].
			stream cr ] ].
	^ result
]

{ #category : 'visiting' }
MicExerciseStudentBodyGenerator >> visitCode: aCodeBlock [
	(aCodeBlock arguments includesKey: #exercise) ifTrue: [
		builder 
			raw: '```exercise';
			newLine;
			line: (aCodeBlock body lines first trimBoth);
			line: '... Your code ...';
			raw: '```';
			newLine]
]

{ #category : 'visiting' }
MicExerciseStudentBodyGenerator >> visitRoot: aRoot [
	builder 
		header: [:b | b text: 'Chapt'] withLevel: 2;
		anchor: 'Chap', chapterNumber;
		newLine.
	self visitChildrenOf: aRoot.
]

{ #category : 'removing' }
MicExerciseStudentBodyGenerator >> writeFile: filename content: content [
	| targetFile |
	targetFile := sourceFile parent / filename.
	targetFile ensureDelete.
	targetFile writeStreamDo: [:stream | stream nextPutAll: content]
]
