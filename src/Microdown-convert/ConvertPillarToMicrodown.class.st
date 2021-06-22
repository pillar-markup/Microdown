Class {
	#name : #ConvertPillarToMicrodown,
	#superclass : #Object,
	#category : #'Microdown-convert'
}

{ #category : #'as yet unclassified' }
ConvertPillarToMicrodown class >> convertPillarFileToMicFile: aStringPath [
	"self convertPillarFileToMicFile: 'PharoTour/PharoTour.pillar'"
	
	| pillarFile pillar micText1 micFile1 |
	pillarFile := FileSystem workingDirectory / aStringPath.
	pillar := PRPillarParser new parse: pillarFile contents.
	micText1 := (PRMicrodownWriter new canvasSetLF; start: pillar).
	micFile1 := FileSystem workingDirectory / 'file1.mic'.
	micFile1 writeStreamDo: [ :stream | stream nextPutAll: micText1 contents ].
	

]

{ #category : #'as yet unclassified' }
ConvertPillarToMicrodown class >> convertPillarFileToTwoMicFile: aStringPath [
	"self convertPillarFileToTwoMicFile: 'PharoTour/PharoTour.pillar'"
	
	| pillarFile pillar micText1 micFile1 mic micText2 micFile2 |
	pillarFile := FileSystem workingDirectory / aStringPath.
	pillar := PRPillarParser new parse: pillarFile contents.
	micText1 := (PRMicrodownWriter new canvasSetLF; start: pillar).
	micFile1 := FileSystem workingDirectory / 'file1.mic'.
	micFile1 writeStreamDo: [ :stream | stream nextPutAll: micText1 contents ].
	
	mic := MicroDownParser new parse: micText1 contents.
	micText2 := mic accept: MicTextualMicrodownExporter new.
	micFile2 := FileSystem workingDirectory / 'file2.mic'.
	micFile2 writeStreamDo: [ :stream | stream nextPutAll: micText2 contents ].
]
