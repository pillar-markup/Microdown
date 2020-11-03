Class {
	#name : #BaselineOfMicrodownCommentRendererDev,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicrodownCommentRendererDev
}

{ #category : #baselines }
BaselineOfMicrodownCommentRendererDev >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec baseline: 'MicrodownDev' with: [ spec 
				repository: self packageRepositoryURL ].
		spec 
			package: #'Microdown-Calypso' with: [
				spec requires:  #('Microdown-RichTextComposer') ];
			package: #'Microdown-RichTextComposer' with: [
				spec requires:  #('MicrodownDev') ]
			]
]
