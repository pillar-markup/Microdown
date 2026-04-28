Class {
	#name : 'PRMicrodownDocument',
	#superclass : 'PRTextDocument',
	#category : 'Pillar-ExporterText',
	#package : 'Pillar-ExporterText'
}

{ #category : 'accessing' }
PRMicrodownDocument >> basicWriter [
	^ PRMicrodownWriter new
]

{ #category : 'accessing' }
PRMicrodownDocument >> extension [
	^ 'microdown'
]
