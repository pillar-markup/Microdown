Class {
	#name : #ConvertPillarToMicrodown,
	#superclass : #Object,
	#category : #'Microdown-Converter'
}

{ #category : #'as yet unclassified' }
ConvertPillarToMicrodown class >> convertPillarBookToMicBook: aBookFolder [
	"self convertPillarBookToMicBook: FileSystem workingDirectory / 'Booklet-Smacc'"
	(aBookFolder isFile and: aBookFolder extension = 'pillar') ifTrue: [ 
		^ self convertPillarFileToTwoMicFile: aBookFolder pathString].
	aBookFolder isDirectory ifTrue: [ 
		aBookFolder children do: [ :each | 
		self convertPillarBookToMicBook: each] ]
	
]

{ #category : #'as yet unclassified' }
ConvertPillarToMicrodown class >> convertPillarFileToMicFile: aStringPath [
	"self convertPillarFileToMicFile: 'PharoByExample80/Chapters/UnderstandingMessage/UnderstandingMessage.pillar'"
	
	| pillarFile pillar micText1 micFile1 path |
	pillarFile := FileSystem workingDirectory / aStringPath.
	path := self pathWithoutExtension: pillarFile.
	pillar := PRPillarParser new parse: pillarFile contents.
	micText1 := (PRMicrodownWriter new canvasSetLF; start: pillar).
	micFile1 := FileSystem workingDirectory / path,'mic'.
	micFile1 writeStreamDo: [ :stream | stream nextPutAll: micText1 contents ].
	

]

{ #category : #'as yet unclassified' }
ConvertPillarToMicrodown class >> convertPillarFileToTwoMicFile: aStringPath [
	"self convertPillarFileToTwoMicFile: 'Seaside.pillar'"
	
	| pillarFile pillar micText1 micFile1 mic micText2 micFile2 path |
	pillarFile := FileSystem workingDirectory / aStringPath.
	path := self pathWithoutExtension: pillarFile.
	pillar := PRPillarParser new parse: pillarFile contents.
	micText1 := (PRMicrodownWriter new canvasSetLF; start: pillar).
	micFile1 := FileSystem workingDirectory / path,'1.mic'.
	micFile1 writeStreamDo: [ :stream | stream nextPutAll: micText1 contents ].
	
	mic := MicroDownParser new parse: micText1 contents.
	micText2 := mic accept: MicTextualMicrodownExporter new.
	micFile2 := FileSystem workingDirectory / path,'2.mic'.
	micFile2 writeStreamDo: [ :stream | stream nextPutAll: micText2 contents ].
]

{ #category : #'as yet unclassified' }
ConvertPillarToMicrodown class >> pathWithoutExtension: aFile [
	| path stream |
	path := aFile pathString.
	stream := (String new: 10000) writeStream.
	path doWithIndex: [ :each :i | (i<(path size - 6)) ifTrue: [ stream nextPutAll: each asString ] ].
	^ stream contents
]
