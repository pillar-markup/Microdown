"
baseline: spec
	<baseline>
	
	spec for: #'common' do: [
		spec 
			baseline: 'Mustache'
			with: [ spec
						repository: 'github://noha/mustache:v1.0/repository';
						loads: #('Core' 'Tests') ].
		spec 
			package: #'Microdown-H5P' 
			with: [ spec requires: #('Mustache') ]
	]
"
Class {
	#name : 'BaselineOfMicrodownH5P',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMicrodownH5P',
	#package : 'BaselineOfMicrodownH5P'
}

{ #category : 'baselines' }
BaselineOfMicrodownH5P >> baseline: spec [
	<baseline>
	
	spec
		for: #(unix osx)
		do: [ spec 
					baseline: 'OSSubprocess' 
					with: [ spec repository: 'github://pharo-contributions/OSSubprocess:v1.4.0/repository' ] ].
	
	spec for: #'common' do: [
		"probably not needed with the latest version e.g. jpeg production."
		spec 
			baseline: 'Mustache'
			with: [ spec
						repository: 'github://noha/mustache:v1.0/repository';
						loads: #('Core' 'Tests') ].
		spec 
			package: #'Microdown-H5P' 
			with: [ spec requires: #('Mustache' 'OSSubprocess') ]
	]
]
