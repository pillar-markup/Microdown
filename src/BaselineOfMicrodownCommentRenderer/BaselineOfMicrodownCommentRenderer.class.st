Class {
	#name : #BaselineOfMicrodownCommentRenderer,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicrodownCommentRenderer
}

{ #category : #baselines }
BaselineOfMicrodownCommentRenderer >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec baseline: 'Microdown' with: [ spec 
				repository: self packageRepositoryURL ].
		spec 
			package: #'Microdown-Calypso' with: [
				spec requires:  #('Microdown-RichTextComposer') ];
			package: #'Microdown-RichTextComposer' with: [
				spec requires:  #('Microdown') ]
			]

]
